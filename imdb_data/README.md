# IMDb Data

This was a small project I built to play around with data from IMDb. It
doesn't have a clear objective at this point, and the most developed part is
probably the importation of the IMDb data sets into the DB.

The [seeds.exs](priv/repo/seeds.exs) script is designed to pull in data from
the [IMDb Datasets](https://datasets.imdbws.com/). This is data that IMDb
exports and updates daily, but I was working on the idea that I would only
need to do this once for simple historical searches. I'm not committing this
data to the repo (partly because of the size), but it should be downloaded and
unzipped into `priv/datasets/`.

I opted to use IMDb's primary keys as my own, so tables use a "~const" key.

## Phoenix Boilerplate

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
