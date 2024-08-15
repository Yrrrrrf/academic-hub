<!-- src/routes/manage/+page.svelte -->
<script lang="ts">
    import { onMount } from 'svelte';
    import { getMetadata, type SchemaTypes } from '$lib/api/schema-generator';

    let schemaInfo: SchemaTypes = {};
    let loading = true;
    let error: string | null = null;

    onMount(async () => {
        try {
            schemaInfo = await getMetadata();
            loading = false;
        } catch (err) {
            console.error('Failed to fetch schema information:', err);
            error = 'Failed to load schema information. Please try again later.';
            loading = false;
        }
    });
</script>

<svelte:head>
    <title>Manage Dashboard</title>
</svelte:head>

<h1 class="text-3xl font-bold mb-6">Manage Dashboard</h1>

{#if loading}
    <p class="text-gray-600">Loading schema information...</p>
{:else if error}
    <p class="text-red-500">{error}</p>
{:else}
    <div class="space-y-8">
        {#each Object.entries(schemaInfo) as [schema, tables]}
            <div class="bg-white p-6 rounded-lg shadow-md">
                <h2 class="text-2xl font-semibold mb-4">{schema}</h2>
                <div class="space-y-4">
                    {#each Object.entries(tables) as [table, columns]}
                        <div class="border-t pt-4">
                            <h3 class="text-xl font-medium mb-2">{table}</h3>
                            <table class="w-full">
                                <thead>
                                <tr class="bg-gray-100">
                                    <th class="text-left py-2 px-4">Column</th>
                                    <th class="text-left py-2 px-4">Type</th>
                                </tr>
                                </thead>
                                <tbody>
                                {#each Object.entries(columns) as [column, type]}
                                    <tr class="border-b">
                                        <td class="py-2 px-4">{column}</td>
                                        <td class="py-2 px-4">{type}</td>
                                    </tr>
                                {/each}
                                </tbody>
                            </table>
                        </div>
                    {/each}
                </div>
            </div>
        {/each}
    </div>
{/if}