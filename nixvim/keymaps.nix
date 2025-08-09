{
  programs.nixvim = {
    globals.mapleader = " ";
    keymaps = [
      { mode = "i"; key = "jk"; action = "<ESC>"; }
      { mode = ["i" "n"]; key = "<C-s>"; action = "<cmd>w<CR>"; }
      { mode = "n"; key = "<C-n>"; action = "<cmd>NvimTreeToggle<CR>"; }
      { mode = "n"; key = "n"; action = "nzzzv"; }
      { mode = "n"; key = "N"; action = "Nzzzv"; }
      { mode = "n"; key = "<C-u>"; action = "<C-u>zz"; }
      { mode = "n"; key = "<C-d>"; action = "<C-d>zz"; }
      { mode = "n"; key = "<esc>"; action = "<cmd>noh<CR>"; }
      { mode = "v"; key = "J"; action = ":m '>+1<CR>gv=gv"; }
      { mode = "v"; key = "K"; action = ":m '<-2<CR>gv=gv"; }
      { mode = "n"; key = "J"; action = "V :m '>+1<CR>gv=gv"; }
      { mode = "n"; key = "K"; action = "V :m '<-2<CR>gv=gv"; }
      { mode = "n"; key = "<C-h>"; action = "<C-w>h"; }
      { mode = "n"; key = "<C-j>"; action = "<C-w>j"; }
      { mode = "n"; key = "<C-k>"; action = "<C-w>k"; }
      { mode = "n"; key = "<C-l>"; action = "<C-w>l"; }
      { mode = "n"; key = "<tab>"; action = "<cmd>BufferLineCycleNext<CR>"; }
      { mode = "n"; key = "<S-tab>"; action = "<cmd>BufferLineCyclePrev<CR>"; }
      { mode = "n"; key = "<leader>b"; action = "<cmd>enew<CR>"; options.desc = "New buffer"; }
      { mode = "n"; key = "<leader>x"; action = "<cmd>Bdelete<CR>"; options.desc = "Close buffer"; }
      { mode = "n"; key = "<"; action = "<<"; }
      { mode = "n"; key = ">"; action = ">>"; }
      { mode = "v"; key = "<"; action = "<gv"; }
      { mode = "v"; key = ">"; action = ">gv"; }
      {
        mode = "i";
        key = "<C-Del>";
        action = "<C-o>dw";
      }
      {
        mode = "i";
        key = "<C-H>";
        action = ''
          function()
            local col = vim.fn.col('.')
            local line = vim.fn.getline('.')
            local char_after = col <= #line and line:sub(col, col) or ""
            if char_after ~= "" then
              return '<C-o>db'
            else
              return '<C-o>dvb'
            end
          end
        '';
        lua = true;
        options.expr = true;
      }
    ];
  };
}
