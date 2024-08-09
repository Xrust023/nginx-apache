FROM nginx:latest

EXPOSE 82

EXPOSE 83

EXPOSE 84

CMD ["nginx", "-g", "daemon off;"]