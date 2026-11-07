hl.unbind("SUPER + T")

-- Send CTRL+T to the focused window (new tab).
-- Down/up split works around send_shortcut leaving key state stuck.
local function send_shortcut_once(mods, key)
  return function()
    hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "down" }))
    hl.timer(function()
      hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "up" }))
    end, { timeout = 50, type = "oneshot" })
  end
end

o.bind("SUPER + T", "New tab", send_shortcut_once("CTRL", "T"))

hl.unbind("SUPER + W")
o.bind("SUPER + Q", "Quit app", hl.dsp.window.close())

o.bind("SUPER + CTRL + RETURN", "Zen blank window", "uwsm-app -- zen-browser --blank-window")
