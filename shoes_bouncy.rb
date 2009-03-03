#!/usr/bin/env shoes

require File.dirname(__FILE__)+'/lib/shoes_shared/point'

=begin
class Shoes
  class Shape
    def distance_to(point)
      Math::sqrt((left-point.x)**2+(top-point.y)**2)
    end
  end
end
=end

Shoes.app do
  $app = self
  #Shoes.show_log

#  OVAL_RADIUS = 50
  background black

  motion_point = Point.new(0, 0)
  click_point = Point.new(0, 0)
  release_point = Point.new(0, 0)

  objects = []
  speeds = {}

  100.times do
    oval_radius = (1..10).rand
    obj = oval((oval_radius..self.width-oval_radius).rand, (oval_radius..self.height-oval_radius).rand, oval_radius)
    obj.style({:fill => rgb((0..255).rand, (0..255).rand , (0..255).rand), :strokewidth => 0})
    objects << obj
  end

  objects.each do |obj|
    speeds[obj] = [(-10..10).rand, (-10..10).rand]
  end

  click do |button, x, y|
    click_point.update(x, y)
  end

  motion do |x, y|
    motion_point.update(x, y)
  end

  release do |button, x, y|
    release_point.update(x, y)
  end

  animate(30) do
    speeds.each do |obj, speed|
      new_left = obj.left + speed.first
      new_top = obj.top + speed.last

      speed[0] *= -1  if new_left >= self.width - obj.width or new_left <= 0
      speed[-1] *= -1 if new_top >= self.height - obj.height or new_top <= 0

      obj.move(new_left.to_i, new_top.to_i)
    end

  end

end
