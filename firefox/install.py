#!/bin/env python3
"""读取并处理firefox的profiles.ini的文件

每个profiles都有N个ProflieX构成和一个Installxxx构成

例如：
[Install4F96D1932A9F858E]
Default=fc8ptlr3.default-release
Locked=1

[Profile1]
Name=default
IsRelative=1
Path=4z3fjqne.default
Default=1

[Profile0]
Name=default-release
IsRelative=1
Path=fc8ptlr3.default-release

首先判断是否存在Default并且这个Default的值是一个Path，
同时这个Default所在这个Section不是以Profile开头，然后就能
拿到Default Profile的Path
"""
from pathlib import Path
import configparser
import logging
import shutil

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
logger.warning("开始检查")

COPY_TARGETS = ["chrome", "user.js"]
src_path = Path(__file__).absolute().parent


def parserini(configpath):
    """处理配置文件"""
    config = configparser.ConfigParser()
    config.read(configpath)
    directory = configpath.parent
    for path in parsepath(config, directory):
        for default in parsedefault(config, directory):
            defaultpath = Path(directory, default)
            if path == default:
                return defaultpath


def parsepath(config, directory):
    """从每一个Section中提取出确实存在的文件Path"""
    for nsp, section in config.items():
        if "Path" in section and Path(directory, section["Path"]).exists():
            yield section["Path"]


def parsedefault(config, directory):
    """首先判断是否存在Default并且这个Default的值是一个Path，
    同时这个Default所在这个Section不是以Profile开头，然后就能
    拿到Default的配置文件
    """
    for nsp, section in config.items():
        if (
            "Default" in section
            and not nsp.startswith("Profile")
            and Path(directory, section["Default"]).exists()
        ):
            yield section["Default"]


def get_profile_path():
    """获取火狐ini路径"""
    firefox_dir = Path.home().joinpath(".mozilla", "firefox")
    return firefox_dir.joinpath("profiles.ini")


def copyto(src, dst):
    src_ = Path(src_path, src)
    dst = Path(dst, src)
    if not dst.exists():
        logger.warning(f"复制{src_}到{dst}")
        _copyto(src_, dst)
    else:
        logger.warning(f"跳过{src_}")


def _copyto(src: Path, dst):
    if src.is_dir():
        shutil.copytree(src, dst)
    else:
        shutil.copy(src, dst)


def main():
    profile = get_profile_path()
    logger.warning(f"配置文件路径位于{profile}")
    profilepath = parserini(profile)
    logger.warning(f"Profile文件夹路径位于{profilepath}")
    for target in COPY_TARGETS:
        copyto(target, profilepath)


if __name__ == "__main__":
    main()
