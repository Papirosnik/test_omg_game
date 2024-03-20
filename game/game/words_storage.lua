local const  = require "game.common.constants"
local messages = require "game.common.messages"

local file_uri = "/assets/data/words.txt"

local words_storage = {
    hash_set = {}
}

function words_storage.init(self)
    local data, error = sys.load_resource(file_uri)
    if data then
        for word in data:gmatch("[^\r\n]+") do
            self.hash_set[hash(word)] = true
        end
    else
        print("ERROR: " .. error .. ".\n'Bonus words' feature will be not available.")
    end
end


function words_storage.word_exists(self, word)
    return self.hash_set[hash(word:lower())]
end


return words_storage