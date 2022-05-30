local w = require('wilder')
w.setup({
    modes = {'/', ':', '?]'},
    enable_cmdline_enter = 1,
})
w.set_option({
    pipeline = {
        w.branch(
            w.cmdline_pipeline({
                language = 'python',
                fuzzy = 1,
            }),
            w.python_search_pipeline({
                pattern = w.python_fuzzy_pattern(),
                sorter = w.python_difflib_sorter(),
                engine = 're',
            })
        )
    },
    renderer = w.wildmenu_renderer({
       highlighter = w.basic_highlighter(),
    }),
})
