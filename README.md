vim-pybreak
===========

Vim function for toggling pdb.set\_trace statement at cursor position

installation
------------
Prefered way of installing this plugin (as with any other script) is by 
installing it as a git submodule, and loading it with pathogen (for pathogen
installation instructions, please refer to https://github.com/tpope/vim-pathogen
or http://www.vim.org/scripts/script.php?script\_id=2332). When you have
pathogen installed, installin pybreak is as simple as:

    git clone git://github.com/nthorne/vim-pybreak.git bundle/pybreak

usage
-----
\<localleader\>d (<localleader> defaulting to `\\`) inserts a set\_trace statement
_after_ the cursor position, if no statements are found on the current line. If,
however, any set\_trace statements (as inserted by pybreak) are found anywhere
on the current line, they are removed, and no set\_trace statements are
inserted.

License
-------
Copyright (C) 2012 Niklas Thörne. This plugin is distributed under the
GNU General Public License version 3.
