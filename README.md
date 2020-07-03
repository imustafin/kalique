# Kalique
Pronounced as /kal'ik/.

Kalique is a text generator written in Ruby on Rails.

## Development
Development environment can be started by running
```
docker-compose -f development.yml up --build
```
Where `--build` is optional.

To run commands in the environment, use `runner` service. Connect to it
using
```
docker-compose -f development.yml run --rm runner
```

First run might require
```
bundle install
```

This docker-compose has `rails` service,
while `rails` is running the application is available at
`localhost:3000`.
