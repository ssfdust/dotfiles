#!/bin/python
from pathlib import Path
import subprocess
import shutil

HOME_TARGETS = ["password-store"]

CONFIG_TARGETS = ["neomutt", "msmtp", "mbsync"]

COPY_TARGETS = ["gnupg"]


dotspath = Path(__file__).parent.parent.absolute()


def create_symbolink(src, dst):
    subprocess.run(["ln", "-s", str(src), str(dst)])


def link_targets(targets, template=""):
    for target in targets:
        source_path = Path(dotspath, target)
        target_path = Path(Path.home(), template.format(target))
        if source_path.exists() and not target_path.exists():
            print(f"linking {source_path} to {target_path}")
            create_symbolink(source_path, target_path)

def copy_targets(targets, template=""):
    for target in targets:
        source_path = Path(dotspath, target)
        target_path = Path(Path.home(), template.format(target))
        for src_file in source_path.iterdir():
            target_file = target_path.joinpath(src_file.name)
            if src_file.exists() and not target_file.exists():
                print(f"Copying {src_file} to {target_file}")
                shutil.copymode(src_file, target_file)


if __name__ == "__main__":
    link_targets(HOME_TARGETS, ".{}")
    link_targets(CONFIG_TARGETS, ".config/{}")
    copy_targets(COPY_TARGETS, ".{}")
