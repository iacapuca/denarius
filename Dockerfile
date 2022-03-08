FROM elixir:1.13 AS build

RUN apt-get update && \
  apt-get install -y postgresql-client


RUN mix local.hex --force \
    && mix local.rebar --force

ENV APP_HOME /denarius
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY mix.exs mix.lock ./
RUN mix do deps.get, deps.compile
COPY . .

EXPOSE 4040

CMD ["mix run --no-halt"]
