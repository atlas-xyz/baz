run: setup test

setup: setup.deps setup.genbaz setup.ecto

setup.deps:
	mix deps.get

setup.genbaz:
	mix baz.gen.migration

setup.ecto:
	mix setup

test: test.dialyzer test.unit

test.dialyzer:
	mix dialyzer

test.unit:
	mix test

start: start.db start.iex

start.db:
	docker-compose up db

start.iex:
	iex --sname baz -S mix
