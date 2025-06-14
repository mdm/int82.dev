When I was getting my degree in computer science, my one of my favorite lectures
was "Computational Geometry". Among other things, it introduced me to the elegant
technique of sweep line algorithms. It should be more widely known and when I
stumbled across a great use case for it in Advent of Code, I thought I would write
about it.

Sweep line algorithms are often a good way to solve geometric problems efficiently.
The name comes from visualizing sweeping a line across a 2D plane, updating a state
data structure whenever the line hits a point of interest. We call those points of
interest "events". What we store in the state and what constitutes an envent depends
on the specific problem at hand. Many sweep line algorithms solve problems in 2D, but
there are also examples of 1D or 3D problems, being solved with this technique.
