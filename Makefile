all: .prepared secrets.yml
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key install.yml

headless: .prepared secrets.yml
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key -e @secrets.yml --tags env,fontconfig,kitty,lf,mbsync,msmtp,mycli,neomutt,neovim,nushell,pacman,password-store,profile,pueue,refind,starship,systemd,wayfire,zellij,dbg install.yml

desktop: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key -e @secrets.yml --tags firefox,gnupg,icons install.yml

starship: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags starship install.yml

nushell: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags nushell install.yml

pueue: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags pueue install.yml

neomutt: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags neomutt install.yml

password-store: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags password-store install.yml

mycli: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags mycli install.yml

msmtp: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags msmtp install.yml

mbsync: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags mbsync install.yml

firefox: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags firefox install.yml

lf: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags lf install.yml

kitty: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags kitty install.yml

fontconfig: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags fontconfig install.yml

gnupg: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags gnupg install.yml

env: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags env install.yml

profile: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags profile install.yml

wayfire: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags wayfire install.yml

zellij: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags zellij install.yml

icons: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags icons install.yml

neovim: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags neovim install.yml

dbg: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags dbg install.yml

refind: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags refind install.yml

pacman: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags pacman install.yml

systemd: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags systemd install.yml

hidpi: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags hidpi install.yml

update: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key update.yml

.secrets:
	./tools/create_secrets

.prepared: .secrets
	ansible-galaxy collection install community.general ansible.posix kewlfft.aur
	touch .prepared
