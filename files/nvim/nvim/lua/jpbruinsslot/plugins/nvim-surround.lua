-- nvim-surround: surround text with quotes, brackets, etc.
--
-- add
--   `ys{motion}{char}`
--     surr*ound_words             ysiw)           (surround_words)
--     *make strings               ys$"            "make strings"
--
-- delete
--   `ds{char}`
--     [delete ar*ound me!]        ds]             delete around me!
--     remove <b>HTML t*ags</b>    dst             remove HTML tags
--     delete(functi*on calls)     dsf             function calls
--
-- change
--   `cs{target}{replacement}`
--     'change quot*es'            cs'"            "change quotes"
--     <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
return {
	"kylechui/nvim-surround",
	event = { "BufReadPre", "BufNewFile" },
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	config = true,
}
