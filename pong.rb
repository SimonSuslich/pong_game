require 'gosu'

class Player
    def initialize()
        @score = 0
    end

    def createBar(x, y)
        PongBar.new(x, y)
    end

    def update
        @bar.draw
    end

end

class PongBall < Player
    def initialize
        @image = Gosu::Image.new("./media/pongball.png")
        @xCord = 312
        @yCord = 312
        @xDir = rand(10..39)*0.1
        @yDir = (4**2 - (@xDir)**2)**0.5
        @top = @yCord
        @bottom = @yCord + 16
        @left = @xCord
        @right = @xCord + 16
    end

    def update
        if (@top <= 16 || @bottom >= 626)
            @yDir *= -1
        end

        if (@left <= 16)
            ballHitWall(false)
        elsif (@right >= 626)
            ballHitWall(true)
        end

        @xCord += @xDir
        @yCord += @yDir
        @top = @yCord
        @bottom = @yCord + 16
        @left = @xCord
        @right = @xCord + 16
    end

    def draw
        @image.draw(@xCord, @yCord)
    end

    def ballHitBar
        @xDir *= -1
    end

    def ballHitWall (playerOneWinBool)
        if !playerOneWinBool
            
        else
            
        end
        initialize
    end

    def getPosition
        {
            :top => @top,
            :bottom => @bottom,
            :left => @left,
            :right => @right
        }
    end
end

class PongBar
    
    def initialize(xCordinate, yCordinate)
        @image = Gosu::Image.new("./media/pongbar.png")
        @xCord = xCordinate
        @yCord = yCordinate
        @top = @yCord
        @bottom = @yCord + 64
        @left = @xCord
        @right = @left + 8
    end

    def moveUp
        if @top >= 16+8
            @yCord -= 8
        end

    end

    def moveDown
        if @bottom <= 640-16-8
            @yCord += 8
        end
    end

    def getPosition
        {
            :top => @top,
            :bottom => @bottom,
            :left => @left,
            :right => @right
        }
    end

    def update
        @top = @yCord
        @bottom = @yCord + 64
    end

    def draw
        @image.draw(@xCord, @yCord, 0)

    end

end


class PongGame < Gosu::Window

    def initialize
        super 640, 640
        self.caption = "Pong Thong"
        xCord1 = 64
        xCord2 = 640-64
        yCord = 272
        @ball = PongBall.new
        @player1 = Player.new
        @player2 = Player.new
        @bar1 = @player1.createBar(xCord1, yCord)
        @bar2 = @player2.createBar(xCord2, yCord)
        @background = Gosu::Image.new("./media/pongbackground.png")
        @counter = 0
    end


    def update
        @ball.update
        @bar1.update
        @bar2.update
    
        ballPosition = @ball.getPosition
        bar1Position = @bar1.getPosition
        bar2Position= @bar2.getPosition

        if ballPosition[:top] >= bar2Position[:top] && ballPosition[:bottom] <= bar2Position[:bottom]
            p "ball between top and bottom"
            if ballPosition[:right] >= bar2Position[:left]
                p "ball not to the right"
                p  ballPosition
                p bar2Position
                if ballPosition[:left] <= bar2Position[:right]
                    p "ball touches bar"
                    @ball.ballHitBar
                end
            end

        end



        if Gosu.button_down? Gosu::KB_UP
            @bar2.moveUp
        end
        if Gosu.button_down? Gosu::KB_W
            @bar1.moveUp
        end
        if Gosu.button_down? Gosu::KB_DOWN
            @bar2.moveDown
        end
        if Gosu.button_down? Gosu::KB_S
            @bar1.moveDown
        end

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
