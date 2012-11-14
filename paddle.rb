require 'gosu'

class Paddle
  attr_reader :x, :y
  HEIGHT=100
  WIDTH=20
  def initialize(x,y, up_key, down_key, side, window)
    @x = x
    @y = y
    @up_key = up_key
    @down_key = down_key
    @window = window
    @side = side
    
    @graphic = Gosu::Image.new(@window, 'media/log.png', false)
  end
  
  def update
    if @window.button_down? @up_key then
      move_up
    end
    if @window.button_down? @down_key then
      move_down
    end
  end
  
  def move_up
    @y -= 10 unless @y<=0
  end
  
  def move_down
    @y += 10 unless @y >= (480-HEIGHT)
  end
  
  def attack_side
    return max_x if @side == :left
    return min_x if @side == :right
  end
  
  def left?
    @side == :left
  end
  
  def right?
    @side == :right
  end
  
  def draw
    c=0xffffffff
    @graphic.draw_as_quad(min_x,min_y,c,
                          max_x,min_y,c,
                          max_x,max_y,c,
                          min_x,max_y,c, 1)
  end

  def min_y
    @y
  end
  
  def max_y
    @y + HEIGHT
  end
  
  def min_x
    @x
  end
  
  def max_x
    @x + WIDTH
  end
  
end