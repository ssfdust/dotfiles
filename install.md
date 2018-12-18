Arch配置详情
=============

1. 安装base-devel,bc,v2ray,aria2,tmux,zsh,mosh,sudo,neovim,thefuck
   ```
   pacman -S v2ray bc base-devel aria2 tmux zsh mosh sudo neovim thefuck
   ```
2. 设置locale，hostname
   修改locale,新增LANG
   ```
   locale-gen
   ```
3. 设置时区
   ```
   timedatectl set-timezone Asia/Shanghai
   ```
4. 新增用户
   ```
   useradd -m -g users -G wheel,docker ssfdust
   passwd ssfdust
   visudo 修改wheel用户组
   ```
   本地：
   ```
   ssh-copy-id -i ~/.ssh/private/id_rsa.pub ssfdust@$remoteip
   ```
   本地修改ssh/config文件，新增登录节点
5. 修改pacman.conf和makepkg.conf

   官方源都修改SigLevel开启multi-library
   ```
   [core]
   SigLevel = PackageRequired
   Include = /etc/pacman.d/mirrorlist
   [xyne-x86_64]
   # A repo for Xyne's own projects: https://xyne.archlinux.ca/projects/
   # Packages for the "x86_64" architecture.
   # Note that this includes all packages in [xyne-any].
   SigLevel = Required
   Server = https://xyne.archlinux.ca/repos/xyne
   ```

   makepkg.conf:
   ```
   DLAGENTS=('file::/usr/bin/curl -gqC - -o %o %u'
             'ftp::/usr/bin/aria2c -UWget -x10 -s10 %u -o %o'
             'http::/usr/bin/aria2c -UWget -x10 -s10 %u -o %o'
             'https::/usr/bin/aria2c -UWget -x10 -s10 %u -o %o'
             'rsync::/usr/bin/rsync --no-motd -z %u %o'
             'scp::/usr/bin/scp -C %u %o')
   ```
6. 安装powerpill以及bauerbill
   ```
   pacman -S powerpill bauerbill
   ```
7. 用新配置sshd,切换到个人用户
   ```
   scp ~/Dropbox/备份/sshd/sshd_config $HOST:/etc/ssh/sshd_config
   systemctl restart sshd
   ```
8. 安装caddy-bin以及rainbarf-git
   ```
   sudo bb-wrapper -S caddy-bin rainbarf-git wemux-git --aur
   ```
   修改/etc/wemux/wemux.conf
   ```
   host_list=(ssfdust)
   ```
9. clone配置文件
   ```
   git clone https://github.com/ssfdust/dotfiles.git
   ```
   先给自己用户配置tmux, neovim, zsh
   给root配置neovim, zsh
   看网络情况执行mosh-server
   ```
   mosh-server
   ```
10. Caddy配置
   ```
   sudo mkdir -p /var/www/main
   sudo chown ssfdust:users /var/www/main
   ```
   /etc/caddy/conf.d/ssfdust.conf
   ```
   www.ssfdust.tk {
       log /var/log/caddy/access.log
       errors /var/log/caddy/errors.log
       root /var/www/main
       index index.html
       proxy /v2ray localhost:12345 {
           websocket
           header_upstream -Origin
       }
   }
   ```
