local enable = ...

-- Guardar valores originales solo una vez
if not _G.NormalLightingSettings then
    _G.NormalLightingSettings = {
        Brightness = game.Lighting.Brightness,
        ClockTime = game.Lighting.ClockTime,
        FogEnd = game.Lighting.FogEnd,
        GlobalShadows = game.Lighting.GlobalShadows,
        Ambient = game.Lighting.Ambient
    }
end

local function setFullbright()
    game.Lighting.Brightness = 1
    game.Lighting.ClockTime = 12
    game.Lighting.FogEnd = 786543
    game.Lighting.GlobalShadows = false
    game.Lighting.Ambient = Color3.fromRGB(178, 178, 178)
end

local function restoreLighting()
    local s = _G.NormalLightingSettings
    game.Lighting.Brightness = s.Brightness
    game.Lighting.ClockTime = s.ClockTime
    game.Lighting.FogEnd = s.FogEnd
    game.Lighting.GlobalShadows = s.GlobalShadows
    game.Lighting.Ambient = s.Ambient
end

if enable then
    setFullbright()
else
    restoreLighting()
end

-- Opcional: Conectar para que si alguien cambia las propiedades, las vuelvas a forzar si está activo

if enable then
    if _G.FullbrightConnection then
        _G.FullbrightConnection:Disconnect()
    end

    _G.FullbrightConnection = game.Lighting.Changed:Connect(function(prop)
        if enable then
            setFullbright()
        else
            restoreLighting()
            if _G.FullbrightConnection then
                _G.FullbrightConnection:Disconnect()
                _G.FullbrightConnection = nil
            end
        end
    end)
else
    if _G.FullbrightConnection then
        _G.FullbrightConnection:Disconnect()
        _G.FullbrightConnection = nil
    end
end
