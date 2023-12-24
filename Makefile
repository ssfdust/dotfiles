HEADLESSTAGS := pacman,bootloader,systemd,terminal,neovim,neomutt,wayfire,gnupg,drop

all: .prepared secrets.yml
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags $(HEADLESSTAGS) install.yml

bootstrap: .prepared secrets.yml
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags pacman,bootloader install.yml

pacman: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags pacman install.yml

bootloader: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags bootloader install.yml

systemd: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags systemd install.yml

terminal: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags terminal install.yml

neovim: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags neovim install.yml

neomutt: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags neomutt install.yml

gnupg: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags gnupg install.yml

wayfire: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags wayfire install.yml

drop: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags drop install.yml

hidpi: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags hidpi install.yml

update: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key update.yml

.prepared: .secrets
	ansible-galaxy collection install community.general ansible.posix kewlfft.aur
	touch .prepared

.secrets:
	./tools/create_secrets
