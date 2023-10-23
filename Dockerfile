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

# Try building the project using Vite
RUN npm run build

# Specify the command to run when the container starts
CMD [ "npm", "run", "start" ]
