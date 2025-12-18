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
	{
		name = "WSL:NixOS",
		distribution = "NixOS",
		username = "nixos",
		default_cwd = "~",
	},
}

config.default_domain = "WSL:Arch"

config.use_ime = true

config.initial_cols = 160
config.initial_rows = 40

config.font = wezterm.font_with_fallback({
	"PlemolJP Console NF",
})
config.font_size = 13

config.color_scheme = "Catppuccin Latte"

config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"

config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.enable_tab_bar = true
config.tab_bar_at_bottom = false

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
