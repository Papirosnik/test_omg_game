-- function tablelength(T)
-- 	local count = 0
-- 	for _ in pairs(T) do count = count + 1 end
-- 	return count
-- end

local user_progress = {
	MSG_PROGRESS_CHANGED = hash("user_progress_changed"),
	current_level = 1,
	level_progress = {},
	level_bonus_words = {},
	total_bonus_words = 0
}

function user_progress.update(self)
	msg.post("/game/gameplay/game.gui_script", MSG_PROGRESS_CHANGED, self)
end

function user_progress.load(self)
	print("Current level: " .. self.current_level)
end

return user_progress;