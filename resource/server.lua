local API_KEY = "YOUR API KEY"
local MODEL_ID = "gpt-3.5-turbo"
local API_URL = "https://api.openai.com/v1/chat/completions"
local warn = "[gangster mentality, criminal, street language etc.]" -- warning before chat (like don't answer world questions etc.)

function chatGPT(msg)
    local jsonData = '{"model":"' .. MODEL_ID .. '","messages":[{"role":"user","content":"'..warn..' ' .. msg .. '"}],"max_tokens":85,"n":1,"stop":"\\n","temperature":0.2}'

    
    local sendOptions = {
        headers = {
            ["Content-Type"] = "application/json",
            ["Authorization"] = "Bearer " .. API_KEY
        },
        postData = jsonData,
    }
    fetchRemote(API_URL, sendOptions, respuestaChatGPT)
end


function respuestaChatGPT(responseData)
    local jsonData = fromJSON(responseData)
    if not jsonData['choices'] then return end
    local msg = jsonData['choices'][1]['message']['content']
    outputChatBox(msg) -- output, call function etc.
end

-- EXAMPLE
function chat(p, c, ...)
    local input = table.concat({...}, " ")
    chatGPT(input)
end
addCommandHandler("chatgpt", chat)
