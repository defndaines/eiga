# 映画
## A True and Complete Record of Movies Watched (2000-12-23 – 2007-04-14)

Starting from December 2000, I kept track of all the movies I watched, writing reviews
and posting them to the website I maintained at that time. The last entry was in
April 2007. Back then, the addition of reviews was almost entirely manual. When
I finally decided to decommission that site, I made a backup of the data.

This repository preserves that data, but also acts as the root for projects
which utilize that data in one form or another. It’s really all playing with
different frameworks, half of which have been abandoned by their maintainers
long ago.

## SQL

The original database was MySQL. [sql/eiga.sql](sql/eiga.sql) is a slightly
updated version of the final data set. I've loaded the data into a more recent
version of MySQL and updated errors that I've come across while playing with the
data more recently. Because the original data did not maintain foreign keys
(though they effectively did exist), I have not added them there. The data
consists of two tables: `movies` and `reviews`. `movies` tracks the facts about
the movies watched, while `reviews` captures my review along with when and where
I watched the film.

[eiga-lite.sql](sql/eiga-lite.sql) takes the MySQL format and strips it
down to a more ANSI-compliant format which can be read into SQLite with `.read
eiga-lite.sql`. The tables can then be queried from the command line.

[movie.dat](sql/movie.dat) and [review.dat](sql/review.dat) are pipe-delimited
data import files, without headers, which are used to import the data into the
applications.


## Maru SQLite <sub>(2017-01-10)</sub>

The [maru_sqlite](maru_sqlite) project is written in Elixir and uses
[Maru](https://github.com/elixir-maru/maru) and
[Sqlite.Ecto](https://github.com/jazzyb/sqlite_ecto). It is a fairly manual
approach to exposing the data, useful for me in exploring putting an Elixir
project together without Phoenix. (The Maru library hasn’t been touched since
2019.)

## Vase <sub>(2017-03-18)</sub>

The [vase](vase) project is written using the
[cognitect/vase](https://github.com/cognitect-labs/vase) Clojure library. Vase pushes most
of the work into configuration files. By default, vase uses Datomic to store
data. Vase is built on top pedestal. (The Vase library hasn’t been touched
since 2019.)

## Pedestal <sub>(2017-03-04)</sub>

The [pedestal](pedestal) project is written using the
[pedestal](https://github.com/pedestal/pedestal) Clojure library. Pedestal
provides the web service layer. I have not yet determined which database this
project will use.

## Phoenix <sub>(2021-12-21)</sub>

The [phoenix](phoenix/eiga) project uses the
[Phoenix](https://www.phoenixframework.org/) Elixir framework.

## IMDb Data <sub>(2022-02-23)</sub>

The [IMDb Data](imdb_data) project was a small
[Phoenix](https://www.phoenixframework.org/)-based efforts to pull data from
IMDb.

## Copyright

Copyright Michael S. Daines, 2000-2025. All Rights Reserved.
