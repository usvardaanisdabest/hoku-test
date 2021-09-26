#wget https://raw.githubusercontent.com/usvardaanisdabest/nodejs-test/main/2.sh && chmod +x 2.sh
#nohup ./2.sh &
#nohup python3 -m http.server 8080 &
service apache2 start && service mysql start
socat tcp-listen:$PORT,reuseaddr,fork tcp:localhost:80
