# Use the official Node.js 16 image as the base image
FROM node:16

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the working directory
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Set the OpenAI API Key environment variable
ENV OPENAI_API_KEY=53534

# Build the SvelteKit application
RUN npm run build

# Install 'serve' to run our application
RUN npm install -g serve

# Set the environment variable for the port
ENV PORT=5173

# Expose the port
EXPOSE $PORT

# Command to run the HTTP server
CMD ["serve", "-s", "./build", "-l", "5173"]
