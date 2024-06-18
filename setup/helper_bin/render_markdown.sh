#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <markdown-file>"
    exit 1
fi

# Check if the specified file exists
if [ ! -f "$1" ]; then
    echo "File not found: $1"
    exit 1
fi

# Variables
MARKDOWN_FILE=$1
HTML_FILE=$(basename "$MARKDOWN_FILE" .md).html

# Function to escape HTML
escape_html() {
    echo "$1" | sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g'
}

# Create the HTML file
{
    echo "<html>"
    echo "<head><title>$(basename "$MARKDOWN_FILE")</title></head>"
    echo "<body>"
    in_code_block=0
    in_list=0

    while IFS= read -r line; do
        if [[ $line =~ ^\# ]]; then
            # Headers
            HEADER_LEVEL=$(echo "$line" | grep -o "^#*" | wc -c)
            HEADER_LEVEL=$((HEADER_LEVEL-1))
            HEADER_TEXT=$(echo "$line" | sed 's/^#* //')
            echo "<h$HEADER_LEVEL>$(escape_html "$HEADER_TEXT")</h$HEADER_LEVEL>"
        elif [[ $line =~ ^\*\* ]]; then
            # Bold text
            echo "$line" | sed -e 's/\*\*\(.*\)\*\*/<b>\1<\/b>/g' -e 's/\*\(.*\)\*/<i>\1<\/i>/g'
        elif [[ $line =~ ^- ]]; then
            # Lists
            if [[ $in_list -eq 0 ]]; then
                echo "<ul>"
                in_list=1
            fi
            echo "<li>$(escape_html "${line:2}")</li>"
        elif [[ $line =~ ^\`\`\` ]]; then
            # Code blocks
            if [[ $in_code_block -eq 0 ]]; then
                echo "<pre><code>"
                in_code_block=1
            else
                echo "</code></pre>"
                in_code_block=0
            fi
        else
            if [[ $in_code_block -eq 1 ]]; then
                echo "$(escape_html "$line")"
            else
                # Paragraphs
                if [[ $in_list -eq 1 ]]; then
                    echo "</ul>"
                    in_list=0
                fi
                echo "<p>$(escape_html "$line")</p>"
            fi
        fi
    done < "$MARKDOWN_FILE"

    if [[ $in_list -eq 1 ]]; then
        echo "</ul>"
    fi
    if [[ $in_code_block -eq 1 ]]; then
        echo "</code></pre>"
    fi

    echo "</body>"
    echo "</html>"
} > "$HTML_FILE"

# Open the HTML file in the default web browser
case "$OSTYPE" in
  linux-gnu*) xdg-open "$HTML_FILE" ;;
  darwin*) open "$HTML_FILE" ;;
  cygwin* | msys* | mingw*) start "$HTML_FILE" ;;
  *) echo "Unsupported OS: $OSTYPE" ;;
esac

