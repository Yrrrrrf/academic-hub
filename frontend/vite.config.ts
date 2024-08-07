import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig, type UserConfig } from 'vite';

const config: UserConfig = {
	plugins: [sveltekit()]
};

export default defineConfig(config);
