<script lang="ts">
    import { onMount } from 'svelte';
    import { fade } from 'svelte/transition';
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
    };

    type Curriculum = {
        [semester: number]: (Course | null)[];
    };

    const programApi = generateCrudOperations<Program>('academic', 'program');
    const programCourseApi = generateCrudOperations<ProgramCourse>('academic', 'program_course');
    const courseApi = generateCrudOperations<Course>('academic', 'course');

    let program: Program | null = null;
    let programCourses: ProgramCourse[] = [];
    let courses: Course[] = [];
    let curriculum: Curriculum = {};
    let maxSemesters = 0;

    const programId = 'ce123456-7890-4321-abcd-ef1234567890';

    async function loadData() {
        try {
            const programData = await programApi.getAll({ id: programId });
            program = programData[0];
            console.log('Program:', program);

            programCourses = await programCourseApi.getAll({ program_id: programId });
            console.log('Program Courses:', programCourses);

            const coursePromises = programCourses.map(pc => 
                courseApi.getAll({ id: pc.course_id })
            );
            const courseResults = await Promise.all(coursePromises);
            courses = courseResults.flatMap(result => result);
            console.log('Courses:', courses);

            curriculum = courses.reduce((acc: Curriculum, course) => {
                const programCourse = programCourses.find(pc => pc.course_id === course.id);
                if (programCourse) {
                    const semester = programCourse.recommended_semester;
                if (!acc[semester]) acc[semester] = [];
                    acc[semester].push(course);
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
            
            console.log('Curriculum:', curriculum);
            console.log('Max Semesters:', maxSemesters);
        } catch (error) {
            console.error('Error fetching data:', error);
        }
    }

    onMount(loadData);

    function getSubjectColor(code: string): string {
        return randomColor();
    }

    function randomColor(): string {
        const colors = [
            "bg-red-200", "bg-yellow-200", "bg-green-200", "bg-blue-200",
            "bg-indigo-200", "bg-purple-200", "bg-pink-200", "bg-gray-200",
        ];
        return colors[Math.floor(Math.random() * colors.length)];
    }



</script>

<div class="container mx-auto p-4 bg-white rounded-lg shadow-lg">
    {#if program}
    <h1 class="text-2xl font-bold mb-4 text-center">{program.name}</h1>
    <p class="text-center mb-8 max-w-2xl mx-auto">{program.description}</p>
    {/if}
    
    <div class="overflow-x-auto">
    <div class="min-w-[1920px] pb-8">
        <div class="grid grid-cols-9 gap-4"> <!-- Increased gap -->
        {#each Object.entries(curriculum) as [semester, semesterCourses] (semester)}
            <div class="space-y-2"> <!-- Increased space between semester title and courses -->
            <h3 class="font-semibold text-center bg-gray-200 p-2 rounded text-sm">Semester {semester}</h3>
            <div class="space-y-4"> <!-- Increased space between courses -->
                {#each semesterCourses as course, index (course?.id || `empty-${index}`)}
                {#if course}
                    <div in:fade="{{ duration: 300 }}">
                    <CM_Subject
                        subject={course}
                        color={getSubjectColor(course.code)}
                        status="Not Started"
                        theoreticalHours={4}
                        practiceHours={2}
                    />
                    </div>
                {:else}
                    <div class="bg-gray-100 p-2 rounded shadow h-24"></div> <!-- Increased height -->
                {/if}
                {/each}
            </div>
            </div>
        {/each}
        </div>
    </div>
    </div>
</div>