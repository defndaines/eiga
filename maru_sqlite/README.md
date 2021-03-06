# Eiga

HTTP service interface to the Eiga reviews data, using
[Maru](https://github.com/elixir-maru/maru) and
[Sqlite.Ecto](https://github.com/jazzyb/sqlite_ecto).

## Status

This project provides access to all the Eiga data. I didn't complete the
bundling of the project into a release.

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

[ { "id": 6, "year": 1999, "title": "Shiri", "short_title": "shiri", "country": "South Korea" }
, { "id": 7, "year": 1999, "title": "Nowhere to Hide", "short_title": "nowhere2hide", "country": "South Korea" }
, { "id": 8, "year": 1983, "title": "Evil Dead", "short_title": "evildead", "country": "U.S." }
,,,
]
```

### POST `/movies`

Enter a new movie into the system. Returns the ID of the movie.
Returns 201 if a new movies is created, 200 if the movie already exists.

Example:
```
curl -X POST -H 'Content-Type: application/json' http://127.0.0.1:8080/movies \
  -d '{"title": "The Goonies", "short_title": "goonies", "year": 1985, "country": "U.S."}'

676
```

### GET `/movies/id`

Get an individual movie by ID. (Note that the IDs are not stable in test mode.)
```
curl http://127.0.0.1:8080/movies/622

{ "year": 2006, "title": "Finishing the Game", "id": 622, "country": "U.S." }
```

### GET `/movies/short_title`

Get an individual movie by short title.
```
curl http://127.0.0.1:8080/movies/shiri

{ "year": 1999, "title": "Shiri", "id": 6, "country": "South Korea" }
```

### PUT `/movies/short_title`

Enter a new movie into the system, providing the "short title" through the URL.
Returns the ID of the movie. Returns 201 if a new movies is created, 200 if the
movie already exists.

Example:
```
curl -X PUT -H 'Content-Type: application/json' http://127.0.0.1:8080/movies/goonies \
  -d '{"title": "The Goonies", "year": 1985, "country": "U.S."}'

676
```

### GET `/reviews`

Get movie reviews. Because the amount of data, reviews must be paginated.
Calling the endpoint without query parameters will return the first ten results.

```
curl http://127.0.0.1:8080/reviews

[ { "year": 1999, "view_date": "2000-12-23"
  , "review": "<p>I started hearing about this ...."
  , "movie": "Shiri", "location": "DVD at home", "country": "South Korea" }
, { "year": 1999, "view_date": "2000-12-23", ,,, }
,,,
]
```

Using pagination:
```
curl 'http://127.0.0.1:8080/reviews?page=3&size=15'
```

### GET `/reviews/id`

```
curl 'http://127.0.0.1:8080/reviews/13'

[ { "year": 1994, "view_date": "2001-01-12"
  , "review":"<p>OK, I've already seen this movie a number of times. ..."
  , "movie": "Drunken Master II", "location": "DVD at home"
  , "country": "Hong Kong"
  }
]
```

### GET `/reviews/short_title`

```
curl 'http://127.0.0.1:8080/reviews/dm2'

[ { "year": 1994, "view_date": "2001-01-12"
  , "review":"<p>OK, I've already seen this movie a number of times. ..."
  , "movie": "Drunken Master II", "location": "DVD at home"
  , "country": "Hong Kong"
  }
, { "year": 1994, "view_date": "2004-06-07"
  , "review": "<p>I hadn't watched this movie in a while and ...."
  , "movie": "Drunken Master II", "location":"DVD at home"
  , "country": "Hong Kong"
  }
]
```
