# Eiga

Web service interface to the Eiga reviews data, using
[Pedestal](https://github.com/pedestal/pedestal)

## Current Status

I've only defined the routing scheme for this project, but have not wired in any
handling or database code.

## Getting Started

This project is written in Clojure and assumes you have
[lein](http://leiningen.org/) installed.

1. Start the application: `lein run`
2. Go to [localhost:8080](http://localhost:8080/) to see: `Hello World!`
3. Read your app's source code at src/eiga/service.clj. Explore the docs of functions
   that define routes and responses.
4. Run your app's tests with `lein test`. Read the tests at test/eiga/service_test.clj.
5. Learn more! See the [Links section below](#links).


## Configuration

To configure logging see config/logback.xml. By default, the app logs to stdout and logs/.
To learn more about configuring Logback, read its [documentation](http://logback.qos.ch/documentation.html).


## Developing your service

1. Start a new REPL: `lein repl`
2. Start your service in dev-mode: `(def dev-serv (run-dev))`
3. Connect your editor to the running REPL session.
   Re-evaluated code will be seen immediately in the service.


## Links
* [Other examples](https://github.com/pedestal/samples)
