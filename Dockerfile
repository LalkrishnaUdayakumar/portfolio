# Use Flutter with Dart 3.6.2+
FROM ghcr.io/cirruslabs/flutter:latest

WORKDIR /app

COPY . .

RUN flutter pub get
RUN flutter build web

# Serve using nginx
RUN apt-get update && apt-get install -y nginx
RUN rm -rf /var/www/html/*
RUN cp -r build/web/* /var/www/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
