# Eiga

REST-like interface to the Eiga reviews data, using
[Maru](https://github.com/elixir-maru/maru) and
[Sqlite.Ecto](https://github.com/jazzyb/sqlite_ecto).

## Development

This project is written in Elixir. In order to build and run it, you will need
to install [Elixir](http://elixir-lang.org/install.html). On Mac OS X, if you
have homebrew installed, this can be done with:
```
brew install elixir
```

To load dependencies and compile the project:
```
mix deps.get
mix compile
```

To create the SQLite database and load the table definitions:
```
mix ecto.create
mix ecto.migrate
sqlite3 eiga.sqlite3 .schema
```

### To Run Tests

Run tests from the root directory with:
```
mix test
```

### Running Locally

To launch the application along with an interactive shell:
```
iex -S mix
```

This should expose endpoints such as:
```
curl http://127.0.0.1:8080/movies
```

## Releasing

This project is configured to use
[distillery](https://github.com/bitwalker/distillery) to build a release.
```
MIX_ENV=prod mix release --env prod
```

The release can then be run with:
```
cd rel/eiga
./bin/eiga console
```

## API

The following endpoints are supported.

### GET `/movies`

Returns a list of all reviewed movies.

Example:
```
curl http://127.0.0.1:8080/movies

TBD: Fill in with example data!
```
