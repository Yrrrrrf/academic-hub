"""Main file for the FastAPI application"""

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from .config import Config
from .routes import *


app: FastAPI = FastAPI(
    title = Config.NAME.value,
    description = Config.DESCRIPTION.value,
    version = Config.VERSION.value,
    contact = { "name": Config.AUTHOR.value, "email": Config.EMAIL.value },
    license_info = { "name": Config.LICENSE.value, "url": Config.LICENSE_URL.value }
)

app.add_middleware(
    CORSMiddleware,  # Add the CORS middleware to the FastAPI application (to allow cross-origin requests)
    allow_origins=["*"],  # Allow all origins
    allow_credentials=True,  # Allow credentials (cookies, auth-headers, etc.)
    allow_methods=["*"],  # Allow all methods (GET, POST, PUT, DELETE, etc.)
    allow_headers=["*"],  # Allow all headers
)

# * Add the routes to the FastAPI application
# app.include_router(home)
# app.include_router(basic_dt)
# app.include_router(views)
app.include_router(crud_attr)


# * Startup event
print("\n\033[92m" + f"Startup completed successfully!\n\n")


# * Run the applicationn (if the file is run directly)
if __name__ == "__main__":
    """
        Run the FastAPI application

        Using the `python main.py` will use this block to run the FastAPI application.
        It will run the application using the `uvicorn` server on the localhost at port 8000.
        So it wont be updated automatically when the code changes.
    """
    import uvicorn  # import uvicorn to run the application
    uvicorn.run(app, host="127.0.0.1", port=8000)
