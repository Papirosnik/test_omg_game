local const  = require "game.common.constants"

local levels_holder = {}


function levels_holder.init(self)
    local levels_json = sys.load_resource(const.FILENAME_LEVELS)
    self.data = json.decode(levels_json)
end


function levels_holder.count(self)
    return #self.data
end


function levels_holder.get_level_by_index(self, level_index)
    return self.data[level_index]
end


return levels_holder
