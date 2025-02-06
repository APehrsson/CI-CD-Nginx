FROM nginx:1.26.2

EXPOSE 80

COPY index.html /usr/share/nginx/html
