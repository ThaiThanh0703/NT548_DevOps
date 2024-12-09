# Dùng Node.js để build ứng dụng
FROM node:18 AS build

WORKDIR /app

# Sao chép các dependency và build app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# Sử dụng Nginx để phục vụ ứng dụng đã build
FROM nginx:alpine

# Sao chép build app vào thư mục Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80 cho Nginx
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
