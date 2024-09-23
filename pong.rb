require 'gosu'

class Player
    def initialize(xCordinate, yCordinate)
        @bar = PongBar.new(xCordinate, yCordinate)
        @score = 0
    end

    def update
        @bar.draw
    end

end

class PongBall
    def initialize
        @image = Gosu::Image.new("./media/pongball.png")
    end

    def draw
        @image.draw(312, 312, 0, 3, 3)
    end
end

class PongBar
    
    def initialize(xCordinate, yCordinate)
        @image = Gosu::Image.new("./media/pongbar.png")
        @xCord = xCordinate
        @yCord = yCordinate

    end


    def draw
        @image.draw(@xCord, @yCord, 0)

    end

end


class PongGame < Gosu::Window

    #konstruktor
    def initialize
        super 640, 640
        self.caption = "Pong Thong"
        xCord1 = 64
        xCord2 = 576-60
        yCord = 288
        @ball = PongBall.new
        @bar1 = PongBar.new(xCord1, yCord)
        @bar2 = PongBar.new(xCord2, yCord)
        @background = Gosu::Image.new("./media/pongbackground.png")
    end


    def update
        
    end

    def draw
        @background.draw(0,0,0)
        @ball.draw
        @bar1.draw
        @bar2.draw
    end

end

game = PongGame.new
game.show
