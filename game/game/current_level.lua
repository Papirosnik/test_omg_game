local const = require "game.common.constants"
local messages = require "game.common.messages"
local user_progress = require "game.common.user_progress"
local levels_holder = require "game.common.levels_holder"
local input_storage = require "game.game.input_storage"
local words_storage = require "game.game.words_storage"


local current_level = {
    index = 0,
    context = {},
    word_count = 0
}

function current_level.load_by_index(self, level_index)
    self.word_count = 0
    self.index = level_index
    self.context = levels_holder:get_level_by_index(level_index)
    msg.post(const.MSG_TARGET_GAME_GUI, messages.START_GAME)
end


function current_level.get(self)
    return self.context
end


local function check_word_way(origin_way)
    local input_way = input_storage:get_way()
    return table.concat(input_way) == table.concat(origin_way)
end


local function check_for_win(self, word_count)
    -- lazy calculation of word count
    if self.word_count == 0 then
        for _ in pairs(self.context.words) do
            self.word_count = self.word_count + 1
        end
    end
    return self.word_count == word_count
end

local function word_accepted(self, word, way)
    local word_count = user_progress:set_word_complete(word, way)
    msg.post(const.MSG_TARGET_GAME_GUI, messages.WORD_ACCEPTED, { ["word"] = word, ["way"] = way, ["index"] = word_count })
    if check_for_win(self, word_count) then
        msg.post(const.MSG_TARGET_GAME_GUI, messages.LEVEL_COMPLETE)
    end
end


local function word_rejected()
    msg.post(const.MSG_TARGET_GAME_GUI, messages.WORD_REJECTED)
end


local function try_another_way()
    msg.post(const.MSG_TARGET_GAME_GUI, messages.TRY_ANOTHER_WAY)
end


function current_level.check_word(self, word)
    for tw, way in pairs(self.context["words"]) do
        if tw == word then
            if check_word_way(way) then
                word_accepted(self, word, way)
            else
                try_another_way()
            end
            return true
        end
    end
    if words_storage:word_exists(word) then
        msg.post(const.MSG_TARGET_GAME_GUI, messages.BONUS_WORD_FOUND, { ["word"] = word })
    else
        word_rejected()
    end
end


return current_level
