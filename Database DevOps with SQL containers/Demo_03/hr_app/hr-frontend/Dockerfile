FROM node:alpine AS builder
COPY . ./hr-frontend
WORKDIR /hr-frontend
ARG API_URL
ENV SERVER=$API_URL
#ENV SERVER=localhost
RUN npm i
RUN $(npm bin)/ng build --prod --build-optimizer=false --aot=false

FROM nginx:alpine
COPY --from=builder /hr-frontend/dist/frontend/ /usr/share/nginx/html/