Point = Struct.new(:x, :y)

center = Point.new(0, 0)
inner_triangle = []
outer_triangle = []

$target_height = 100
$stroke_width = 8

distance_base_to_center = Math::tan(30 * Math::PI / 180) * 0.5
inner_triangle << Point.new(center.x - 0.5, center.y + distance_base_to_center)
inner_triangle << Point.new(center.x + 0.5, center.y + distance_base_to_center)
inner_triangle << Point.new(center.x + 0, center.y + distance_base_to_center - Math::sin(60 * Math::PI / 180))
distance_foot_x = Math::cos(30 * Math::PI / 180)
distance_foot_y = Math::sin(30 * Math::PI / 180)
outer_triangle << Point.new(inner_triangle[0].x - distance_foot_x, inner_triangle[0].y + distance_foot_y)
outer_triangle << Point.new(inner_triangle[1].x + distance_foot_x, inner_triangle[1].y + distance_foot_y)
outer_triangle << Point.new(inner_triangle[2].x, inner_triangle[2].y - 1)

$total_radius = (center.y - outer_triangle[2].y)
$pixels_per_unit = $target_height / (2 * $total_radius)


def transform(value)
    ((value + $total_radius) * $pixels_per_unit).round
end

inner_triangle_coordinates = inner_triangle.map { |point| "#{transform(point.x)} #{transform(point.y)}"}.join(' ')

puts <<~LOGO
<?xml version="1.0" standalone="no"?>
<svg viewBox="0 0 #{$target_height} #{$target_height}" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
  <symbol id="logo" width="#{$target_height}" height="#{$target_height}">
    <polygon points="#{inner_triangle_coordinates}"/>
    <circle cx="#{transform(center.x)}" cy="#{transform(center.y)}" r="#{$pixels_per_unit.round}"/>
    <line x1="#{transform(inner_triangle[0].x)}" y1="#{transform(inner_triangle[0].y)}" x2="#{transform(outer_triangle[0].x)}" y2="#{transform(outer_triangle[0].y)}"/>
    <line x1="#{transform(inner_triangle[1].x)}" y1="#{transform(inner_triangle[1].y)}" x2="#{transform(outer_triangle[1].x)}" y2="#{transform(outer_triangle[1].y)}"/>
    <line x1="#{transform(inner_triangle[2].x)}" y1="#{transform(inner_triangle[2].y)}" x2="#{transform(outer_triangle[2].x)}" y2="#{transform(outer_triangle[2].y)}"/>
  </symbol>

  <use xlink:href="#logo" transform="rotate(20,50,50)" fill="transparent" stroke-width="8"/>
</svg>
LOGO