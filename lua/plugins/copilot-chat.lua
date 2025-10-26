return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    cmd = {
      "CopilotChat",
      "CopilotChatExplain",
      "CopilotChatFix",
      "CopilotChatOptimize",
      "CopilotChatDocs",
      "CopilotChatTests",
      "CopilotChatFixDiagnostic",
      "CopilotChatCommit",
      "CopilotChatCommitStaged",
    },
    keys = {
      -- Normal mode
      {
        "<leader>Cc",
        "<cmd>CopilotChat<cr>",
        desc = "Copilot Chat",
        mode = "n",
      },
      {
        "<leader>Cfd",
        "<cmd>CopilotChatFixDiagnostic<cr>",
        desc = "Fix diagnostic",
        mode = "n",
      },
      {
        "<leader>Cgm",
        "<cmd>CopilotChatCommit<cr>",
        desc = "Generate commit",
        mode = "n",
      },
      {
        "<leader>Cgs",
        "<cmd>CopilotChatCommitStaged<cr>",
        desc = "Generate commit staged",
        mode = "n",
      },
      -- Visual mode
      {
        "<leader>Ce",
        "<cmd>CopilotChatExplain<cr>",
        desc = "Explain code",
        mode = "v",
      },
      {
        "<leader>Cf",
        "<cmd>CopilotChatFix<cr>",
        desc = "Fix code",
        mode = "v",
      },
      {
        "<leader>Co",
        "<cmd>CopilotChatOptimize<cr>",
        desc = "Optimize code",
        mode = "v",
      },
      {
        "<leader>Cd",
        "<cmd>CopilotChatDocs<cr>",
        desc = "Add docs",
        mode = "v",
      },
      {
        "<leader>Ct",
        "<cmd>CopilotChatTests<cr>",
        desc = "Generate tests",
        mode = "v",
      },
      {
        "<leader>Cc",
        "<cmd>CopilotChat<cr>",
        desc = "Copilot Chat with selection",
        mode = "v",
      },
    },
    config = function()
      local select = require("CopilotChat.select")
      local chat = require("CopilotChat")

      require("CopilotChat").setup({
        debug = true,
        proxy = nil,
        allow_insecure = false,
        model = "claude-4.0-sonnet",
        temperature = 0.1,
        language = "Japanese",

        -- マッピング設定
        mappings = {
          close = {
            normal = "q",
            insert = "<C-c>",
          },
          reset = {
            normal = "<C-l>",
            insert = "<C-l>",
          },
        },

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
          layout = "float",
          width = 0.8, -- 広めに設定
          height = 0.8,
        },
      })
    end,
  },
}

-- ## 壁打ちでの使い方
--
-- ### 1. **基本的な流れ**
-- ```
-- 1. 空のファイル（.md, .txt など）を開く
-- 2. <leader>Cc でチャットを開く
-- 3. 質問・相談を入力（例：「Rustの所有権について説明して」）
-- 4. 応答を確認
-- 5. 良ければヤンクして反映
-- ```
--
-- ### 2. **チャットウィンドウでの操作**
-- - **`yy`**: チャット内容全体をヤンク（コピー）
-- - **`gc`**: コードブロックのみをヤンク
-- - **`gy`**: 提案された差分をヤンク
-- - **`<C-y>`**: カーソル位置に直接挿入
-- - **`q`**: チャットを閉じる
--
-- ### 3. **具体的な使用例**
--
-- #### パターンA: 全文をコピー
-- ```
-- 1. チャットで質問・相談
-- 2. チャットウィンドウで yy
-- 3. 元のファイルに戻って p でペースト
-- ```
--
-- #### パターンB: コードだけコピー
-- ```
-- 1. チャットで「Rustの例を教えて」
-- 2. チャットウィンドウで gc（コードブロックのみコピー）
-- 3. 元のファイルに戻って p でペースト
-- ```
--
-- #### パターンC: 直接挿入
-- ```
-- 1. 挿入したい位置にカーソルを置く
-- 2. チャットで質問
-- 3. チャットウィンドウで <C-y>（直接挿入）
-- ```
--
-- ### 4. **複数回の壁打ち**
-- ```
-- 1. チャットを開いたまま質問を続ける
-- 2. 気に入った回答だけ yy でコピー
-- 3. <C-l> でリセットして新しい話題へ
