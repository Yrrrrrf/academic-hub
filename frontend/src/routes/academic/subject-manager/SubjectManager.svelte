<script lang="ts">
    import { onMount } from 'svelte';
    import AcademicSchedule from '$lib/components/AcademicSchedule.svelte';
    
    type Subject = {
      id: string;
      name: string;
      code: string;
      credits: number;
      day?: number;
      startHour?: number;
      duration?: number;
      color?: string;
      icon?: string;
    };
    
    let allSubjects: Subject[] = [
      { id: "MATH101", name: "Calculus I", code: "MATH101", credits: 4, day: 1, startHour: 9, duration: 2, color: "#3B82F6", icon: "∑" },
      { id: "CS101", name: "Introduction to Programming", code: "CS101", credits: 3, day: 2, startHour: 11, duration: 2, color: "#10B981", icon: "💻" },
      { id: "ENG101", name: "English Composition", code: "ENG101", credits: 3, day: 3, startHour: 14, duration: 2, color: "#F59E0B", icon: "📝" },
      { id: "PHYS101", name: "Physics I", code: "PHYS101", credits: 4, day: 4, startHour: 10, duration: 2, color: "#EF4444", icon: "⚛️" },
      { id: "CHEM101", name: "General Chemistry", code: "CHEM101", credits: 4, day: 5, startHour: 13, duration: 2, color: "#8B5CF6", icon: "⚗️" },
      { id: "BIO101", name: "Introduction to Biology", code: "BIO101", credits: 4, day: 1, startHour: 13, duration: 2, color: "#EC4899", icon: "🧬" },
      { id: "HIST101", name: "World History", code: "HIST101", credits: 3, day: 2, startHour: 15, duration: 2, color: "#F97316", icon: "🌍" },
      { id: "ECON101", name: "Principles of Economics", code: "ECON101", credits: 3, day: 3, startHour: 11, duration: 2, color: "#14B8A6", icon: "📊" },
      { id: "PSYCH101", name: "Introduction to Psychology", code: "PSYCH101", credits: 3, day: 4, startHour: 14, duration: 2, color: "#6366F1", icon: "🧠" },
      { id: "ART101", name: "Introduction to Art", code: "ART101", credits: 3, day: 5, startHour: 9, duration: 2, color: "#F43F5E", icon: "🎨" },
    ];
    
    let availableSubjects: Subject[] = [];
    let enrolledSubjects: Subject[] = [];
    let searchTerm = "";
    
    $: filteredSubjects = availableSubjects.filter(subject => 
      subject.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
      subject.code.toLowerCase().includes(searchTerm.toLowerCase())
    );
    
    function addSubject(subject: Subject) {
      if (enrolledSubjects.some(s => s.id === subject.id)) {
        showToast("Already Enrolled", `You are already enrolled in ${subject.name}.`, "error");
      } else {
        enrolledSubjects = [...enrolledSubjects, subject];
        availableSubjects = availableSubjects.filter(s => s.id !== subject.id);
        showToast("Subject Added", `${subject.name} has been added to your schedule.`, "success");
      }
    }
    
    function removeSubject(subject: Subject) {
      enrolledSubjects = enrolledSubjects.filter(s => s.id !== subject.id);
      availableSubjects = [...availableSubjects, subject];
      showToast("Subject Removed", `${subject.name} has been removed from your schedule.`, "info");
    }
    
    function showToast(title: string, message: string, type: 'success' | 'error' | 'info') {
      // Implement your toast notification here
      console.log(`${type.toUpperCase()}: ${title} - ${message}`);
    }
    
    onMount(() => {
      availableSubjects = [...allSubjects];
    });
    </script>
    
    <div class="container">
      <h1>Academic Schedule Manager</h1>
      
      <div class="grid">
        <div class="card">
          <h2>Available Subjects</h2>
          <p>Subjects you can add to your schedule</p>
          
          <div class="search">
            <label for="search">Search Subjects</label>
            <input
              id="search"
              type="text"
              placeholder="Search by name or code"
              bind:value={searchTerm}
            />
          </div>
          
          <div class="subject-list">
            {#each filteredSubjects as subject (subject.id)}
              <div class="subject-item" transition:fade>
                <div>
                  <p class="subject-name">{subject.name}</p>
                  <p class="subject-info">{subject.code} - {subject.credits} credits</p>
                </div>
                <button on:click={() => addSubject(subject)}>+</button>
              </div>
            {/each}
          </div>
        </div>
    
        <div class="card">
          <h2>Enrolled Subjects</h2>
          <p>Subjects in your current schedule</p>
          
          <div class="subject-list">
            {#each enrolledSubjects as subject (subject.id)}
              <div class="subject-item" transition:fade>
                <div>
                  <p class="subject-name">{subject.name}</p>
                  <p class="subject-info">{subject.code} - {subject.credits} credits</p>
                </div>
                <button on:click={() => removeSubject(subject)}>-</button>
              </div>
            {/each}
          </div>
          
          <div class="total-credits">
            <p>Total Credits: {enrolledSubjects.reduce((sum, subject) => sum + subject.credits, 0)}</p>
          </div>
        </div>
      </div>
    
      <div class="schedule-section">
        <h2>Your Schedule</h2>
        <AcademicSchedule subjects={enrolledSubjects} />
      </div>
    </div>
    
    <style>
      .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 1rem;
        font-family: Arial, sans-serif;
      }
      
      h1 {
        font-size: 1.5rem;
        text-align: center;
        margin-bottom: 1rem;
      }
      
      .grid {
        display: grid;
        grid-template-columns: 1fr;
        gap: 1rem;
        margin-bottom: 2rem;
      }
      
      @media (min-width: 768px) {
        .grid {
          grid-template-columns: 1fr 1fr;
        }
      }
      
      .card {
        background-color: white;
        border-radius: 0.5rem;
        padding: 1rem;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      }
      
      h2 {
        font-size: 1.25rem;
        margin-bottom: 0.5rem;
      }
      
      .search {
        margin-bottom: 1rem;
      }
      
      input {
        width: 100%;
        padding: 0.5rem;
        border: 1px solid #ccc;
        border-radius: 0.25rem;
      }
      
      .subject-list {
        max-height: 300px;
        overflow-y: auto;
      }
      
      .subject-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0.5rem;
        border-bottom: 1px solid #eee;
      }
      
      .subject-name {
        font-weight: bold;
      }
      
      .subject-info {
        font-size: 0.875rem;
        color: #666;
      }
      
      button {
        background-color: #f0f0f0;
        border: none;
        border-radius: 50%;
        width: 24px;
        height: 24px;
        font-size: 1rem;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
      }
      
      .total-credits {
        margin-top: 1rem;
        padding: 0.5rem;
        background-color: #f0f0f0;
        border-radius: 0.25rem;
      }
    
      .schedule-section {
        margin-top: 2rem;
      }
    </style>
