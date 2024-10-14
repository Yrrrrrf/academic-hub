<script lang="ts">
    import { onMount } from 'svelte';
    import { fade, fly } from 'svelte/transition';
    import CM_Subject from './CM_Subject.svelte';
    import { generateCrudOperations } from '$lib/api/crud';

    type Program = {
        id: string;
        code: string;
        name: string;
        description: string;
        degree_level: string;
        is_active: boolean;
    };

    type ProgramCourse = {
        id: string;
        program_id: string;
        course_id: string;
        is_required: boolean;
        recommended_semester: number;
    };

    type Course = {
        id: string;
        code: string;
        title: string;
        description: string;
        credits: number;
        is_active: boolean;
        category: 'basic' | 'core' | 'advanced';
    };

    type Curriculum = {
        [semester: number]: (Course & { is_required: boolean })[];
    };

    const programApi = generateCrudOperations<Program>('academic', 'program');
    const programCourseApi = generateCrudOperations<ProgramCourse>('academic', 'program_course');
    const courseApi = generateCrudOperations<Course>('academic', 'course');

    let program: Program | null = null;
    let programCourses: ProgramCourse[] = [];
    let courses: Course[] = [];
    let curriculum: Curriculum = {};
    let maxSemesters = 0;

    // const programId = 'ce123456-7890-4321-abcd-ef1234567890';  // Computer Engineering
    const programId = '9a173283-6a6c-44bd-8899-e00840511262';  // Civil Engineering

    async function loadData() {
        try {
            const programData = await programApi.getAll({ id: programId });
            program = programData[0];  // There should be only one program with the given ID

            programCourses = await programCourseApi.getAll({ program_id: programId });

            const coursePromises = programCourses.map(pc => courseApi.getAll({ id: pc.course_id }));
            const courseResults = await Promise.all(coursePromises);
            courses = courseResults.flatMap(result => result);

            curriculum = courses.reduce((acc: Curriculum, course) => {
                const programCourse = programCourses.find(pc => pc.course_id === course.id);
                if (programCourse) {
                    const semester = programCourse.recommended_semester;
                    if (!acc[semester]) acc[semester] = [];
                    acc[semester].push({ ...course, is_required: programCourse.is_required });
                    maxSemesters = Math.max(maxSemesters, semester);
                }
                return acc;
            }, {});

            const maxCoursesPerSemester = Math.max(...Object.values(curriculum).map(courses => courses.length), 0);
            for (let i = 1; i <= maxSemesters; i++) {
                curriculum[i] = curriculum[i] || [];
                while (curriculum[i].length < maxCoursesPerSemester) {
                    curriculum[i].push(null);
                }
            }
        } catch (error) {
            console.error('Error fetching data:', error);
        }
    }

    onMount(loadData);

    function randomColor(): string {
        const colors = [
            "bg-red-100", "bg-yellow-100", "bg-green-100", "bg-blue-100",
            "bg-indigo-100", "bg-purple-100", "bg-pink-100", "bg-gray-100",
        ];
        return colors[Math.floor(Math.random() * colors.length)];
    }

    const typeColors = {
        'basic': 'bg-gray-200',
        'core': 'bg-purple-200',
        'advanced': 'bg-yellow-200'
    };
</script>

<div class="container mx-auto p-4 bg-white rounded-lg shadow-lg">
    {#if program}
        <h1 class="text-3xl font-bold mb-4 text-center" in:fly="{{ y: -20, duration: 500 }}">{program.name}</h1>
        <p class="text-center mb-8 max-w-2xl mx-auto" in:fly="{{ y: 20, duration: 500, delay: 200 }}">{program.description}</p>
    {/if}
    
    <div class="mb-4 flex justify-center space-x-4" in:fade="{{ duration: 300, delay: 400 }}">
        <div class="flex items-center">
            <span class="w-4 h-4 inline-block mr-2 border-l-4 border-gray-400"></span>
            <span>Basic</span>
        </div>
        <div class="flex items-center">
            <span class="w-4 h-4 inline-block mr-2 border-l-4 border-purple-500"></span>
            <span>Core</span>
        </div>
        <div class="flex items-center">
            <span class="w-4 h-4 inline-block mr-2 border-l-4 border-yellow-500"></span>
            <span>Advanced</span>
        </div>
        <div class="flex items-center">
            <span class="w-4 h-4 inline-block mr-2 rounded-full bg-red-500"></span>
            <span>Required</span>
        </div>
        <div class="flex items-center">
            <span class="w-4 h-4 inline-block mr-2 rounded-full bg-green-500"></span>
            <span>Optional</span>
        </div>
    </div>
    
    <div class="overflow-x-auto">
        <div class="min-w-[1920px] pb-8">
            <div class="grid grid-cols-9 gap-4">
                {#each Object.entries(curriculum) as [semester, semesterCourses] (semester)}
                    <div class="space-y-2" in:fade="{{ duration: 300, delay: 200 * parseInt(semester) }}">
                        <h3 class="font-semibold text-center bg-gray-200 p-2 rounded text-sm">Semester {semester}</h3>
                        <div class="space-y-4">
                            {#each semesterCourses as course, index (course?.id || `empty-${index}`)}
                                {#if course}
                                    <div in:fade="{{ duration: 300 }}">
                                        <CM_Subject
                                            subject={course}
                                            color={typeColors[course.category]}
                                            status="Not Started"
                                            theoreticalHours={4}
                                            practiceHours={2}
                                            isRequired={course.is_required}
                                        />
                                    </div>
                                {:else}
                                    <div class="bg-gray-100 p-2 rounded shadow h-24"></div>
                                {/if}
                            {/each}
                        </div>
                    </div>
                {/each}
            </div>
        </div>
    </div>
</div>
