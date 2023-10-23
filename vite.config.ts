import adapter from '@sveltejs/adapter-vercel';
import { vitePreprocess } from '@sveltejs/kit/vite';

/** @type {import('@sveltejs/kit').Config} */
const config = {
    preprocess: vitePreprocess(),
    kit: {
        // Use the Vercel adapter for deployment
        adapter: adapter(),
        // Add other kit configurations if needed
        // ...
    }
};

export default config;
