local messages = require "game.common.messages"
local user_progress = require "game.common.user_progress"
local levels_holder = require "game.common.levels_holder"
local input_storage = require "game.game.input_storage"
local words_storage = require "game.game.words_storage"


local current_level = {
    index = 0,
    context = {}
}

function current_level.load_by_index(self, level_index)
    self.index = level_index
    self.context = levels_holder:get_level_by_index(level_index)
    msg.post("game:/game#game_gui", messages.START_GAME)
end


function current_level.get(self)
    return self.context
end


local function check_word_way(origin_way)
    local input_way = input_storage:get_way()
    return table.concat(input_way) == table.concat(origin_way)
end


local function check_for_win(self, word_count)
    local count = 0
    for _ in pairs(self.context.words) do
        count = count + 1
    end
    return count == word_count
end

local function word_accepted(self, word, way)
    local word_count = user_progress:set_word_complete(word, way)
    msg.post("game:/game#game_gui", messages.WORD_ACCEPTED, { ["word"] = word, ["way"] = way, ["index"] = word_count })
    if check_for_win(self, word_count) then
        msg.post("game:/game#game_gui", messages.LEVEL_COMPLETE)
    end
end


local function word_rejected()
    msg.post("game:/game#game_gui", messages.WORD_REJECTED)
end


local function try_another_way()
    msg.post("game:/game#game_gui", messages.TRY_ANOTHER_WAY)
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
        msg.post("game:/game#game_gui", messages.BONUS_WORD_FOUND, { ["word"] = word })
    else
        word_rejected()
    end
end


return current_level
