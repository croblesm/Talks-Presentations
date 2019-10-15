FROM node:alpine AS builder
COPY . ./hr-frontend
WORKDIR /hr-frontend
RUN npm i
RUN $(npm bin)/ng build

FROM nginx:alpine
COPY --from=builder /hr-frontend/dist/frontend/ /usr/share/nginx/html/