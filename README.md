<!-- @format -->

[![hex.pm version](https://img.shields.io/hexpm/v/ez_alias.svg)](https://hex.pm/packages/ez_alias)
[![CI](https://github.com/tashirosota/ez_alias/actions/workflows/ci.yml/badge.svg)](https://github.com/tashirosota/ecto_cellar/ez_alias/workflows/ci.yml)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/tashirosota/ez_alias)

# EzAlias

**TODO**

## Documentation

This is the user guide. See also, the [API reference](https://hexdocs.pm/ez_alias).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ez_alias` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ez_alias, "~> 0.1"}
  ]
end
```

## Usage

### 1. Configuration.

Add ecto_cellar configure to your config.exs.

```elixir
config :ez_alias,
  default_import_modules: [],
  default_alias_namespaces: [:model, :service],
```

## Bugs and Feature requests

Feel free to open an issues or a PR to contribute to the project.
