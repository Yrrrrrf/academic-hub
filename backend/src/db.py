from dotenv import load_dotenv
from crud_forge.db import DatabaseManager
import os


load_dotenv()

# * Database Configuration
DB: dict[str, str | None] = {key: os.getenv(key) for key in ['DB_OWNER_ADMIN', 'DB_OWNER_PWORD', 'DB_HOST', 'DB_NAME']}
db_url: str = f"postgresql://{DB['DB_OWNER_ADMIN']}:{DB['DB_OWNER_PWORD']}@{DB['DB_HOST']}/{DB['DB_NAME']}"
db_manager: DatabaseManager = DatabaseManager(db_url=db_url)
