# Markdown Heading Switcher for Neovim

This function searches in a md, qmd or rmd file for headings.
Then it opens a loction list window and a heading can be selected.
After this, the location list window is closed.

There are great tools to do this task, too.
For example: [telescope-heading.nvim](https://github.com/crispgm/telescope-heading.nvim),
bit I want to do it by myself and I was looking for something small.
My solution is not a complete plugin.
It is a lua module belonging into the `~/.config/nvim/lua/my_modules/` path, and the autocmds.lua belongs to this path, too.

## Usage
In normal mode: `<leader>mh`

## How does it work

### Getting the headings with vimgrep.
`lvimgrep/^\s*#\{1,6}\s/` fetch all headings.

Meaning of the pattern:

^: Beginning of the line  
\s*: arbitrary number of white characters  
#\{1,6}: 1 to 6 times "#"  
\s: white char instead of " ". (The " " is used before).

The RegEx meaning is explained in `:h usr_27.txt`

It is not perfect. If you like to comment things like:
```
###########
# Comment #
###########
```
the comment is fetched, too.

### Formatting the text entrie
Then the list of headings is formatted and send to the location list.
The format is: `lnr: | 2 spacings for each level | heading`.

There is an example of formatting the qf-list in the very last paragraph of "quickfix.txt".

### The qf-window
The location list window is opened at last.
For the closing the \<CR\> is redefined. Therefore the usage of this redefinition is very limited. (Nobody wants a couple of command whenever he/she press return).

[How can I cause the QuickFix window to close after I select an item in it?](https://stackoverflow.com/questions/21321357/how-can-i-cause-the-quickfix-window-to-close-after-i-select-an-item-in-it)

## Ideas
Using this tool in insert-mode.


## Other Resources
[Instant grep + quickfix](https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3)

[vim and the quickfix list](https://vonheikemen.github.io/devlog/tools/vim-and-the-quickfix-list/)


