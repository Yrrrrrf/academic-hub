<!-- src/routes/+layout.svelte -->
<script lang="ts">
    import '../app.postcss';
    import NavBar from '$lib/components/NavBar.svelte';

    // You can customize the services list here if needed
    const services = [
        { name: 'School', href: '/school' },
        { name: 'Academic', href: '/academic' },
        { name: 'Library', href: '/library' },
        { name: 'Infrastructure', href: '/infrastructure' },
        { name: 'HR', href: '/hr' },
        { name: 'Dashboard', href: '/dashboard' },
        { name: 'Manage', href: '/manage' }
    ];
</script>

<div class="flex flex-col min-h-screen bg-base-200">
    <NavBar {services}>
<!--        <svelte:fragment slot="search">-->
<!--            <input type="text" placeholder="Search..." class="input input-bordered input-sm" />-->
<!--        </svelte:fragment>-->
    </NavBar>

    <main class="flex-grow container mx-auto px-4 py-8">
        <slot />
    </main>

    <footer class="bg-neutral text-neutral-content">
        <div class="container mx-auto px-4 py-6 text-center">
            <p>&copy; 2024 Academic Hub. All rights reserved.</p>
        </div>
    </footer>
</div>

<style>
    :global(body) {
        font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
</style>
