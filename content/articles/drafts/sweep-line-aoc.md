+++
draft = true
+++
# A Sweep Line Algorithm For Advent of Code

When I was getting my degree in computer science, my one of my favorite lectures
was "Computational Geometry". Among other things, it introduced me to the elegant
technique of sweep line algorithms. This technique should be more widely known
and when I stumbled across a great use case for it in Advent of Code, I thought
I would write about it.

Sweep line algorithms are often a good way to solve geometric problems efficiently.
The name comes from visualizing sweeping a line across a 2D plane, updating a state
data structure whenever the line hits a point of interest. We call those points of
interest "events". What we store in the state and what constitutes an event depends
on the specific problem at hand. Many sweep line algorithms solve problems in 2D,
but there are also examples of 1D or 3D problems being solved with this technique.

In the problem from Advent of Code 2023, day 18, we are given a polygon with axis-aligned
edges and are asked to compute its area. All coordinates given are integers. So
in typical Advent of Code fashion part 1 of the puzzle can easily be solved by
drawing an outline of the polygon into a 2D array and then iterating through the
array row by row to sum up the total area. But in part 2 the polygon becomes so
large that this approach is infeasible.

Let's first take a step back and look at a general outline for how sweep line algorithms
are structured. Then discuss we'll discuss how the Advent of Code problem fits
into that framework.
