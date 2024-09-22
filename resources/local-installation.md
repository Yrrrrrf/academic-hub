<!-- TODO: COMPLETE THIS local-installation.md FILE W/ RELEVANT INFO -->

# Local Installation Guide

This guide provides step-by-step instructions for setting up the Academic Hub project locally without using Docker.

## Prerequisites

Ensure you have the following installed on your system:

- [PostgreSQL](https://www.postgresql.org/) (v12 or later)
- [Python](https://www.python.org/) (v3.9 or later)
- [Node.js](https://nodejs.org/) (v14 or later) or [bun](https://bun.sh/)

## Step 1: Clone the Repository

```bash
git clone https://github.com/Yrrrrrf/academic-hub.git
cd academic-hub
```

## Step 2: Set Up the Database

1. Create a new PostgreSQL database:
   ```sql
   CREATE DATABASE academic_hub;
   ```

2. Create a database user:
   ```sql
   CREATE USER academic_hub_owner WITH PASSWORD 'your_secure_password';
   ```

3. Grant necessary privileges to the user:
   ```sql
   GRANT ALL PRIVILEGES ON DATABASE academic_hub TO academic_hub_owner;
   ```

4. Execute the SQL setup scripts:
   - Run the `00_db_setup.sql` file from the `sql` directory.
   - Run the remaining SQL files in numerical order using the `academic_hub_owner` role.

## Step 3: Set Up the Backend

1. Navigate to the backend directory:
   ```bash
   cd backend
   ```

2. Create a virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows, use `venv\Scripts\activate`
   ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Create a `.env` file in the backend directory with the following content:
   ```
   DB_NAME=academic_hub
   DB_HOST=localhost
   DB_OWNER_ADMIN=academic_hub_owner
   DB_OWNER_PWORD=your_secure_password
   ```

5. Start the FastAPI server:
   ```bash
   uvicorn src.main:app --reload
   ```

## Step 4: Set Up the Frontend

1. Navigate to the frontend directory:
   ```bash
   cd ../frontend
   ```

2. Install dependencies:
   ```bash
   npm install
   # or if using bun
   bun install
   ```

3. Start the development server:
   ```bash
   npm run dev
   # or if using bun
   bun run dev
   ```

## Step 5: Access the Application

- The web application should now be accessible at `http://localhost:5173`
- The API documentation can be found at `http://localhost:8000/docs`

## Troubleshooting

If you encounter any issues during the setup process, please check the following:

1. Ensure all prerequisites are correctly installed and up to date.
2. Verify that the PostgreSQL service is running.
3. Check that the database connection details in the `.env` file are correct.
4. Make sure all required ports (5173 for frontend, 8000 for backend) are available and not in use by other applications.

If problems persist, please refer to our [issue tracker](https://github.com/Yrrrrrf/academic-hub/issues) or create a new issue for assistance.
