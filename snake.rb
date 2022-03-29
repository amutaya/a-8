class Snake

    attr_writer :direction
    attr_reader :positions

    def initialize
        @positions = [[3, 0], [3,1], [3,2], [3,3]] # initialize the coordinates of the snake so it appears in same place every time
        @direction = 'down'    
        @growing = false
    end

    def draw
        @positions.each do |position| # iterate through the positions and draw a square
            Square.new(x: position[0] * GRID_SIZE, y: position[1] * GRID_SIZE, size: GRID_SIZE - 1, color: 'white')
        end
    end

    # method to move the snake
    def move
        if !@growing  # check if snake has eaten food and isn't growing
            @positions.shift   # undraw last square, ie. the tail, by shifting the array by one
        end
    
        case @direction  # check for the arrow chosen and draw new square by pushing a new coordinate 1 square away in the direction of the arrow
        when 'down'
            @positions.push(new_coords(head[0], head[1] + 1))
        when 'up'
            @positions.push(new_coords(head[0], head[1] - 1))
        when 'left'
            @positions.push(new_coords(head[0] - 1, head[1]))
        when 'right'
            @positions.push(new_coords(head[0] + 1, head[1]))
        end
        @growing = false
    end

    # method to preventing snake from moving backwards into itself, so if it's going up, it shouldn't be able to go down
    def can_change_direction_to?(new_direction)
        case @direction
        when 'up' then new_direction != 'down'
        when 'down' then new_direction != 'up'
        when 'left' then new_direction != 'right'
        when 'right' then new_direction != 'left'
        end
    end

    # simple methods to return the coordinates of the snake's head
    def x
        head[0]
    end

    def y
        head[1]
    end

    # method to grow the snake. Will be triggered when snake eats food
    def grow
        @growing = true
    end

    # method to check if snake has bit itself 
    def snake_hit_itself?
        @positions.uniq.length != @positions.length # check if there are duplicate positions in the snake coordinates which signals self-collision
    end

    private
    # new_coords and head should be private because they are only needed by move 

    # Method to make snake appear on the other side of the screen when it goes over the edge
    def new_coords(x,y)
        [x % GRID_WIDTH, y % GRID_HEIGHT]    # use modulo to ensure x and y never exceed the grid size
    end

    # method to return the head when we undraw it
    def head
        @positions.last
    end

end