#!/bin/bash

unset CDPATH
SCRIPT_DIR=$(cd `dirname $0` && pwd)

DEFAULT_PRELUDE_PERSONAL_DIR="$HOME/.emacs.d/personal"

if [ -z "$PRELUDE_PERSONAL_DIR" ]; then
    if [ -d "$DEFAULT_PRELUDE_PERSONAL_DIR" ]; then
        PRELUDE_PERSONAL_DIR="$DEFAULT_PRELUDE_PERSONAL_DIR"
    else
        echo "prelude personal dir (e.g. $DEFAULT_PRELUDE_PERSONAL_DIR) not found"
        exit 1
    fi
fi

IFS=""

function normalize {
    P="$1"
    echo "$(cd `dirname "$P"` && pwd)/$(basename "$P")"
}

cd "$SCRIPT_DIR"
find . -name "*.el" -print0 | while read -d $'\000' FILE; do
    SOURCE_FILE=`normalize "$SCRIPT_DIR/$FILE"`
    TARGET_FILE=`normalize "$PRELUDE_PERSONAL_DIR/$FILE"`
    ln -sf $SOURCE_FILE $TARGET_FILE
done
