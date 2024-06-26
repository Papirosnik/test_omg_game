local const = require "game.common.constants"
local messages = require "game.common.messages"
local user_progress = require "game.common.user_progress"
local current_level = require "game.game.current_level"


local cell_view_size = 128

local grid_storage = {
    is_ready = false,
    cells = {}
}


function grid_storage.reset(self)
    self.is_ready = false
    self.cells = {}
end


function grid_storage.clear(self)
    for y = 1, #self.cells do
        for x = 1, #self.cells[y] do
            for _, node in pairs(self.cells[y][x].nodes) do
                gui.delete_node(node)
            end
        end
    end
    self:reset()
end


local function create_cells(self, level)

    local template = gui.get_node(const.HASH_CELL_ROOT)

    local mid = (level.size + 1) / 2
    local need_scale = level.size > 4
    local sfy = need_scale and (4 / level.size) or 1
    local sfx = sfy * 1.1

    for y = 1, level.size do

        self.cells[y] = {}

        for x = 1, level.size do
            local cloned_nodes = gui.clone_tree(template)

            local new_cell = {
                ["cell_pos"] = { ["x"] = x, ["y"] = y },
                ["nodes"] = cloned_nodes
            }

            self.cells[y][x] = new_cell

            local new_root = new_cell.nodes[const.HASH_CELL_ROOT]
            gui.set_parent(new_root, gui.get_node(hash("root")))

            -- cells positioning and scaling (if needed)
            local pos = gui.get_position(new_root)

            pos.x = (x - mid) * cell_view_size * sfx
            pos.y = (mid - y) * cell_view_size * sfy
            gui.set_position(new_root, pos)

            gui.set_scale(new_root, vmath.vector3(0))
            gui.set_enabled(new_root, true)

            gui.animate(new_root, gui.PROP_SCALE,
            vmath.vector3(-sfx, sfy, sfy), gui.EASING_INOUTCIRC, 0.2, 0.25 + math.random() * 0.25,
            function() gui.animate(new_root, "scale.x", sfx, gui.EASING_LINEAR, 0.2, 0.6 + math.random() * 0.4) end)
        end
    end
end


local function setup_words(self, level)
    for word, position in pairs(level.words) do
        for i = 1, #word do
            local pos_index = (i - 1) * 2 + 1
            local cell_x, cell_y = position[pos_index], position[pos_index + 1]
            local text_node = self.cells[cell_y][cell_x].nodes[const.HASH_CELL_TEXT]
            gui.set_text(text_node, word:sub(i, i))
        end
    end
end


local function paint_completed_cells(self, delay)
    local progress = user_progress:current_level_progress()
    for index, data in ipairs(progress) do
        local color = const.WORD_COLORS[index]
        local pos_array = data["way"]
        for i = 1, #pos_array, 2 do
            local x = pos_array[i]
            local y = pos_array[i + 1]
            local cell = self.cells[y][x]
            cell["done"] = true -- restore its finished status
            local root_node = cell.nodes[const.HASH_CELL_ROOT]
            gui.animate(root_node, gui.PROP_COLOR, color, gui.EASING_LINEAR, 0.25, delay)
            local text_node = cell.nodes[const.HASH_CELL_TEXT]
            gui.animate(text_node, "color.w", 0.333, gui.EASING_LINEAR, 0.25, delay)
        end
    end
end


function grid_storage.get_cell_by_screen_pos(self, pos_x, pos_y)
    for y = 1, #self.cells do
        for x = 1, #self.cells[y] do
            local cell_root = self.cells[y][x].nodes[const.HASH_CELL_ROOT]
            if gui.pick_node(cell_root, pos_x, pos_y) then
                return self.cells[y][x]
            end
        end
    end
end


function grid_storage.create_grid(self)
    self:clear()
    local level = current_level:get()
    create_cells(self, level)
    setup_words(self, level)
    -- enable gameplay after 2 sec of board animation
    paint_completed_cells(self, 2)
    timer.delay(2, false, function() self.is_ready = true end)
end


function grid_storage.set_word_completed(self)
    paint_completed_cells(self, 0)
end


return grid_storage