Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if Config == nil then
            if DoesFileExist(GetResourcePath(GetCurrentResourceName()) .. '/config.lua') then
                Config = load(LoadResourceFile(GetCurrentResourceName(), 'config.lua'))()
            else
                print('Config file not found!')
                Config = {}
            end
        end
    end
end)

local function updateHair()
    local playerPed = PlayerPedId()
    local hatDrawable = GetPedDrawableVariation(playerPed, 1) -- 1 is the component ID for hats
    if Config.HatComponents[hatDrawable] then
        -- If the player is wearing a hat, adjust or hide the hair
        SetPedComponentVariation(playerPed, 2, 0, 0, 0) -- Set the hair to a specific style that works with hats
    else
        -- If the player is not wearing a hat, restore the original hair
        SetPedComponentVariation(playerPed, 2, originalHairDrawable, originalHairTexture, 0)
    end
end

-- Store the original hair style
local originalHairDrawable = GetPedDrawableVariation(PlayerPedId(), 2)
local originalHairTexture = GetPedTextureVariation(PlayerPedId(), 2)

-- Check for hat changes periodically
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500) -- Adjust the wait time as needed
        updateHair()
    end
end)
