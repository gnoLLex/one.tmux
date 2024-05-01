#!/bin/bash

get() {
   local option=$1
   local default_value=$2
   local option_value="$(tmux show-option -gqv "$option")"

   if [ -z "$option_value" ]; then
      echo "$default_value"
   else
      echo "$option_value"
   fi
}

set() {
   local option=$1
   local value=$2
   tmux set-option -gq "$option" "$value"
}

setw() {
   local option=$1
   local value=$2
   tmux set-window-option -gq "$option" "$value"
}

theme=$(get "@one_theme" "light")

if [[ $theme == "light" ]]; then
    one_black="#101012"
    one_blue="#4078f2"
    one_yellow="#986801"
    one_red="#e45649"
    one_white="#fafafa"
    one_green="#50a14f"
    one_dark_grey="#5c6370"
    one_grey="#848b98"
    one_light_grey="#e6e6e6"
    one_bg="#fafafa"
    one_fg="#383a42"
    one_bg2="$one_light_grey"
elif [[ $theme == "dark" ]]; then
    one_black="#282c34"
    one_blue="#61afef"
    one_yellow="#e5c07b"
    one_red="#e06c75"
    one_white="#aab2bf"
    one_green="#98c379"
    one_visual_grey="#3e4452"
    one_comment_grey="#5c6370"
    one_dark_grey="#5c6370"
    one_grey="#848b98"
    one_light_grey="#e6e6e6"
    one_bg="#282c34"
    one_fg="#fafafa"
    one_bg2="$one_dark_grey"
else
    echo "Unknown one theme: $theme"
fi


set "status" "on"
set "status-justify" "left"

set "status-left-length" "100"
set "status-right-length" "100"
set "status-right-attr" "none"

set "message-fg" "$one_fg"
set "message-bg" "$one_bg"

set "message-command-fg" "$one_fg"
set "message-command-bg" "$one_bg"

set "status-attr" "none"
set "status-left-attr" "none"

setw "window-status-fg" "$one_fg"
setw "window-status-bg" "$one_bg"
setw "window-status-attr" "none"

setw "window-status-activity-fg" "$one_fg"
setw "window-status-activity-bg" "$one_bg"
setw "window-status-activity-attr" "none"

setw "window-status-separator" ""

set "window-style" "fg=$one_fg"
set "window-active-style" "fg=$one_fg"

set "pane-border-fg" "$one_fg"
set "pane-border-bg" "$one_bg"
set "pane-active-border-fg" "$one_fg"
set "pane-active-border-bg" "$one_bg"

set "display-panes-active-colour" "$one_yellow"
set "display-panes-colour" "$one_blue"

set status-fg "$one_fg"
set status-bg "$one_bg"

status_widgets=$(get "@one_widgets" "")
time_format=$(get "@one_time_format" "%R")
date_format=$(get "@one_date_format" "%d/%m/%Y")

status_right="\
#[fg=$one_fg,bg=$one_bg,nounderscore,noitalics]${time_format}  ${date_format} \
#[fg=$one_grey,bg=$one_bg]\
#[fg=$one_grey,bg=$one_grey]\
#[fg=$one_fg, bg=$one_grey]${status_widgets} \
#[fg=$one_green,bg=$one_grey,nobold,nounderscore,noitalics]\
#[fg=$one_bg,bg=$one_green,bold] #h \
#[fg=$one_yellow, bg=$one_green]\
#[fg=$one_red,bg=$one_yellow]\
"

status_left="\
#[fg=$one_bg,bg=$one_green,bold] #S \
#[fg=$one_green,bg=$one_bg,nobold,nounderscore,noitalics]\
"

set "status-right" "$status_right"
set "status-left" "$status_left"

window_status_format="\
#[fg=$one_bg,bg=$one_bg,nobold,nounderscore,noitalics]\
#[fg=$one_fg,bg=$one_bg] #I  #W \
#[fg=$one_bg,bg=$one_bg,nobold,nounderscore,noitalics]\
"
window_status_current_format="\
#[fg=$one_bg,bg=$one_bg2,nobold,nounderscore,noitalics]\
#[fg=$one_fg,bg=$one_bg2,nobold] #I  #W \
#[fg=$one_bg2,bg=$one_bg,nobold,nounderscore,noitalics]\
"

set "window-status-format" "$window_status_format"
set "window-status-current-format" "$window_status_current_format"
