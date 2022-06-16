---
title:  "Styles Test"
---
You’ll find this post in your `_posts` directo<span style="color: pink">ry. Go ahead and edit it and r</span>e-build the site to see your changes. You can rebuild the site in many different ways, but the most common way is to run `jekyll serve`, which launches a web server and auto-regenerates your site when a file is updated.

> To add new posts, simply add a file in the `_posts` directory that follows the convention `YYYY-MM-DD-name-of-post.ext` and includes the necessary front matter. Take a look at the source for this post to get an idea about how it works.

Jekyll also offers powerful support for code snippets:

```rust
use std::{io::BufRead, usize};

#[derive(Debug)]
enum Test {
  A,
  B,
}

fn count_increasing(measurements: &Vec<u32>) -> usize {
    measurements
        .iter()
        .skip(1)
        .zip(measurements.iter())
        .filter(|(a, b)| a > b)
        .count()
}

fn main() {
    let filename = std::env::args().nth(1).unwrap();
    let file = std::fs::File::open(filename).unwrap();
    let reader = std::io::BufReader::new(file);

    let measurements = reader
        .lines()
        .map(|line| line.unwrap().parse::<u32>().unwrap())
        .collect::<Vec<_>>();

    let part1 = count_increasing(&measurements);

    println!("{}", part1);

    let mut measurements2 = Vec::new();
    for i in 2..measurements.len() {
        let sum_of_three = measurements[i - 2] + measurements[i - 1] + measurements[i];
        measurements2.push(sum_of_three);
    }

    let part2 = count_increasing(&measurements2);

    println!("{}", part2);
}
```

```ruby
class SimpleGraph
    Vertex = Struct.new(:edges)
    Edge = Struct.new(:vertex1, :vertex2)

    def initialize(num_vertices)
        @edges = []
        @vertices = []
        @test = "some\tstring#{interpolation_test}\r\n"
        num_vertices.times { @vertices << Vertex.new([]) }
    end

    def add_vertex
        @vertices << Vertex.new([])
    end

    def add_edge(vertex1, vertex2)
        edge = Edge.new(vertex1, vertex2)
        @edges << edge
        @vertices[vertex1].edges << edge
        @vertices[vertex2].edges << edge
    end

    def find_directed_path(source, destination)
        visited = [nil] * @vertices.length
        visited[source] = Edge.new(nil, nil)  # dummy, so we don't visit the source twice
        queue = [source]

        while queue.length > 0
            current = queue.delete_at(0)
            #puts current

            if current == destination
                path = []
                while not (current == source)
                    path << visited[current]
                    current = visited[current].vertex1
                end
                return path.reverse
            end

            @vertices[current].edges.each do |edge|
                if visited[edge.vertex2] == nil  # vertex2 was not visited before
                    queue << edge.vertex2
                    visited[edge.vertex2] = edge
                end
            end
        end

        return []
    end

    def write_dot_file(filename, directed)
        File.open(filename, 'wb') do |file|
            if directed
                file.puts 'digraph {'
                @edges.each { |edge| file.puts('    ' + edge.vertex1.to_s + ' -> ' + edge.vertex2.to_s + ';') }
            else
                file.puts 'graph {'
                @edges.each { |edge| file.puts('    ' + edge.vertex1.to_s + ' -- ' + edge.vertex2.to_s + ';') }
            end
            file.puts '}'
        end
    end
end
```

Check out the [Jekyll docs][jekyll] for more info on how to get the most out of Jekyll. File all bugs/feature requests at [Jekyll’s GitHub repo][jekyll-gh]. If you have questions, you can ask them on [Jekyll’s dedicated Help repository][jekyll-help].

[jekyll]:      http://jekyllrb.com
[jekyll-gh]:   https://github.com/jekyll/jekyll
[jekyll-help]: https://github.com/jekyll/jekyll-help
