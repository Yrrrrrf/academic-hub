<script lang="ts">
    import { onMount } from 'svelte';
    import { fade, fly } from 'svelte/transition';

    interface Feature {
        icon: string;
        title: string;
        description: string;
    }

    const features: Feature[] = [
        { icon: '📚', title: 'Comprehensive Data Management', description: 'Handle student records, courses, and faculty information with ease.' },
        { icon: '🔄', title: 'Real-time Updates', description: 'Experience instant data synchronization across all platforms.' },
        { icon: '🖥️', title: 'Cross-platform Compatibility', description: 'Access via web browsers or as a desktop application.' },
        { icon: '📊', title: 'Scalable Architecture', description: 'Designed to efficiently manage large volumes of academic data.' },
        { icon: '🎨', title: 'User-friendly Interface', description: 'Intuitive design for enhanced user experience.' },
        { icon: '🔒', title: 'Secure Authentication', description: 'Role-based access control for data protection.' }
    ];

    let visibleFeatures: Feature[] = [];

    onMount(() => {
        const interval = setInterval(() => {
            if (visibleFeatures.length < features.length) {
                visibleFeatures = [...visibleFeatures, features[visibleFeatures.length]];
                // progress.set(visibleFeatures.length / features.length);
            } else {
                clearInterval(interval);
            }
        }, 500);

        return () => clearInterval(interval);
    });

    function handleGetStarted(): void {
        // Implement your "Get Started" logic here
        console.log("Get Started clicked");
    }
</script>

<main class="min-h-screen bg-gradient-to-br from-base-200 to-base-300 text-base-content">
    <div class="container mx-auto px-4 py-12">
        <header class="text-center mb-16" in:fade={{ duration: 1000 }}>
            <h1 class="text-5xl font-extrabold text-primary mb-4">Welcome to Academic Hub</h1>
            <p class="text-2xl text-secondary font-light">Empowering educational institutions with cutting-edge data management</p>
        </header>

        <section class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 mb-16">
            {#each visibleFeatures as feature, i (feature.title)}
                <div class="card bg-base-100 shadow-xl hover:shadow-2xl transition-shadow duration-300"
                     in:fly={{ y: 50, duration: 500, delay: i * 100 }}>
                    <div class="card-body">
                        <span class="text-5xl mb-4">{feature.icon}</span>
                        <h2 class="card-title text-accent text-2xl mb-2">{feature.title}</h2>
                        <p class="text-base-content/80">{feature.description}</p>
                    </div>
                </div>
            {/each}
        </section>

        <footer class="text-center" in:fade={{ duration: 1000, delay: 2000 }}>
            <p class="text-xl mb-6">Start managing your academic data more efficiently today!</p>
            <button on:click={handleGetStarted} class="btn btn-primary btn-lg hover:btn-secondary transition-colors duration-300">
                Get Started
            </button>
        </footer>
    </div>
</main>

<style>
    :global(body) {
        font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
</style>