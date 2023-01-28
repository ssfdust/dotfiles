all: .prepared secrets.yml
	ansible-playbook -K -e @secrets.yml install.yml

headless: .prepared secrets.yml
	ansible-playbook -K -e @secrets.yml --tags aria2,env,fcitx5,fontconfig,kitty,lf,mako,mbsync,msmtp,mycli,neomutt,neovim,nushell,pacman,pamd,password-store,profile,pueue,refind,sddm,starship,systemd,waybar,wayfire,wlogout,wofi,zellij install.yml

desktop: .prepared secrets
	ansible-playbook -K -e @secrets.yml --tags firefox,gnupg,icons install.yml

secrets.yml:
	@cp secrets.yml.template secrets.yml
	@echo "YOU MUST EDIT THE secrets.yml FILE"
	@exit 1

starship: .prepared
	ansible-playbook --tags starship install.yml

osync: .prepared
	ansible-playbook --tags osync install.yml

nushell: .prepared
	ansible-playbook --tags nushell install.yml

pueue: .prepared
	ansible-playbook --tags pueue install.yml

neomutt: .prepared
	ansible-playbook -e @secrets.yml --tags neomutt install.yml

password-store: .prepared
	ansible-playbook --tags password-store install.yml

mycli: .prepared
	ansible-playbook --tags mycli install.yml

msmtp: .prepared
	ansible-playbook --tags msmtp install.yml

mbsync: .prepared
	ansible-playbook --tags mbsync install.yml

mako: .prepared
	ansible-playbook --tags mako install.yml

firefox: .prepared
	ansible-playbook --tags firefox install.yml

lf: .prepared
	ansible-playbook --tags lf install.yml

kitty: .prepared
	ansible-playbook --tags kitty install.yml

fontconfig: .prepared
	ansible-playbook --tags fontconfig install.yml

gnupg: .prepared
	ansible-playbook -K --tags gnupg install.yml

aria2: .prepared
	ansible-playbook --tags aria2 install.yml

env: .prepared
	ansible-playbook --tags env install.yml

profile: .prepared
	ansible-playbook --tags profile install.yml

wlogout: .prepared
	ansible-playbook --tags wlogout install.yml

fcitx5: .prepared
	ansible-playbook --tags fcitx5 install.yml

waybar: .prepared
	ansible-playbook --tags waybar install.yml

wayfire: .prepared
	ansible-playbook --tags wayfire install.yml

wofi: .prepared
	ansible-playbook --tags wofi install.yml

qt: .prepared
	ansible-playbook --tags qt install.yml

zellij: .prepared
	ansible-playbook -K --tags zellij install.yml

icons: .prepared
	ansible-playbook --tags icons install.yml

neovim: .prepared
	ansible-playbook --tags neovim install.yml

refind: .prepared
	ansible-playbook -K --tags refind install.yml

pacman: .prepared
	ansible-playbook -K --tags pacman install.yml

sddm: .prepared
	ansible-playbook -K --tags sddm install.yml

pamd: .prepared secrets.yml
	ansible-playbook -e @secrets.yml -K --tags pamd install.yml

systemd: .prepared secrets.yml
	ansible-playbook -e @secrets.yml -K --tags systemd install.yml

.prepared:
	ansible-galaxy collection install community.general ansible.posix
	touch .prepared
