# Bambank

Bambank is a prototype online banking application that enables users to create an account, view their balance and transactions, and send money to other users. As part of our promotional campaign, users receive 100 free Bambeuros upon sign up.

This project is built using Ruby on Rails and PostgreSQL.

## How to Run

### Prerequisites

Before running the application, ensure the following are installed on your local machine:

- Docker: [Installation guide](https://docs.docker.com/engine/install/)
- Docker Compose: [Installation guide](https://docs.docker.com/compose/install/)

### Running with Docker

1. Build the Docker images:
```sh
docker-compose build
```
2. Run the application:
```sh
docker-compose up
```
This command starts the Rails server and the PostgreSQL database. The Rails server runs on port 3000 by default.

### Running without Docker

**NOTE:** If you are not using Docker, update the `config/database.yml` file and change the host from `db` to `localhost`.

1. Install the required gems:
```sh
bundle install
```
2. Create and set up the database:
```sh
rails db:create
rails db:migrate
```
3. Run the application:
```sh
rails server
```
The Rails server runs on port 3000 by default.

## Shortcomings

- **Code Organization:** The current implementation is basic (mainly scaffolded), and in some places, such as the `TransactionsController`, a lot of logic is put directly in the controller.
- **Testing:** The current implementation lacks tests.
- **Style:** The current implementation uses basic Bootstrap styling.
- **Error Handling:** The current implementation does not handle errors effectively.
- **Docker setup:** The current implementation provides only a development setup for Docker, not production.
