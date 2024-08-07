from fastapi import APIRouter
from crud_forge.generators.crud import generate_crud
from .db import db_manager, all_models, db_schemas


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
