<script lang="ts">
    import { onMount } from 'svelte';
    import AcademicSchedule from '../../lib/components/AcademicSchedule.svelte';

    export type Subject = {
        name: string;
        day: number;
        startHour: number;
        duration: number;
        color: string;
        icon: string;
        teacher: string;
        grade?: number;
    };

    export type Semester = {
        id: string;
        name: string;
        year: number;
        subjects: Subject[];
        gpa: number;
    };

    let semesters: Semester[] = [
        {
        id: "fall2023",
        name: "Fall",
        year: 2023,
        subjects: [
            { name: "Mathematics", day: 1, startHour: 9, duration: 2, color: "#3B82F6", icon: "∑", teacher: "Dr. Smith", grade: 85 },
            { name: "Physics", day: 2, startHour: 11, duration: 2, color: "#10B981", icon: "φ", teacher: "Prof. Johnson", grade: 78 },
            { name: "Literature", day: 3, startHour: 14, duration: 2, color: "#F59E0B", icon: "📚", teacher: "Ms. Davis", grade: 92 },
            { name: "History", day: 4, startHour: 10, duration: 2, color: "#8B5CF6", icon: "H", teacher: "Dr. Brown", grade: 88 },
        ],
        gpa: 3.4,
        },
        {
        id: "spring2024",
        name: "Spring",
        year: 2024,
        subjects: [
            { name: "Chemistry", day: 1, startHour: 13, duration: 2, color: "#EF4444", icon: "⚗️", teacher: "Dr. White", grade: 81 },
            { name: "Biology", day: 2, startHour: 14, duration: 2, color: "#EC4899", icon: "🧬", teacher: "Prof. Green", grade: 89 },
            { name: "Computer Science", day: 3, startHour: 9, duration: 2, color: "#6366F1", icon: "💻", teacher: "Mr. Black", grade: 95 },
            { name: "Art", day: 5, startHour: 9, duration: 2, color: "#F97316", icon: "🎨", teacher: "Ms. Gray", grade: 87 },
        ],
        gpa: 3.6,
        },
    ];

    let selectedSemester: Semester = semesters[0];

    function selectSemester(semester: Semester) {
        selectedSemester = semester;
    }

    onMount(() => {
        selectedSemester = semesters[0];
    });
</script>

<div class="semester-review">
    <h2>Semester Review</h2>
    
    <div class="semester-tabs">
    {#each semesters as semester}
        <button 
        class="semester-tab" 
        class:active={selectedSemester.id === semester.id}
        on:click={() => selectSemester(semester)}
        >
        {semester.name} {semester.year}
        </button>
    {/each}
    </div>

    <div class="semester-content">
    <div class="schedule">
        <h3>Class Schedule</h3>
        <AcademicSchedule subjects={selectedSemester.subjects} />
    </div>

    <div class="grades">
        <h3>Grades Overview</h3>
        <p>Semester GPA: {selectedSemester.gpa.toFixed(2)}</p>
        <ul>
        {#each selectedSemester.subjects as subject}
            <li>
            <span>{subject.name}</span>
            <span>{subject.grade}%</span>
            </li>
        {/each}
        </ul>
    </div>
    </div>
</div>

<style>
    .semester-review {
    background-color: #ffffff;
    border-radius: 8px;
    padding: 20px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    h2 {
    font-size: 1.5rem;
    margin-bottom: 1rem;
    }

    .semester-tabs {
    display: flex;
    gap: 10px;
    margin-bottom: 1rem;
    }

    .semester-tab {
    padding: 8px 16px;
    border: none;
    background-color: #f0f0f0;
    border-radius: 4px;
    cursor: pointer;
    }

    .semester-tab.active {
    background-color: #3B82F6;
    color: white;
    }

    .semester-content {
    display: grid;
    grid-template-columns: 2fr 1fr;
    gap: 20px;
    }

    .grades ul {
    list-style-type: none;
    padding: 0;
    }

    .grades li {
    display: flex;
    justify-content: space-between;
    margin-bottom: 0.5rem;
    }
</style>
