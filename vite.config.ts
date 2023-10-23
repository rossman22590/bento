import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vitest/config';
import Unfonts from 'unplugin-fonts/vite';

export default defineConfig({
  root: './src',
  build: {
    rollupOptions: {
      input: './src/app.html'
    }
  },
  plugins: [
    sveltekit(),
    Unfonts({
      google: {
        families: ['Figtree'],
      },
    }),
  ],
  test: {
    include: ['src/**/*.{test,spec}.{js,ts}']
  }
});

