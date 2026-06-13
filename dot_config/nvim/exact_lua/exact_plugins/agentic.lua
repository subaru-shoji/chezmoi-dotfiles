return {
  {
    "carlos-algms/agentic.nvim",
    --- @type agentic.PartialUserConfig
    opts = {
      provider = "opencode-acp",
    },
    keys = {
      {
        "<leader>Aa",
        function()
          require("agentic").toggle()
        end,
        mode = "n",
        desc = "Agentic Chat (toggle)",
      },
      {
        "<leader>A",
        function()
          require("agentic").add_selection()
        end,
        mode = "x",
        desc = "Add Selection to Agentic",
      },
      {
        ",Aa",
        function()
          require("agentic").toggle()
        end,
        mode = "n",
        desc = "Agentic Chat (toggle)",
      },
      {
        ",Av",
        function()
          require("agentic").add_selection()
        end,
        mode = "x",
        desc = "Add Selection to Agentic",
      },
      {
        ",Ar",
        function()
          require("agentic").restore_session()
        end,
        mode = "n",
        desc = "Restore Session",
      },
    },
  },
}
