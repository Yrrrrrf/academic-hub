<!-- src/lib/components/NavBar.svelte -->
<script lang="ts">
    import { page } from '$app/stores';
    import { fly } from 'svelte/transition';
    import { clickOutside } from '../../routes/clickOutside';

    export let services = [
        { name: 'School', href: '/school' },
        { name: 'Academic', href: '/academic' },
        { name: 'Library', href: '/library' },
        { name: 'Infrastructure', href: '/infrastructure' },
        { name: 'HR', href: '/hr' },
        { name: 'Dashboard', href: '/dashboard' }
    ];

    let showServices = false;

    function toggleServices() {
        showServices = !showServices;
    }

    function closeServices() {
        showServices = false;
    }
</script>

<header class="bg-primary text-primary-content shadow-lg">
    <nav class="container mx-auto px-4 py-3">
        <div class="flex justify-between items-center">
            <!-- Logo slot -->
            <slot name="logo">
                <a href="/" class="flex items-center space-x-2">
                    <img src="favicon.png" alt="Academic Hub Icon" class="w-8 h-8">
                    <span class="text-xl font-bold hidden md:inline">Academic Hub</span>
                </a>
            </slot>

            <div class="flex items-center space-x-4">
                <!-- Search bar slot -->
                <slot name="search">
                    <!-- Default: No search bar -->
                </slot>

                <!-- Dashboard link slot -->
                <slot name="dashboard">
                    <a href="/dashboard" class="hover:text-secondary">Dashboard</a>
                </slot>

                <!-- Services dropdown -->
                <div class="relative" use:clickOutside on:click_outside={closeServices}>
                    <button
                            on:click={toggleServices}
                            class="flex items-center space-x-1 hover:text-secondary"
                    >
                        <span>Services</span>
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                        </svg>
                    </button>
                    {#if showServices}
                        <div
                                class="absolute right-0 mt-2 w-48 bg-base-100 rounded-md shadow-lg py-1 z-10"
                                in:fly="{{ y: -5, duration: 300 }}"
                                out:fly="{{ y: -5, duration: 300 }}"
                        >
                            {#each services as service}
                                <a
                                        href={service.href}
                                        class="block px-4 py-2 text-sm text-base-content hover:bg-base-200"
                                        class:font-bold={$page.url.pathname === service.href}
                                >
                                    {service.name}
                                </a>
                            {/each}
                        </div>
                    {/if}
                </div>

                <!-- Profile slot -->
                <slot name="profile">
                    <a href="/profile" class="hover:text-secondary">Profile</a>
                </slot>
            </div>
        </div>
    </nav>
</header>
