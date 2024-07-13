<script lang="ts">
    import { testSupabaseConnection } from '$lib/api/testConn';
    import { onMount } from 'svelte';
    import { fade, fly } from 'svelte/transition';

    let connectionStatus = '';
    let metadataInfo: {
        databaseName: string;
        schemas: string[];
        publicTables: string[];
        loginSuccessful: boolean;
        user?: {
            id: string;
            email: string;
        };
    } | null = null;

    async function checkConnection() {
        connectionStatus = 'Checking connection and logging in...';
        const result = await testSupabaseConnection();
        connectionStatus = result.message;
        metadataInfo = result.success ? result.data || null : null;
    }

    // ... (rest of your existing script code)
</script>

<main class="min-h-screen bg-base-200 text-base-content">
    <div class="container mx-auto px-4 py-8">
        <header class="text-center mb-12" in:fade={{ duration: 1000 }}>
            <h1 class="text-4xl font-bold text-primary mb-2">Welcome to Academic Hub</h1>
            <p class="text-xl text-secondary">Empowering educational institutions with cutting-edge data management</p>
        </header>

        <div class="text-center mb-8">
            <button class="btn btn-secondary" on:click={checkConnection}>Test Supabase Connection and Login</button>
            {#if connectionStatus}
                <p class="mt-4 text-accent">{connectionStatus}</p>
            {/if}
            {#if metadataInfo}
                <div class="mt-4 text-left">
                    <h3 class="text-lg font-semibold">Connection and Login Information:</h3>
                    <p>Database Name: {metadataInfo.databaseName}</p>
                    <p>Schemas:</p>
                    <ul class="list-disc list-inside">
                        {#each metadataInfo.schemas as schema}
                            <li>{schema}</li>
                        {/each}
                    </ul>
                    <p>Public Tables:</p>
                    <ul class="list-disc list-inside">
                        {#each metadataInfo.publicTables as table}
                            <li>{table}</li>
                        {/each}
                    </ul>
                    <p>Login Successful: {metadataInfo.loginSuccessful ? 'Yes' : 'No'}</p>
                    {#if metadataInfo.user}
                        <p>Logged in User ID: {metadataInfo.user.id}</p>
                        <p>Logged in User Email: {metadataInfo.user.email}</p>
                    {/if}
                </div>
            {/if}
        </div>

        <!-- ... (rest of your existing HTML) -->
    </div>
</main>

<style>
    /* ... (any custom styles) */
</style>