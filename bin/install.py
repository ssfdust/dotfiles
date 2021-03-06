#!/bin/python
from pathlib import Path
import subprocess
import shutil

HOME_TARGETS = ["password-store", "xprofile", "xinitrc"]

CONFIG_TARGETS = [
    "neomutt",
    "msmtp",
    "mbsync",
    "alacritty",
    "pueue",
    "dunst",
    "fontconfig",
    "aria2",
    "starship",
    "fcitx5"
]

LINK_ITEM_TARGETS = ["gnupg"]

FCITX = ["fcitx5share"]

dotspath = Path(__file__).absolute().parent.parent


def create_symbolink(src, dst):
    subprocess.run(["ln", "-s", str(src), str(dst)])


def link_targets(targets, template=""):
    for target in targets:
        source_path = Path(dotspath, target)
        target_path = Path(Path.home(), template.format(target))
        if source_path.exists() and not target_path.exists():
            print(f"linking {source_path} to {target_path}")
            create_symbolink(source_path, target_path)


def link_item_targets(targets, template=""):
    for target in targets:
        source_path = Path(dotspath, target)
        target_path = Path(Path.home(), template.format(target))
        for src_file in source_path.iterdir():
            target_file = target_path.joinpath(src_file.name)
            if src_file.exists() and not target_file.exists():
                print(f"linking {src_file} to {target_file}")
                create_symbolink(src_file, target_file)


def advance_copy(src, dest):
    if src.is_dir():
        shutil.copytree(src, dest)
    else:
        shutil.copy2(src, dest)


def copy_targets(targets, template=""):
    for target in targets:
        source_path = Path(dotspath, target)
        target_path = Path(Path.home(), template.format(target))
        for src_file in source_path.iterdir():
            target_file = target_path.joinpath(src_file.name)
            if src_file.exists() and not target_file.exists():
                print(f"Copying {src_file} to {target_file}")
                advance_copy(src_file, target_file)


if __name__ == "__main__":
    link_targets(HOME_TARGETS, ".{}")
    link_targets(CONFIG_TARGETS, ".config/{}")
    link_item_targets(LINK_ITEM_TARGETS, ".{}")
    copy_targets(FCITX, ".local/share/fcitx5")
