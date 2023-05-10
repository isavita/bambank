# Bambank

Bambank is a prototype online bank application that allows users to create an account, view their balance and transactions, and send money to other users. Users receive 100 free Bambeuros upon sign up as part of our promotional campaign.

This project is built using Ruby on Rails and PostgreSQL.

# Prerequisites

Ensure you have the following installed on your local machine:

- Docker: [Installation guide](https://docs.docker.com/engine/install/)
- Docker Compose: [Installation guide](https://docs.docker.com/compose/install/)

# Installation

1. Build the Docker images:
```sh
docker-compose build
```
2. Run the application:
```sh
docker-compose up
```
This command will start the Rails server and the PostgreSQL database. The Rails server runs on port 3000 by default.

**NOTE:** If you are not using Docker, you need to update the config/database.yml file and change the host from db to localhost.

# Shortcomings
- **Code Organization:** The current implementation is very basic (mainly scaffolded) and in some places as the **TransactionsController** a lot of logic is put dirrectly in the controller.
- **Testing:** The current implementation does not have any tests.
- **Style:** The current implementation has very basic bootstrap styling.
- **Error Handling:** The current implementation does not handle errors very well.
- **Docker setup:** The current implementation has only development setup for docker and not production.
