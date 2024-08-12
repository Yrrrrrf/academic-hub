from fastapi import APIRouter
from crud_forge.generators.crud import generate_crud
from .db import db_manager, all_models, db_schemas


# * Add the schema routes to the main FastAPI application
# * crud_attr: APIRouter contains all the CRUD operations for the schemas 
def generate_schema_crud(router: APIRouter, models: dict) -> None:
    """Generate CRUD operations for a schema's models."""
    [generate_crud(sqlalchemy_model, pydantic_model, router, db_manager.get_db) for sqlalchemy_model, pydantic_model in models.values()]

# * Generate CRUD operations for each schema
schema_routers: dict[str, APIRouter] = {schema: APIRouter(prefix=f"/{schema}") for schema in db_schemas}
[generate_schema_crud(schema_routers[schema], all_models[schema]) for schema in schema_routers.keys()]

# * Include each router in the main 'crud_attr' router
crud_attr: APIRouter = APIRouter()
[crud_attr.include_router(router) for router in schema_routers.values()]

# * Expose routers globally (for use in the main FastAPI application)
globals().update(schema_routers)  # Update the global namespace with the routers
globals()['crud_attr'] = crud_attr  # Update the global namespace with the main 'crud_attr' router


# ? TEST CODE ... -----------------------------------------------------------------------------

# ? All the code below is for testing purposes only. It is not part of the actual application.
# ? It is used to simulate the implementation of the 'robots.txt' endpoint.

# * Add some test routes to the main FastAPI application
# * test_router: APIRouter contains test routes
from fastapi import APIRouter, Response
from fastapi.responses import PlainTextResponse

test_router: APIRouter = APIRouter(prefix="/test", tags=["Test"])

# Define the content of robots.txt
ROBOTS_TXT_CONTENT = """
User-agent: *
Disallow: /admin/
Disallow: /private/
Allow: /

Sitemap: 'still working on it...'
"""

@test_router.get("/robots.txt", response_class=PlainTextResponse)
async def test_robots_txt() -> Response:
    """
    Serve a robots.txt file.

    This endpoint returns a basic robots.txt file as plain text.
    It instructs web crawlers on which parts of the site they are allowed to index.

    Returns:
        Response: A plain text response containing the robots.txt content.
    """
    return Response(content=ROBOTS_TXT_CONTENT.strip(), media_type="text/plain")
