local user_progress = {
    MSG_PROGRESS_CHANGED = hash("user_progress_changed"),
    data = {
        current_level = 9999,
        level_progress = {},
        level_bonus_words = {},
        total_bonus_words = 123
    }
}

function user_progress.update_info(self)
    msg.post("/gameplay/gameplay_gui_holder#gameplay_gui", self.MSG_PROGRESS_CHANGED, self.data)
end

function user_progress.load(self)
    self:update_info()
end

return user_progress