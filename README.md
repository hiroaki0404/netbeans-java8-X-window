# netbeans-java8-X-Window
Dockerを使用した、Netbeansの実行環境です。Chromeも入っています。  
コンテナ上でX ClientのNetbeansを動かし、手元のマシンまでsshで転送します。  
コンテナ上のアカウントは、docker/dockerです。

## ビルド
Docker for Macがインストールしてある環境であれば、Mac側のterminalから  
``docker build -t nb8 .``   
とします。このファイルがあるディレクトリで実行します。  

## 起動
``docker run -P -d -v `pwd`:/src nb8``  
のようにします。nb8は、ビルドの時 -t でつけた名前です。  
netbeansを終了させても、コンテナや仮想マシンは動いたままなので、適宜終了させたほうがよいかと。

``docker ps``
とやって、sshのポートがどこに転送されたかを調べます。
``slogin -Y docker@localhost -p 転送先ポート``
とやって、コンテナ内にログインします。X Windowの転送が有効になっているので、NetbeansやChromeのWindowが問題なく開きます。

開発はDocker for Macです。