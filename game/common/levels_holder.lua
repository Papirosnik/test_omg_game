local levels_holder = {}


function levels_holder.init(self)
    local levels_json = sys.load_resource("/assets/data/levels.json")
    self.data = json.decode(levels_json)
end


function levels_holder.count(self)
    return #self.data
end


function levels_holder.get_level_by_index(self, level_index)
    for index, level in ipairs(self.data) do
        if index == level_index then
            return level
        end
    end
    print("WARNING: No level found with index " .. level_index)
end


return levels_holder