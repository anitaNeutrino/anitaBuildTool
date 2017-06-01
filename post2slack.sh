#!/bin/bash

# usage post2slack channel msg  
# based on https://gist.github.com/dopiaza/6449505

# ANITA_SLACK_TOKEN needs to be defined


if [ -z "$ANITA_SLACK_TOKEN" ]; then
  echo "Need ANITA_SLACK_TOKEN to be defined" 
else
  channel=$1
  text=$2 
  escapedText=$(echo $text | sed 's/"/\"/g' | sed "s/'/\'/g")
  json="{\"channel\": \"#$channel\", \"username\": \"anita-ci\", \"icon_emoji\": \":bug:\", \"text\": \"$escapedText\"}"
  curl -s -d"payload=$json" "$ANITA_SLACK_TOKEN" 
fi

