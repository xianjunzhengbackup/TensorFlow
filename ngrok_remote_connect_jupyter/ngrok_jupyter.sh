#!/bin/bash
/usr/bin/setsid /home/jun/anaconda3/bin/jupyter notebook --no-browser &
sleep 20s
txt=$(/home/jun/anaconda3/bin/jupyter notebook list)
token=$(echo $txt | grep -o "token=[0-9a-z]*")
/usr/bin/setsid /home/jun/ngrok http 8888 &
sleep 20s
txt=$(GET http://localhost:4040/status)
link=$(echo $txt | grep -o "https://[0-9a-z]*\.ngrok\.io")
echo $link > /home/jun/ngrok_jupyter_email.txt
echo $token >>/home/jun/ngrok_jupyter_email.txt
sleep 20s
cat /home/jun/ngrok_jupyter_email.txt | mutt -s "ngrok jupyter login remote info" wolff_zheng@hotmail.com
