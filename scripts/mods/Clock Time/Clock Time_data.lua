local mod = get_mod("Clock Time")

return {
	name 			 = "Clock Time",
	description 	 = "In game clock.",
	is_togglable 	 = true,
	is_mutator 		 = false,
	mutator_settings = {},

	options = {
		widgets = {
			{
				setting_id      = "clock_time_offset_x",
				type            = "numeric",
				default_value   = 0,
				range           = {-3840, 3840}
			},
			{
				setting_id      = "clock_time_offset_y",
				type            = "numeric",
				default_value   = 0,
				range           = {-2160, 2160}
			},
			{
				setting_id    = "clock_time_font_size",
				type          = "numeric",
				default_value = 32,
				range         = {0, 128}
			},
			{
				setting_id  = "color_group",
				type        = "group",
				sub_widgets = {
					{
						setting_id      = "clock_time_alpha",
						type            = "numeric",
						default_value   = 255,
						range           = {0, 255}
					},
					{
						setting_id      = "clock_time_red",
						type            = "numeric",
						default_value   = 255,
						range           = {0, 255}
					},
					{
						setting_id      = "clock_time_green",
						type            = "numeric",
						default_value   = 255,
						range           = {0, 255}
					},
					{
						setting_id      = "clock_time_blue",
						type            = "numeric",
						default_value   = 255,
						range           = {0, 255}
					}
				}
			}
		}
	}
}
