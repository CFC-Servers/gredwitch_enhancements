local soundMultiplier = 0.7

local function silenceEmplacement( ent, m )
    if not ent.sounds then return end
    for k, sound in pairs( ent.sounds ) do
        local soundLevel = sound:GetSoundLevel() * m
        sound:SetSoundLevel( soundLevel * m )
    end

end

local isBasedOn = scripted_ents.IsBasedOn

hook.Remove("OnEntityCreated", "CFC_GredwitchEnhancementsSounds")
hook.Add( "OnEntityCreated", "CFC_GredwitchEnhancementsSounds", function( ent )
    local class = ent:GetClass()
    local isEmplacement = class == "gred_emp_base" or isBasedOn( class, "gred_emp_base" )

    if isEmplacement then
        timer.Simple( 0.1, function()
            silenceEmplacement( ent, soundMultiplier )
        end )
    end
end )
