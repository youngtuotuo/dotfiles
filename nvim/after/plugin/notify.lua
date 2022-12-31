local status, _ = pcall(require, "notify")
if not status then return end

require("notify").setup({
    background_colour = "#000000",
    fps = 60,
    icons = {DEBUG = "", ERROR = "", INFO = "", TRACE = "✎", WARN = ""},
    level = 2,
    minimum_width = 50,
    render = "default",
    stages = "fade",
    timeout = 450,
    top_down = true
})
