local input_stack = {}


function input_stack.reset(self)
    self.cells = {}
end


function input_stack.contains(self, cell)
    for _, c in ipairs(self.cells) do
        if c == cell then
            return true
        end
    end
end


function input_stack.size(self)
    return #self.cells
end


function input_stack.index_of(self, cell)
    for i, c in ipairs(self.cells) do
        if c == cell then
            return i
        end
    end
    return 0
end


function input_stack.push(self, cell)
    self.cells[#self.cells + 1] = cell
end


function input_stack.pop(self)
    if #self.cells > 0 then
        return table.remove(self.cells, #self.cells)
    end
end


function input_stack.top(self)
    if #self.cells > 0 then
        return self.cells[#self.cells]
    end
end


return input_stack