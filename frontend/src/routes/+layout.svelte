<!-- src/routes/+layout.svelte -->
<script lang="ts">
    import '../app.postcss';
    import { onMount } from 'svelte';
    import NavBar from '$lib/components/NavBar.svelte';
    import UrlDisplay from '$lib/components/URLDisplay.svelte';

    const services = [
        { name: 'School', href: '/school' },
        { name: 'Academic', href: '/academic' },
        { name: 'Library', href: '/library' },
        { name: 'Infrastructure', href: '/infrastructure' },
        { name: 'HR', href: '/hr' },
    ];

    let bgImg = '';

    onMount(() => {
        bgImg = `academic/school-0${Math.floor(Math.random() * 4) + 1}.jpg`;
    });
</script>

<div class="flex flex-col min-h-screen bg-base-200 relative">
    <div class="absolute inset-0 bg-cover bg-center bg-no-repeat opacity-15"
        style="background-image: url('{bgImg}');"
    ></div>

    <div class="relative z-10 flex flex-col min-h-screen">
        <NavBar />
        <!-- <NavBar services={services} /> -->  <!-- Uncomment this line to use the services prop -->

        <main class="flex-grow container mx-auto px-4 py-8">
            <slot />
        </main>

        <UrlDisplay />

        <footer class="bg-neutral text-neutral-content">
            <div class="container mx-auto px-4 py-6 text-center">
                <p>&copy; 2024 Academic Hub. All rights reserved.</p>
            </div>
        </footer>
    </div>
</div>

<style>
    :global(body) {
        font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
</style>
