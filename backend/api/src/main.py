"""
Main file for the FastAPI application
"""
from fastapi import FastAPI
from crud_forge.generators.routes import gen_default_routes

from .config import set_app_data, allow_all_middleware, setup_logging
from .routes import *


app: FastAPI = FastAPI()  # Create the FastAPI application

# set_app_data(app)  # Set the data for the FastAPI application
setup_logging(app)  # Setup the logging configuration
allow_all_middleware(app)  # Allow all middleware

# * Add the routes to the FastAPI application
gen_default_routes(app)  # Default routes (for app health & version info)
[app.include_router(route) for route in [
    test,  # ^ Health routes (for checking the health of the FastAPI application)
    enums_router,  # ^ Enum routes (for getting the enums in the database)
    metadata,  # Metadata routes (for getting metadata about the database)
    crud_attr, # CRUD routes (for creating, reading, updating, and deleting records in the database)
    # some_other_router
]]  # Include the routes in the FastAPI application


def on_startup():
    print("\n\n\033[92m" + f"Startup completed successfully!\n\n")


on_startup()  # Run the startup event