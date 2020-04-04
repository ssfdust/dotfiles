#!/bin/env python3
from pathlib import Path
import configparser
import logging

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
logger.warning("开始检查")

def parserini(configpath):
    """处理配置文件"""
    config = configparser.ConfigParser()
    config.read(configpath)
    for path in parsepath(config):
        for default in parsedefault(config):
            if path == default:
                chromepath = configpath.parent.joinpath(path,
                                                        'chrome')
                if not chromepath.exists():
                    chromepath.mkdir()
                return chromepath

def parsepath(config):
    for nsp, section in config.items():
        if 'Path' in section:
            yield section['Path']

def parsedefault(config):
    for nsp, section in config.items():
        if 'Default' in section:
            yield section['Default']

def get_profile_path():
    """获取火狐ini路径"""
    firefox_dir = Path.home().joinpath(
        '.mozilla', 'firefox')
    return firefox_dir.joinpath('profiles.ini')

def readcss():
    scriptpath = Path(__file__).parent
    csspath = scriptpath.joinpath('photon-australis',
                                  'userChrome-dark.css')
    with open(csspath, 'r') as f:
        return f.readlines()

def main():
    profile = get_profile_path()
    logger.warning(f"配置文件路径位于{profile}")
    csspath = parserini(profile).joinpath('userChrome.css')
    logger.warning(f"css配置文件路径位于{csspath}")
    with open(csspath, 'w') as f:
        for line in readcss():
            f.write(line)


if __name__ == '__main__':
    main()
