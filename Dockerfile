# Step 1: Use Node.js image
FROM node:16-alpine

# Step 2: Set working directory
WORKDIR /app

# Step 3: Copy package files
COPY package*.json ./

# Step 4: Install dependencies
RUN npm install

# Step 5: Copy source code
COPY . .

# Step 6: Build the React app
RUN npm run build

# Step 7: Use Nginx to serve the app
FROM nginx:stable-alpine
COPY --from=0 /app/build /usr/share/nginx/html

# Step 8: Expose the port and start Nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
