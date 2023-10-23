# Use the official Node.js 14 image as the base image
FROM node:16

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the working directory
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Set the environment variable for the port
ENV PORT=3000

# Expose the port
EXPOSE $PORT

# Set the default command to run when the container starts
CMD ["npm", "run", "dev"]
