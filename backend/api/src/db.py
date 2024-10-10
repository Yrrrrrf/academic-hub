from forge import APIForge, DBForge, DBConfig
from forge.gen.metadata import get_metadata_router
from fastapi import APIRouter
import os


# * Database Connection
db_manager: DBForge = DBForge(config=DBConfig(
    # * Set the database type and driver type
    db_type='postgresql',  # 'postgresql', 'mysql', 'sqlite'
    driver_type='sync',  # 'async', 'sync'
    #  * Set the database connection parameters (& default values)
    user=os.environ.get('DB_OWNER_ADMIN') or 'academic_hub_owner',
    password=os.environ.get('DB_OWNER_PWORD') or 'some_secure_password',
    # host=os.environ.get('DB_HOST') or 'a-hub-db',  # * for the docker-compose setup
    host=os.environ.get('DB_HOST') or 'localhost',
    database=os.environ.get('DB_NAME') or 'academic_hub',
))

metadata: APIRouter = get_metadata_router(db_manager.metadata)

# todo: Improve 'crud-forge' to now gen routes depending on the user permissions
# todo:     This to allow the app to be multi-tenant
# todo:     and have different users with different permissions
schemas = [
    "academic", 
    "agnostic",
    "auth",
    "course_offering",
    "hr",
    "infrastructure",
    "library",
    "student",
    "public",
]

def gen_schema_routes(schema: str, db_manager: DBForge, router: APIRouter) -> APIRouter:
    api_forge: APIForge = APIForge(
        db_manager=db_manager,
        router=router,
        include_schemas=[schema],
        # exclude_tables=["some-table"],
    )
    api_forge.genr_crud()
    api_forge.p_schemas(schemas=[schema])
    return router

schema_routers: list[APIRouter] = [gen_schema_routes(schema, db_manager, APIRouter(prefix=f"/{schema}", tags=[schema.upper()])) for schema in schemas]

print("\nTotal Routes:")
for schema, router in zip(schemas, schema_routers):
    print(f"\033[92m{len(router.routes):>8}\033[0m \033[1m{schema}\033[0m \033[90m`{router.prefix}`\033[0m") 

# print the total count of routes generated depending on the schemas
print(f"\033[94m{sum([len(router.routes) for router in schema_routers]):>8}\033[0m\n")
