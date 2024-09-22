"""Main file for the FastAPI application"""
from fastapi import APIRouter, FastAPI
from forge.utils import Config, allow_all_middleware

from .db import schema_routers, metadata


app: FastAPI = FastAPI()
allow_all_middleware(app)  # Allow all middleware

config: Config = Config(  # * Set the configuration
    PROJECT_NAME="Academic Hub",
    VERSION = "v0.0.3",
    DESCRIPTION = "Hub for academic management and resources",
    AUTHOR = "Yrrrrrf",
    EMAIL = "fernandorezacampos@gmail.com",
)
config.set_app_data(app)  # Set the app metadata
config.setup_logging()  # Setup logging (add some color to the logs)










# test_router = APIRouter(prefix="/test", tags=["TEST"])
# @test_router.get("/test")
# def test(): return {"message": "Hello, World!"}

# @app.get("/t02")
# def t02(): return {"PENCHS: PENCHS"}



# * Add the routes to the FastAPI application
[app.include_router(route) for route in [
    # enums_router,  # ^ Enum routes (for getting the enums in the database)
    # test_router,
    metadata,  # Metadata routes (for getting metadata about the database)
    *schema_routers  # ^ unpack the routers

]]  # Include the routes in the FastAPI application

# * Startup event
def on_startup(): print("\n\n\033[92m" + f"Startup completed successfully!\n\n")

on_startup()  # Run the startup event
