# Markdown Heading Switcher for Neovim

This little function search in a md, qmd or rmd for headings.
Then it opens a loction list window and a heading can be selected.
After this, the location list window is closed.

There are great tools to do this task.
For example: [telescope-heading.nvim](https://github.com/crispgm/telescope-heading.nvim).
I want to do it by myself and I was looking for something small.
My solution is not a complete plugin.
It is a lua module belonging into the `~/.config/nvim/lua/my_modules/` path and the autocmds.lua, too.

## Usage
In normal mode: `<leader>mh`

## How does it work
`lvimgrep/^\s*#\{1,6}\s/` fetch all headings.
(It is not perfect. If you like to comment like:
```
###########
# Comment #
###########
```
the comment is fetched, too.)

Then the list of headings is formatted and send to the location list.
The format is: `lnr: | 2 spacings for each level | heading`.
The location list window is opened at last.
For the closing the <CR> is redefined. Therefore the usage is very limited. Nobody wants a couple of command whenever he/she press return.

## Ideas
Using this tool in insert-mode.


