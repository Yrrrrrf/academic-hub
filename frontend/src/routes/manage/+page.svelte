<script lang="ts">
    import { onMount } from 'svelte';
    import { getMetadata } from '$lib/api/schema-generator';
    import type { SchemaTypes } from '$lib/api/schema-generator';
    import { initializeApi } from '$lib/api';
    import { schemaStore } from '$lib/stores/schemaStore';
    import SchemaAccordion from '$lib/components/SchemaAccordion.svelte';
    import LoadingIndicator from '$lib/components/LoadingIndicator.svelte';
    import ErrorDisplay from '$lib/components/ErrorDisplay.svelte';

    let loading = true;
    let error: string | null = null;

    onMount(async () => {
        try {
            await initializeApi();
            const schemaInfo = await getMetadata();
            schemaStore.set(schemaInfo);
            loading = false;
        } catch (err) {
            console.error('Failed to initialize API or fetch schema information:', err);
            error = 'Failed to load schema information. Please try again later.';
            loading = false;
        }
    });
</script>

<svelte:head>
    <title>Manage Dashboard</title>
</svelte:head>

<div class="container mx-auto p-4">
    <h1 class="text-3xl font-bold mb-6">Manage Dashboard</h1>

    {#if loading}
        <LoadingIndicator />
    {:else if error}
        <ErrorDisplay {error} />
    {:else}
        <SchemaAccordion />
    {/if}
</div>
