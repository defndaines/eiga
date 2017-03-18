# Eiga

Exposes the Eiga dataset using [vase](https://github.com/cognitect-labs/vase).

## Status

I'm in the process of learning the vase API and configuring the schema and
endpoints. At this time the loading of data is manual, as it only uses an
in-memory Datomic database.

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

[[{"db/id":17592186045425
  ,"eiga.movie/short-title":"cthd"
  ,"eiga.movie/title":"Crouching Tiger, Hidden Dragon"
  ,"eiga.movie/year":2000
  ,"eiga.movie/country":["China","Hong Kong","Taiwan","U.S."]}]
,[{"db/id":17592186045423
   ,"eiga.movie/short-title":"shiri"
   ,"eiga.movie/title":"Shiri"
   ,"eiga.movie/year":1999
   ,"eiga.movie/country":["South Korea"]}]
]
```

#### `POST movies`

Add a movie.
```shell
curl -H "Content-Type: application/json" -X POST \
-d '{"payload":[{"eiga.movie/short-title":"shiri","eiga.movie/title":"Shiri","eiga.movie/year":1999,"eiga.movie/country":"South Korea"}]}' \
'http://localhost:8080/api/eiga/v1/movies'

{"whitelist":[{"eiga.movie/short-title":"shiri","eiga.movie/title":"Shiri","eiga.movie/year":1999,"eiga.movie/country":"South Korea"}]
,"transaction":[[null,null,null],[null,null,null],[null,null,null],[null,null,null]]}
```

Add a movie with multiple countries.
```shell
curl -H "Content-Type: application/json" -X POST \
-d '{"payload":[{"eiga.movie/short-title":"cthd","eiga.movie/title":"Crouching Tiger, Hidden Dragon","eiga.movie/year":2000,"eiga.movie/country":["China","Hong Kong","Taiwan","U.S."]}]}' \
'http://localhost:8080/api/eiga/v1/movies'

{"whitelist":[{"eiga.movie/short-title":"cthd","eiga.movie/title":"Crouching Tiger, Hidden Dragon","eiga.movie/year":2000,"eiga.movie/country":["China","Hong Kong","Taiwan","U.S."]}]
,"transaction":[[null,null,null],[null,null,null],[null,null,null],[null,null,null]]}
```

#### `GET reviews`

Get a list of all reviews.
```shell
curl http://localhost:8080/api/eiga/v1/reviews
```

#### `POST reviews`

Add a movie review.
NOTE: This does not work on the command line ... probably an escaping problem.
Put payload into file and attempt to pass that.
```shell
curl -H "Content-Type: application/json" -X POST \
-d '{"payload":[{"eiga.review/movie":17592186045423,"eiga.review/location":"DVD at home","eiga.review/view-date":"2000-12-23","eiga.review/text":"<p>I started hearing about this movie through references in different articles. This was the top-grossing Korean film ever, though I\'ve been told that the record has since been broken (by what I don\'t know). No surprise, once I saw it, that this was the case. I was at a video store known for its Hong Kong selection, looking through their DVD list when I saw it. I found it on the shelves and double checked that it had English subtitles (because last I had heard, it didn\'t). The DVD comes out of Hong Kong.</p><p>This film falls into a few different categories, particularly action and drama. The action scenes are well done and logically flow with the film, but there is also a love story that touches you. The acting is well done and the plot twists pull you in. There isn\'t a lot I can say about the film\'s plot, because it is really something you have to experience for yourself. You will enjoy seeing how things fall together by the end.</p><p>My only complaint about the film would have to be its demonization of North Korea, particularly the early training scenes. These scenes help foster a nationalist image of North Korea as a bunch of fanatics, which of course only serves to keep the two nations divided and to further the interests of those in power in South Korea (who have kept the nations divided for a reason). On the other hand, I love the lead male terrorist. He has some lines which really put things into perspective ... pointing out the disparities between the two Koreas.</p>"}]}' \
'http://localhost:8080/api/eiga/v1/reviews'
```


## Links

 * [Pedestal examples](https://github.com/pedestal/samples)
 * [Vase examples](https://github.com/cognitect-labs/vase/samples)
