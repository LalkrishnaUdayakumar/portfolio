# Use the official Dart image with Flutter pre-installed
FROM cirrusci/flutter:stable

# Set working directory
WORKDIR /app

# Copy everything to container
COPY . .

# Get dependencies
RUN flutter pub get

# Build the web app
RUN flutter build web

# Use a simple web server to serve the app
RUN apt-get update && apt-get install -y nginx
RUN rm -rf /var/www/html/*
RUN cp -r build/web/* /var/www/html/

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]