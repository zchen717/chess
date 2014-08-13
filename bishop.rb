#require_relative 'slider.rb'

class Bishop < Slider
  def move_dirs
    DIAG
  end
end