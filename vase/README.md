# Eiga

Exposes the Eiga dataset using [vase](https://github.com/cognitect-labs/vase).

## Getting Started

1. Start the application: `lein run`
2. Go to [localhost:8080](http://localhost:8080/) to see: `Hello World!`
3. Read your app's source code at src/eiga/service.clj. Explore the docs of functions
   that define routes and responses.
4. See your Vase API Specification at `resources/eiga_service.edn`.
5. Run your app's tests with `lein test`. Read the tests at test/eiga/service_test.clj.
6. Learn more! See the [Links section below](#links).


## Configuration

To configure logging see config/logback.xml. By default, the app logs to stdout and logs/.
To learn more about configuring Logback, read its [documentation](http://logback.qos.ch/documentation.html).


## Developing your service

1. Start a new REPL: `lein repl`
2. Start your service in dev-mode: `(def dev-serv (run-dev))`
3. Connect your editor to the running REPL session.
   Re-evaluated code will be seen immediately in the service.
4. All changes to your Vase Service Descriptor will be loaded - no re-evaluation
   needed.

### [Docker](https://www.docker.com/) container support

1. Build an uberjar of your service: `lein uberjar`
2. Build a Docker image: `sudo docker build -t eiga .`
3. Run your Docker image: `docker run -p 8080:8080 eiga`

### [OSv](http://osv.io/) unikernel support with [Capstan](http://osv.io/capstan/)

1. Build and run your image: `capstan run -f "8080:8080"`

Once the image it built, it's cached.  To delete the image and build a new one:

1. `capstan rmi eiga; capstan build`


## API

This section documents the endpoints supported by this service.

### Movies

#### `GET movies`

Get a list of all movies.
```shell
curl http://localhost:8080/api/eiga/v1/movies
```

#### `POST movies`

Add a movie.
```shell
curl -H "Content-Type: application/json" -X POST \
-d '{"payload":[{"eiga.movie/short-title":"shiri","eiga.movie/title":"Shiri","eiga.movie/year":1999,"eiga.movie/country":"South Korea"}]}' \
'http://localhost:8080/api/eiga/v1/movies'
```


## Links

 * [Pedestal examples](https://github.com/pedestal/samples)
 * [Vase examples](https://github.com/cognitect-labs/vase/samples)
