json = require "json"

messages = {}

function exists(table,indices)
    test=table
    for i = 1,#indices
    do
        index=indices[i]
        if test[index]~=nil
        then
            test=test[index]
        else
            return false
        end
    end
    return true
end

function socket_client:onmessage(message)
    print(message)

    jsonmessage = json.decode(message)
    if (exists(jsonmessage, {"identifier"})) then
        -- print(main.current.player.hp)
        -- main.current.player.hp = main.current.player.hp + 10
        -- print(main.current.player.hp)

        -- if (gold) then
        --     print(gold)
        --     gold = gold + 1
        --     print(gold)
        -- end
        table.insert(messages, jsonmessage)
    end
end

function socket_client:onopen()
    identifier = json.encode({ channel = "ChatChannel", stream_id = "cypress", user_id = "52f352ea-db6f-48a5-823c-ff138b80b720" })
    subscribemessage = json.encode({ command = "subscribe", identifier = identifier })

    print(subscribemessage)

    self:send(subscribemessage)
end

function socket_client:onclose(code, reason)
    print("closecode: "..code..", reason: "..reason)
end

function love.update()
    socket_client:update()
end
