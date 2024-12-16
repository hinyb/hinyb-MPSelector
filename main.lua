mods["RoRRModdingToolkit-RoRR_Modding_Toolkit"].auto(true)

mods.on_all_mods_loaded(function()
    for k, v in pairs(mods) do
        if type(v) == "table" and v.tomlfuncs then
            Toml = v
        end
    end
    params = {
        select_next_player_key = 512
    }
    params = Toml.config_update(_ENV["!guid"], params)
end)

MPselector = true

local other_player_list = {}
local select_player_index = 1
local select_player
gm.post_script_hook(gm.constants.hud_draw_health, function(self, other, result, args)
    if other_player_list[select_player_index] ~= nil then
        if args[1].value.object_index == gm.constants.oP and args[1].value.m_id == other_player_list[select_player_index].m_id then
            gm.draw_set_color(Color.WHITE)
            local x = args[3].value + args[5].value
            local y = args[4].value
            local h = args[6].value
            gm.draw_triangle(x, y + h / 2, x + h, y, x + h, y + h, 0);
        end
    end
end)
gm.post_script_hook(gm.constants.init_player_late, function(self, other, result, args)
    if not self.is_local then
        table.insert(other_player_list, self)
        select_player = other_player_list[select_player_index]
    end
end)
gm.post_script_hook(gm.constants.run_create, function(self, other, result, args)
    other_player_list = {}
    select_player_index = 1
    select_player = nil
end)
local function select_next_player()
    if #other_player_list ~= 0 then
        select_player_index = select_player_index + 1
        if select_player_index > #other_player_list then
            select_player_index = 1
        end
    end
    select_player = other_player_list[select_player_index]
end
gm.post_script_hook(gm.constants.disconnect_player, function(self, other, result, args)
    for k,v in pairs(other_player_list) do
        if v.m_id == nil then
            table.remove(other_player_list, k)
            select_next_player()
        end
    end
end)
gui.add_always_draw_imgui(function()
    if ImGui.IsKeyPressed(params['select_next_player_key'], false) then
        select_next_player()
    end
end)

gui.add_to_menu_bar(function()
    local isChanged, keybind_value = ImGui.Hotkey("Select next player", params['select_next_player_key'])
    if isChanged then
        params['select_next_player_key'] = keybind_value
        Toml.save_cfg(_ENV["!guid"], params)
    end
end)

get_select_player = function ()
    return select_player
end
