from crud_forge.db import DatabaseManager
import os

# * Environment Variables
DB = {
    'NAME': os.environ.get('DB_NAME') or 'academic_hub',
    'HOST': os.environ.get('DB_HOST') or 'localhost',  # localhost by default
    'ADMIN': os.environ.get('DB_OWNER_ADMIN') or 'academic_hub_owner',
    'PWORD': os.environ.get('DB_OWNER_PWORD') or 'some_secure_password',
}

# * Database Connection
db_url: str = f"postgresql://{DB['ADMIN']}:{DB['PWORD']}@{DB['HOST']}/{DB['NAME']}"
db_manager: DatabaseManager = DatabaseManager(db_url=db_url)
