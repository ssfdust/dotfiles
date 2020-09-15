#!/bin/python
from pathlib import Path
import subprocess

HOME_TARGETS = ["password-store"]

CONFIG_TARGETS = ["neomutt"]


dotspath = Path(__file__).parent.parent.absolute()


def create_symbolink(src, dst):
    subprocess.run(["ln", "-s", str(src), str(dst)])


def link_targets(targets, template=""):
    for target in targets:
        source_path = Path(dotspath, target)
        target_path = Path(Path.home(), template.format(target))
        if source_path.exists() and not target_path.exists():
            create_symbolink(source_path, target_path)


if __name__ == "__main__":
    link_targets(HOME_TARGETS, ".{}")
    link_targets(CONFIG_TARGETS, ".config/{}")
