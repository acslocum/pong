require 'rubygems' # only necessary in Ruby 1.8
require 'gosu'
require 'paddle'
require 'ball'

class MyWindow < Gosu::Window
  def initialize
   super(640, 480, false)
   self.caption = 'PONG!'
   @paddle1 = Paddle.new(20,50, Gosu::KbA, Gosu::KbZ, :left, self)
   @paddle2 = Paddle.new(580,50, Gosu::KbK, Gosu::KbM, :right, self)
   @ball = Ball.new(100,100,self)
   @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
   @player_1_score=0
   @player_2_score=0
  end
  
  def score_player_1
    @ball.reset
    @player_1_score += 1
  end
  
  def score_player_2
    @ball.reset
    @player_2_score += 1
  end
  
  def update
    @ball.update(@paddle1, @paddle2)
    @paddle1.update
    @paddle2.update
    check_end
  end
  
  def draw
    @paddle1.draw
    @paddle2.draw
    @ball.draw
    draw_score
  end
  
  def draw_score
    @font.draw("#{@player_1_score}         #{@player_2_score}", 280, 10, 10)
  end
  
  def check_end
    close if @player_1_score > 10 or @player_2_score > 10
  end
  
  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end

window = MyWindow.new
window.show