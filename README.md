# netbeans-java7-X-Window
Docker Machineを使用した、Netbeansの実行環境です。  
コンテナ上でX ClientのNetbeansを動かし、手元のマシンまでsshで転送します。  
手元の/Usersが共有されて、Netbeansからも/Usersでアクセスできます(Mac)。  
VMの名称は"dev"を想定しています。
コンテナ上のアカウントは、docker/dockerです。

## ビルド
Docker Machineでdevという仮想マシンを作っていれば、Mac側のterminalから  
``docker `docker-machine config dev` build -t netbeans-java7 $PWD/src/docker/netbeans-java7-X-Window``   
とします。$PWD/src/docker/netbeans-java7-X-Window はこのファイルがあるディレクトリを指すように。  

## 起動
scriptディレクトリのscriptを使って、  
``docker-start-container netbeans-java7 eclipse``  
のようにします。netbeans-java7は、ビルドの時 -t でつけた名前。  
netbeansを終了させても、コンテナや仮想マシンは動いたままなので、適宜終了させたほうがよいかと。

scriptディレクトリには、起動用script(docker-start-container)と接続用script(docker-x)があります。使い方は、見ればわかると思うので、略。

開発はMac版Virtual Boxです。