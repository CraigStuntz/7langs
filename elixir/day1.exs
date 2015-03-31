# Easy
point = {1, 2}
line = {{1, 2}, {3, 4}}
circle = {{1, 2}, 3}
triangle = {{1, 2}, {3, 4}, {5, 6}}

length_of_hypotenuse = &(:math.pow(&1, 2) + :math.pow(&2, 2) |> :math.sqrt())
IO.puts length_of_hypotenuse.(3, 4)

a = String.to_atom("Foo")
is_atom a

# Medium
a_list = [1, 3, 2]
defmodule Lists do
  def len([], acc), do: acc 
  def len([_|tail], acc), do: len(tail, acc + 1)
  def len(lst), do: len(lst, 0)
end
IO.puts Lists.len(a_list)
defmodule Words do
  def count([], acc), do: acc
  def count([head|tail], acc) do 
    count(tail, Map.put(acc, head, (acc[head] || 0) + 1))
  end
  def count(lst), do: count(lst, %{})
end
IO.inspect Words.count([:one, :two, :two])
