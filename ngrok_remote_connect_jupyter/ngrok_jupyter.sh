#!/bin/bash
#txt=$(/home/jun/anaconda3/bin/jupyter-notebook)
#echo $txt
setsid ngrok http 8888 &
sleep 5s
txt=$(GET http://localhost:4040/status)
link=$(echo $txt | grep -o "https://[0-9a-z]*\.ngrok\.io")
echo $link
