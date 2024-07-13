<script>
    import { onMount } from 'svelte';
    import { fade, fly } from 'svelte/transition';

    let features = [
        { icon: '📚', title: 'Comprehensive Data Management', description: 'Handle student records, courses, and faculty information with ease.' },
        { icon: '🔄', title: 'Real-time Updates', description: 'Experience instant data synchronization across all platforms.' },
        { icon: '🖥️', title: 'Cross-platform Compatibility', description: 'Access via web browsers or as a desktop application.' },
        { icon: '📊', title: 'Scalable Architecture', description: 'Designed to efficiently manage large volumes of academic data.' },
        { icon: '🎨', title: 'User-friendly Interface', description: 'Intuitive design for enhanced user experience.' },
        { icon: '🔒', title: 'Secure Authentication', description: 'Role-based access control for data protection.' }
    ];

    let visibleFeatures = [];

    onMount(() => {
        const interval = setInterval(() => {
            if (visibleFeatures.length < features.length) {
                visibleFeatures = [...visibleFeatures, features[visibleFeatures.length]];
            } else {
                clearInterval(interval);
            }
        }, 500);

        return () => clearInterval(interval);
    });
</script>

<main class="min-h-screen bg-base-200 text-base-content">
    <div class="container mx-auto px-4 py-8">
        <header class="text-center mb-12" in:fade={{ duration: 1000 }}>
            <h1 class="text-4xl font-bold text-primary mb-2">Welcome to Academic Hub</h1>
            <p class="text-xl text-secondary">Empowering educational institutions with cutting-edge data management</p>
        </header>

        <section class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {#each visibleFeatures as feature, i}
                <div class="card bg-base-100 shadow-xl" in:fly={{ y: 50, duration: 500, delay: i * 100 }}>
                    <div class="card-body">
                        <span class="text-4xl mb-2">{feature.icon}</span>
                        <h2 class="card-title text-accent">{feature.title}</h2>
                        <p>{feature.description}</p>
                    </div>
                </div>
            {/each}
        </section>

        <footer class="text-center mt-12" in:fade={{ duration: 1000, delay: 2000 }}>
            <p class="mb-4">Start managing your academic data more efficiently today!</p>
            <button class="btn btn-primary">Get Started</button>
        </footer>
    </div>
</main>

<style>
    /* Any custom styles that can't be handled by DaisyUI classes */
    :global(body) {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
</style>