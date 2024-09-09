from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from uvicorn.logging import AccessFormatter
from logging import config, LogRecord
from enum import Enum
import re


class Config(Enum):
    """Project Config"""
    NAME = "Academic Hub"
    VERSION = "v0.0.2"
    AUTHOR = "Yrrrrrf"
    EMAIL = "fernandorezacampos@gmail.com"
    DESCRIPTION = "Hub for academic management and resources"
    LICENSE = "MIT"
    LICENSE_URL = "https://choosealicense.com/licenses/mit/"


# * Create fn that set the data for the FastAPI application
def set_app_data(app: FastAPI):
    app.title = Config.NAME.value,
    app.description = Config.DESCRIPTION.value,
    app.version = Config.VERSION.value,
    app.contact = { "name": Config.AUTHOR.value, "email": Config.EMAIL.value },
    app.license_info = { "name": Config.LICENSE.value, "url": Config.LICENSE_URL.value }


# * Create a fn that 'ALLOWS ALL' the middleware
def allow_all_middleware(app: FastAPI):
    app.add_middleware(
        CORSMiddleware,  # Add the CORS middleware to the FastAPI application (to allow cross-origin requests)
        allow_origins=["*"],  # Allow all origins
        allow_credentials=True,  # Allow credentials (cookies, auth-headers, etc.)
        allow_methods=["*"],  # Allow all methods (GET, POST, PUT, DELETE, etc.)
        allow_headers=["*"],  # Allow all headers
    )

# * Create fn that setup the logging configuration
class ColoredAccessFormatter(AccessFormatter):
    method_colors: dict[str, str] = {
        "GET": "\033[94m",    # Blue
        "PUT": "\033[93m",    # Yellow
        "DELETE": "\033[91m", # Red
        "POST": "\033[92m",   # Green
        "RESET": "\033[0m"    # Reset color
    }

    def format(self, record: LogRecord) -> str:
        return re.sub(
            r'(' + '|'.join(self.method_colors.keys()) + r' )',  # Match any of the method names
            lambda match: f'{self.method_colors[match.group()]}{match.group()}{self.method_colors["RESET"]}',  # Wrap the matched method name in color
            super().format(record)  # Call the parent class's format method
        )

# Configure custom logging
LOG_CONFIG = {
    "version": 1,
    "disable_existing_loggers": False,
    "formatters": {
        "color_access": {
            "()": ColoredAccessFormatter,
            "fmt": "%(levelprefix)s %(client_addr)s - \"%(request_line)s\" %(status_code)s",
        }
    },
    "handlers": {
        "access": {
            "formatter": "color_access",
            "class": "logging.StreamHandler",
            "stream": "ext://sys.stderr",
        }
    },
    "loggers": {
        "uvicorn.access": {"handlers": ["access"], "level": "INFO", "propagate": False},
    }
}

    # from .console_output import LOG_CONFIG

def setup_logging(app: FastAPI):
    @app.on_event("startup")
    async def startup_event(): config.dictConfig(LOG_CONFIG)  # ^ Set the LOG_CONFIG as the logging config
