local M = {
    LOAD_LEVEL = hash("load_level"), -- index: level index [1..]
    SHOW_INFO = hash("show_info"),
    HIDE_INFO = hash("hide_info"),
    INPUT_CHANGED = hash("input_changed"), -- input: str
    INPUT_COMPLETED = hash("input_completed"),
    WORD_ACCEPTED = hash("word_accepted"), -- word, way, stored_index (for example, for color selection)
    WORD_REJECTED = hash("word_rejected"),
    TRY_ANOTHER_WAY = hash("try_another_way"),
    BONUS_WORD_FOUND = hash("bonus_word_found"),
    USER_PROGRESS_CHANGED = hash("user_progress_changed")
}

return M
