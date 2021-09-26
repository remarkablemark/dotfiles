# This tmux statusbar config was created by tmuxline.vim
# on Wed, 23 Nov 2016

set -g status-style bg="colour234"
set -g message-command-style fg="colour231"
set -g status-justify "left"
set -g status-left-length "100"
set -g status "on"
set -g pane-active-border-style fg="colour254"
# set -g message-style bg="colour31" # if uncommented, makes <prefix> <colon> green instead of yellow
set -g status-right-length "100"
set -g status-right-style "none"
# set -g message-style fg="colour231" # if uncommented, makes <prefix> <colon> not visible
set -g message-command-style bg="colour31"
# set -g status-style "none" # if uncommented, makes status bar no longer black
set -g pane-border-style fg="colour240"
set -g status-left-style "none"
setw -g window-status-style fg="colour250"
setw -g window-status-style "none"
setw -g window-status-activity-style bg="colour234"
setw -g window-status-activity-style "none"
setw -g window-status-activity-style fg="colour250"
setw -g window-status-separator ""
setw -g window-status-style bg="colour234"
set -g status-left "#[fg=colour16,bg=colour254,bold] #S #[fg=colour254,bg=colour234,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=colour236,bg=colour234,nobold,nounderscore,noitalics]#[fg=colour247,bg=colour236] %Y-%m-%d | %H:%M #[fg=colour252,bg=colour236,nobold,nounderscore,noitalics]#[fg=colour235,bg=colour252] #h "
setw -g window-status-format "#[fg=colour244,bg=colour234] #I |#[fg=colour250,bg=colour234] #W "
setw -g window-status-current-format "#[fg=colour234,bg=colour31,nobold,nounderscore,noitalics]#[fg=colour117,bg=colour31] #I |#[fg=colour231,bg=colour31,bold] #W #[fg=colour31,bg=colour234,nobold,nounderscore,noitalics]"