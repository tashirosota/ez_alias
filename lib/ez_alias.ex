defmodule EzAlias do
  @doc """
  use EzAlias,
  """
  defmacro __using__(opts \\ []) do
    imports = (opts[:import] || []) ++ Application.get_env(:ez_alias, :default_import_modules, [])

    namespaces =
      ((opts[:alias] || []) ++ Application.get_env(:ez_alias, :default_alias_namespaces, []))
      |> to_capital_strings()

    aliases =
      all_module_strs()
      |> filter(namespaces)
      |> add_as()

    do_import(imports) ++ do_alias(aliases)
  end

  defp add_as(mod_strs) do
    metas =
      mod_strs
      |> Enum.map(fn mod_str ->
        separated = mod_str |> String.split(".")

        %{
          orizin: mod_str,
          separated: separated,
          aliased: separated |> Enum.reverse() |> List.first()
        }
      end)

    aliases = metas |> Enum.map(& &1[:aliased])

    metas
    |> do_add_as(aliases, [])
  end

  defp do_add_as([], _, added_as), do: added_as

  defp do_add_as(metas, aliases, results) do
    [meta | metas] = metas

    if meta[:aliased] in aliases do

      as = "Duplicated" <> meta[:aliased]
      do_add_as(metas, aliases ++ [as], results ++ [meta[:orizin] <> " as #{as}"])
    else
      do_add_as(metas, aliases, results ++ [meta[:orizin]])
    end
  end

  defp to_capital_strings(alias_namespaces) do
    alias_namespaces
    |> Enum.map(&(&1 |> to_string() |> String.capitalize()))
  end

  defp filter(mod_strs, namespaces) do
    mod_strs
    |> Enum.filter(fn mod_str ->
      mod_str
      |> String.split(".")
      |> Enum.any?(fn str ->
        str in namespaces
      end)
    end)
  end

  defp do_import(modules) do
    modules
    |> Enum.map(fn mod ->
      quote do
        import unquote(mod)
      end
    end)
  end

  defp do_alias(modules) do
    modules
    |> Enum.map(fn mod ->
      quote do
        alias unquote(mod)
      end
    end)
  end

  defp all_module_strs do
    :code.all_loaded()
    |> Enum.map(&elem(&1, 0))
    |> Enum.map(&to_string(&1))
  end
end
