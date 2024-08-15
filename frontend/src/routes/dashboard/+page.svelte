<script lang="ts">
    import { onMount } from 'svelte';

    let grades = [];
    let loans = [];
    let averageGrade = 0;

    onMount(async () => {
        // Simulate API calls to fetch data
        grades = await fetchGrades();
        loans = await fetchLoans();
        averageGrade = calculateAverageGrade(grades);
    });

    async function fetchGrades() {
        // Simulate API call
        return [
            { course: 'Math', grade: 85 },
            { course: 'Science', grade: 92 },
            { course: 'History', grade: 78 },
            { course: 'Literature', grade: 88 },
            { course: 'Physical Education', grade: 95 },
        ];
    }

    async function fetchLoans() {
        // Simulate API call
        return [
            { book: 'The Great Gatsby', dueDate: '2024-08-20' },
            { book: 'To Kill a Mockingbird', dueDate: '2024-08-25' },
            { book: '1984', dueDate: '2024-08-30' },
        ];
    }

    function calculateAverageGrade(grades) {
        if (grades.length === 0) return 0;
        const sum = grades.reduce((acc, grade) => acc + grade.grade, 0);
        return Math.round(sum / grades.length);
    }
</script>

<svelte:head>
    <title>Dashboard | Academic Hub</title>
</svelte:head>

<div class="p-6 max-w-7xl mx-auto">
    <h1 class="text-3xl font-bold mb-6">Student Dashboard</h1>

    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <!-- Grade Widget -->
        <div class="bg-base-200 p-6 rounded-lg shadow-lg">
            <h2 class="text-xl font-semibold mb-4">Recent Grades</h2>
            <ul class="space-y-2">
                {#each grades as grade}
                    <li class="flex justify-between items-center">
                        <span>{grade.course}</span>
                        <span class="font-semibold">{grade.grade}%</span>
                    </li>
                {/each}
            </ul>
        </div>

        <!-- Average Grade Widget -->
        <div class="bg-base-200 p-6 rounded-lg shadow-lg flex flex-col items-center justify-center">
            <h2 class="text-xl font-semibold mb-4">Average Grade</h2>
            <div class="text-4xl font-bold">{averageGrade}%</div>
        </div>

        <!-- Library Loans Widget -->
        <div class="bg-base-200 p-6 rounded-lg shadow-lg">
            <h2 class="text-xl font-semibold mb-4">Library Loans</h2>
            <ul class="space-y-2">
                {#each loans as loan}
                    <li>
                        <span class="font-semibold">{loan.book}</span>
                        <br>
                        <span class="text-sm">Due: {loan.dueDate}</span>
                    </li>
                {/each}
            </ul>
        </div>

        <!-- Placeholder for future widget -->
        <div class="bg-base-200 p-6 rounded-lg shadow-lg flex items-center justify-center">
            <p class="text-lg text-center">Future Widget Placeholder</p>
        </div>
    </div>
</div>
