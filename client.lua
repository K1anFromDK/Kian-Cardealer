function removeCamAndAnimation()
    DestroyCam(cam, 0)
    FreezeEntityPosition(PlayerPedId(), false)
    RenderScriptCams(0, 0, 1, 1, 1)
    FreezeEntityPosition(PlayerPedId(), false)
    ClearPedTasksImmediately(PlayerPedId())
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

CreateThread(function()
    for k, v in ipairs(Config.Previewloc) do
        exports.ox_target:addBoxZone({
            coords = v.coords,
            size = v.size,
            rotation = 45,
            drawSprite = false,
            options = {
                {
                    name = 'MADEBYKiAN',
                    icon = 'fa-solid fa-car',
                    label = 'Pdm menu',
                    canInteract = function()
                        return lib.callback.await('IsPlayerJob')
                    end,
                    onSelect = function()
                        local ped = PlayerPedId()
                        FreezeEntityPosition(ped, true)
                        SetEntityCoords(ped, -54.6835, -1087.9286, 24.9900)
                        SetEntityHeading(ped, 156.5382)
                        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -54.339599609375, -1091.6785888672 + 0.5,
                            27.4223 + 0.0, -20.0, 0.0, heading, 60.00, false, 0)
                        SetCamActive(cam, true)                     
                        RenderScriptCams(true, false, 1, true, true) 
                        openMenu()
                        TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", 0, true)
                    end
                },
            }
        })
    end
end)

function openMenu()
    lib.registerContext({
        id = 'bilforhandler_menu',
        title = 'Pdm',
        menu = 'bilforhandler_menu',
        onExit = function()
            removeCamAndAnimation()
        end,
        options = {
            {
                title = 'Sell car',
                description = 'Ved at trykke på denne knap, kan du som bilforhandler sælge biler til folk.',
                icon = 'fa-solid fa-car',
                onSelect = function()
                    sellcar()
                end
            }
        }
    })
    lib.showContext('bilforhandler_menu')
end

function sellcar()
    local input = lib.inputDialog('Cardealer', {
        { type = 'input', label = 'Id',    required = true, min = 0, max = 16 },
        { type = 'input', label = 'car',   required = true, min = 0, max = 16 },
        { type = 'input', label = 'price', required = true, min = 0, max = 16 },
        { type = 'input', label = 'type',  description = 'car, bike', required = true, min = 0, max = 16 },
    })
    if input then
        TriggerServerEvent('buyvehicle', input)
        lib.notify({ type = 'success', description = 'Du har solgt en ' .. input[2] .. ' til ' .. input[3] .. 'DKK' })
        FreezeEntityPosition(PlayerPedId(), false)
        RenderScriptCams(0, 0, 1, 1, 1)
        removeCamAndAnimation()
    else
        lib.notify({ type = 'error', description = 'Du har ikke udfyldt fælterne!' })
        removeCamAndAnimation()
    end
end
