export alias l = ls
export alias ll = ls -l
export alias ldu = ls -ld
export alias la = ls -a
export alias lla = ls -al
export alias ssh = kitty +kitten ssh
export alias mycli = ^mycli --myclirc ~/.config/mycli/myclirc
export alias pcargo = sudo podman run --name cargo_builder -u 1000 --rm -ti -v $"(pwd | str trim):/source" -v $"(mkdir target/rocky;pwd | str trim)/target/rocky:/source/target" docker.io/ssfdust/rockylinux-rust:8.5-1.60.0 cargo 
