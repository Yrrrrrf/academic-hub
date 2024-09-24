<script lang="ts">
    import { fade } from 'svelte/transition';

    export type Subject = {
        name: string;
        day: number;
        startHour: number;
        duration: number;
        color: string;
        icon: string;
    };

    export let subjects: Subject[] = [];

    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
    const hours = Array.from({ length: 9 }, (_, i) => i + 8); // 8 AM to 4 PM

    let hoveredSubject: Subject | null = null;

    function handleMouseEnter(subject: Subject) {
        hoveredSubject = subject;
    }

    function handleMouseLeave() {
        hoveredSubject = null;
    }
</script>

<div class="schedule-container">
    <header class="header">
    <h1>Semester Schedule</h1>
    <p>Fall 2023</p>
    </header>

    <div class="schedule-grid">
    <div class="time-header">Time</div>
    {#each days as day}
        <div class="day-header">{day}</div>
    {/each}
    {#each hours as hour}
        <div class="hour-cell">{hour}:00 - {hour + 1}:00</div>
        {#each days as _, dayIndex}
        <div class="schedule-cell">
            {#each subjects.filter(subject => 
            subject.day === dayIndex + 1 && 
            subject.startHour <= hour && 
            hour < subject.startHour + subject.duration
            ) as subject (subject.name)}
            <div
                class="subject-block"
                style="
                top: {(subject.startHour - hour) * 100}%;
                height: {subject.duration * 100}%;
                background-color: {subject.color};
                "
                on:mouseenter={() => handleMouseEnter(subject)}
                on:mouseleave={handleMouseLeave}
            >
                <div class="subject-content">
                <span class="subject-icon">{subject.icon}</span>
                <span class="subject-name">{subject.name}</span>
                </div>
                <div class="subject-time">
                {subject.startHour}:00 - {subject.startHour + subject.duration}:00
                </div>
            </div>
            {/each}
        </div>
        {/each}
    {/each}
    </div>

    {#if hoveredSubject}
    <div class="subject-details" transition:fade>
        <h3>
        <span class="subject-icon">{hoveredSubject.icon}</span>
        {hoveredSubject.name}
        </h3>
        <p>
        Every {days[hoveredSubject.day - 1]}, 
        {hoveredSubject.startHour}:00 - {hoveredSubject.startHour + hoveredSubject.duration}:00
        </p>
    </div>
    {/if}
</div>

<style>
    .schedule-container {
    font-family: Arial, sans-serif;
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
    background-color: #f5f5f5;
    }

    .header {
    text-align: center;
    margin-bottom: 20px;
    }

    h1 {
    font-size: 2rem;
    color: #333;
    }

    .schedule-grid {
    display: grid;
    grid-template-columns: auto repeat(5, 1fr);
    gap: 1px;
    background-color: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    .time-header, .day-header {
    background-color: #333;
    color: white;
    padding: 10px;
    text-align: center;
    font-weight: bold;
    }

    .hour-cell {
    background-color: #f0f0f0;
    padding: 10px;
    text-align: center;
    font-size: 0.8rem;
    }

    .schedule-cell {
    position: relative;
    height: 60px;
    border: 1px solid #e0e0e0;
    }

    .subject-block {
    position: absolute;
    left: 0;
    right: 0;
    padding: 5px;
    color: white;
    font-size: 0.8rem;
    overflow: hidden;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    transition: all 0.2s ease-in-out;
    border-radius: 4px;
    margin: 1px;
    }

    .subject-block:hover {
    transform: scale(1.05);
    z-index: 10;
    }

    .subject-content {
    display: flex;
    align-items: center;
    }

    .subject-icon {
    margin-right: 5px;
    }

    .subject-name {
    font-weight: bold;
    }

    .subject-time {
    font-size: 0.7rem;
    opacity: 0.8;
    }

    .subject-details {
    position: fixed;
    bottom: 20px;
    right: 20px;
    background-color: white;
    padding: 15px;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    max-width: 300px;
    }

    .subject-details h3 {
    margin: 0 0 10px 0;
    display: flex;
    align-items: center;
    }

    .subject-details p {
    margin: 0;
    font-size: 0.9rem;
    color: #666;
    }
</style>
