FROM heroku/heroku:20
#ENV DEBIAN_FRONTEND=noninteractive
RUN wget https://raw.githubusercontent.com/usvardaanisdabest/hoku-test/main/1.sh
RUN apt update && apt install apache2 sudo mysql-server php libapache2-mod-php php-mysql php-mbstring php-zip php-curl php-gd php-ldap php-xml php-imagick php-mysql -y
RUN service apache2 start && service mysql start && mysql -e "CREATE DATABASE filerun;" && mysql -e "CREATE USER 'filerun'@'localhost' IDENTIFIED BY 'YOUR-DB-PASSWORD';" && mysql -e "GRANT ALL ON filerun.* TO 'filerun'@'localhost';" && mysql -e "FLUSH PRIVILEGES;"
#RUN sleep 10
#RUN mysql -e "CREATE DATABASE filerun;"
#RUN mysql -e "CREATE USER 'filerun'@'localhost' IDENTIFIED BY 'YOUR-DB-PASSWORD';"
#RUN mysql -e "GRANT ALL ON filerun.* TO 'filerun'@'localhost';"
#RUN mysql -e "FLUSH PRIVILEGES;"
RUN wget https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz && tar -xzf ioncube_loaders_lin_x86-64.tar.gz -C /usr/lib/php
RUN wget https://raw.githubusercontent.com/usvardaanisdabest/hoku-test/main/00-ioncube.ini -O /etc/php/7.4/apache2/conf.d/00-ioncube.ini && wget https://raw.githubusercontent.com/usvardaanisdabest/hoku-test/main/filerun.ini -O /etc/php/7.4/apache2/conf.d/filerun.ini
RUN service apache2 restart && service mysql restart
RUN cd /var/www/html/ && rm index.html && wget -O FileRun.zip https://filerun.com/download-latest && unzip FileRun.zip && chown -R www-data:www-data /var/www/html/
RUN chmod +x 1.sh
RUN useradd -m heroku
RUN passwd -d heroku
RUN echo heroku ALL=NOPASSWD: /sbin/service apache2 restart,/etc/init.d/httpd restart,/sbin/service mysql restart>>/etc/sudoers
RUN chown root:root /usr/bin/sudo && chmod 4755 /usr/bin/sudo
USER heroku
CMD ./1.sh
