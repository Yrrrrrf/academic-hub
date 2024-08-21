<script lang="ts">
    import { onMount, getContext } from 'svelte';
    import { getMetadata } from '$lib/api/schema-generator';
    import type { SchemaTypes } from '$lib/api/schema-generator';
    import { fade, fly } from 'svelte/transition';
    import { api } from '$lib/api';
    import TableComponent from './TableComponent.svelte';

    const navbarState = getContext('navbarState');

    let schemaInfo: SchemaTypes = {};
    let loading = true;
    let error: string | null = null;
    let expandedSchemas: Record<string, boolean> = {};
    let searchQuery = '';

    onMount(async () => {
        try {
            schemaInfo = await getMetadata();
            expandedSchemas = Object.keys(schemaInfo).reduce((acc, schema) => {
                acc[schema] = false;
                return acc;
            }, {} as Record<string, boolean>);
            loading = false;

            if (navbarState) {
                navbarState.update(state => ({
                    ...state,
                    title: 'Manage Dashboard',
                    showSearch: true,
                    onSearch: handleSearch
                }));
            }
        } catch (err) {
            console.error('Failed to fetch schema information:', err);
            error = 'Failed to load schema information. Please try again later.';
            loading = false;
        }

        return () => {
            if (navbarState) {
                navbarState.update(state => ({
                    ...state,
                    title: 'Academic Hub',
                    showSearch: false,
                    onSearch: null
                }));
            }
        };
    });

    function toggleSchema(schema: string) {
        expandedSchemas[schema] = !expandedSchemas[schema];
        expandedSchemas = {...expandedSchemas};
    }

    async function handleCrudOperation(event: CustomEvent<{schema: string, table: string, operation: string, data?: any}>) {
        const { schema, table, operation, data } = event.detail;
        try {
            let result;
            switch (operation) {
                case 'GET':
                    result = await api[schema][table].getAll({ limit: '5' });
                    console.log(`GET result for ${schema}.${table}:`, result);
                    break;
                case 'POST':
                    result = await api[schema][table].create(data);
                    console.log(`Created new ${table} in ${schema}:`, result);
                    break;
                case 'PUT':
                    if (data && data.id) {
                        result = await api[schema][table].update(data.id, data);
                        console.log(`Updated ${table} in ${schema}:`, result);
                    } else {
                        console.error('Cannot update: missing id in data');
                    }
                    break;
                case 'DELETE':
                    if (data && data.id) {
                        await api[schema][table].delete(data.id);
                        console.log(`Deleted from ${table} in ${schema}`);
                    } else {
                        console.error('Cannot delete: missing id');
                    }
                    break;
            }
        } catch (err) {
            console.error(`Failed to perform ${operation} on ${schema}.${table}:`, err);
        }
    }

    function handleSearch(query: string) {
        searchQuery = query.toLowerCase();
    }

    $: filteredSchemaInfo = searchQuery
        ? Object.entries(schemaInfo).reduce((acc, [schema, tables]) => {
            const filteredTables = Object.entries(tables).filter(([table, columns]) =>
                table.toLowerCase().includes(searchQuery) ||
                Object.keys(columns).some(column => column.toLowerCase().includes(searchQuery))
            );
            if (filteredTables.length > 0) {
                acc[schema] = Object.fromEntries(filteredTables);
            }
            return acc;
        }, {} as SchemaTypes)
        : schemaInfo;
</script>

<svelte:head>
    <title>Manage Dashboard</title>
</svelte:head>

<div class="space-y-6">
    {#if loading}
        <p class="text-gray-600" in:fade>Loading schema information...</p>
    {:else if error}
        <p class="text-red-500" in:fade>{error}</p>
    {:else}
        {#each Object.entries(filteredSchemaInfo) as [schema, tables], i}
            <div
                    class="bg-white p-6 rounded-lg shadow-md hover:shadow-xl transition-shadow duration-300"
                    in:fly="{{ y: 50, duration: 300, delay: i * 150 }}"
            >
                <button
                        class="flex justify-between items-center w-full text-left focus:outline-none"
                        on:click={() => toggleSchema(schema)}
                >
                    <h2 class="text-2xl font-semibold text-gray-800">{schema}</h2>
                    <svg
                            class="w-6 h-6 transform transition-transform duration-300 ease-in-out {expandedSchemas[schema] ? 'rotate-180' : ''}"
                            fill="none"
                            stroke="currentColor"
                            viewBox="0 0 24 24"
                            xmlns="http://www.w3.org/2000/svg"
                    >
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                    </svg>
                </button>

                {#if expandedSchemas[schema]}
                    <div transition:fly="{{ y: -20, duration: 300 }}" class="mt-4 space-y-4">
                        {#each Object.entries(tables) as [table, columns], j}
                            <div in:fly="{{ y: 20, duration: 300, delay: j * 100 }}">
                                <TableComponent
                                        {schema}
                                        {table}
                                        {columns}
                                        on:crudOperation={handleCrudOperation}
                                />
                            </div>
                        {/each}
                    </div>
                {/if}
            </div>
        {/each}
    {/if}
</div>