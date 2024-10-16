local get_lan_ip = function()
  if vim.fn.has("win32") == 1 then
    local output = vim.fn.system("ipconfig")
    local lan_ip = output:match("IPv4 Address.-:%s192([%d%.]+)")
    return "192" .. lan_ip
  elseif vim.fn.has("mac") == 1 then
    local cmd = "ipconfig getifaddr en0"
    local ip = vim.fn.system(cmd):match("([%d%.]+)%\n")
    return ip
  elseif vim.fn.has("linux") == 1 or vim.fn.has("wsl") == 1 then
    local cmd = "ip route get 1.1.1.1 | awk '{print $7}'"
    local ip = vim.fn.system(cmd)
    return ip:gsub("%s+", "") -- Remove any leading/trailing whitespace
  end
end

return {
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    cmd = { "MarkdownPreview", "MP" },
    init = function()
      vim.api.nvim_create_user_command("MP", "MarkdownPreview", {})
    end,
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
      --  set to 1, nvim will open the preview window after entering the markdown buffer
      --  default: 0
      vim.g.mkdp_auto_start = 0

      --  set to 1, the nvim will auto close current preview window when change
      --  from markdown buffer to another buffer
      --  default: 1
      vim.g.mkdp_auto_close = 0

      --  set to 1, the vim will refresh markdown when save the buffer or
      --  leave from insert mode, default 0 is auto refresh markdown as you edit or
      --  move the cursor
      --  default: 0
      vim.g.mkdp_refresh_slow = 0

      --  set to 1, the MarkdownPreview command can be use for all files,
      --  by default it can be use in markdown file
      --  default: 0
      vim.g.mkdp_command_for_global = 0

      --  set to 1, preview server available to others in your network
      --  by default, the server listens on localhost (127.0.0.1)
      --  default: 0
      vim.g.mkdp_open_to_the_world = 1

      --  use custom IP to open preview page
      --  useful when you work in remote vim and preview on local browser
      --  more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
      --  default empty
      -- vim.g.mkdp_open_ip = "127.0.0.1"
      vim.g.mkdp_open_ip = get_lan_ip()

      --  specify browser to open preview page
      --  default: ''
      vim.g.mkdp_browser = ""

      --  set to 1, echo preview page url in command line when open preview page
      --  default is 0
      vim.g.mkdp_echo_preview_url = 1

      --  a custom vim function name to open preview page
      --  this function will receive url as param
      --  default is empty
      vim.g.mkdp_browserfunc = ""

      --  use a custom markdown style must be absolute path
      --  like '/Users/username/markdown.css' or expand('~/markdown.css')
      vim.g.mkdp_markdown_css = ""

      --  use a custom highlight style must absolute path
      --  like '/Users/username/highlight.css' or expand('~/highlight.css')
      vim.g.mkdp_highlight_css = ""

      --  use a custom port to start server or random for empty
      vim.g.mkdp_port = "8085"

      --  preview page title
      --  ${name} will be replace with the file name
      vim.g.mkdp_page_title = "「${name}」"

      vim.g.mkdp_theme = "light"
    end,
  },
}
