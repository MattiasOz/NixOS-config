{
  programs.nixvim = {
    plugins = {
      lualine.enable = true;
      nvim-tree = {
        enable = true;
        git.ignore = false;
        view = {
          number = true;
          relativenumber = true;
        };
        updateFocusedFile = {
          enable = true;
          updateRoot = true;
        };
      };
      web-devicons.enable = true; # necessary for nvim-tree
      bufferline = {
        enable = true;
      };
      bufdelete.enable = true;
      smear-cursor = {
        enable = true;
        #time_interval = 90;
        settings = {
          distance_stop_animating = 0.5;
          # hide_target_hack = false;
          stiffness = 0.8;
          trailing_stiffness = 0.5;
        };
      };
      which-key = {
        enable = true;
        settings.preset = "helix"; # classic, modern, helix
      };
      #nvim-surround ?? check out
      treesitter = {
        enable = true;
        settings = {
          indent.enable = true;
          ensure_installed = ["lua"];
          sync_install = true;
        };
      };
      # cmp = {
      #   enable = true;
      #   autoEnableSources = true;
      #   settings
      # };
      # cmp.enable = true;
      # cmp.settings.sources = [
      #   { name = "nvim_lsp";}
      #   { name = "path";}
      #   { name = "buffer";}
      #   { name = "luasnip";}
      # ];
      lsp = {
        enable = true;
        servers = {
          pyright.enable = true;
        };
      };
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          snippet.expand = # lua
            ''
              function(args)
                require("luasnip").lsp_expand(args.body)
              end
            '';
          # window = {
          #   documentation.border = "${config.nvix.border}";
          #   completion = {
          #     border = "${config.nvix.border}";
          #     scrollbar = false;
          #   };
          # };
          #mappingPresets = ["insert"];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-u>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm()";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i'})";
          };
          sources = [
            { name = "luasnip"; }
            { name = "nvim_lsp"; }
            # { name = "nvim_lsp_signature_help"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
        };
      };
      # cmp-treesitter.enable = true;
      nvim-autopairs.enable = true;
    };
  };
}
