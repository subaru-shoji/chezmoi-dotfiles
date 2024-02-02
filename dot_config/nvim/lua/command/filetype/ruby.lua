local function generate_sig_file()
	-- プロジェクトのルートを検出
	local project_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]

	-- 現在のファイルのプロジェクトルートからの相対パスを取得
	local file_path = vim.fn.expand("%")
	local base_file_path = file_path:sub(#project_root + 2)

	-- シグネチャファイルのパスを生成
	local sig_file_dir = project_root .. "/sig/" .. vim.fn.fnamemodify(base_file_path, ":h")
	local sig_file_path = sig_file_dir .. "/" .. vim.fn.fnamemodify(base_file_path, ":t")

	-- シグネチャファイルがすでに存在するかチェック
	if vim.fn.filereadable(sig_file_path) ~= 0 then
		-- 確認ダイアログを表示
		if vim.fn.confirm("Signature file already exists. Overwrite?", "Yes\nNo") ~= 1 then
			print("Operation cancelled.")
			return
		end
	end

	-- シグネチャファイル用のディレクトリが存在するかチェック、存在しない場合は作成
	if vim.fn.isdirectory(sig_file_dir) == 0 then
		vim.fn.mkdir(sig_file_dir, "p")
	end

	-- シェルコマンドを実行
	local command = "rbs prototype rb " .. file_path .. " > " .. sig_file_path
	vim.fn.system(command)

	-- シグネチャファイルを開く
	vim.cmd("edit " .. sig_file_path)
end

-- Neovimのコマンドとして関数を登録
vim.api.nvim_create_user_command("RailsGenerateSigFile", generate_sig_file, {})

return { { "RailsGenerateSigFile", "RailsGenerateSigFile" } }
