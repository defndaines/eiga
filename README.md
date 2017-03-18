# 映画
## A True and Complete Record of Movies Watched (2000-12-23 – 2007-04-14)

Starting from December 2000, I kept track of all the movies I watched, writing reviews
and posting them to the website I maintained at that time. The last entry was in
April 2007. Back then, the addition of reviews was almost entirely manual. When
I finally decided to decommission that site, I made a backup of the data.

This repository preserves that data, but also acts as the root for projects
which utilize that data in one form or another.

## SQL

The original database was MySQL. [sql/eiga.sql](sql/eiga.sql) is a slightly
updated version of the final data set. I've loaded the data into a more recent
version of MySQL and updated errors that I've come across while playing with the
data more recently. Because the original data did not maintain foreign keys
(though they effectively did exist), I have not added them there. The data
consists of two tables: `movies` and `reviews`. `movies` tracks the facts about
the movies watched, while `reviews` captures my review along with when and where
I watched the film.

## Maru SQLite

The [maru_sqlite](maru_sqlite) project is written in Elixir and uses 
[Maru](https://github.com/elixir-maru/maru) and
[Sqlite.Ecto](https://github.com/jazzyb/sqlite_ecto). It is a fairly manual
approach to exposing the data, useful for me in exploring putting an Elixir
project together without Phoenix.

## Vase

The [vase](vase) project is written using the
[cognitect/vase](https://github.com/cognitect-labs/vase) Clojure library. Vase pushes most
of the work into configuration files. By default, vase uses Datomic to store
data. Vase is built on top pedestal.

## Pedestal

The [pedestal](pedestal) project is written using the
(pedestal)[https://github.com/pedestal/pedestal] Clojure library. Pedestal
provides the web service layer. I have not yet determined which database this
project will use.

## Copyright

Copyright Michael S. Daines, 2000-2017. All Rights Reserved.
