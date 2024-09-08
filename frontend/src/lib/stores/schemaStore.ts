import { writable } from 'svelte/store';
import type { SchemaTypes } from '$lib/api/schema-generator';

export const schemaStore = writable<SchemaTypes>({});
