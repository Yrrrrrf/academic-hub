<script lang="ts">
    import { api } from '$lib/api';
    import { onMount } from 'svelte';

    export let schema: string;
    export let table: string;

    let data: any[] = [];
    let loading = true;
    let error: string | null = null;

    onMount(async () => {
        await fetchData();
    });

    async function fetchData() {
        loading = true;
        error = null;
        try {
            data = await api[schema][table].getAll();
        } catch (err) {
            console.error(`Failed to fetch data for ${schema}.${table}:`, err);
            error = `Failed to fetch data for ${schema}.${table}. Please try again.`;
        } finally {
            loading = false;
        }
    }
</script>

{#if loading}
    <p>Loading data...</p>
{:else if error}
    <p class="text-red-500">{error}</p>
{:else if data.length > 0}
    <div class="mt-6 overflow-x-auto">
        <table class="min-w-full bg-white shadow-md rounded-lg overflow-hidden">
            <thead class="bg-gray-100">
                <tr>
                    {#each Object.keys(data[0]) as column}
                        <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">{column}</th>
                    {/each}
                </tr>
            </thead>
            <tbody class="divide-y divide-gray-200">
                {#each data as row}
                    <tr>
                        {#each Object.values(row) as value}
                            <td class="px-4 py-2 whitespace-nowrap text-sm text-gray-900">{value}</td>
                        {/each}
                    </tr>
                {/each}
            </tbody>
        </table>
    </div>
{:else}
    <p>No data available.</p>
{/if}
