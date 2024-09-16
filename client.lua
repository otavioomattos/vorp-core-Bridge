RSGCore = exports['rsg-core']:GetCoreObject()

local VORPcore = {}

VORPcore.RpcCall = function(name, cb, ...)
    if cb and type(cb) == 'function' then
        RSGCore.Functions.TriggerCallback(name, function(result)
            cb(result)
        end, ...)
    else
        local p = promise.new()

        RSGCore.Functions.TriggerCallback(name, function(result)
            p:resolve(result)
        end, ...)

        return Citizen.Await(p)
    end
end

VORPcore.Callback = {
    Register = function(name, callback)
        RSGCore.Functions.CreateCallback(name, callback)
    end,

    TriggerAsync = function(name, callback, ...)
        RSGCore.Functions.TriggerCallback(name, function(result)
            callback(result)
        end, ...)
    end,

    TriggerAwait = function(name, ...)
        local p = promise.new()

        RSGCore.Functions.TriggerCallback(name, function(result)
            p:resolve(result)
        end, ...)

        return Citizen.Await(p)
    end
}

RegisterNetEvent("vorpcharacter:savenew", function(skin)
    TriggerServerEvent("vorpcharacter:SaveClothes", skin)
end)

RegisterNetEvent("vorpcharacter:updateCache", function(skin)
    TriggerServerEvent("vorpcharacter:SaveClothes", skin)
end)

AddEventHandler('RSGCore:Client:OnPlayerLoaded', function()
    local PlayerData = RSGCore.Functions.GetPlayerData()
    TriggerEvent("vorp:SelectedCharacter", PlayerData.citizenid)
end)


AddEventHandler('getCore', function(cb)
    cb(VORPcore)
end)

AddEventHandler('GetCore', function(cb)
    cb(VORPcore)
end)
