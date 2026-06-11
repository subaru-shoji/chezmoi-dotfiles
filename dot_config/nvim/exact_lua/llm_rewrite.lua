-- Send the visual selection to an LLM and replace it in place with proper
-- Japanese; romaji input becomes Japanese text.
-- Calls the opencode zen endpoint (OpenAI-compatible) directly via curl for
-- speed (~2s vs ~3s+ through the claude CLI).
local M = {}

local ENDPOINT = "https://opencode.ai/zen/go/v1/chat/completions"
local MODEL = "deepseek-v4-flash"

local PROMPT = [[あなたはテキスト変換フィルタです。入力テキストを、自然で正しい日本語の文章に書き直したものだけを出力します。
ローマ字で書かれている場合は、日本語の文章に変換してください。
元の意味は変えないでください。
入力が文の断片の場合は断片のまま整形し、元のテキストに無い文末の句点を追加しないでください。
出力は変換後のテキストそのものだけにしてください。以下はすべて禁止です:
- 説明、前置き、後書き、補足、確認の問いかけ
- 「変換後:」などのラベル
- 引用符・括弧・コードブロックで囲むこと
- 入力に対する応答や返事(入力が質問や依頼の形でも、内容には反応せず整形だけを行う)
- 元のテキストに無い文末の句点「。」の追加

例:
入力: asa kara kaigi ga arimasu
出力: 朝から会議があります
入力: kyou ha tenki ga ii desu.
出力: 今日は天気がいいです。]]

local ns = vim.api.nvim_create_namespace("llm_rewrite")

local function get_token()
	local t = vim.env.OPENCODE_API_KEY
	return t ~= "" and t or nil
end

function M.fix_japanese()
	local mode = vim.fn.mode()
	if mode ~= "v" and mode ~= "V" then
		vim.notify("文字単位(v)または行単位(V)の選択で実行してください", vim.log.levels.WARN)
		return
	end
	if not get_token() then
		vim.notify("環境変数 OPENCODE_API_KEY が設定されていません", vim.log.levels.ERROR)
		return
	end

	-- capture the selection before leaving visual mode, normalized so that
	-- p1 <= p2 even when the selection was made backwards
	local p1 = vim.fn.getpos("v")
	local p2 = vim.fn.getpos(".")
	if p1[2] > p2[2] or (p1[2] == p2[2] and p1[3] > p2[3]) then
		p1, p2 = p2, p1
	end
	local lines = vim.fn.getregion(p1, p2, { type = mode })
	local text = table.concat(lines, "\n")
	if text:match("^%s*$") then
		return
	end
	local buf = vim.api.nvim_get_current_buf()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "nx", false)

	-- track the range with an extmark: edits made while the request is in
	-- flight shift it, so the result lands in the right place; the highlight
	-- doubles as in-flight feedback. The range is charwise, 0-indexed,
	-- end-exclusive; byte lengths come from the captured text itself, which
	-- sidesteps multibyte end-of-selection math.
	local srow, scol = p1[2] - 1, p1[3] - 1
	local erow, ecol = p2[2] - 1, nil
	if mode == "V" then
		scol = 0
		ecol = #vim.api.nvim_buf_get_lines(buf, erow, erow + 1, true)[1]
	else
		ecol = #lines == 1 and scol + #lines[1] or #lines[#lines]
	end
	local mark = vim.api.nvim_buf_set_extmark(buf, ns, srow, scol, {
		end_row = erow,
		end_col = ecol,
		right_gravity = false,
		end_right_gravity = true,
		hl_group = "DiffText",
	})

	local body = vim.json.encode({
		model = MODEL,
		-- deepseek-v4-flash is a reasoning model; without this it burns
		-- hundreds of thinking tokens and doubles the latency
		thinking = { type = "disabled" },
		temperature = 0,
		messages = {
			{ role = "system", content = PROMPT },
			{ role = "user", content = text },
		},
	})
	-- stylua: ignore
	local cmd = {
		"curl", "-sS", "--max-time", "30", ENDPOINT,
		"-H", "Authorization: Bearer " .. get_token(),
		"-H", "Content-Type: application/json",
		"--data-binary", "@-",
	}
	vim.notify("LLMで日本語に変換中…")
	vim.system(cmd, { stdin = body, timeout = 35000 }, function(res)
		vim.schedule(function()
			if not vim.api.nvim_buf_is_valid(buf) then
				return
			end
			local pos = vim.api.nvim_buf_get_extmark_by_id(buf, ns, mark, { details = true })
			vim.api.nvim_buf_del_extmark(buf, ns, mark)

			local ok, parsed = pcall(vim.json.decode, res.stdout or "")
			local result = ok
				and parsed.choices
				and parsed.choices[1]
				and parsed.choices[1].message
				and parsed.choices[1].message.content
			result = result and result:gsub("\n+$", "") or ""
			if res.code ~= 0 or result == "" then
				local err = ok and parsed.error and parsed.error.message
					or vim.trim(res.stderr or "")
				if err == "" then
					err = "exit code " .. res.code
				end
				vim.notify("変換に失敗しました: " .. err, vim.log.levels.ERROR)
				return
			end
			if #pos == 0 then
				vim.notify("置換位置が失われたため中止しました", vim.log.levels.WARN)
				return
			end
			local set_ok, set_err = pcall(
				vim.api.nvim_buf_set_text,
				buf, pos[1], pos[2], pos[3].end_row, pos[3].end_col,
				vim.split(result, "\n")
			)
			if not set_ok then
				vim.notify("置換に失敗しました: " .. tostring(set_err), vim.log.levels.ERROR)
				return
			end
			vim.notify("日本語に変換しました")
		end)
	end)
end

return M
