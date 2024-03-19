local levels_holder = require "game.common.levels_holder"
local user_progress = require "game.common.user_progress"


local grid_controller = {
    hash_cell_root = hash("cell/root"),
    hash_cell_text = hash("cell/text"),
    hash_cell_cover = hash("cell/cover"),
    is_ready = false,
    cells = {}
}


function grid_controller.reset(self)
    self.is_ready = false
    self.cells = {}
end


function grid_controller.clear(self)
    for y = 1, #self.cells do
        for x = 1, #self.cells[y] do
            for _, node in pairs(self.cells[y][x]) do
                gui.delete_node(node)
            end
        end
    end
    self:reset()
end


local function current_level()
    return levels_holder:get_level_by_index(user_progress:current_level_index())
end


local function create_cells(self, level)

    local template = gui.get_node(self.hash_cell_root)

    for y = 1, level.size do

        self.cells[y] = {}

        for x = 1, level.size do
            local new_cell = gui.clone_tree(template)
            self.cells[y][x] = new_cell

            local new_root = new_cell[self.hash_cell_root]

            -- cells positioning and scaling (if needed)
            local need_scale = level.size > 4
            local scale_factor = need_scale and (4 / level.size) or 1
            local pos = gui.get_position(new_root)
            local mid = (level.size + 1) / 2
            pos.x = 320 + (x - mid) * 128 * scale_factor
            pos.y = 400 - (y - mid) * 128 * scale_factor
            gui.set_position(new_root, pos)

            gui.set_scale(new_root, vmath.vector3(0))
            gui.set_enabled(new_root, true)

            gui.animate(new_root, gui.PROP_SCALE,
                vmath.vector3(-scale_factor, scale_factor, scale_factor), gui.EASING_INOUTCIRC, 0.2, 0.25 + math.random() * 0.25,
                function() gui.animate(new_root, "scale.x", scale_factor, gui.EASING_LINEAR, 0.2, 0.6 + math.random() * 0.4) end) 
        end
    end
end


local function setup_words(self, level)
    for word, position in pairs(level.words) do
        for i = 1, #word do
            local pos_index = (i - 1) * 2 + 1
            local cell_x, cell_y = position[pos_index], position[pos_index + 1]
            local text_node = self.cells[cell_y][cell_x][self.hash_cell_text]
            gui.set_text(text_node, word:sub(i, i))
        end
    end
end


function grid_controller.get_grid_pos(self, cell)
    for y = 1, #self.cells do
        for x = 1, #self.cells[y] do
            if cell == self.cells[y][x] then
                return x, y
            end
        end
    end
end



function grid_controller.get_cell_at_screen_pos(self, pos_x, pos_y)
    for y = 1, #self.cells do
        for x = 1, #self.cells[y] do
            local cell_root = self.cells[y][x][self.hash_cell_root]
            if gui.pick_node(cell_root, pos_x, pos_y) then
                return self.cells[y][x], x, y
            end
        end
    end
end


function grid_controller.create_grid(self)
    self:clear()
    local level = current_level()
    create_cells(self, level)
    setup_words(self, level)
    -- enable gameplay after 2 sec of board animation
    timer.delay(2, false, function() self.is_ready = true end) 
end


return grid_controller