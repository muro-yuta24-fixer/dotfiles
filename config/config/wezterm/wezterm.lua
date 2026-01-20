local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.wsl_domains = {
	{
		name = "WSL:Arch",
		distribution = "archlinux",
		username = "yuta",
		default_cwd = "~",
		default_prog = { "fish", "--login", "--interactive" },
	},
}

config.default_domain = "WSL:Arch"

config.use_ime = true

config.initial_cols = 160
config.initial_rows = 40

config.font = wezterm.font_with_fallback({
	"PlemolJP Console NF",
})
config.font_size = 13.0

config.color_scheme = "Catppuccin Mocha"

config.window_decorations = "TITLE | RESIZE"

config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.enable_tab_bar = true
config.tab_bar_at_bottom = false
config.tab_max_width = 64
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false

config.window_frame = {
	font = wezterm.font({ family = "PlemolJP Console NF", weight = "Bold" }),
	font_size = 13.0,
	inactive_titlebar_bg = "#1e1e2e",
	active_titlebar_bg = "#1e1e2e",
}

config.window_background_gradient = {
	colors = { "#1e1e2e" },
}

config.colors = {
	tab_bar = {
		inactive_tab_edge = "none",
	},
}

local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_left_half_circle_thick
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_right_half_circle_thick

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local background = "#cdd6f4"
	local foreground = "#1e1e2e"
	local edge_background = "none"
	if tab.is_active then
		background = "#89b4fa"
		foreground = "#1e1e2e"
	end
	local edge_foreground = background
	local title = " " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. " "
	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

-- すべてのデフォルトキーバインディングを無効化
config.disable_default_key_bindings = true

config.integrated_title_button_style = "Windows"

config.keys = {
	{
		key = "Enter",
		mods = "SHIFT",
		action = wezterm.action({ SendString = "\x1b\r" }),
	},
	-- コピー (Windows/Linux)
	{
		key = "c",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CopyTo("Clipboard"),
	},
	-- ペースト (Windows/Linux)
	{
		key = "v",
		mods = "CTRL|SHIFT",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
	-- プライマリセレクションへのコピー (Linux)
	{
		key = "Insert",
		mods = "CTRL",
		action = wezterm.action.CopyTo("PrimarySelection"),
	},
	-- プライマリセレクションからのペースト (Linux)
	{
		key = "Insert",
		mods = "SHIFT",
		action = wezterm.action.PasteFrom("PrimarySelection"),
	},
	-- ========================================
	-- ウィンドウ操作
	-- ========================================
	-- 新しいウィンドウを作成 (Windows/Linux)
	{
		key = "n",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SpawnWindow,
	},
	-- ========================================
	-- タブ操作
	-- ========================================
	-- 新しいタブを作成 (Windows/Linux)
	{
		key = "t",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	-- タブを閉じる (Windows/Linux)
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
	},
	-- 前のタブへ移動 (Windows/Linux)
	{
		key = "Tab",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "PageUp",
		mods = "CTRL",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	-- 次のタブへ移動 (Windows/Linux)
	{
		key = "Tab",
		mods = "CTRL",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "PageDown",
		mods = "CTRL",
		action = wezterm.action.ActivateTabRelative(1),
	},
	-- ========================================
	-- デバッグ・便利機能 (推奨)
	-- ========================================
	-- デバッグオーバーレイ
	{
		key = "L",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ShowDebugOverlay,
	},
	-- コマンドパレット
	{
		key = "P",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivateCommandPalette,
	},
}

-- Finally, return the configuration to wezterm:
return config
