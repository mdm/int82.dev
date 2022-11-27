---
title: htraceray
tagline: A ray tracer with multi-core support.
repo: https://github.com/mdm/htraceray
tech: Haskell
license: BSD-3-Clause license
screenshot: /assets/images/htraceray.png
---
I learned Haskell in university, but had never used it for a non-trivial project.
To gain more experience with Haskell I implemented a ray tracer in Haskell. I used
the design from Peter Shirley's "[Ray Tracing in One Weekend][1]" and changed it
to better fit the functional programming paradigm.

The ray tracer supports spheres and triangle meshes in a couple of different materials.
It makes use of multicore processors, but even with that the performance is not on par
with some other implementations of this design, I have seen around the web. However,
the results look nice, and I learned a lot about Haskell.

[1]: https://raytracing.github.io/books/RayTracingInOneWeekend.html
