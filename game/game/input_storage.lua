local const  = require "game.common.constants"

local input_storage = {
    size_limit = 13 -- max possible len word
}


function input_storage.reset(self)
    self.cells = {}
    self.word = ""
end


function input_storage.contains(self, cell)
    for _, c in ipairs(self.cells) do
        if c == cell then
            return true
        end
    end
end


function input_storage.size(self)
    return #self.cells
end


function input_storage.index_of(self, cell)
    for i, c in ipairs(self.cells) do
        if c == cell then
            return i
        end
    end
    return 0
end


function input_storage.push(self, cell)
    if #self.cells >= self.size_limit then
        return false
    end
    self.cells[#self.cells + 1] = cell
    self.word = self.word .. gui.get_text(cell.nodes[const.HASH_CELL_TEXT])
    return true
end


function input_storage.pop(self)
    if #self.cells > 0 then
        self.word = self.word:sub(1, -2)
        return table.remove(self.cells, #self.cells)
    end
end


function input_storage.top(self)
    if #self.cells > 0 then
        return self.cells[#self.cells]
    end
end

function input_storage.get_way(self)
    local way = {}
    for i, cell in ipairs(self.cells) do
        table.insert(way, cell.cell_pos.x)
        table.insert(way, cell.cell_pos.y)
    end
    return way
end


return input_storage
