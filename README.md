# mmss-server-ex

My Mp3 Streaming Server [SERVER](https://github.com/leader22/mmss-server) rewritten with Elixir.

```sh
# prod
MIX_ENV=prod mix run --no-halt

# dev
iex -S mix

## format, lint and typecheck
mix format
mix credo --strict -a
mix dialyzer
```

Env variables are listed in `/config/config.exs`.
