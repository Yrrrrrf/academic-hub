<script lang="ts">
    import { onMount } from 'svelte';
    import { user } from '$lib/stores/user';
    import { tweened } from 'svelte/motion';
    import { cubicOut } from 'svelte/easing';
    import AcademicSchedule from '$lib/components/AcademicSchedule.svelte';
    import StudentCard from './StudentCard.svelte';
    
    let student = {
        name: "Jane Doe",
        id: "12345678",
        major: "Computer Science",
        enrollmentYear: 2021,
        subjects: [
            { id: "MATH101", name: "Calculus I", grade: 85, credits: 4, semester: 1, year: 2021 },
            { id: "CS101", name: "Introduction to Programming", grade: 92, credits: 3, semester: 1, year: 2021 },
            { id: "ENG101", name: "English Composition", grade: 88, credits: 3, semester: 1, year: 2021 },
            { id: "PHYS101", name: "Physics I", grade: 78, credits: 4, semester: 2, year: 2022 },
            { id: "CS201", name: "Data Structures", grade: 90, credits: 3, semester: 2, year: 2022 },
            { id: "MATH201", name: "Linear Algebra", grade: 82, credits: 3, semester: 2, year: 2022 },
            { id: "CS301", name: "Algorithms", grade: 88, credits: 4, semester: 3, year: 2022 },
            { id: "CS302", name: "Database Systems", grade: 85, credits: 3, semester: 3, year: 2022 },
            { id: "STAT201", name: "Statistics for Engineers", grade: 79, credits: 3, semester: 3, year: 2022 },
            { id: "CS401", name: "Artificial Intelligence", grade: 91, credits: 4, semester: 4, year: 2023 },
            { id: "CS402", name: "Computer Networks", grade: 87, credits: 3, semester: 4, year: 2023 },
            { id: "CS403", name: "Software Engineering", grade: 89, credits: 3, semester: 4, year: 2023 },
        ]
    };
    
    let currentSchedule = [
        { name: "Calculus I", day: 1, startHour: 9, duration: 2, color: "#3B82F6", icon: "∑" },
        { name: "Introduction to Programming", day: 2, startHour: 11, duration: 2, color: "#10B981", icon: "💻" },
        { name: "English Composition", day: 3, startHour: 14, duration: 2, color: "#F59E0B", icon: "📝" },
        { name: "Physics I", day: 4, startHour: 10, duration: 2, color: "#EF4444", icon: "⚛️" },
        { name: "Data Structures", day: 5, startHour: 13, duration: 2, color: "#8B5CF6", icon: "🌳" },
    ];

    let loans = [
        { book_copy_id: 'The Great Gatsby', due_date: '2024-08-20' },
        { book_copy_id: 'To Kill a Mockingbird', due_date: '2024-08-25' },
        { book_copy_id: '1984', due_date: '2024-08-30' },
    ];
    
    let activeTab = 'overview';
    
    const averageGrade = tweened(0, {
        duration: 2000,
        easing: cubicOut
    });
    
    const gpa = tweened(0, {
        duration: 2000,
        easing: cubicOut
    });
    
    const progress = tweened(0, {
        duration: 2000,
        easing: cubicOut
    });
    
    function calculateGPA(subjects) {
        const totalPoints = subjects.reduce((sum, subject) => sum + subject.grade * subject.credits, 0);
        const totalCredits = subjects.reduce((sum, subject) => sum + subject.credits, 0);
        return totalPoints / totalCredits;
    }
    
    function calculateProgress(subjects) {
        const totalCredits = subjects.reduce((sum, subject) => sum + subject.credits, 0);
        const requiredCredits = 120; // Assuming 120 credits are required for graduation
        return (totalCredits / requiredCredits) * 100;
    }
    
    onMount(() => {
        const calculatedAverage = student.subjects.reduce((sum, subject) => sum + subject.grade, 0) / student.subjects.length;
        averageGrade.set(calculatedAverage);
        gpa.set(calculateGPA(student.subjects));
        progress.set(calculateProgress(student.subjects));
    });
    
    const currentYear = new Date().getFullYear();
    const yearOfStudy = currentYear - student.enrollmentYear + 1;
    </script>
    
    <svelte:head>
        <title>Academic Dashboard | Academic Hub</title>
    </svelte:head>
    
    <div class="container mx-auto p-6 space-y-6 bg-gray-50 min-h-screen">
        <header class="mb-8">
            <StudentCard 
                name={student.name}
                id={student.id}
                major={student.major}
                enrollmentYear={student.enrollmentYear}
                gpa={$gpa}
            />
        </header>
    
        <nav class="tabs bg-white shadow-md rounded-lg mb-8">
            <button class:active={activeTab === 'overview'} on:click={() => activeTab = 'overview'}>Overview</button>
            <button class:active={activeTab === 'subjects'} on:click={() => activeTab = 'subjects'}>Subjects</button>
            <button class:active={activeTab === 'progress'} on:click={() => activeTab = 'progress'}>Progress</button>
            <button class:active={activeTab === 'statistics'} on:click={() => activeTab = 'statistics'}>Statistics</button>
        </nav>
    
        <div class="text-center mb-8">
            <a href="/academic/subject-manager" class="bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-600 transition-colors">
                Manage Subjects
            </a>
        </div>

        {#if activeTab === 'overview'}
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <!-- ... (previous overview cards remain the same) -->

                <!-- Library Loans Widget -->
                <div class="card">
                    <h2 class="card-title">Library Loans</h2>
                    <div class="card-content">
                        <ul class="space-y-2">
                            {#each loans as loan}
                                <li class="flex justify-between items-center">
                                    <span>{loan.book_copy_id}</span>
                                    <span class="text-sm">{loan.due_date}</span>
                                </li>
                            {/each}
                        </ul>
                    </div>
                </div>

                <!-- Average Grade Widget -->
                <div class="card">
                    <h2 class="card-title">Average Grade</h2>
                    <div class="card-content flex justify-center items-center">
                        <div class="radial-progress" style="--value:{$averageGrade}; --size:8rem; --thickness: 1rem;">
                            <div class="text-2xl font-bold">{$averageGrade.toFixed(1)}%</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Academic Schedule -->
            <div class="card mt-6">
                <h2 class="card-title">Current Semester Schedule</h2>
                <div class="card-content">
                    <AcademicSchedule subjects={currentSchedule} />
                </div>
            </div>
        {/if}

        {#if activeTab === 'subjects'}
            <div class="card">
                <h2 class="card-title">Subject List</h2>
                <div class="card-content">
                    <table class="w-full">
                        <thead>
                            <tr>
                                <th class="text-left">Subject</th>
                                <th class="text-center">Grade</th>
                                <th class="text-center">Credits</th>
                                <th class="text-center">Year</th>
                                <th class="text-center">Semester</th>
                            </tr>
                        </thead>
                        <tbody>
                            {#each student.subjects as subject}
                                <tr>
                                    <td>{subject.name}</td>
                                    <td class="text-center">{subject.grade}</td>
                                    <td class="text-center">{subject.credits}</td>
                                    <td class="text-center">{subject.year}</td>
                                    <td class="text-center">{subject.semester}</td>
                                </tr>
                            {/each}
                        </tbody>
                    </table>
                </div>
            </div>
        {/if}
    
        {#if activeTab === 'progress'}
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="card">
                    <h2 class="card-title">Degree Progress</h2>
                    <div class="card-content">
                        <div class="progress-item">
                            <div class="flex justify-between items-center mb-2">
                                <span class="font-semibold">Overall Progress</span>
                                <span class="text-2xl font-bold">{$progress.toFixed(1)}%</span>
                            </div>
                            <div class="progress-bar">
                                <div class="progress" style="width: {$progress}%"></div>
                            </div>
                        </div>
                        <div class="progress-item">
                            <div class="flex justify-between items-center mb-2">
                                <span class="font-semibold">Credits Completed</span>
                                <span class="text-xl font-bold">
                                    {student.subjects.reduce((sum, subject) => sum + subject.credits, 0)} / 120
                                </span>
                            </div>
                            <div class="progress-bar">
                                <div class="progress" style="width: {(student.subjects.reduce((sum, subject) => sum + subject.credits, 0) / 120) * 100}%"></div>
                            </div>
                        </div>
                    </div>
                </div>
    
                <div class="card">
                    <h2 class="card-title">Year-wise Progress</h2>
                    <div class="card-content">
                        {#each [...new Set(student.subjects.map(s => s.year))] as year}
                            {@const yearCredits = student.subjects
                                .filter(s => s.year === year)
                                .reduce((sum, subject) => sum + subject.credits, 0)}
                            <div class="progress-item">
                                <div class="flex justify-between items-center mb-2">
                                    <span class="font-semibold">{year}</span>
                                    <span class="text-xl font-bold">{yearCredits} credits</span>
                                </div>
                                <div class="progress-bar">
                                    <div class="progress" style="width: {(yearCredits / 30) * 100}%"></div>
                                </div>
                            </div>
                        {/each}
                    </div>
                </div>
            </div>
        {/if}
    
        {#if activeTab === 'statistics'}
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="card">
                    <h2 class="card-title">Performance Metrics</h2>
                    <div class="card-content">
                        <div class="info-item">
                            <span class="font-semibold">Highest Grade</span>
                            <span class="text-xl font-bold">
                                {Math.max(...student.subjects.map(s => s.grade))}
                            </span>
                        </div>
                        <div class="info-item">
                            <span class="font-semibold">Lowest Grade</span>
                            <span class="text-xl font-bold">
                                {Math.min(...student.subjects.map(s => s.grade))}
                            </span>
                        </div>
                        <div class="info-item">
                            <span class="font-semibold">Average Grade</span>
                            <span class="text-xl font-bold">
                                {(student.subjects.reduce((sum, s) => sum + s.grade, 0) / student.subjects.length).toFixed(2)}
                            </span>
                        </div>
                        <div class="info-item">
                            <span class="font-semibold">Total Subjects</span>
                            <span class="text-xl font-bold">{student.subjects.length}</span>
                        </div>
                    </div>
                </div>
    
                <div class="card">
                    <h2 class="card-title">Grade Distribution</h2>
                    <div class="card-content">
                        {#each ['A', 'B', 'C', 'D', 'F'] as grade}
                            {@const count = student.subjects.filter(s => {
                                if (grade === 'A') return s.grade >= 90;
                                if (grade === 'B') return s.grade >= 80 && s.grade < 90;
                                if (grade === 'C') return s.grade >= 70 && s.grade < 80;
                                if (grade === 'D') return s.grade >= 60 && s.grade < 70;
                                return s.grade < 60;
                            }).length}
                            <div class="progress-item">
                                <div class="flex items-center">
                                    <span class="w-8 font-semibold">{grade}:</span>
                                    <div class="progress-bar flex-grow">
                                        <div class="progress" style="width: {(count / student.subjects.length) * 100}%"></div>
                                    </div>
                                    <span class="w-8 text-right">{count}</span>
                                </div>
                            </div>
                        {/each}
                    </div>
                </div>
            </div>
        {/if}
    </div>
    
    <style>
        .container {
            font-family: Arial, sans-serif;
        }
        .tabs {
            display: flex;
            justify-content: center;
            margin-bottom: 2rem;
        }
        .tabs button {
            background: none;
            border: none;
            padding: 0.5rem 1rem;
            margin: 0 0.5rem;
            font-size: 1rem;
            cursor: pointer;
            border-bottom: 2px solid transparent;
            transition: all 0.3s ease;
        }
        .tabs button.active {
            border-bottom: 2px solid #3B82F6;
            font-weight: bold;
        }
        .card {
            background-color: white;
            border-radius: 0.5rem;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }
        .card-title {
            font-size: 1.25rem;
            font-weight: bold;
            margin-bottom: 1rem;
        }
        .card-content {
            font-size: 0.9rem;
        }
        .info-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
        }
        .progress-item {
            margin-bottom: 1rem;
        }
        .progress-bar {
            background-color: #E5E7EB;
            border-radius: 9999px;
            height: 0.5rem;
            overflow: hidden;
        }
        .progress {
            background-color: #3B82F6;
            height: 100%;
            transition: width 0.5s ease-out;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 0.75rem;
            text-align: left;
            border-bottom: 1px solid #E5E7EB;
        }
        th {
            background-color: #F3F4F6;
            font-weight: bold;
        }
        .radial-progress {
            --value: 0;
            --size: 8rem;
            --thickness: 1rem;
            width: var(--size);
            height: var(--size);
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            background: 
                radial-gradient(closest-side, white 79%, transparent 80% 100%),
                conic-gradient(#3B82F6 calc(var(--value) * 1%), #E5E7EB 0);
        }
        .radial-progress::before {
            content: attr(data-value);
        }
    </style>