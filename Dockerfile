FROM node:14.18.2-alpine as build

COPY package*.json /app/

WORKDIR /app

RUN npm install

COPY ./ /app/

RUN npm run build


FROM nginx:1.16.0-alpine

COPY --from=build /app/build /usr/share/nginx/html

RUN rm /etc/nginx/conf.d/default.conf

COPY /nginx/nginx.conf /etc/nginx/conf.d

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

