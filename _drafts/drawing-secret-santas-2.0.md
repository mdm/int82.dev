---
title:  "Drawing Secret Santas"
date: 2022-10-15
---

<!--
* Explain concrete algorithm first and introduce theory after?
-->

My family draws Secret Santas each year for Christmas. If you are not familiar with the concept,
you basically draw from a pool of names and then buy a present only for the person whose name you
drew.

If you have ever done that, you'll probably have experienced some issues with the draw.
People might draw their own name, or you may want to enforce additional constraints like "couples
should not draw each other" or "you should not draw the same person as last year". Of course, you
can redo the full draw until everyone draws a name that does not violate any of the constraints,
but there's a better, algorithmic way that will find a valid draw in one go if that is at all possible.

I've prepared a simple web app demonstrating the algorithm [here](https://santa.migge.io). If you
are interested in how this works read on.

Formalizing The Problem Statement
---------------------------------

Let's first try to phrase the problem of drawing names in a more formal way. Often an algorithmic
problem we want to solve already has well established solutions in academic literature and using
the proper jargon will help us in our research. Even if we come up empty it's often useful to see
what has already been tried on similar problems.

Every participant in the draw has two roles to fulfill: They give a present, and they receive a present.
Additionally, we want to allow certain giver-receiver combinations and disallow others. We can represent
this scenario as an [undirected graph](https://en.wikipedia.org/wiki/Graph_(discrete_mathematics)). Each participant
is represented by two vertices - a giver vertex and a receiver vertex. An edge between a giver and a
receiver means we want to allow that combination. Note that edges between two givers or between two
receivers don't make sense in this scenario. Such a graph, where there are two sets of vertices and edges
only run between vertices from different sets is called a [bipartite graph](https://en.wikipedia.org/wiki/Bipartite_graph) (see figure 1).

<!-- Insert figure 1 here. -->

In general a matching in a given graph is a set of edges so that no two edges have a common vertex. It
follows that a matching in our bipartite graph nicely describes a draw - edges in the matching are the
assignments of givers to receivers and by the definition of a matching we can be sure that no giver is
assigned two receivers or vice versa. We are, however, not interested in any matching, but a matching
where every giver also has an assigned receiver. This might or might not be possible. So in other words
we are interested in maximizing the number of edges in the matching. This is called a
[maximum cardinality matching](https://en.wikipedia.org/wiki/Maximum_cardinality_matching).

So how do we find such a maximum cardinality matching? It turns out we can treat our problem as a special
case of a more general problem called [maximum flow](https://en.wikipedia.org/wiki/Maximum_flow_problem)
and solve this using the well-known [Ford-Fulkerson algorithm](https://en.wikipedia.org/wiki/Ford%E2%80%93Fulkerson_algorithm).
This involves embedding our bipartite graph into a slightly more complicated graph, but let's first introduce
the general maximum flow problem in a bit more detail.

A [flow network](https://en.wikipedia.org/wiki/Flow_network) is a directed graph where each edge has an
associated maximum capacity and an associated flow. Also, there are two special nodes called the
source and the sink. The maximum capacity of each edge can be an arbitrary non-negative number, but there
are restrictions on the flow. Specifically, the flow for each edge must be between 0 and the maximum
capacity of the edge and the sum of the flows going into each vertex (except for the source and
the sink) must be equal to the sum of the flows going out of the vertex. You can think of this as a system
of water pipes running between the vertices. The maximum flow of such a system would be the maximum amount
water per time unit that you could pump through it. If we maximize the flow of each individual edge in a flow
network while making sure we don't violate the restrictions the maximum flow would be the sum of the flows
going out of the source or equivalently going into the sink.

To solve our maximum cardinality matching problem we turn our bipartite graph into a flow network as follows:

1. Add source and sink vertices
2. Add directed edges from the source to each giver vertex
3. Turn the edges in our original bipartite graph into directed edges from giver to receiver
4. Add directed edges from each receiver to the sink
5. Set all edge capacities to 1 and all edge flows to 0

Figure 2 shows how such a flow network might look for a simple instance of our problem.

<!-- Insert figure 2 here -->

To give an informal justification why the maximum flow in this network gives us a maximum cardinality
matching observe that while there might be multiple maximum flows that are equal in value in our case there is always
a maximum flow that uses each edge either to its full capacity or not at all (TODO: Is this really true? It seems like a vertex with one incoming edge with capacity 3 and two outgoing edges each with capacity 2 would be a counter-example). The Ford-Fulkerson algorithm
finds such a maximum flow. So the setup of the graph guarantees three properties:

1. The matching will not contain more edges than there are participants in the draw, because the source has
   a total outgoing capacity equal to the number of participants.
2. Each giver will be matched with at most one receiver and vice versa, because the outgoing and incoming flows
   of each vertex except the source and the sink must be equal.
3. The maximum flow will use the maximum number of giver to receiver edges possible, because otherwise it would
   not maximize the flow from the source to the giver vertices.

This means that, in the maximum flow as calculated by the Ford-Fulkerson algorithm, every edge from a giver to a
receiver that is used (i.e. every edge that is assigned a flow greater than 0) is part of the maximum cardinality
matching we want to calculate.

The Algorithm
-------------


The Implementation
------------------

References
----------

I tried to link relevant Wikipedia articles throughout this blog post. But I first came across this algorithm
in the book "Introduction to Algorithms" by Cormen, et al.

