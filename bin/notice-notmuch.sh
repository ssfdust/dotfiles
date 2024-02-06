#!/bin/bash
# This is a simple script which uses notmuch and the standard 'notify-send' 
# utility to create notification popups with email subjects.
# Due to the way notify-send handles special characters you will also need
# the recode utility to change from UTF-8 to HTML.

# Most of the settings are set below.

# USAGE:
#   notmuch-notification.sh [--show-none]
#   
#   --show-none  show a notification even if there are no new messages.


# The notmuch search that will generate subjects you want
set -e

SEARCH="tag:new"
NEW_COUNT=$(notmuch count --output=messages "$SEARCH" and not tag:reported)
if [ "$1" == "--show-unread" ]; then
  SEARCH="tag:unread"
  NEW_COUNT=$(notmuch count --output=messages "$SEARCH")
fi
echo $NEW_COUNT

export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
# set some other things you might want to change

# The number of subjects to show in the notification
#   corresponds to the --limit option of notmuch search
LIMIT=3

# the icon in the notification window
NOTIFICATION_ICON='mail-client'

# the sort order of subjects
#   corresponds to the --sort option of notmuch search
SORT="newest-first"

# have notmuch count the number of messages in the search
if [ "$NEW_COUNT" -gt 0 ]; then
  # have notmuch pull the specified number of mail subjects from the search.
  # also, do some rought formatting of the result, to pull thread string,
  # sender etc. leaving just the subject text.
  if [ "$1" == "--show-unread" ]; then
    TXT_SUBS=$(notmuch search --format=text --output=summary --limit="$LIMIT" --sort="$SORT" "$SEARCH" and not tag:reported | sed 's/^[^;]*; //' | sed 's/$/\n'/)
  else
    TXT_SUBS=$(notmuch search --format=text --output=summary --limit="$LIMIT" --sort="$SORT" "$SEARCH" | sed 's/^[^;]*; //' | sed 's/$/\n'/)
  fi
  # special characters like @, &, (, ), etc. break notify-send
  # however it likes HTML encoding just fine, so use recode.
  # HTML_SUBS=$(echo "$TXT_SUBS" | recode UTF-8..html)
  notmuch tag +reported tag:new

  notify-send -i "$NOTIFICATION_ICON" -c mail "$NEW_COUNT new mesages." "$TXT_SUBS"
elif [ -z "$1" ]; then
  exit 0
elif [ "$1" == "--show-none" ]; then
  notify-send -t 1500 -i "$NOTIFICATION_ICON" "No new messages."
fi

exit 0
