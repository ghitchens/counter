# Counter

This is a trivial application to explore issues related to
handling events and state.  

It implements a single counter that counts upwards once a second,
but can be reset via an API.

Here is an example of IEX enter in a command every 2-3 seconds.

```elixir
Interactive Elixir (1.4.1) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> Counter.count
3
iex(2)> Counter.count
5
iex(3)> Counter.clear
:ok
iex(4)> Counter.count
3
```
 
