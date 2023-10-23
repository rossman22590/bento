# Use an official Node.js runtime as the base image
FROM node:16

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock if you're using Yarn) into the container
COPY package*.json ./

# Install project dependencies
# If you have native dependencies, you might need additional tools in the container.
# If that's the case, before this step, you'd add:
# RUN apt-get update && apt-get install -y some-required-tool
RUN npm ci

# Copy the rest of the application code into the container
COPY . .

# Build the project
RUN npm run build

# Specify the command to run when the container starts
# In this case, "node build" as per your scripts
CMD [ "npm", "run", "start" ]
