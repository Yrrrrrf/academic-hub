<!-- src/routes/+layout.svelte -->
<script lang="ts">
    import { onMount } from 'svelte';
    import '../app.postcss';
    import NavBar from '$lib/components/NavBar.svelte';

    const services = [
        { name: 'School', href: '/school' },
        { name: 'Academic', href: '/academic' },
        { name: 'Library', href: '/library' },
        { name: 'Infrastructure', href: '/infrastructure' },
        { name: 'HR', href: '/hr' },
    ];

    let backgroundImage = '';

    onMount(() => {
        const randomIndex = Math.floor(Math.random() * 4) + 1;
        backgroundImage = `academic/school-0${randomIndex}.jpg`;
    });
</script>

<div class="flex flex-col min-h-screen bg-base-200 relative">
    <div
            class="absolute inset-0 bg-cover bg-center bg-no-repeat opacity-15"
            style="background-image: url('{backgroundImage}');"
    ></div>

    <div class="relative z-10 flex flex-col min-h-screen">
        <NavBar />
<!--        <NavBar services={[-->
<!--          { name: 'Custom Service 1', href: '/custom1' },-->
<!--          { name: 'Custom Service 2', href: '/custom2' },-->
<!--        ]} />-->

        <main class="flex-grow container mx-auto px-4 py-8">
            <slot />
        </main>

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