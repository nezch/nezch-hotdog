ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local pisiriyormu = false
local hazirliyormu = false
local paketliyormu = false
local ekmekaliyormu = false
local malzemealiyormu = false
local satiyormu = false
local satiskordinat = false
local satisblip = false

local locations = { -- Paket dağıtım kordinatları
vector3(-110.581, 6322.067, 31.576),
vector3(-360.045, 6260.873, 31.899),
vector3(-407.227, 6314.219, 28.941),
vector3(-380.215, 6252.975, 31.851),
vector3(-438.103, 6272.246, 30.068),
vector3(-245.941, 6414.263, 31.462),
}

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    while true do
        local sleep = 2000

        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local distance = GetDistanceBetweenCoords(playercoords, Config.SosisPisirme.x, Config.SosisPisirme.y, Config.SosisPisirme.z, true)
        local distance2 = GetDistanceBetweenCoords(playercoords, Config.SosisliHazirla.x, Config.SosisliHazirla.y, Config.SosisliHazirla.z, true)
        local distance3 = GetDistanceBetweenCoords(playercoords, Config.SosisliPaketle.x, Config.SosisliPaketle.y, Config.SosisliPaketle.z, true)
        local distance4 = GetDistanceBetweenCoords(playercoords, Config.SosisliDagitim.x, Config.SosisliDagitim.y, Config.SosisliDagitim.z, true)
        local coords = GetBlipInfoIdCoord(satisblip)
        local distance5 = GetDistanceBetweenCoords(playercoords, coords[1], coords[2], coords[3], true)
        local distance6 = GetDistanceBetweenCoords(playercoords, Config.SosisliEkmek.x, Config.SosisliEkmek.y, Config.SosisliEkmek.z, true)
        local distance7 = GetDistanceBetweenCoords(playercoords, Config.SosisliMalzeme.x, Config.SosisliMalzeme.y, Config.SosisliMalzeme.z, true)

        if distance < 10 then
            sleep = 7
           -- DrawMarker(2, Config.SosisPisirme.x, Config.SosisPisirme.y, Config.SosisPisirme.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if distance < 1 then
                DrawText3D(Config.SosisPisirme.x, Config.SosisPisirme.y, Config.SosisPisirme.z + 0.4, '~g~E~s~ - Sosis Pisir')
                if IsControlJustReleased(0, 38) then
                    HotdogPisir()
                end
            end
        end

        if distance2 < 10 then
            sleep = 7
            --DrawMarker(2, Config.SosisliHazirla.x, Config.SosisliHazirla.y, Config.SosisliHazirla.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if distance2 < 1 then
                DrawText3D(Config.SosisliHazirla.x, Config.SosisliHazirla.y, Config.SosisliHazirla.z + 0.4, '~g~E~s~ - Hotdog Hazırla')
                if IsControlJustReleased(0, 38) then
                    HotdogHazirla()
                end
            end
        end

        if distance3 < 10 then
            sleep = 7
            --DrawMarker(2, Config.SosisliPaketle.x, Config.SosisliPaketle.y, Config.SosisliPaketle.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if distance3 < 1 then
                DrawText3D(Config.SosisliPaketle.x, Config.SosisliPaketle.y, Config.SosisliPaketle.z + 0.4, '~g~E~s~ - Sosisli Paketle')
                if IsControlJustReleased(0, 38) then
                    HotdogPaketle()
                end
            end
        end

        if distance4 < 10 then
            sleep = 7
            --DrawMarker(2, Config.SosisliDagitim.x, Config.SosisliDagitim.y, Config.SosisliDagitim.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if distance4 < 1 then
                DrawText3D(Config.SosisliDagitim.x, Config.SosisliDagitim.y, Config.SosisliDagitim.z + 0.4, '~g~E~s~ - Dagıtıma Çık')
                if IsControlJustReleased(0, 38) then
                    HotdogSat()
                end
            end
        end

        if satiyormu == true and satiskordinat ~= false and distance5 < 10 then
            sleep = 7
            --DrawMarker(2, coords[1], coords[2], coords[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if distance5 < 1 then
                DrawText3D(coords[1], coords[2], coords[3] + 0.4, '~g~E~s~ - Kapıyı Çal')
                if IsControlJustReleased(0, 38) then
                    HotdogyuSat()
                end
            end
        end

        if distance6 < 10 then
            sleep = 7
            --DrawMarker(2, Config.SosisliEkmek.x, Config.SosisliEkmek.y, Config.SosisliEkmek.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if distance6 < 1 then
                DrawText3D(Config.SosisliEkmek.x, Config.SosisliEkmek.y, Config.SosisliEkmek.z + 0.4, '~g~E~s~ - Ekmek Al')
                if IsControlJustReleased(0, 38) then
                    HotdogEkmegi()
                end
            end
        end

        if distance7 < 10 then
            sleep = 7
            --DrawMarker(2, Config.SosisliMalzeme.x, Config.SosisliMalzeme.y, Config.SosisliMalzeme.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if distance7 < 1 then
                DrawText3D(Config.SosisliMalzeme.x, Config.SosisliMalzeme.y, Config.SosisliMalzeme.z + 0.4, '~g~E~s~ - Malzemeleri Topla')
                if IsControlJustReleased(0, 38) then
                    HotdogMalzemesi()
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

function HotdogMalzemesi()
    if not malzemealiyormu then
        malzemealiyormu = true
        exports['mythic_progbar']:Progress({
            name = "hotdogmalzemesi",
            duration = 000,
            label = 'Malzemeleri topluyorsun...',
            useWhileDead = false,
            canCancel = false,
             controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_arresting",
                anim = "a_uncuff",
                flags = 49,
            },
        }, function(cancelled)
            if not cancelled then
                TriggerServerEvent('nezch-hotdog:malzemetopla')
                malzemealiyormu = false
                ESX.ShowNotification('Sosisli malzemesi topladın!')
             else
                 -- Do Something If Action Was Cancelled
            end
        end)
    end
end

function HotdogEkmegi()
    if not ekmekaliyormu then
        ekmekaliyormu = true
        exports['mythic_progbar']:Progress({
            name = "hotdogekmegi",
            duration = 1000,
            label = 'Sosisli ekmeği alıyorsun...',
            useWhileDead = false,
            canCancel = false,
             controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_arresting",
                anim = "a_uncuff",
                flags = 49,
            },
        }, function(cancelled)
            if not cancelled then
                TriggerServerEvent('nezch-hotdog:ekmektopla')
                ekmekaliyormu = false
                ESX.ShowNotification('Ekmeği başarıyla ısıttın!')
             else
                 -- Do Something If Action Was Cancelled
            end
        end)
    end
end

function HotdogPisir()
    if not pisiriyormu then
        pisiriyormu = true
        local player = PlayerPedId()
        TaskStartScenarioInPlace(player, 'PROP_HUMAN_BBQ', 0, true)
        local finished = exports["reload-skillbar"]:taskBar(5000,math.random(5,15))
        if finished ~= 100 then
            pisiriyormu = false
            ClearPedTasksImmediately(player)
            ESX.ShowNotification('Sosisi pişiremedin!')
        else
            local finished2 = exports["reload-skillbar"]:taskBar(4750,math.random(5,15))
            if finished2 ~= 100 then
                pisiriyormu = false
                ClearPedTasksImmediately(player)
                ESX.ShowNotification('Sosisi pişiremedin!')
            else
                local finished3 = exports["reload-skillbar"]:taskBar(4500,math.random(5,15))
                if finished3 ~= 100 then
                    pisiriyormu = false
                    ClearPedTasksImmediately(player)
                    ESX.ShowNotification('Sosisi pişiremedin!')
                else
                    TriggerServerEvent('nezch-hotdog:ettopla')
                    pisiriyormu = false
                    ClearPedTasksImmediately(player)
                    ESX.ShowNotification('Sosisi başarıyla pişirdin!')
                end
            end
        end
    end
end

function HotdogHazirla()
    if not hazirliyormu then
        ESX.TriggerServerCallback('nezch-hotdog:malzemekontrol', function(data)
            hazirliyormu = true
            exports['mythic_progbar']:Progress({
                name = "hotdoghazirla",
                duration = 000,
                label = 'Sosisli hazırlıyorsun...',
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "mp_arresting",
                    anim = "a_uncuff",
                    flags = 49,
                },
            }, function(cancelled)
                if not cancelled then
                    TriggerServerEvent('nezch-hotdog:hotdogtopla')
                    hazirliyormu = false
                    ESX.ShowNotification('Başarıyla sosisli hazırladın!')
                else
                    -- Do Something If Action Was Cancelled
                end
            end)
        end, "sausage", 1)
    end
end

function HotdogPaketle()
    if not paketliyormu then
        ESX.TriggerServerCallback('nezch-hotdog:malzemekontrol', function(data)
            paketliyormu = true
            exports['mythic_progbar']:Progress({
                name = "hotgodhazirla",
                duration = 1000,
                label = 'Sosisli paketliyorsun...',
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "mp_arresting",
                    anim = "a_uncuff",
                    flags = 49,
                },
            }, function(cancelled)
                if not cancelled then
                    TriggerServerEvent('nezch-hotdog:paketver')
                    paketliyormu = false
                    ESX.ShowNotification('Başarıyla sosisli paketledin!')
                else
                    -- Do Something If Action Was Cancelled
                end
            end)
        end, "hotdog", 1)
    end
end

function HotdogSat()
    if not satiyormu then
        ESX.TriggerServerCallback('nezch-hotdog:malzemekontrol', function(data)
            local random = math.random(1,#locations)
	        satisblip = true
	        satiskordinat = {
		        x = locations[random][1],
		        y = locations[random][2],
		        z = locations[random][3]
	        }
	        satisblip = SatisBlipOlustur(satiskordinat.x, satiskordinat.y, satiskordinat.z)
            satiyormu = true
            ESX.ShowNotification('Musteri Haritada Isaretlendi!')
        end, "paketsosisli", 1)
    elseif satiyormu then
        ESX.ShowNotification('Zaten bir sosisli satıyorsun!')
    end
end

function SatisBlipOlustur(x,y,z)
	local blip = AddBlipForCoord(x,y,z)
	SetBlipSprite(blip, 514)
	SetBlipColour(blip, 4)
	AddTextEntry('MYBLIP', "Müşteri")
	BeginTextCommandSetBlipName('MYBLIP')
	AddTextComponentSubstringPlayerName(name)
	EndTextCommandSetBlipName(blip)
	return blip
end

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        if satiyormu == false and satisblip ~= false then
            sleep = 7
			RemoveBlip(satisblip)
			satisblip = false
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
	--local coords = vector3(11.43397, -1599.46, 29.375)
	local blip = AddBlipForCoord(Config.Blip.coords)

	SetBlipSprite(blip, Config.Blip.sekil)
	SetBlipScale(blip, Config.Blip.boyut)
	SetBlipColour(blip, Config.Blip.renk)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(Config.Blip.yazi)
	EndTextCommandSetBlipName(blip)
end)

function HotdogyuSat()
    exports['mythic_progbar']:Progress({
        name = "kapicalma",
        duration = 3000,
        label = 'Kapıyı çalıyorsun...',
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "timetable@jimmy@doorknock@",
            anim = "knockdoor_idle",
            flags = 49,
        },
    }, function(cancelled)
        if not cancelled then
            TriggerServerEvent('nezch-hotdog:hotdogsat')
            satiskordinat = false
            satiyormu = false
            ESX.ShowNotification('Başarıyla sosisli sattın!')
        else
            -- Do Something If Action Was Cancelled
        end
    end)
end
