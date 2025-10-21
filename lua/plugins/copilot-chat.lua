return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- copilot.luaを使用
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    config = function()
      local select = require("CopilotChat.select")

      require("CopilotChat").setup({
        debug = true,
        proxy = nil,
        allow_insecure = false,
        model = "claude-3.7-sonnet",
        temperature = 0.1,
        language = "Japanese",
        prompts = {
          Explain = {
            prompt = "/COPILOT_EXPLAIN 選択したコードの説明を段落をつけて書いてください。",
            selection = select.selection,
          },
          Fix = {
            prompt = "/COPILOT_FIX このコードには問題があります。バグを修正したコードに書き換えてください。",
            selection = select.selection,
          },
          Optimize = {
            prompt = "/COPILOT_OPTIMIZE 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。",
            selection = select.selection,
          },
          Docs = {
            prompt = "/COPILOT_DOCS 選択したコードのドキュメントを書いてください。ドキュメントをコメントとして追加した元のコードを含むコードブロックで回答してください。使用するプログラミング言語に最も適したドキュメントスタイルを使用してください（例：JavaScriptのJSDoc、Pythonのdocstringsなど）",
            selection = select.selection,
          },
          Tests = {
            prompt = "/COPILOT_TESTS 選択したコードの詳細な単体テスト関数を書いてください。",
            selection = select.selection,
          },
          FixDiagnostic = {
            prompt = "/COPILOT_FIXDIAGNOSTIC ファイル内の次のような診断上の問題を解決してください：",
            selection = select.diagnostics,
          },
        },
        window = {
          layout = "vertical",
          width = 0.3,
          height = 0.3,
          relative = "editor",
          border = "single",
          row = 0,
          col = 0,
          title = "Copilot Chat",
          footer = nil,
          zindex = 1,
        },
      })
    end,
  },
}
