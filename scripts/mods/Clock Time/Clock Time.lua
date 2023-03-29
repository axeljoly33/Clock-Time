local mod = get_mod("Clock Time")

-- VARIABLES --
local SCREEN_WIDTH = 3840
local SCREEN_HEIGHT = 2160

-- UI FUNCTIONS --
local function get_x()
	local x =  mod:get("clock_time_offset_x")
	local x_limit = SCREEN_WIDTH / 2
	local max_x = math.min(mod:get("clock_time_offset_x"), x_limit)
	local min_x = math.max(mod:get("clock_time_offset_x"), -x_limit)
	if x == 0 then
		return 0
	end
	local clamped_x =  x > 0 and max_x or min_x
	return clamped_x
end

local function get_y()
	local y =  mod:get("clock_time_offset_y")
	local y_limit = SCREEN_HEIGHT / 2
	local max_y = math.min(mod:get("clock_time_offset_y"), y_limit)
	local min_y = math.max(mod:get("clock_time_offset_y"), -y_limit)
	if y == 0 then
		return 0
	end
	local clamped_y = -(y > 0 and max_y or min_y)
	return clamped_y
end

local fake_input_service = {
	get = function ()
	 	return
	end,
	has = function ()
		return
	end
}

local scenegraph_definition = {
	root = {
	  	scale = "fit",
	  	size = {
			SCREEN_WIDTH,
			SCREEN_HEIGHT
	  	},
	  	position = {
			0,
			0,
			UILayer.hud
	  	}
	}
}

local clock_time_ui_definition = {
	scenegraph_id = "root",
	element = {
	  	passes = {
			{
				style_id = "clock_time_text",
				pass_type = "text",
				text_id = "clock_time_text",
				retained_mode = false,
				fade_out_duration = 5,
				content_check_function = function(content)
					return true
				end
			}
	  	}
	},
	content = {
		clock_time_text = ""
	},
	style = {
		clock_time_text = {
			font_type = "hell_shark",
			font_size = mod:get("clock_time_font_size"),
			vertical_alignment = "center",
			horizontal_alignment = "center",
			text_color = Colors.get_table("white"),
			offset = {
				get_x(),
				get_y(),
				0
			}
		}
	},
	offset = {
		0,
		0,
		0
	},
}

-- MOD EVENTS --
function mod:on_enabled()
	mod:on_setting_changed()
end

function mod:on_disabled()
	mod.ui_renderer = nil
	mod.ui_scenegraph = nil
	mod.ui_widget = nil
end

function mod:on_setting_changed()
	if not mod.ui_widget then
	  	return
	end
	mod.ui_widget.style.clock_time_text.offset[1] = get_x()
	mod.ui_widget.style.clock_time_text.offset[2] = get_y()
	mod.ui_widget.style.clock_time_text.font_size = mod:get("clock_time_font_size")
    mod.ui_widget.style.clock_time_text.text_color = {mod:get("clock_time_alpha"), mod:get("clock_time_red"), mod:get("clock_time_green"), mod:get("clock_time_blue")}
end

function mod:init()
	if mod.ui_widget then
	  	return
	end

	local world = Managers.world:world("top_ingame_view")
	mod.ui_renderer = UIRenderer.create(world, "material", "materials/fonts/gw_fonts")
	mod.ui_scenegraph = UISceneGraph.init_scenegraph(scenegraph_definition)
	mod.ui_widget = UIWidget.init(clock_time_ui_definition)
end

-- HOOKS --
mod:hook_safe(IngameHud, "update", function(self)
	if self:is_own_player_dead() then
		return
	end

	if not self._currently_visible_components.EquipmentUI then 
        return 
    end

	if not mod.ui_widget then
	  	mod.init()
	end

	local widget = mod.ui_widget
	local ui_renderer = mod.ui_renderer
	local ui_scenegraph = mod.ui_scenegraph

    widget.content.clock_time_text = os.date("%X")
	widget.style.clock_time_text.font_size = mod:get("clock_time_font_size")
    widget.style.clock_time_text.text_color = {mod:get("clock_time_alpha"), mod:get("clock_time_red"), mod:get("clock_time_green"), mod:get("clock_time_blue")}
	widget.style.clock_time_text.offset[1] = get_x()
	widget.style.clock_time_text.offset[2] = get_y()

	UIRenderer.begin_pass(ui_renderer, ui_scenegraph, fake_input_service, dt)
	UIRenderer.draw_widget(ui_renderer, widget)
	UIRenderer.end_pass(ui_renderer)
end)