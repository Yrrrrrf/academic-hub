export const prerender = true
export const ssr = false


import { initializeSchemaTypes } from '$lib/api';

export async function load() {
    await initializeSchemaTypes();
    return {};
}
