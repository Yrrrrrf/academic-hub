from crud_forge.db import DatabaseManager, DBConfig, DBType, DriverType
from crud_forge.forge import APIForge
from fastapi import APIRouter
import os


# * Database Connection
db_manager: DatabaseManager = DatabaseManager(config=DBConfig(
    db_type=DBType.POSTGRESQL,
    driver_type=DriverType.SYNC,  # ^ Use the synchronous driver
    user=os.environ.get('DB_OWNER_ADMIN') or 'academic_hub_owner',
    password=os.environ.get('DB_OWNER_PWORD') or 'some_secure_password',
    host=os.environ.get('DB_HOST') or 'localhost',
    database=os.environ.get('DB_NAME') or 'academic_hub',
))

schemas = [
    "academic", 
    # "agnostic",
    # "auth",
    # "course_offering",
    # "hr",
    # "infrastructure",
    "library",
    # "student",
    # "public",
]

def gen_schema_routes(schema: str, db_manager: DatabaseManager, router: APIRouter) -> APIRouter:
    api_forge: APIForge = APIForge(
        db_manager=db_manager,
        router=router,
        include_schemas=[schema],
        # exclude_tables=["some-table"],
    )
    api_forge.gen_routes()
    api_forge.print_schema(schema=schema)
    return router

routers = [gen_schema_routes(schema, db_manager, APIRouter(prefix=f"/{schema}", tags=[schema.upper()])) for schema in schemas]

print("\nTotal Routes:")
for schema, router in zip(schemas, routers):
    print(f"\033[92m{len(router.routes):>8}\033[0m \033[1m{schema}\033[0m \033[90m`{router.prefix}`\033[0m") 

# print the total count of routes generated depending on the schemas
print(f"\033[94m{sum([len(router.routes) for router in routers]):>8}\033[0m\n")
