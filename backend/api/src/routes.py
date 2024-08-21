from fastapi import APIRouter
from crud_forge.generators import models, crud, routes
from .db import db_manager


# * Get all schemas from the database
db_schemas = db_manager.metadata.keys()  # Get all schemas from the database
all_models = models.generate_models_from_metadata(db_manager.metadata)  # Generate Pydantic & SQLAlchemy models for each schema

# Generate CRUD operations for each schema
schema_routers: dict[str, APIRouter] = {
    schema: APIRouter(prefix=f"/{schema.replace('_management', '')}", tags=[schema.replace('_management', '')])  # Remove '_management' from the schema name
    # schema: APIRouter(prefix=f"/{schema.replace('_management', '')}")  # Remove '_management' from the schema name
    for schema in db_schemas}  # * for all schemas in the database

def generate_schema_crud(router: APIRouter, models: dict):
    """Generate CRUD operations for a schema's models."""
    [crud.generate_crud(sqlalchemy_model, pydantic_model, router, db_manager.get_db) for sqlalchemy_model, pydantic_model in models.values()]

[generate_schema_crud(schema_routers[schema], all_models[schema]) for schema in db_schemas]  # Generate CRUD operations for each schema

# Include each router in the main 'crud_attr' router
crud_attr: APIRouter = APIRouter()
[crud_attr.include_router(router) for router in schema_routers.values()]

# ^ Expose routers globally (for use in the main FastAPI application)
globals().update(schema_routers)  # Update the global namespace with the routers
globals()['crud_attr'] = crud_attr  # Update the global namespace with the main 'crud_attr' router

# * Generate metadata routes
metadata: APIRouter = routes.generate_metadata_routes(db_manager.metadata, db_manager.get_db)


# * Generate test routes
test: APIRouter = APIRouter(tags=["test"])

@test.get("/test")
def test_get(): return "GET request to /test route"

@test.post("/test")
def test_post(): return "POST request to /test route"

@test.put("/test")
def test_put(): return "PUT request to /test route"

@test.delete("/test")
def test_delete(): return "DELETE request to /test route"

# ^ Expose the metadata and test routers globally (for use in the main FastAPI application)
globals()['metadata'] = metadata  # Update the global namespace with the metadata router
globals()['test'] = test  # Update the global namespace with the test router
