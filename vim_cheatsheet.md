## Files 

<leader>n          Rename (and reopen) current file

## Fuzzy File Finder fzf

C-p                 File finder
C-k                 Move to next item from matchlist
C-j                 Move to previous item from matchlist
C-x                 Open the selected file in horizontal split
C-v                 Open the selected file in vertical split
C-t                 Open the selected file in a new tab page
C-c                 Dismiss fzf

## Buffers

C-6                 Switch to previous buffer

## Tabs

tab ball            Show each buffer in a tab (up to 'tabpagemax' tabs)
gt                  Go to next tap
gT                  Go to previous tab
{i}gt               Go to tab in position i
tabm {i}            Move current tab to position i+1

## Windows

C-W =               Resize windows to equal height/width:

C-W >               Increase window width
C-W <               Decrease window width

C-W +               Increase window height
C-W -               Decrease window height

C-W J               Switch vertical splits to horizontal
C-W H               Switch horizontal splits to vertical

## Sessions

mksession!          Records current session in a Session.vim file
$ vim -S            Restores session
source Session.vim  Restores session

## Folding

za / <space>        Toogle folding
zR                  Open all folds
zM                  Close all folds

## Encodings

echo &fenc          Show file encoding

## Moving around

Move through the jump list:

  C-O (back) C-I (fwd)

Show jump list:
  
  :ju

Moving through the change list:

  g; (back) g, (fwd)

Show changes list:

  :changes

## Editing

Paste from outside vim without autoindenting

  :set paste
  :set nopaste

Delete inner tag content

  dit

## Surround

Surround whole line in php tags 

  yss-

## Open url in default browser

:gx 

## Spell

Activate spell with
:set spell

Languages should already been predefined at the vimrc, but if not, simply:
:set spell spelllanguage=ca,en_us

To disable spell
:set nospell

To move to a misspelled word:
]s # move to the NEXT bad word
[s # move to the PREVIOUS bad word

Once the cursor is on the word
z= # List of suggested alternatives.

Sometimes the dictionary lacks some words.
zg # Add word to dictionary

This adds the word to a spellfile located by default at .config/nvim/spell where all the added words are stored and are loaded together with the main dictionary. It's a good idea to keep this (actually the whole nvim folder) in same repo to never lose this work!

Misspelled words are highlighted. If you are not comfortable with the default highlight colors you can change them:
:hi clear SpellBad
:hi SpellBad cterm=underline

## Python REPL - iron.vim

Open a REPL for current file type
:IronRepl

Send a chunk of text to REPL. Works with motions
ctr

## Nerdcommenter

Toggles the comment state of the selected line(s)
[count]<leader>c<space>

## Editing HTML files

Sends the current html file to the browser
<leader>b

## Shell commands (To be copied to it own file soon)

$ tree        Show all files underneath the current directory in a tree-like view
