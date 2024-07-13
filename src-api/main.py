"""Main file for the FastAPI application"""

from src.config import Config


# app: FastAPI = FastAPI(
#     title = Config.NAME.value,
#     description = Config.DESCRIPTION.value,
#     version = Config.VERSION.value,
#     contact = { "name": Config.AUTHOR.value, "email": Config.EMAIL.value },
#     license_info = { "name": Config.LICENSE.value, "url": Config.LICENSE_URL.value }
# )

# app.add_middleware(  # Add CORS middleware
#     CORSMiddleware,
#     allow_origins=[  # origin: protocol + host + port (ex: "http://localhost:5173")
#         "*"  # allow all origins
#         ],
#     allow_credentials=True,
#     allow_methods=["*"],
#     allow_headers=["*"],
# )


# * Startup event
print("\n\033[92m" + f"Startup completed successfully!\n\n")


# * Run the application
if __name__ == "__main__":
    """
        Run the FastAPI application

        Using the `python main.py` will use this block to run the FastAPI application.
        It will run the application using the `uvicorn` server on the localhost at port 8000.
        So it wont be updated automatically when the code changes.
    """
#     import uvicorn  # import uvicorn to run the application
#     uvicorn.run(app, host="127.0.0.1", port=8000)
    pass
