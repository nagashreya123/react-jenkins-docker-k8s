# Dockerfile
# Use an official Node.js image as a base
FROM node:14-alpine

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React app
RUN npm run build

# Expose port 3000
EXPOSE 3000

# Start the application
CMD ["npx", "serve", "-s", "build", "-l", "3000"]
