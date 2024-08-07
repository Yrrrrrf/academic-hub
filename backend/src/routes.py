from typing import Dict
from fastapi import APIRouter
from crud_forge.generators.crud import generate_crud
from .db import db_manager, all_models, db_schemas


def generate_schema_crud(router: APIRouter, models: dict) -> None:
    """Generate CRUD operations for a schema's models."""
    for sqlalchemy_model, pydantic_model in models.values():
        generate_crud(sqlalchemy_model, pydantic_model, router, db_manager.get_db)

def define_routes() -> Dict[str, APIRouter]:
    """Define and create APIRouters for each schema in the Academic Hub API."""
    schemas = {db_schemas[i]: db_schemas[i] for i in range(1, len(db_schemas))}
    routers = {schema: APIRouter(prefix=f"/{schema}") for schema in schemas}
    
    return routers, schemas

# * Generate CRUD operations for each schema
routers, schemas = define_routes()
[generate_schema_crud(routers[schema], all_models[db_schema]) for schema, db_schema in schemas.items()]

# * Include each router in the main 'crud_attr' router
crud_attr = APIRouter()
[crud_attr.include_router(router) for router in routers.values()]

# * Expose routers globally (for use in the main FastAPI application)
globals().update(routers)
globals()['crud_attr'] = crud_attr
