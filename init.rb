require 'ruby2d'
require_relative 'snake.rb'
require_relative 'game.rb'

set background: 'navy'
set fps_cap: 10      # this sets the speed of the snake
set title: "Snake Xenzia"     # change window title
set width: 800
set height: 600

GRID_SIZE = 20      # grid size in pixels

# scale the grid size to the window size
GRID_WIDTH = Window.width / GRID_SIZE
GRID_HEIGHT = Window.height / GRID_SIZE


snake = Snake.new    # instantiate snake and game
game = Game.new(snake)

# the main loop that runs the game
update do
    clear     # start by clearing the screen

    unless game.finished? or game.paused?  # snake continuously moves unless game is paused or finished
        snake.move
    end
    snake.draw
    game.draw

    if game.snake_hit_ball?(snake.x, snake.y)  # check if snake has eaten the food
        game.record_hit
        snake.grow
    end

    if snake.snake_hit_itself?   # check if snake has crushed into itself
        game.finish
    end
end

# the main mapping to take input from user, control the snake and play game
on :key_down do |event|
    if ['up', 'down', 'left', 'right'].include?(event.key)
        if snake.can_change_direction_to?(event.key)  # change direction of snake if its not backwards 
            snake.direction = event.key
        end
    elsif event.key == 'r' or event.key == 'R' # resetting game
        snake = Snake.new
        game = Game.new(snake)
    elsif event.key == 'q' or event.key == 'Q' # quitting game
        exit()
    elsif event.key == 'p' or event.key == 'P' # pausing/unpausing game
        if game.paused?
            game.unpause
        else
            game.pause
        end
    end

end

show
