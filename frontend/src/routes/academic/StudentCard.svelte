<script lang="ts">
    export let name: string;
    export let id: string;
    export let major: string;
    export let enrollmentYear: number;
    export let gpa: number;
    
    const currentYear = new Date().getFullYear();
    const yearOfStudy = currentYear - enrollmentYear + 1;
    
    function getInitials(name: string): string {
        return name.split(' ').map(n => n[0]).join('').toUpperCase();
    }
    </script>
    
    <div class="student-card bg-white shadow-lg rounded-lg p-6 flex items-center space-x-6">
        <div class="avatar bg-purple-200 rounded-full w-24 h-24 flex items-center justify-center text-3xl font-bold text-purple-700">
            {getInitials(name)}
        </div>
        <div class="info">
            <h2 class="text-2xl font-bold text-gray-800">{name}</h2>
            <p class="text-gray-600">{major}</p>
            <div class="mt-2 flex space-x-4">
                <div class="text-sm">
                    <span class="font-semibold">ID:</span> {id}
                </div>
                <div class="text-sm">
                    <span class="font-semibold">Year:</span> {yearOfStudy}
                </div>
                <div class="text-sm">
                    <span class="font-semibold">GPA:</span> {gpa.toFixed(2)}
                </div>
            </div>
        </div>
    </div>
    
    <style>
        .student-card {
            max-width: 600px;
            margin: 0 auto;
        }
    </style>