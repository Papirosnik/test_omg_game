local M = {
    START_GAME = hash("load_level"),
    SHOW_INFO = hash("show_info"),
    HIDE_INFO = hash("hide_info"),
    INPUT_CHANGED = hash("input_changed"), -- input: str
    INPUT_COMPLETED = hash("input_completed"),
    WORD_ACCEPTED = hash("word_accepted"), -- word, way, stored_index (for example, for color selection)
    WORD_REJECTED = hash("word_rejected"),
    TRY_ANOTHER_WAY = hash("try_another_way"),
    BONUS_WORD_FOUND = hash("bonus_word_found"),
    RESET_BONUS_WORDS = hash("reset_bonus_words"),
    UPDATE_BONUS_WORDS = hash("update_bonus_count"),
    LEVEL_COMPLETE = hash("level_complete"),
    UNLOAD_LEVEL = hash("unload_level"),
    GOTO_LEVEL_MAP = hash("goto_level_map"),
}

return M
