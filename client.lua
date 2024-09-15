RSGCore = exports['rsg-core']:GetCoreObject()

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