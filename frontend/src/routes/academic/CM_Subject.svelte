<script lang="ts">
    type SubjectStatus = 'Not Started' | 'In Progress' | 'Passed' | 'Failed';
  
    export let subject: {
      id: string;
      code: string;
      title: string;
      description: string;
      credits: number;
      is_active: boolean;
    };
  
    export let status: SubjectStatus = 'Not Started';
    export let grade: number | undefined = undefined;
    export let color: string = 'bg-blue-100';
    export let theoreticalHours: number = 0;
    export let practiceHours: number = 0;
  
    let isHovered = false;
  
    $: totalHours = theoreticalHours + practiceHours;
  
    const statusColors = {
      'Not Started': 'bg-gray-200 text-gray-800',
      'In Progress': 'bg-yellow-200 text-yellow-800',
      'Passed': 'bg-green-200 text-green-800',
      'Failed': 'bg-red-200 text-red-800'
    };

    function truncate(str: string, n: number) {
        return (str.length > n) ? str.slice(0, n-1) + '...' : str;
    }
</script>

<div
  class="cursor-pointer transform transition-all duration-300 hover:scale-105"
  on:mouseenter={() => isHovered = true}
  on:mouseleave={() => isHovered = false}
  on:keydown={(e) => {
    if (e.key === 'Enter' || e.key === ' ') {
      isHovered = !isHovered;
    }
  }}
  role="button"
  tabindex="0"
>
  <div class="w-full h-28 {color} rounded-lg shadow-md overflow-hidden relative"> <!-- Increased height -->
    <div class="p-2 h-full flex flex-col justify-between">
      <div class="flex flex-col h-full justify-between {isHovered ? 'opacity-0' : 'opacity-100'} transition-opacity duration-300">
        <div class="flex-grow overflow-hidden">
          <h3 class="font-bold text-sm mb-1 line-clamp-2">{subject.title}</h3> <!-- Increased font size and allowed 2 lines -->
          <p class="text-xs text-gray-600">{subject.code}</p>
        </div>
        <div class="flex justify-between items-end text-xs mt-1">
          <span class="bg-gray-400 text-white px-2 py-1 rounded-full">
            {subject.credits} cr
          </span>
          <span class="font-semibold">{totalHours} hrs</span>
        </div>
      </div>
      
      <div class="absolute inset-0 bg-white p-2 flex flex-col justify-between {isHovered ? 'opacity-100' : 'opacity-0'} transition-opacity duration-300 overflow-y-auto"> <!-- Added overflow-y-auto -->
        <div>
          <!-- <p class="text-xs mb-1">{subject.description}</p> -->
          <p class="text-xs mb-1"><span class="font-semibold px-2 py-1 rounded-full text-xs {statusColors[status]}">{status}</span></p>
          {#if grade !== undefined}
            <p class="text-xs mb-1">Grade: <span class="font-semibold">{grade}</span></p>
          {/if}
        </div>
        <div class="text-xs mt-auto"> <!-- Added mt-auto to push to bottom if space allows -->
          <p>Theory: <span class="font-semibold">{theoreticalHours}</span> hrs</p>
          <p>Practice: <span class="font-semibold">{practiceHours}</span> hrs</p>
          <p>Total: <span class="font-semibold">{totalHours}</span> hrs</p>
        </div>
      </div>
    </div>
  </div>
</div>
