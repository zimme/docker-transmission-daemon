#!/bin/sh
set -e

groupmod -g "$GID" transmission

if [ $GIDS ]; then

  OLDIFS="$IFS"
  IFS=","

  for TMP_GID in $GIDS; do

    if [ ! $(getent group "$TMP_GID") ]; then

      groupadd -g "$TMP_GID" "g$TMP_GID"

    fi

  done

  IFS="$OLDIFS"
  unset OLDIFS

fi

usermod -u "$UID" -a -G "$GIDS" transmission

su -s /bin/ash - transmission

exec "$@" 
