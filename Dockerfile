# FROM node:18-alpine

# # Install necessary dependencies
# RUN apk add --no-cache libc6-compat

# # Set the working directory
# WORKDIR /app

# # Copy all files into the container
# COPY . .

# # Install dependencies
# RUN npm install

# # Expose port 3000
# EXPOSE 3000

# # Set environment variable
# ENV NODE_ENV=development

# # Run the development server
# CMD ["npm", "run", "dev"]


# Base image for building the application
FROM node:18-alpine AS builder

# Install necessary build dependencies
RUN apk add --no-cache libc6-compat

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the files and build the application
COPY . .
RUN npm run build

# Final image for running the application
FROM node:18-alpine

# Install necessary runtime dependencies
RUN apk add --no-cache libc6-compat

# Set working directory
WORKDIR /app

# Copy only the necessary files from the builder stage
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/next.config.js ./next.config.js
COPY --from=builder /app/styles ./styles
COPY --from=builder /app/components ./components
COPY --from=builder /app/pages ./pages

# Install dependencies in the runtime environment
RUN npm install --production

# Expose port 3000
EXPOSE 3000

# Set environment variable
ENV NODE_ENV=production

# Run the application
CMD ["npm", "run", "start"]
