FROM elixir:1.13.3-alpine

WORKDIR /app

RUN mix local.hex --force
RUN mix local.rebar --force

COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get, deps.compile

COPY lib lib
COPY test test
RUN mix compile

EXPOSE 4000
CMD ["mix", "run", "--no-halt"]
