<script lang="ts">
    import { page } from '$app/stores';
    import { fly } from 'svelte/transition';
    import { clickOutside } from '../../routes/clickOutside';
    import SearchBar from './SearchBar.svelte';

    type ServiceItem = {
        name: string;
        href: string;
    };

    export let services: ServiceItem[] = [
        { name: "Manage", href: "/manage" },
        { name: "Some", href: "/some" },
        { name: "Another", href: "/another" }
    ];

    let showServices = false;

    function toggleServices() {
        showServices = !showServices;
    }

    function closeServices() {
        showServices = false;
    }

    function handleSearch(event: CustomEvent<string>) {
        const query = event.detail;
        console.log('Searching for:', query);
        // Implement search functionality here
    }
</script>

<header class="bg-primary text-primary-content shadow-lg">
    <nav class="container mx-auto px-4 py-3">
        <div class="flex justify-between items-center">
            <!-- TODO: Add logo slot here -->
            <a href="/" class="flex items-center space-x-2">
                <span class="text-xl font-bold">Academic Hub</span>
            </a>

            <div class="flex items-center space-x-4">
                <!-- TODO: Add search slot here -->
                <div class="relative">
                    <SearchBar on:search={handleSearch} />
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                    </svg>
                </div>

                <!-- TODO: Add dashboard slot here -->
                <a href="/dashboard" class="hover:text-secondary">Dashboard</a>

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
                            <!-- TODO: Add services slot here -->
                            {#each services as service}
                                <a
                                        href={service.href}
                                        class="block px-4 py-2 text-sm text-base-content hover:bg-base-200"
                                        class:font-bold={$page.url.pathname === service.href}
                                >
                                    {service.name}
                                </a>
                            {/each}
                            <div class="border-t border-base-300 my-1"></div>
                            <a
                                    href="/settings"
                                    class="block px-4 py-2 text-sm text-accent hover:bg-base-200"
                                    class:font-bold={$page.url.pathname === '/settings'}
                            >
                                Settings
                            </a>
                        </div>
                    {/if}
                </div>

                <!-- TODO: Add profile slot here -->
                <a href="/profile" class="hover:text-secondary">Profile</a>
            </div>
        </div>
    </nav>
</header>