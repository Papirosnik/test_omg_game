local levels = require "game.common.levels_holder"
local defsave = require("defsave.defsave")

local user_progress = {
    MSG_PROGRESS_CHANGED = hash("user_progress_changed"),
    KEY_SAVE_CURRENT = "current",
    data = {
        current_level = 1,
        level_progress = {},
        level_bonus_words = {},
        total_bonus_words = 0
    }
}

function user_progress.update_info(self)
    msg.post("/gameplay/gameplay#gameplay_gui", self.MSG_PROGRESS_CHANGED, self.data)
end

function user_progress.init(self)
    defsave.appname = "test_omg"
    defsave.verbose = true
    defsave.use_default_data = true
    defsave.default_data[self.KEY_SAVE_CURRENT] = self.data

    defsave.load(self.KEY_SAVE_CURRENT)
    self.data.current_level = defsave.get(self.KEY_SAVE_CURRENT, "current_level")
    self.data.level_progress = defsave.get(self.KEY_SAVE_CURRENT, "level_progress")
    self.data.level_bonus_words = defsave.get(self.KEY_SAVE_CURRENT, "level_bonus_words")
    self.data.total_bonus_words = defsave.get(self.KEY_SAVE_CURRENT, "total_bonus_words")

    self:update_info()
end

function user_progress.done(self)
    defsave.save(self.KEY_SAVE_CURRENT)
end

function user_progress.next_level(self)
    if self.data.current_level < levels:count() then
        self.data.current_level = self.data.current_level + 1
    else
        self.data.current_level = 1
    end
    defsave.set(self.KEY_SAVE_CURRENT, "current_level", self.data.current_level)
    defsave.save(self.KEY_SAVE_CURRENT)
    self:update_info()
end

return user_progress