RSGCore = exports['rsg-core']:GetCoreObject()

VORP = {
    getUser = function(source)
        local src = tonumber(source)
        if src == nil then return nil end
        local RSGPlayer = RSGCore.Functions.GetPlayer(src)
        local vorpUser = function()
            local self = {}
            if RSGPlayer then
                self._identifier = RSGPlayer.PlayerData.citizenid
                self._license = RSGPlayer.PlayerData.license
                self._group = RSGCore.Functions.GetPermission(src)
                self._playerwarnings = {}
                self._charperm = false
                self._usercharacters = {}
                self._numofcharacters = 0
                self.usedCharacterId = -1
                self.source = src

                self.UsedCharacterId = function(value)            
                    return RSGPlayer.slot
                end
            
                self.Source = function(value)
                    return self.source
                end

                self.Numofcharacters = function(value)
                    return 1
                end

                self.Identifier = function(value)
                    if value ~= nil then
                        self._identifier = value
                    end
                    return self._identifier
                end

                self.License = function(value)
                    if value ~= nil then
                        self._license = value
                    end
                    return self._license
                end
            
                self.Group = function(value)
                    if value ~= nil then
                        self._group = value
                    end
                    return self._group
                end
            
                self.Playerwarnings = function()
                    return self._playerwarnings
                end
            
                self.Charperm = function(value)
                    return self._charperm
                end
            
                self.___UsedCharacterF = function()
                    local self = {}
                    self.identifier = RSGPlayer.PlayerData.license
                    self.charIdentifier = RSGPlayer.PlayerData.citizenid
                    self.group = RSGCore.Functions.GetPermission(src)
                    self.job = RSGPlayer.PlayerData.job.name
                    self.jobgrade = RSGPlayer.PlayerData.job.grade.level
                    self.firstname = RSGPlayer.PlayerData.charinfo.firstname
                    self.lastname = RSGPlayer.PlayerData.charinfo.lastname
                    self.inventory = {}
                    self.status = {}
                    self.coords = {}
                    self.skin = MySQL.scalar.await('SELECT skin FROM playerskins WHERE citizenid=?', {RSGPlayer.PlayerData.citizenid})
                    self.comps = {}
                    self.money = RSGPlayer.PlayerData.money.cash
                    self.gold = RSGPlayer.PlayerData.money.gold
                    self.rol = 0
                    self.healthOuter = 0
                    self.healthInner = 0
                    self.staminaOuter = 0
                    self.staminaInner = 0
                    self.xp = 0
                    self.hours = 0
                    self.isdead = RSGPlayer.PlayerData.metadata.isDead
                    self.source = src

                    self.Identifier = function()
                        return self.identifier
                    end

                    self.CharIdentifier = function(value)
                        if value ~= nil then
                            self.charIdentifier = value
                        end
                        return self.charIdentifier
                    end

                    self.Group = function(value)
                        if value ~= nil then
                            --
                        end
                        return self.group
                    end

                    self.Job = function(value)
                        if value ~= nil then RSGPlayer.Functions.SetJob(value, RSGPlayer.PlayerData.job.level) end
                        return self.job
                    end

                    self.Jobgrade = function(value)
                        if value ~= nil then RSGPlayer.Functions.SetJob(RSGPlayer.PlayerData.job.name, value) end
                        return self.jobgrade
                    end

                    self.Firstname = function(value)
                        if value ~= nil then 
                            print("Not impl")
                        end
                        return self.firstname
                    end

                    self.Lastname = function(value)
                        if value ~= nil then print("Not impl") end
                        return self.lastname
                    end

                    self.Inventory = function(value)
                        if value ~= nil then print("Not impl") end
                        return self.inventory
                    end

                    self.Status = function(value)
                        if value ~= nil then print("Not impl") end
                        return self.status
                    end

                    self.Coords = function(value)
                        if value ~= nil then print("Not impl") end
                        return self.coords
                    end

                    self.Money = function(value)
                        if value ~= nil then RSGPlayer.Functions.SetMoney('cash', value) end
                        return self.money
                    end

                    self.Gold = function(value)
                        if value ~= nil then print("Not impl") end
                        return self.gold
                    end

                    self.Rol = function(value)
                        if value ~= nil then print("Not impl") end
                        return self.rol
                    end

                    self.HealthOuter = function(value)
                        if value ~= nil then print("Not impl") end
                        return self.healthOuter
                    end

                    self.HealthInner = function(value)
                        if value ~= nil then print("Not impl") end
                        return self.healthInner
                    end

                    self.StaminaOuter = function(value)
                        if value ~= nil then print("Not impl") end
                        return self.staminaOuter
                    end

                    self.StaminaInner = function(value)
                        if value ~= nil then print("Not impl") end
                        return self.staminaInner
                    end

                    self.Xp = function(value)
                        if value ~= nil then print("Not impl") end
                        return self.xp
                    end

                    self.Hours = function(value)
                        if value ~= nil then print("Not impl") end
                        return self.hours
                    end

                    self.IsDead = function(value)
                        if value ~= nil then Player.Functions.SetMetaData('isDead', value) end
                        return self.isdead
                    end

                    self.Skin = function(value)
                        MySQL.scalar("SELECT skin FROM playerskins WHERE citizenid=?", {identifiers.identifier}, function(oldSkin)
                            local decoded = UnJson(oldSkin)
                            table.merge(decoded,value)
                            MySQL.update("UPDATE playerskins SET skin=? WHERE citizenid=?", {json.encode(decoded),identifiers.identifier})
                        end)

                        if value ~= nil then
                            RSGPlayer.SetSkinData(value)
                        end

                        return RSGCore.Function.GetPlayer(source).skin
                    end

                    self.Comps = function(value)
                        if value ~= nil then
                            RSGPlayer.SetClothesData(value)
                        end

                        return RSGCore.GetPlayer(source).clothes
                    end

                    self.getCharacter = function()
                        local userData = {}

                        userData.identifier = self.identifier
                        userData.charIdentifier = self.charIdentifier
                        userData.group = self.group
                        userData.job = self.job
                        userData.jobGrade = self.jobgrade
                        userData.money = self.money
                        userData.gold = self.gold
                        userData.rol = self.rol
                        userData.xp = self.xp
                        userData.healthOuter = self.healthOuter
                        userData.healthInner = self.healthInner
                        userData.staminaOuter = self.staminaOuter
                        userData.staminaInner = self.staminaInner
                        userData.hours = self.hours
                        userData.firstname = self.firstname
                        userData.lastname = self.lastname
                        userData.inventory = self.inventory
                        userData.status = self.status
                        userData.coords = self.coords
                        userData.isdead = self.isdead
                        userData.skin = self.skin
                        userData.comps = self.comps

                        userData.setStatus = function(status) --Prevent bugs here
                            self.Status(status)
                        end

                        userData.setJobGrade = function(jobgrade)
                            self.Jobgrade(jobgrade)
                        end

                        userData.setGroup = function(group)
                            self.Group(group)
                        end

                        userData.setJob = function(job)
                            self.Job(job)
                        end

                        self.setJobGrade = function(jobgrade)
                            self.Jobgrade(jobgrade)
                        end

                        userData.setMoney = function(money)
                            self.Money(money)
                            self.updateCharUi()
                        end

                        userData.setGold = function(gold)
                            self.Gold(gold)
                            self.updateCharUi()
                        end

                        userData.setRol = function(rol)
                            self.Rol(rol)
                            self.updateCharUi()
                        end

                        userData.setXp = function(xp)
                            self.Xp(xp)
                            self.updateCharUi()
                        end

                        userData.setFirstname = function(firstname)
                            self.Firstname(firstname)
                        end

                        userData.setLastname = function(lastname)
                            self.Lastname(lastname)
                        end

                        userData.updateSkin = function(skin)
                            self.Skin(skin)
                        end

                        userData.updateComps = function(comps)
                            self.Comps(comps)
                        end

                        userData.addCurrency = function(currency, quantity)
                            self.addCurrency(currency, quantity)
                        end

                        userData.removeCurrency = function(currency, quantity)
                            self.removeCurrency(currency, quantity)
                        end

                        userData.addXp = function(xp)
                            self.addXp(xp)
                        end

                        userData.removeXp = function(xp)
                            self.removeXp(xp)
                        end

                        userData.updateCharUi = function()
                            local nuipost = {}

                            nuipost["type"] = "ui"
                            nuipost["action"] = "update"
                            nuipost["moneyquanty"] = self.Money()
                            nuipost["goldquanty"] = self.Gold()
                            nuipost["rolquanty"] = self.Rol()
                            nuipost["serverId"] = self.source
                            nuipost["xp"] = self.Xp()

                            TriggerClientEvent("vorp:updateUi", self.source, json.encode(nuipost))
                        end

                        return userData
                    end

                    self.GetUser = function()
                        local userData = {}
                    
                        userData.getIdentifier = function()
                            return RSGPlayer.PlayerData.license
                        end

                        userData.getGroup = self.Group()
                    
                        userData.getPlayerwarnings = function()
                            return self.Playerwarnings()
                        end
                    
                        userData.setPlayerWarnings = function(warnings)
                            self.Playerwarnings(warnings)
                        end
                    
                        userData.getCharperm = self.Charperm()
                    
                        userData.source = self.source
                    
                        userData.setGroup = function(group)
                            self.Group(group)
                        end
                    
                        userData.setCharperm = function(char)
                            self.Charperm(char)
                        end
                    
                        userData.getUsedCharacter = self.___UsedCharacterF
                        userData.getUserCharacters = self.UserCharacters()
                    
                        userData.getNumOfCharacters = function()
                            return self._numofcharacters
                        end
                    
                        userData.addCharacter = function(firstname, lastname, skin, comps)
                            self._numofcharacters = self._numofcharacters + 1 --Should not be done like this
                            self.addCharacter(firstname, lastname, skin, comps)
                        end
                    
                        userData.removeCharacter = function(charid)
                            if self._usercharacters[charid] then
                                self._numofcharacters = self._numofcharacters - 1 --Should not be done like this
                                self.delCharacter(charid)
                            end
                        end
                    
                        userData.setUsedCharacter = function(charid)
                            self.SetUsedCharacter(charid)
                        end
                    
                        return userData
                    end
                

                    self.updateCharUi = function()
                    
                    end

                    self.addCurrency = function(currency, quantity, bankid) --add check for security
                        if currency == 0 then
                            RSGPlayer.Functions.AddMoney('cash', quantity)
                        elseif currency == 1 then
                            RSGPlayer.Functions.AddMoney('gold', quantity)
                            --exports.ghmattimysql:execute("UPDATE player_banks SET amount = ? WHERE citizenid = ? AND bankid=?", {tonumber(quantity), RSGPlayer.PlayerData.citizenid, bankid})
                            ----RSGPlayer.Functions.AddMoney('bank', quantity)
                        elseif currency == 2 then
                            print("Not Have")
                        end
                        self.updateCharUi()
                    end

                    self.removeCurrency = function(currency, quantity) --add check for security
                        if currency == 0 then
                            RSGPlayer.Functions.RemoveMoney('cash', quantity)
                        elseif currency == 1 then
                            self.gold = self.gold - quantity
                        elseif currency == 2 then
                            self.rol = self.rol - quantity
                        end
                        self.updateCharUi()
                    end

                    self.addXp = function(quantity) --add check for security

                        self.updateCharUi()
                    end

                    self.removeXp = function(quantity) --add check for security

                        self.updateCharUi()
                    end

                    self.saveHealthAndStamina = function(healthOuter, healthInner, staminaOuter, staminaInner)
                    
                    end

                    self.setJob = function(newjob)
                        self.Job(newjob)
                    end

                    self.setGroup = function(newgroup)
                        self.Group(newgroup)
                    end

                    self.setDead = function(dead)
                        self.IsDead(dead)
                    end

                    self.UpdateHours = function(hours)
                        print("Not impl")
                    end

                    self.SaveNewCharacterInDb = function(cb)
                        print("Not impl")
                    end

                    self.DeleteCharacter = function()
                        print("Not impl")
                    end

                    self.SaveCharacterCoords = function(coords)
                        print("Not impl")
                    end

                    self.SaveCharacterInDb = function()
                        print("Not impl")
                    end

                    return self
                end
                self.___UsedCharacter = self.___UsedCharacterF()

                self.getUsedCharacter = self.___UsedCharacter

                self.getGroup = self.Group()
            
                self.UsedCharacter = function()
                    return self.___UsedCharacter
                end
            
                self.UserCharacters = function()
                    local userCharacters = {}
                    return userCharacters
                end
            
                self.GetUsedCharacter = function()
                    if self.___UsedCharacter then
                        return self.___UsedCharacter
                    else
                        return nil
                    end
                end
            
                self.SetUsedCharacter = function(charid)

                end

                self.getIdentifier = function()
                    return RSGPlayer.PlayerData.license
                end
            
                return self
            end
        end
        return vorpUser()
    end,

    maxCharacters = 1,

    addRpcCallback = function(name, callback)
        TriggerEvent("vorp:addNewCallBack", name, callback)
    end,

    getUsers = function()
        return {}
    end,

    Warning = function(text)
        print("^3WARNING: ^7" .. tostring(text) .. "^7")
    end,

    Error = function(text)
        print("^1ERROR: ^7" .. tostring(text) .. "^7")
    end,

    Success = function(text)
        print("^2SUCCESS: ^7" .. tostring(text) .. "^7")
    end,

    NotifyTip = function(source, text, duration)
        local _source = source
        TriggerEvent('rNotify:Tip', _source, text, duration)
    end,

    NotifyLeft = function(source, title, subtitle, dict, icon, duration, colors)
        local _source = source
        TriggerEvent('rNotify:NotifyLeft', _source, title, subtitle, dict, icon, duration)
    end,

    NotifyRightTip = function(source, text, duration)
        local _source = source

    end,

    NotifyObjective = function(source, text, duration)
        local _source = source

    end,

    NotifyTop = function(source, text, location, duration)
        local _source = source
        TriggerEvent('rNotify:NotifyTop', _source, text, location, duration)
    end,

    NotifySimpleTop = function(source, text, subtitle, duration)
        local _source = source

    end,

    NotifyAvanced = function(source, text, dict, icon, text_color, duration, quality, showquality)
        local _source = source

    end,

    NotifyCenter = function(source, text, duration, color)
        local _source = source

    end,

    NotifyBottomRight = function(source, text, duration)
        local _source = source

    end,

    NotifyFail = function(source, text, subtitle, duration)
        local _source = source

    end,

    NotifyDead = function(source, title, audioRef, audioName, duration)
        local _source = source

    end,

    NotifyUpdate = function(source, title, subtitle, duration)
        local _source = source

    end,

    NotifyWarning = function(source, title, msg, audioRef, audioName, duration)
        local _source = source

    end,

    dbUpdateAddTables = function(tbl)

    end,

    dbUpdateAddUpdates = function(updt)

    end,

    AddWebhook = function(title, webhook, description, color, name, logo, footerlogo, avatar)

    end,
}

RegisterNetEvent("vorpcharacter:SaveClothes", function(skin)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    MySQL.scalar("SELECT skin FROM playerskins WHERE citizenid=?", {Player.PlayerData.citizenid}, function(oldSkin)
      local decoded = UnJson(oldSkin)
      table.merge(decoded, skin)
      MySQL.update("UPDATE playerskins SET skin=? WHERE citizenid=?", {json.encode(decoded), Player.PlayerData.citizenid})
    end)
end)

--exports("GetCore", function()
--    return VORP
--end)

AddEventHandler('getCore', function(cb)
    cb(VORP)
end)

AddEventHandler('GetCore', function(cb)
    cb(VORP)
end)

-- © 2024 otavioomattos 
