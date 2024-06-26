return {
  {
    "xiyaowong/link-visitor.nvim",
    opts = {
      skip_confirmation = true,
    },
    cmd = {
      "VisitLinkInBuffer",
      "VisitLinkUnderCursor",
      "VisitLinkNearCursor",
      "VisitLinkNearest",
    },
    keys = {
      { "gx", "<cmd>VisitLinkNearest<cr>", desc = "Visit Link Nearest" },
    },
    lazy = true,
  },
}
