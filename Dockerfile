FROM densuke/ubuntu-jp-remix:trusty
MAINTAINER hiroaki0404@gmail.com

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -y wget apt-file && \
    apt-file update && apt-get install -y software-properties-common  && \
    wget -q https://www.ubuntulinux.jp/ubuntu-ja-archive-keyring.gpg -O- | sudo apt-key add - && \
    wget -q https://www.ubuntulinux.jp/ubuntu-jp-ppa-keyring.gpg -O- | sudo apt-key add - && \
    wget -q https://www.ubuntulinux.jp/sources.list.d/trusty.list -O /etc/apt/sources.list.d/ubuntu-ja.list && \
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list && \
    add-apt-repository ppa:openjdk-r/ppa  && \
    apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y openssh-server xterm xauth x11-xserver-utils openjdk-8-jdk unzip mlterm fontforge fonts-inconsolata mozc-server uim uim-mozc fonts-takao  google-chrome-stable && \
    ln -s /usr/bin/google-chrome /usr/local/bin/chrome && \
    sed -i 's#/usr/bin#/bin#' /etc/init.d/dbus && \
    locale-gen en_US.UTF.8
# chrome driver
RUN wget -q -O /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/2.27/chromedriver_linux64.zip && \
    unzip /tmp/chromedriver_linux64.zip -d /usr/local/bin && \
    chmod +x /usr/local/bin/chromedriver

# font
WORKDIR /tmp
RUN mkdir -p /tmp/font /root/.fonts /root/.local/share/fonts
RUN wget -q -O migu-1m.zip 'http://osdn.jp/frs/redir.php?m=jaist&f=%2Fmix-mplus-ipa%2F63545%2Fmigu-1m-20150712.zip'
RUN unzip migu-1m.zip
RUN cp migu-1m-20150712/migu-1m*.ttf /tmp/font
WORKDIR /tmp/font
RUN wget -q https://github.com/google/fonts/raw/master/ofl/inconsolata/Inconsolata-Bold.ttf
RUN wget -q https://github.com/google/fonts/raw/master/ofl/inconsolata/Inconsolata-Regular.ttf
RUN wget -q http://www.rs.tus.ac.jp/yyusa/ricty/ricty_generator.sh
RUN chmod +x ricty_generator.sh && cp /usr/share/fonts/truetype/inconsolata/Inconsolata.* .
RUN ./ricty_generator.sh  -v auto
RUN cp Ricty*.ttf /root/.fonts/

## netbeans
WORKDIR /tmp
RUN wget -q http://download.netbeans.org/netbeans/8.1/final/bundles/netbeans-8.1-linux.sh
RUN chmod +x netbeans-8.1-linux.sh
RUN /tmp/netbeans-8.1-linux.sh --silent
RUN ln -s /usr/local/netbeans-8.1/bin/netbeans /usr/local/bin
RUN sed -i 's/true"/true -J-Dawt.useSystemAAFontSettings=on"/' /usr/local/netbeans-8.1/etc/netbeans.conf
RUN sed -i 's#/usr#/usr/lib/jvm/java-8-openjdk-amd64#' /usr/local/netbeans-8.1/etc/netbeans.conf

ADD run.sh /etc/
RUN chmod +x /etc/run.sh
EXPOSE 22
CMD /etc/run.sh
