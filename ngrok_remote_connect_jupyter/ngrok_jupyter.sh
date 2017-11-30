#This script is used to remote login and use jupyter.
#So task1 will start jupyter note in background
#task2 run jupyter notebook list and scrape token info from the response
#task3 will start ngrok 
#task 4 will GET reponse from localhost:4040/status and scrape link
#!/bin/bash

#start jupyter in background without browser. setsid command & will run
#the command in the background and also change the parent process id.
#So even current script is finished and current process ends, the process
#to start jupyter won't affect, because parent changed.
/usr/bin/setsid /home/jun/anaconda3/bin/jupyter notebook --no-browser &
sleep 20s
txt=$(/home/jun/anaconda3/bin/jupyter notebook list)
#grep -o will output matched result
token=$(echo $txt | grep -o "token=[0-9a-z]*")
#ngrok http 8888 will forward all http request from ngrok to localhost:8888
#which is local jupyter service.
#ngrok:80 -------> jupyter:8888
/usr/bin/setsid /home/jun/ngrok http 8888 &
sleep 20s
txt=$(GET http://localhost:4040/status)
link=$(echo $txt | grep -o "https://[0-9a-z]*\.ngrok\.io")
echo $link > /home/jun/ngrok_jupyter_email.txt
echo $token >>/home/jun/ngrok_jupyter_email.txt
sleep 20s
#email task
cat /home/jun/ngrok_jupyter_email.txt | mutt -s "ngrok jupyter login remote info" wolff_zheng@hotmail.com
