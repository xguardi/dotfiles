# How-to do everything

## zsh

- Com que tenim el vi mode actiu (bindkey -v)
  0               Inici de línia
  $               Fi de línia
  dd              Esborrar línia
  etc.
  (prompt) >      Insert mode
  (prompt) <      Normal mode

- Recover past commands
  $ history | grep foo 

## Wezterm

CTRL-A c        New tab
CTRL-TAB        Move to next tab
CTRL-SHIFT-TAB  Move to prev tab
CTRL-A n        Move to next tab
CTRL-A p        Move to next tab

CTRL-A ,        Rename current pane
CTRL-A -        Split pane horizontally
CTRL-A |        Split pane vertically
CTRL-A {hjkl}   Move around panes vimlike
CTRL-A m        Toggle full view current pane

CTRL-A W        Resurrect. Save window
CTRL-A L        Resurrect. Load window

## Neovim / Lazyvim

### Spell

set spell        Enable spell checking
set nospell      Disable spell checking

- Navigation
  ]s    Next misspelled word
  [s    Previous misspelled word

- Fixing
  z=    Show suggestions for word under cursor
  zg    Add word to your personal dictionary (mark as good)
  zug   Undo zg
