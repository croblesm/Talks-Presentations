# FRONTEND - Pass Summit 2019 DEMO for DevOps SQL Server CI/CD

## Development server

Run `ng serve -o` for a dev server. Navigate to `http://localhost:4200/`. The app will automatically reload if you change any of the source files.

## Build

Run `ng build` to build the project. The build artifacts will be stored in the `dist/` directory. Use the `--prod` flag for a production build.

## How to build the container with Docker:

    docker build --rm -t demo-front-app:latest .
    
## How to build the container with Docker:

    docker run --rm -d -p 90:80 --name demo_front demo-front-app:latest