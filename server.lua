ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('nezch-hotdog:ettopla')
AddEventHandler('nezch-hotdog:ettopla', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.canCarryItem('sausage', 1) then
        xPlayer.addInventoryItem('sausage', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
    end
end)

RegisterServerEvent('nezch-hotdog:ekmektopla')
AddEventHandler('nezch-hotdog:ekmektopla', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.canCarryItem('hotdogbread', 1) then
        xPlayer.addInventoryItem('hotdogbread', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
    end
end)

RegisterServerEvent('nezch-hotdog:malzemetopla')
AddEventHandler('nezch-hotdog:malzemetopla', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.canCarryItem('hotdogmalzeme', 1) then
        xPlayer.addInventoryItem('hotdogmalzeme', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
    end
end)

RegisterServerEvent('nezch-hotdog:hotdogtopla')
AddEventHandler('nezch-hotdog:hotdogtopla', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getQuantity('sausage') >= 1 then
        if xPlayer.getQuantity('hotdogbread') >= 1 then
            if xPlayer.getQuantity('hotdogmalzeme') >= 1 then
                if xPlayer.canCarryItem('hotdog', 1) then
                    xPlayer.removeInventoryItem('sausage', 1)
                    Citizen.Wait(250)
                    xPlayer.removeInventoryItem('hotdogbread', 1)
                    Citizen.Wait(250)
                    xPlayer.removeInventoryItem('hotdogmalzeme', 1)
                    Citizen.Wait(500)
                    xPlayer.addInventoryItem('hotdog', 1)
                else
                    TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
                end
            else
                TriggerClientEvent('esx:showNotification', src, 'Üzerinde yeterli sosisli malzemesi yok!')
            end
        else
            TriggerClientEvent('esx:showNotification', src, 'Üzerinde yeterli sosisli ekmeği yok!')
        end
    end
end)

RegisterServerEvent('nezch-hotdog:paketver')
AddEventHandler('nezch-hotdog:paketver', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getQuantity('hotdog') >= 1 then
        if xPlayer.canCarryItem('paketsosisli', 1) then
            xPlayer.removeInventoryItem('hotdog', 1)
            Citizen.Wait(500)
            xPlayer.addInventoryItem('paketsosisli', 1)
        else
            TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
        end
    end
end)

RegisterServerEvent('nezch-hotdog:hotdogsat')
AddEventHandler('nezch-hotdog:hotdogsat', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local money = math.random(Config.MinParaMiktar, Config.MaxParaMiktar)
    if xPlayer.getQuantity('paketsosisli') >= 1 then
        xPlayer.removeInventoryItem('paketsosisli', 1)
        Citizen.Wait(500)
        xPlayer.addMoney(money)
    end
end)

ESX.RegisterServerCallback('nezch-hotdog:malzemekontrol', function(source, cb, item, gereklisayi)
	local xPlayer = ESX.GetPlayerFromId(source)
    local itemcount = xPlayer.getQuantity(item)
    local itemname = xPlayer.getQuantity(item)
	if itemcount >= gereklisayi then
		cb(true)
	else
        activity = 0
        TriggerClientEvent('esx:showNotification', source, 'Üzerinde yeterli '..itemname..' yok!')
	end
end)
