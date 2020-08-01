# Kalique
Pronounced as /kal'ik/.

Kalique is a text generator written in Ruby on Rails.

## Development
### Code, Git and GitHub
Development is done with the use of git and GitHub.

To download the current code:
```
git clone https://github.com/imustafin/kalique.git
```

To create your own repository for the project, first register
at https://github.com. Sign Up form appears if you are not logged in.

After registering, click the Plus icon on the left of your user picture in the top right corner and select New Repository.
Enter the required configuration. We recommend enabling the "Initialize this repository with a README".

Click Create Repository.

Run `git clone [REPO_URL]` where `[REPO_URL]` is the address of the repository to download the repository.

Add code to the created folder, commit and push. Further configuration is described below.

### Deployment and Heroku
The application can be deployed using Heroku.

Go to https://heroku.com and sign up.

After logging in, go to https://dashboard.heroku.com/apps, click New > Create new app in the top right corner. Create the new app.

Install Heroku CLI (https://devcenter.heroku.com/articles/heroku-cli). Run `heroku login` and then `heroku authorizations:create`.
An access *token* should be displayed. Copy it and go to the GitHub page of your repository. Go to Settings section > Secrets and create a new secret called `HEROKU_API_KEY` and paste the access token as the value of this secret. This secret is used during the deployment (described below).

Modify the `.github/workflows/master.yml` to update the configuration relevant to heroku deployment. Set `HEROKU_APP_NAME` to the application name from heroku, `APP_HOST` to the
domain to which the application is deployed (usually it is `[appname].herokuapp.com` where `[appname]` is the application name).

After this change, all commits pushed to master will be automatically deployed to the specified application and UAT testing will be ran on the deployed instance. This can be used as a staging environment for the release candidates.


To run the application, create these additional configuration values in Heroku.
Go to the app page > Settings, click Reveal Config Vars. Add:

name | description | sample value
-----|-------------|---------------
`ADMIN_LOGIN` | login for the admin panel | `admin`
`ADMIN_PASSWORD` | password for the admin panel | `admin`
`DATABASE_URL` | should appear automatically after adding postgres plugin (described below) | `postgres://xxx:yyy@zzz`
`LANG` | linux env var | `en_US.UTF-8`
`RACK_ENV` | env for rack in the application | `production`
`RAILS_ENV` | env for rails in the application | `production`
`SECRET_KEY_BASE` | used by rails for web security | should be output of `rake secret`
`VK_APP_ID` | application id of the VK app (described below) | `1234...`
`VK_SERVICE` | service token of the VK app (described below) | `abc...`

#### Heroku Postgres Database
Free Heroku Postgres plan is sufficient for the application. See https://devcenter.heroku.com/articles/heroku-postgresql
for instruction on how to add postgres plugin to the application. Make sure that `DATABASE_URL` config var appears
in the list of config vars of the application

#### VK application
This application parses posts from vk.com. To get access to the post data, an application
should be created at https://dev.vk.com. Go to https://vk.com/editapp?act=create,
select Standalone app as the type. After creating, the required tokens are available
in the Settings section.

#### Config values in development
We recommend to create a `.env` file near of the `development.yml` which
defines the required values. This file will be read by `docker-compose` and
the values will be inserted into the services.

### Coding and Development
Install docker (https://docs.docker.com/engine/install/) and docker-compose (https://docs.docker.com/compose/install/).

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
and
```
yarn install
```
inside the runner service.

This docker-compose has `rails` service,
while `rails` is running the application is available at
`localhost:3000`.

#### Running Tests in Development
This should be done in `runner`.

To prepare test database do
```
rake db:test:prepare
```

To run tests do
```
rake spec
```

### Version Control Configuration Management
We recommend to do continuous integration with this project. This will include making all branches originate from master and to be merged into master. Merges should be done only through pull requests, configured to be mergeable only after commit-stage tests pass. This can be enabled in the repository settings: go to Settings > Branches, create a new rule. Set `master` as the Branch name pattern, and enable Require status checks to pass before merging.

Additionally, we recommend enabling Require linear history and Include administrators options.
