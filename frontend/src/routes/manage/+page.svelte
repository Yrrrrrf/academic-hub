<script lang="ts">
    import { onMount } from 'svelte';
    import { getMetadata } from '$lib/api/schema-generator';
    import type { SchemaTypes } from '$lib/api/schema-generator';
    import { fade, slide } from 'svelte/transition';
    import { api, initializeApi } from '$lib/api';

    let schemaInfo: SchemaTypes = {};
    let loading = true;
    let error: string | null = null;
    let expandedSchemas: Record<string, boolean> = {};
    let activeTable: Record<string, string | null> = {};
    let formData: Record<string, Record<string, Record<string, string>>> = {};

    onMount(async () => {
        try {
            await initializeApi(); // Initialize the API
            schemaInfo = await getMetadata();
            expandedSchemas = Object.fromEntries(
                Object.keys(schemaInfo).map(schema => [schema, false])
            );
            activeTable = Object.fromEntries(
                Object.keys(schemaInfo).map(schema => [schema, null])
            );
            formData = Object.fromEntries(
                Object.keys(schemaInfo).map(schema => [schema, {}])
            );
            loading = false;
        } catch (err) {
            console.error('Failed to initialize API or fetch schema information:', err);
            error = 'Failed to load schema information. Please try again later.';
            loading = false;
        }
    });

    function toggleSchema(schema: string): void {
        expandedSchemas[schema] = !expandedSchemas[schema];
        expandedSchemas = {...expandedSchemas};
    }

    function setActiveTable(schema: string, table: string): void {
        activeTable[schema] = activeTable[schema] === table ? null : table;
        activeTable = {...activeTable};
        if (activeTable[schema]) {
            formData[schema][table] = formData[schema][table] || {};
        }
    }

    function handleInputChange(event: Event, schema: string, table: string | null, column: string): void {
        if (table) {
            const value = (event.target as HTMLInputElement).value;
            if (!formData[schema]) formData[schema] = {};
            if (!formData[schema][table]) formData[schema][table] = {};
            formData[schema][table][column] = value;
            formData = {...formData};
        }
    }

    async function fetchAndPrintTableData(schema: string, table: string | null): Promise<void> {
        if (table && api[schema] && api[schema][table]) {
            try {
                const data = await api[schema][table].getAll();
                console.log(`Data for ${schema}.${table}:`, data);
            } catch (err) {
                console.error(`Failed to fetch data for ${schema}.${table}:`, err);
            }
        } else {
            console.error(`Invalid schema or table: ${schema}.${table}`);
        }
    }
</script>

<svelte:head>
    <title>Manage Dashboard</title>
</svelte:head>

<div class="container mx-auto p-4">
    <h1 class="text-3xl font-bold mb-6">Manage Dashboard</h1>

    {#if loading}
        <p class="text-gray-600" transition:fade>Loading schema information...</p>
    {:else if error}
        <p class="text-red-500" transition:fade>{error}</p>
    {:else}
        {#each Object.entries(schemaInfo) as [schema, tables]}
            <div class="mb-6 bg-white shadow rounded-lg p-4">
                <button
                        class="flex justify-between items-center w-full text-left focus:outline-none"
                        on:click={() => toggleSchema(schema)}
                >
                    <h2 class="text-xl font-semibold text-gray-800">{schema}</h2>
                    <svg
                            class="w-5 h-5 transform transition-transform duration-200"
                            class:rotate-180={expandedSchemas[schema]}
                            fill="none"
                            stroke="currentColor"
                            viewBox="0 0 24 24"
                            xmlns="http://www.w3.org/2000/svg"
                    >
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                    </svg>
                </button>

                {#if expandedSchemas[schema]}
                    <div transition:slide="{{ duration: 300 }}" class="mt-4 space-y-4">
                        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
                            {#each Object.keys(tables) as table}
                                <button
                                        on:click={() => setActiveTable(schema, table)}
                                        class="p-4 hover:bg-blue-100 text-blue-700 rounded-lg shadow transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-50"
                                        class:bg-blue-100={activeTable[schema] === table}
                                        class:bg-blue-50={activeTable[schema] !== table}
                                >
                                    <span class="font-medium">{table}</span>
                                </button>
                            {/each}
                        </div>

                        {#if activeTable[schema]}
                            <div transition:slide="{{ duration: 300 }}">
                                <h3 class="text-lg font-semibold mb-2">{activeTable[schema]} Metadata</h3>
                                <table class="w-full bg-white shadow-sm rounded-lg overflow-hidden">
                                    <thead class="bg-gray-50">
                                    <tr>
                                        <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider w-1/4">Column Name</th>
                                        <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider w-1/4">Type</th>
                                        <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Value</th>
                                    </tr>
                                    </thead>
                                    <tbody class="divide-y divide-gray-200">
                                    {#each Object.entries(tables[activeTable[schema]]) as [columnName, columnType]}
                                        <tr>
                                            <td class="px-4 py-2 whitespace-nowrap text-sm font-medium text-gray-900">{columnName}</td>
                                            <td class="px-4 py-2 whitespace-nowrap text-sm text-gray-500 italic">{columnType}</td>
                                            <td class="px-4 py-2">
                                                <input
                                                        type="text"
                                                        class="w-full px-2 py-1 border rounded-md"
                                                        value={formData[schema]?.[activeTable[schema]]?.[columnName] || ''}
                                                        on:input={(e) => handleInputChange(e, schema, activeTable[schema], columnName)}
                                                />
                                            </td>
                                        </tr>
                                    {/each}
                                    </tbody>
                                </table>
                                <button
                                        on:click={() => fetchAndPrintTableData(schema, activeTable[schema])}
                                        class="mt-4 px-4 py-2 bg-green-500 text-white rounded-md hover:bg-green-600 focus:outline-none focus:ring-2 focus:ring-green-500 focus:ring-opacity-50"
                                >
                                    Fetch and Print Table Data
                                </button>
                            </div>
                        {/if}
                    </div>
                {/if}
            </div>
        {/each}
    {/if}
</div>
