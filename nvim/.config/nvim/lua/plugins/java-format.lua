return {
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      opts.settings = opts.settings or {}
      opts.settings.java = opts.settings.java or {}

      -- Configure jdtls to use your eclipse style
      opts.settings.java.format = {
        enabled = true,
        settings = {
          url = vim.fn.stdpath("config") .. "/eclipse-java-style.xml",
          profile = "Default",
        },
      }

      -- Fix: LazyVim's glob picks up non-OSGi JARs (jacocoagent.jar,
      -- runner-jar-with-dependencies.jar) that cause JDTLS bundle loading
      -- to fail entirely. Override with an explicit filtered list.
      local mason_registry = require("mason-registry")
      local bundles = {}

      if mason_registry.is_installed("java-debug-adapter") then
        vim.list_extend(
          bundles,
          vim.fn.glob("$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin-*.jar", false, true)
        )
      end

      if mason_registry.is_installed("java-test") then
        -- Exclude non-OSGi JARs: runner-jar-with-dependencies.jar and jacocoagent.jar
        local test_jars = vim.fn.glob("$MASON/share/java-test/*.jar", false, true)
        for _, jar in ipairs(test_jars) do
          if not jar:match("runner%-jar%-with%-dependencies") and not jar:match("jacocoagent") then
            table.insert(bundles, jar)
          end
        end
      end

      opts.jdtls = opts.jdtls or {}
      opts.jdtls.init_options = opts.jdtls.init_options or {}
      opts.jdtls.init_options.bundles = bundles

      -- Add a "debug nearest test" keymap to match tt/tr/tT. Runs the nearest
      -- test through the debug adapter so breakpoints are honored.
      opts.on_attach = function(args)
        require("which-key").add({
          {
            mode = "n",
            buffer = args.buf,
            {
              "<leader>td",
              function()
                require("jdtls.dap").test_nearest_method()
              end,
              desc = "Debug Nearest Test",
            },
          },
        })
      end

      return opts
    end,
  },
}
