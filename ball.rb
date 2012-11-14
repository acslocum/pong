require 'gosu'

class Ball
  WIDTH=40
  HEIGHT=40
  def initialize(x,y,window)
    @x = x
    @y = y
    @velocity_x = 5
    @velocity_y = 5
    @window = window
    @graphic = Gosu::Image.new(@window, 'media/tennis-ball1.png', false)
  end
  
  def update(paddle1, paddle2)
    resolve_paddle_collision(paddle1)
    resolve_paddle_collision(paddle2)
    resolve_wall_collision
    @x += @velocity_x
    @y += @velocity_y
  end
  
  def reset
    @x = 300
    @y = 220
    @velocity_x = random_velocity
    @velocity_y = random_velocity
  end
  
  def random_velocity
    5 * (rand(2)*2-1)
  end
  
  def resolve_wall_collision
    @velocity_x = -@velocity_x if @x <=0 or @x >= (640-WIDTH)
    @velocity_y = -@velocity_y if @y <=0 or @y >= (480-HEIGHT)
  end
  
  def resolve_paddle_collision(paddle)
    @window.score_player_1 if max_x > 635
    @window.score_player_2 if min_x < 5

    return if max_y < paddle.min_y or min_y > paddle.max_y
    if(side == :left && paddle.left?) then
      @velocity_x = -@velocity_x if min_x <= paddle.attack_side
    elsif(side == :right and paddle.right?) then
      @velocity_x = -@velocity_x if max_x >= paddle.attack_side
    end
  end
  
  def side
    return :left if @x <= 320
    return :right if @x > 320
  end
  
  def draw
    c=0xffffffff
    @graphic.draw_as_quad(@x,@y,c,@x+WIDTH,@y,c,@x+WIDTH,@y+HEIGHT,c,@x,@y+HEIGHT,c,2)
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