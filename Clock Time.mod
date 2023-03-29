return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`Clock Time` mod must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("Clock Time", {
			mod_script       = "scripts/mods/Clock Time/Clock Time",
			mod_data         = "scripts/mods/Clock Time/Clock Time_data",
			mod_localization = "scripts/mods/Clock Time/Clock Time_localization",
		})
	end,
	packages = {
		"resource_packages/Clock Time/Clock Time",
	},
}
