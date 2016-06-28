# Pond

**Challenge for June NashFP**

This NashFP playground is based on an [ElixirForum](https://elixirforum.com/t/thought-experiment-drawing-a-pond-simulation/894) post by James Edward Gray II ([JEG2](https://twitter.com/JEG2)).
> I've been playing with several simulations for a while now, to learn more about how Elixir's processes work. Now I am cleaning up some ideas in preparation for a training at ElixirConf
>
> _...(omitted text)..._
>
>Here's the problem:
>
>Draw a 64 lily pads wide by 128 lily pads high pond with 3,000 turtles and 3,000 frogs distributed randomly across them. No critter should share a pad. Each critter periodically counts surrounding neighbors of the same type. If the same type count is less than 30% of the total number of neighbors (up to eight), the critter will try to move to an open pad in a random direction, some random distance between one and five steps away.

While the experiment was posed as an Elixir challenge, it would be fun to see actor-model solutions in other FP languages to.

# Running

to run, just run `mix run -e Pond.main` _note: you will
need Elixir 1.3 to run this_. You will probably need to
minimize your terminal font size to see the full grid.
