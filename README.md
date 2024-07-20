<h1 align="center">
   <img src="./static/favicon.png" alt="Some Store Icon" width="128">
   <div align="center">Academic Hub</div>
</h1>

<p align="center">
  <a href="https://github.com/Yrrrrrf/academic-hub">
    <img src="https://img.shields.io/badge/github-academic--hub-blue?style=for-the-badge&logo=github" alt="GitHub">
  </a>
  <img src="https://img.shields.io/badge/license-MIT-green?style=for-the-badge" alt="License">
  <img src="https://img.shields.io/badge/version-0.1.0-blue?style=for-the-badge" alt="Version">
</p>

<p align="center">
  A comprehensive Desktop + Web application for managing critical data in academic institutes.
</p>

## Table of Contents

- [Features](#features)
- [Technology Stack](#technology-stack)
- [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
- [Usage](#usage)
- [Database Schema](#database-schema)
- [API Documentation](#api-documentation)
- [Contributing](#contributing)
- [License](#license)

## Features

Academic Hub offers a robust set of features designed to streamline academic data management:

- **Comprehensive Data Management**: Handle student records, course information, faculty details, and more.
- **Real-time Updates**: Utilize PLpgSQL real-time capabilities for instant data synchronization.
- **Cross-platform Compatibility**: Access the system via web browsers or as a desktop application.
- **Scalable Architecture**: Designed to handle large volumes of data efficiently.
- **User-friendly Interface**: Intuitive design using DaisyUI for enhanced user experience.
- **Secure Authentication**: Implement role-based access control for data protection.
- **Reporting and Analytics**: Generate insightful reports on various academic metrics.

## Technology Stack

- **Backend**:
    <!-- - [Supabase](https://supabase.io/) for database and API -->
	- [FastAPI](https://www.python.org/) for backend development
	- [PostgreSQL](https://www.postgresql.org/) for robust data storage
- **Frontend**:
	- [SvelteKit](https://kit.svelte.dev/) for efficient web development
   	- [DaisyUI](https://daisyui.com/) for responsive and attractive UI components
- **Desktop Application**:
	- [Tauri](https://tauri.app/) for cross-platform desktop development

## Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- [PostgreSQL](https://www.postgresql.org/) (v12 or later)
- [Python](https://www.python.org/) (v3.9 or later)
- [Node.js](https://nodejs.org/) (v14 or later) or [bun](https://bun.sh/)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/Yrrrrrf/academic-hub.git
cd academic-hub  # Change to project directory
```

2. Install dependencies:
```bash
npm install  # Install Node.js dependencies
bun install  # Install bun dependencies
```

3. Set up the main db using the `*.sql` files in the [`sql`](./sql) directory.
	- Execute the [`00_db_setup.sql`](./sql/00_db_setup.sql) file to create the main database.
	- Execute the rest of the files in the order using the `academic_hub_owner` role to create the necessary schemas and tables.

4. Run the development server:
```bash
npm run dev  # or `bun` if you are using bun
```

5. For desktop app development, install Tauri CLI:
```bash
npm install -g @tauri-apps/cli   # Install Tauri CLI
```

## Usage

- Access the web application at `http://localhost:5173`. (Port may vary based on your configuration)
- To run the desktop application:
```bash
npm run tauri dev  # Start the Tauri dev server
```

## Database Schema

Our database schema is designed to efficiently manage academic data. 
Including the separation in some schemas that help to organize the data in a more structured way.

![Database Schema](./static/db_erd.png "db main schema")

This separation allows for better organization and management of data.

## API Documentation

API documentation is available at `/{port}/docs` when running the development server. It provides detailed information about available endpoints, request/response formats, and authentication requirements.

## Contributing

We welcome contributions to Academic Hub! Please follow these steps to contribute:

1. Fork the repository
2. Create a new branch: `git checkout -b feature/your-feature-name`
3. Make your changes and commit them: `git commit -m 'Add some feature'`
4. Push to the branch: `git push origin feature/your-feature-name`
5. Submit a pull request

Please read our [Contributing Guide](CONTRIBUTING.md) for more details.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.