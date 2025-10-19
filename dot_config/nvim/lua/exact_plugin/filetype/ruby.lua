return {
	{
		"rgroli/other.nvim",
		config = function()
			local rails_controller_patterns = {
				{ target = "/spec/controllers/%1_spec.rb", context = "spec" },
				{ target = "/spec/requests/%1_spec.rb", context = "spec" },
				{ target = "/spec/factories/%1.rb", context = "factories", transformer = "singularize" },
				{ target = "/app/models/%1.rb", context = "models", transformer = "singularize" },
				{ target = "/app/views/%1/**/*.html.*", context = "view" },
			}
			require("other-nvim").setup({
				mappings = {
					{
						pattern = "/app/models/(.*).rb",
						target = {
							{ target = "/spec/models/%1_spec.rb", context = "spec" },
							{ target = "/spec/factories/%1.rb", context = "factories", transformer = "pluralize" },
							{
								target = "/app/controllers/**/%1_controller.rb",
								context = "controller",
								transformer = "pluralize",
							},
							{ target = "/app/views/%1/**/*.html.*", context = "view", transformer = "pluralize" },
						},
					},
					{
						pattern = "/spec/models/(.*)_spec.rb",
						target = {
							{ target = "/app/models/%1.rb", context = "models" },
						},
					},
					{
						pattern = "/spec/factories/(.*).rb",
						target = {
							{ target = "/app/models/%1.rb", context = "models", transformer = "singularize" },
							{ target = "/spec/models/%1_spec.rb", context = "spec", transformer = "singularize" },
						},
					},
					{
						pattern = "/app/services/(.*).rb",
						target = {
							{ target = "/spec/services/%1_spec.rb", context = "spec" },
						},
					},
					{
						pattern = "/spec/services/(.*)_spec.rb",
						target = {
							{ target = "/app/services/%1.rb", context = "services" },
						},
					},
					{
						pattern = "/app/controllers/.*/(.*)_controller.rb",
						target = rails_controller_patterns,
					},
					{
						pattern = "/app/controllers/(.*)_controller.rb",
						target = rails_controller_patterns,
					},
					{
						pattern = "/app/views/(.*)/.*.html.*",
						target = {
							{ target = "/spec/factories/%1.rb", context = "factories", transformer = "singularize" },
							{ target = "/app/models/%1.rb", context = "models", transformer = "singularize" },
							{
								target = "/app/controllers/**/%1_controller.rb",
								context = "controller",
								transformer = "pluralize",
							},
						},
					},
					{
						pattern = "/lib/(.*).rb",
						target = {
							{ target = "/spec/%1_spec.rb", context = "spec" },
							{ target = "/sig/%1.rbs", context = "sig" },
						},
					},
					{
						pattern = "/sig/(.*).rbs",
						target = {
							{ target = "/lib/%1.rb", context = "lib" },
							{ target = "/%1.rb" },
						},
					},
					{
						pattern = "/spec/(.*)_spec.rb",
						target = {
							{ target = "/lib/%1.rb", context = "lib" },
							{ target = "/sig/%1.rbs", context = "sig" },
						},
					},
				},
			})
		end,
	},
	{
		"weizheheng/ror.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("ror").setup({
				test = {
					message = {
						-- These are the default title for nvim-notify
						file = "Running test file...",
						line = "Running single test...",
					},
					coverage = {
						-- To customize replace with the hex color you want for the highlight
						-- guibg=#354a39
						up = "DiffAdd",
						-- guibg=#4a3536
						down = "DiffDelete",
					},
					notification = {
						-- Using timeout false will replace the progress notification window
						-- Otherwise, the progress and the result will be a different notification window
						timeout = false,
					},
					pass_icon = "✅",
					fail_icon = "❌",
				},
			})
		end,
	},
}
