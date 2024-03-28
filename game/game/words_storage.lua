local const  = require "game.common.constants"
local messages = require "game.common.messages"


local words_storage = {
    hash_set = {}
}


function words_storage.init(self)
    local data, error = sys.load_resource(const.FILENAME_WORDS)
    if data then
        for word in data:gmatch("[^\r\n]+") do
            self.hash_set[hash(word)] = true
        end
    else
        print(const.TXT_ERROR .. error .. const_TXT_BONUS_NOT_AVAILABLE)
    end
end


function words_storage.word_exists(self, word)
    return self.hash_set[hash(word:lower())]
end


return words_storage