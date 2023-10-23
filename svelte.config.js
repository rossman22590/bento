import adapter from '@sveltejs/adapter-node';
import { vitePreprocess } from '@sveltejs/kit/vite';

/** @type {import('@sveltejs/kit').Config} */
const config = {
    preprocess: vitePreprocess(),
    kit: {
        // Use the Node adapter for deployment
        adapter: adapter(),
        // Add other kit configurations if needed
        // ...
    }
};

export default config;

