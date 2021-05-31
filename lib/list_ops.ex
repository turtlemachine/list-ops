defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @moduledoc """
   Both `ListOps.count/1` and `ListOps.reverse/1` had initial implementations
   that were naturally very similar to the eventual `ListOps.reduce/3`
   implmentation, so it made sense to later refactor them in terms of `reduce/3`
   once it was available.

   Similarly, it made sense to implement `ListOps.concat/1` in terms of
   a private `ListOps.append/1` along with `ListOps.append/2` given the tests
   indicate it works the same as `:lists.append/1`.
  """

  @spec count(list) :: non_neg_integer
  def count(l) do
    reduce(l, 0, fn _, acc -> acc + 1 end)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    reduce(l, [], fn x, acc -> [x | acc] end)
  end

  @spec map(list, (any -> any)) :: list
  def map([head | tail], f) do
    [f.(head) | map(tail, f)]
  end

  @spec map([], (any -> any)) :: list
  def map([], _f), do: []

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    for n <- l, f.(n), do: n
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([head | tail], acc, f) do
    reduce(tail, f.(head, acc), f)
  end

  @spec reduce([], acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _f), do: acc

  @spec append(list, list) :: list
  def append([head | tail], b) do
    [head | append(tail, b)]
  end

  @spec append([], nonempty_list) :: list
  def append([], [head | _tail] = b) when is_list(head), do: append(b)

  @spec append([], nonempty_list) :: list
  def append([], b), do: b

  @spec append([any]) :: any
  defp append([e]), do: e

  @spec append(nonempty_list) :: list
  defp append([head | tail]), do: append(head, tail)

  @spec append([]) :: []
  defp append([]), do: []

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    append(ll)
  end
end
