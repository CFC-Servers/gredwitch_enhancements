local blacklisted = {["gb_rocket_nebel"] = true,
                     ["gb_shell_50mm"] = true,
                     ["gb_shell_57mm"] = true,
                     ["gb_shell_75mm"] = true,
                     ["gb_shell_76mm"] = true,
                     ["gb_shell_88mm"] = true,
                     ["gb_shell_105mm"] = true,
                     ["gb_shell_128mm"] = true,
                     ["gb_shell_152mm"] = true,
                     ["gb_shell_155mm"] = true
}

hook.Remove("OnEntityCreated", "cfc_gred_ammobox_restrictions")
hook.Add( "OnEntityCreated", "cfc_gred_ammobox_restrictions", function( ent )
    if blacklisted[ent:GetClass()] then ent:Remove() end
end )