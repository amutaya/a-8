class Game
    # initialize the game attributes
    def initialize(snake)
        @snake = snake
        @score = 0
        initial_coords = draw_ball
        @ball_x = initial_coords[0]
        @ball_y = initial_coords[1]
        @finished = false
        @paused = false
    end

    # methos to ensure the food doesn't get drawn inside the snake, so initially snake position is not the same as food position 
    def draw_ball
        available_coords = []
        for x in (0..GRID_WIDTH-1)
            for y in (0..GRID_HEIGHT-1)
                available_coords.append([x, y])
            end
        end

        selected = available_coords.select{|coord| @snake.positions.include?(coord) == false}  # checks for coordinates not occupied by snake
        selected.sample

    end

    # method to draw food and game message to screen 
    def draw
        unless finished?  # run until the game is finished
            Square.new(x: @ball_x * GRID_SIZE, y: @ball_y * GRID_SIZE, size: GRID_SIZE, color: 'orange')
        end
        Text.new(text_message, color: 'green', x: 10, y: 10, size: 25)
    end
    
    # method to check if snake ate food by comparing coordinates
    def snake_hit_ball?(x, y)
        @ball_x == x && @ball_y == y
    end

    # method to increment score and draw the food
    def record_hit
        @score += 1
        ball_coords = draw_ball
        @ball_x = ball_coords[0]
        @ball_y = ball_coords[1]
    end

    # following methods return the game state

    def finish
        @finished = true
    end

    def finished?
        @finished
    end

    def pause
        @paused = true
    end

    def unpause
        @paused = false
    end

    def paused?
        @paused
    end



    private

    # private to only draw. Writes the text to the screen 
    def text_message
        if finished?
            "Game over, score: #{@score}. Press 'R' to restart, 'Q' to quit."
        elsif paused?
            "Game paused, score: #{@score}. Press 'P' to resume."
        else
            "Score: #{@score}"
        end
    end

end



