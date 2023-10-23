# Use an official Node.js runtime as the base image
FROM node:16

# Set the working directory in the container
WORKDIR /app

# Copy all files into the container
COPY . .

# Install dependencies
RUN npm install

# Build the project using Vite
RUN npx vite build

# Expose the port your app runs on. Assuming it's 3000.
EXPOSE 3000

# Command to run your production server. This is based on your npm script.
CMD [ "npm", "run", "start" ]
