#require_relative 'slider.rb'

class Queen < Slider
  def move_dirs
    DIAG + STRT
  end
end