RSGCore = exports['rsg-core']:GetCoreObject()

local VORPcore = {}

VORPcore.Warning = function(text)
    print("^3WARNING: ^7" .. tostring(text) .. "^7")
end

VORPcore.Error = function(text)
    print("^1ERROR: ^7" .. tostring(text) .. "^7")
end

VORPcore.Success = function(text)
    print("^2SUCCESS: ^7" .. tostring(text) .. "^7")
end

VORPcore.NotifyTip = function(text, duration)
    return TriggerEvent('rNotify:Tip', text, duration)
end

VORPcore.NotifyLeft = function(title, subtitle, dict, icon, duration, colors)
    TriggerEvent('rNotify:NotifyLeft', title, subtitle, dict, icon, duration)
end

VORPcore.NotifyRightTip = function(text, duration)
    return lib.notify({title = text, type = "info", duration = duration})
end

VORPcore.NotifyObjective = function(text, duration)
    return lib.notify({title = text, type = "info", duration = duration})
end

VORPcore.NotifyTop = function(text, location, duration)
    return TriggerEvent('rNotify:NotifyTop', text, location, duration)
end

VORPcore.NotifySimpleTop = function(text, subtitle, duration)
    return lib.notify({ title = text, description = subtitle, type = 'info', duration = duration})
end

VORPcore.NotifyAvanced = function(text, dict, icon, text_color, duration, quality, showquality)
    return lib.notify({ title = text, type = 'info', icon = icon, iconAnimation = 'shake', duration = duration})
end

VORPcore.NotifyCenter = function(text, duration, color)
    return lib.notify({title = text, type = "info", duration = duration})
end

VORPcore.NotifyBottomRight = function(text, duration)
    return lib.notify({title = text, type = "info", duration = duration})
end

VORPcore.NotifyFail = function(text, subtitle, duration)
    return lib.notify({title = text, description = subtitle, type = "info", duration = duration})
end

VORPcore.NotifyDead = function(title, audioRef, audioName, duration)
    return lib.notify({title = text, type = "info", duration = duration})
end

VORPcore.NotifyUpdate = function(title, subtitle, duration)
    return lib.notify({title = text, description = subtitle, type = "info", duration = duration})
end

VORPcore.NotifyWarning = function(title, msg, audioRef, audioName, duration)
    return lib.notify({title = title, description = msg, type = "info", duration = duration})
end

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
