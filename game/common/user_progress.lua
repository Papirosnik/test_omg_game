local levels = require "game.common.levels_holder"
local messages = require "game.common.messages"
local defsave = require "defsave.defsave"


local KEY_CURRENT = "current"

local KEY_CURRENT_LEVEL = "current_level"
local KEY_LEVEL_PROGRESS = "level_progress"
local KEY_BONUS_WORDS = "bonus_words"


local user_progress = {
    data = {
        [KEY_CURRENT_LEVEL] = 1,
        [KEY_LEVEL_PROGRESS] = {}, -- array of records {"word": str, "way": [numbers]}
        [KEY_BONUS_WORDS] = {}, -- hash set
    }
}


function user_progress.init(self)
    defsave.appname = "test_omg"
    defsave.verbose = true
    defsave.use_default_data = true
    defsave.default_data[KEY_CURRENT] = self.data

    defsave.load(KEY_CURRENT)
    self.data.current_level = defsave.get(KEY_CURRENT, KEY_CURRENT_LEVEL)
    self.data.level_progress = defsave.get(KEY_CURRENT, KEY_LEVEL_PROGRESS)
    self.data.bonus_words = defsave.get(KEY_CURRENT, KEY_BONUS_WORDS)
end


local function flush_save()
    defsave.save(KEY_CURRENT)
end


function user_progress.done(self)
    flush_save()
end


function user_progress.current_level_index(self)
    return self.data.current_level
end


function user_progress.current_level_progress(self)
    return self.data.level_progress
end


function user_progress.get_bonus_words_count(self)
    local res = 0
    for _ in pairs(self.data.bonus_words) do
        res = res + 1
    end
    return res
end


function user_progress.goto_next_level(self)
    if self.data.current_level < levels:count() then
        self.data.current_level = self.data.current_level + 1
    else
        self.data.current_level = 1
    end
    defsave.set(KEY_CURRENT, KEY_CURRENT_LEVEL, self.data.current_level)

    -- clear progress of previous level
    self.data.level_progress = {}
    self.data.level_bonus_words = {}
    defsave.set(KEY_CURRENT, KEY_LEVEL_PROGRESS, self.data.level_progress)
    defsave.set(KEY_CURRENT, KEY_BONUS_WORDS, self.data.level_bonus_words)

    flush_save()
end


function user_progress.set_word_complete(self, word, way)
    table.insert(self.data.level_progress, { ["word"] = word, ["way"] = way })
    defsave.set(KEY_CURRENT, KEY_LEVEL_PROGRESS, self.data.level_progress)
    flush_save()
    return #self.data.level_progress
end


function user_progress.check_bonus_word(self, word)
    return self.data.bonus_words[word]
end


local function save_bonus_words(self)
    defsave.set(KEY_CURRENT, KEY_BONUS_WORDS, self.data.bonus_words)
    flush_save()
end


function user_progress.add_bonus_word(self, word)
    self.data.bonus_words[word] = true
    save_bonus_words(self)
end


function user_progress.reset_bonus_words(self)
    self.data.bonus_words = {}
    save_bonus_words(self)
end


return user_progress
