// src/lib/api/schemaGenerator.ts

import { apiClient } from './client';

export interface ColumnMetadata {
    name: string;
    type: string;
    is_primary_key: boolean;
    is_foreign_key: boolean;
}

export interface SchemaTypes {
    [schema: string]: {
        [table: string]: {
            [column: string]: string;
        };
    };
}

/**
 * Converts a PostgreSQL type to a TypeScript type
 * @param pgType PostgreSQL type
 * @returns Corresponding TypeScript type
 */
function mapPgTypeToTs(pgType: string): string {
    switch (pgType.toLowerCase()) {
        case 'integer':
        case 'bigint':
        case 'smallint':
        case 'decimal':
        case 'numeric':
        case 'real':
        case 'double precision':
            return 'number';
        case 'boolean':
            return 'boolean';
        case 'json':
        case 'jsonb':
            return 'object';
        case 'date':
        case 'timestamp':
        case 'timestamptz':
            return 'Date';
        default:
            return 'string';
    }
}

/**
 * Generates TypeScript interfaces based on database schema
 */
export async function generateSchemaTypes(): Promise<SchemaTypes> {
    const schemaTypes: SchemaTypes = {};

    try {
        const schemas = await apiClient.request<string[]>('/dt/schemas');

        for (const schema of schemas) {
            schemaTypes[schema] = {};
            const tables = await apiClient.request<string[]>(`/dt/${schema}/tables`);

            for (const table of tables) {
                schemaTypes[schema][table] = {};
                const columns = await apiClient.request<ColumnMetadata[]>(`/dt/${schema}/${table}/columns`);

                for (const column of columns) {
                    schemaTypes[schema][table][column.name] = mapPgTypeToTs(column.type);
                }
            }
        }

        return schemaTypes;
    } catch (error) {
        console.error('Error generating schema types:', error);
        throw error;
    }
}

/**
 * Generates TypeScript interface declarations as a string
 * @param schemaTypes Object containing schema types
 * @returns String of TypeScript interface declarations
 */
export function generateTypeDeclarations(schemaTypes: SchemaTypes): string {
    let declarations = '';

    for (const [schema, tables] of Object.entries(schemaTypes)) {
        declarations += `export namespace ${schema} {\n`;

        for (const [table, columns] of Object.entries(tables)) {
            declarations += `  export interface ${table.charAt(0).toUpperCase() + table.slice(1)} {\n`;

            for (const [column, type] of Object.entries(columns)) {
                declarations += `    ${column}: ${type};\n`;
            }

            declarations += '  }\n\n';
        }

        declarations += '}\n\n';
    }

    return declarations;
}

/**
 * Initializes the schema types when the app starts
 */
export async function initializeSchemaTypes(): Promise<void> {
    try {
        const schemaTypes = await generateSchemaTypes();
        const typeDeclarations = generateTypeDeclarations(schemaTypes);

        // Here you could write the type declarations to a file
        // or use them to create a dynamic type system in your app

        console.log('Schema types generated successfully');
        console.log(typeDeclarations);

        // Optionally, you could expose these types globally
        // window.__SCHEMA_TYPES__ = schemaTypes;
    } catch (error) {
        console.error('Failed to initialize schema types:', error);
    }
}

/**
 * Fetches and returns the complete database schema information.
 * @returns A promise that resolves to an object containing all schema, table, and column information.
 */
export async function getMetadata(): Promise<SchemaTypes> {
    try {
        const schemas = await apiClient.request<string[]>('/dt/schemas');
        const schemaInfo: SchemaTypes = {};

        for (const schema of schemas) {
            schemaInfo[schema] = {};
            const tables = await apiClient.request<string[]>(`/dt/${schema}/tables`);

            for (const table of tables) {
                const columns = await apiClient.request<ColumnMetadata[]>(`/dt/${schema}/${table}/columns`);
                schemaInfo[schema][table] = {};
                for (const column of columns) {
                    schemaInfo[schema][table][column.name] = column.type;
                }
            }
        }

        return schemaInfo;
    } catch (error) {
        console.error('Error fetching schema information:', error);
        throw error;
    }
}
