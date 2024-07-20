from dotenv import load_dotenv
from typing import Tuple, Type
from pydantic import BaseModel
from crud_forge.db import DatabaseManager
from crud_forge.generators.models import generate_models, generate_views
import os


load_dotenv()

# * Database Configuration
DB: dict[str, str] = {key: os.getenv(key) for key in ['DB_OWNER_ADMIN', 'DB_OWNER_PWORD', 'DB_HOST', 'DB_NAME']}
db_manager = DatabaseManager(f"postgresql://{DB['DB_OWNER_ADMIN']}:{DB['DB_OWNER_PWORD']}@{DB['DB_HOST']}/{DB['DB_NAME']}")

# * Generate models and views
db_schemas = [
    "auth",
    "infrastructure",
    "hr",
    "academic",
    "course_offering",
    "student",
    "library"
]

all_models: dict[str, dict[str, Tuple[Type[BaseModel], Type[BaseModel]]]] = {}
for schema in db_schemas:
    models = generate_models(db_manager.engine, [f"{schema}_management" if schema != "auth" else schema])
    all_models[schema] = models
    globals()[f"{schema}_models"] = models

