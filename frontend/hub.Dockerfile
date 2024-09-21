# Use an official Node.js image as the base image
FROM node:18-alpine AS build

# Set working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all files from the current directory to the container
COPY . .

# Build the app using the static adapter
RUN npm run build

# Use an official Nginx image to serve the static files
FROM nginx:alpine AS serve

# Copy the built static files from the previous stage to Nginx's html folder
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 to access the app
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
