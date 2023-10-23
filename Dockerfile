# Use an official Node.js runtime as the base image
FROM node:16

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json into the container
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy the rest of the application code into the container
COPY . .

# Build the project using Vite
RUN vite build

# Expose the port your app runs on. Assuming it's 3000.
EXPOSE 3000

# Command to run your production server. This is based on your npm script.
CMD [ "npm", "run", "start" ]
