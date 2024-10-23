# hinyb-MPSelector
This is a small mod that allows you to select player, which can help develop mods.

## How to use
* Press Tab to recyclic selected player

* Initialize
```
mods.on_all_mods_loaded(function()
    for _, v in pairs(mods) do
        if type(v) == "table" and v.MPselector then
            _G["get_select_player"] = v["get_select_player"]
        end
    end
end)
```
* Use the function to get CInstance of the selected player or nil.
```
get_select_player()
```

---

## How to binding 
* Open the ImGUI window display (default key is `Insert`)
* [List of possible keys for the toggle](https://oprypin.github.io/crystal-imgui/ImGui/ImGuiKey.html)

## Feedback
https://github.com/hinyb/hinyb-MPSelector/issues

## Installation Instructions

[Installation FAQ](https://docs.google.com/document/u/1/d/1NgLwb8noRLvlV9keNc_GF2aVzjARvUjpND2rxFgxyfw/edit?usp=sharing)

## Special Thanks To
* The Return Of Modding team