return {
    {
        "saghen/blink.cmp",
        optional = true,
        opts = {
            keymap = {
                preset = 'enter',
                ["<C-space>"] = {},
            },
            completion = {
                menu = { border = "rounded" },
                documentation = { window = { border = "rounded" } },
            },
            signature = { window = { border = "rounded" } },
            fuzzy = {
                prebuilt_binaries = {
                    download = false,
                    ignore_version_mismatch = true,
                },
            }
        },
    },
}
