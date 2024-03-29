HEADLESSTAGS := proxy,pacman,bootloader,system,terminal,neovim,neomutt,container,gnupg,virtualization,wayfire,drop
HOSTNAME := RedLotusX

all: .prepared
	ansible-playbook -e hostname=$(HOSTNAME) -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags $(HEADLESSTAGS) install.yml

bootstrap: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags proxy,pacman install.yml

pacman: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags pacman install.yml

bootloader: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags bootloader install.yml

system: .prepared
	ansible-playbook -e hostname=$(HOSTNAME) -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags system install.yml

proxy: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags proxy install.yml

terminal: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags terminal install.yml

neovim: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags neovim install.yml

neomutt: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags neomutt install.yml

gnupg: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags gnupg install.yml

container: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags container install.yml

wayfire: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags wayfire install.yml

virtualization: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags virtualization install.yml

drop: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags drop install.yml

hidpi: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags hidpi install.yml

firewalld: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key --tags firewalld install.yml

update: .prepared
	ansible-playbook -e@./.secrets/passwords.yml --vault-pass-file ./.secrets/private_key update.yml

.prepared:
	./tools/create_secrets
	ansible-galaxy collection install kewlfft.aur
	touch .prepared
