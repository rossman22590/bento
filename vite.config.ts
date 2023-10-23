import adapter from '@sveltejs/adapter-node'; // or '@sveltejs/adapter-static' or other appropriate adapter

/** @type {import('@sveltejs/kit').Config} */
const config = {
  kit: {
    // hydrate the <div id="svelte"> element in src/app.html
    target: '#svelte',
    adapter: adapter({
      // adapter options
    }),
    vite: {
      // Vite options
    }
  }
};

export default config;

