local M = {
    HASH_CELL_ROOT = hash("cell/root"),
    HASH_CELL_TEXT = hash("cell/text"),
    HASH_CELL_COVER = hash("cell/cover"),

    FILENAME_WORDS = "/assets/data/words.txt",
    FILENAME_LEVELS = "/assets/data/levels.json",
    
    TXT_LEVEL = "Level ",
    TXT_BONUS_WORDS = "Bonus words: ",
    TXT_ERROR = "ERROR: ",
    TXT_FOUND = "FOUND!",
    TXT_TRY_ANOTHER_WAY = "TRY TO COLLECT THIS WORD IN ANOTHER WAY",
    TXT_ALREADY_COLLECTED = "ALREADY COLLECTED",
    TXT_BONUS_WORD_FOUND = "BONUS WORD FOUND!",
    TXT_TAP_TO_CONTINUE = "TAP TO CONTINUE",
    TXT_CONGRATULATIONS = "CONGRATULATIONS!",
    TXT_BONUS_NOT_AVAILABLE = ".\n'Bonus words' feature will be not available.",

    SND_BEEP = "main:/main#sound_beep",
    SND_CLICK = "main:/main#sound_click",
    SND_SUCCESS = "main:/main#sound_success",
    SND_NEGATIVE = "main:/main#sound_negative",
    SND_POSITIVE = "main:/main#sound_positive",
    SND_LEVEL_WIN = "main:/main#sound_win",

    MSG_SYS_ACQUIRE_FOCUS = "acquire_input_focus",

    MSG_TARGET_MAIN = "main:/main#main",
    MSG_TARGET_GAME_GUI = "game:/game#game_gui",
    MSG_TARGET_GRID_GUI = "game:/grid#grid_gui",

    WORD_COLORS = {
        vmath.vector4(0.33, 0.47, 0.28, 1),
        vmath.vector4(0.40, 0.74, 0.32, 1),
        vmath.vector4(0.34, 0.77, 0.58, 1),
        vmath.vector4(0.42, 0.54, 0.64, 1),
        vmath.vector4(0.48, 0.53, 0.42, 1),
        vmath.vector4(0.35, 0.67, 0.59, 1),
        vmath.vector4(0.45, 0.47, 0.34, 1),
        vmath.vector4(0.32, 0.55, 0.35, 1),
        vmath.vector4(0.65, 0.75, 0.33, 1),
        vmath.vector4(0.69, 0.48, 0.35, 1)
    }
}

return M
