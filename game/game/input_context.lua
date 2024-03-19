local grid_context = require "game.game.grid_context"


local input_context = {
    size_limit = 13 -- max possible len word
}


function input_context.reset(self)
    self.cells = {}
    self.data = ""
end


function input_context.contains(self, cell)
    for _, c in ipairs(self.cells) do
        if c == cell then
            return true
        end
    end
end


function input_context.size(self)
    return #self.cells
end


function input_context.index_of(self, cell)
    for i, c in ipairs(self.cells) do
        if c == cell then
            return i
        end
    end
    return 0
end


function input_context.push(self, cell)
    if #self.cells >= self.size_limit then
        return false
    end
    self.cells[#self.cells + 1] = cell
    self.data = self.data .. gui.get_text(cell[grid_context.hash_cell_text])
    return true
end


function input_context.pop(self)
    if #self.cells > 0 then
        self.data = self.data:sub(1, -2)
        return table.remove(self.cells, #self.cells)
    end
end


function input_context.top(self)
    if #self.cells > 0 then
        return self.cells[#self.cells]
    end
end


return input_context