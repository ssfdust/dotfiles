#!/bin/env python
import urllib.request
import shutil
import getpass
import os
from shutil import which
import pkg_resources
import subprocess
import sys
import re
from pathlib import Path
try:
    from crontab import CronTab
except ImportError:
    print("Please run `pip install python-crontab` first.")
    sys.exit(-1)


def get_cron_cmd() -> str:
    prefix = []
    http_proxy = os.environ.get("HTTP_PROXY")
    https_proxy = os.environ.get("HTTPS_PROXY")
    if http_proxy:
        prefix.append(f"HTTP_PROXY={http_proxy}")
    if https_proxy:
        prefix.append(f"HTTPS_PROXY={https_proxy}")
    pre_str = "{} ".format(" ".join(prefix)) if prefix else ""
    rsinc = Path(which("rsinc"))
    return f"{pre_str}/usr/bin/flock -n /tmp/rsinc.lock {rsinc} -Da"


def create_cront() -> None:
    with CronTab(user=True) as cron:
        if not any(cron.find_command("rsinc")):
            cmd = get_cron_cmd()
            job = cron.new(command=cmd)
            job.minutes.every(5)


def download_rclone() -> None:
    url = "https://rclone.org/install.sh"
    filename = "/tmp/install.sh"
    with urllib.request.urlopen(url) as r, open(filename, "wb") as f:
        shutil.copyfileobj(r, f)


def install_rclone() -> None:
    if os.path.exists("/tmp/install.sh"):
        passwd = getpass.getpass(f"[sudo] password for {getpass.getuser()}:")
        os.system(f"echo {passwd} | sudo -S bash /tmp/install.sh")
    else:
        raise FileNotFoundError("rclone install script is not found.")


def install_rsinc() -> None:
    subprocess.check_call(
        [
            sys.executable,
            "-m",
            "pip",
            "install",
            "git+https://github.com/ConorWilliams/rsinc",
        ]
    )


def check_rclone_config() -> bool:
    process = subprocess.run(["rclone", "config", "file"], capture_output=True)
    output = process.stdout.decode("utf8").split()
    for path in output:
        if re.match("/^(\/[^\/]+){0,2}\/?$/gm", path):
            break
    if os.path.exists(path):
        return True
    else:
        return False


def mksymbollink() -> None:
    rsinc_dir = Path(Path.home(), "dotfiles/rsinc").absolute()
    config_path = Path(Path.home(), ".rsinc").absolute()
    if not config_path.exists():
        cmd = f"ln -sf {rsinc_dir} {config_path}"
        os.system(cmd)


def main() -> None:
    if not which("rclone"):
        print("Downloading rclone ...")
        download_rclone()
        print("Installing ...")
        install_rclone()
    installed = [pkg.key for pkg in pkg_resources.working_set]
    if "rsinc" not in installed:
        install_rsinc()
    # config rclone
    if not check_rclone_config():
        os.system("rclone config")
    # sync from remote
    print("Sync...")
    os.system("rclone sync dropbox: ~/Dropbox")
    print("link configs...")
    mksymbollink()
    print("Making cron job ...")
    create_cront()


if __name__ == "__main__":
    main()
