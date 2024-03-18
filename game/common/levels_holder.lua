local levels_holder = {}

function levels_holder.init(self)
	local levels_json = sys.load_resource("/assets/data/levels.json")
	self.data = json.decode(levels_json)
end

function levels_holder.count(self)
	return #self.data
end

return levels_holder