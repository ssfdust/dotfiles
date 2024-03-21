#!/bin/env python3
import socket
import json as js
import os
import configparser
from pathlib import Path
from ast import literal_eval
import subprocess

def get_msg_template(method: str):
    # Create generic message template
    message = {}
    message["method"] = method
    message["data"] = {}
    return message

class WayfireSocket:
    def __init__(self, socket_name):
        self.client = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        self.client.connect(socket_name)

    def read_exact(self, n):
        response = bytes()
        while n > 0:
            read_this_time = self.client.recv(n)
            if not read_this_time:
                raise Exception("Failed to read anything from the socket!")
            n -= len(read_this_time)
            response += read_this_time

        return response

    def read_message(self):
        rlen = int.from_bytes(self.read_exact(4), byteorder="little")
        response_message = self.read_exact(rlen)
        response = js.loads(response_message)
        if "error" in response:
            raise Exception(response["error"])
        return response

    def send_json(self, msg):
        data = js.dumps(msg).encode('utf8')
        header = len(data).to_bytes(4, byteorder="little")
        self.client.send(header)
        self.client.send(data)
        return self.read_message()

    def watch(self, events = None):
        message = get_msg_template("window-rules/events/watch")
        if events:
            message["data"]["events"] = events
        return self.send_json(message)

    def close(self):
      self.client.close()

    def query_output(self, output_id: int):
        message = get_msg_template("window-rules/output-info")
        message["data"]["id"] = output_id
        return self.send_json(message)


def get_swayidle_cmd():
    config = configparser.ConfigParser()
    default_config = "~/.config/wayfire.ini"
    wayfire_config = os.getenv("WAYFIRE_CONFIG_FILE", default_config)
    wayfire_config_path = Path(wayfire_config).expanduser()
    config.read(wayfire_config_path)
    return config["autostart"]["swayidle"]


class SwayIdleProc:
    def __init__(self, pid: int, idle_time: int):
        self.pid = pid
        self.cmd = get_swayidle_cmd()
        self.proc = subprocess.Popen(self.cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        self._kill_all_swayidle()

    def _kill_all_swayidle(self):
        for dir in Path("/proc").iterdir():
            try:
                exe_path = dir.joinpath("exe")
                if dir.is_dir() and dir.name.isdigit() and exe_path.exists():
                    binary_path = os.readlink(exe_path)
                    if str(binary_path).endswith("swayidle"):
                        pid = int(dir.name)
                        os.kill(pid, 9)
            except PermissionError:
                continue

    def start(self):

    def __str__(self):
        return f"PID: {self.pid}, Idle time: {self.idle_time}"

def control_swayidle(method: str):
    # kill all running swayidle processes

    if method == "start":
        config = configparser.ConfigParser()
    elif method == "stop":
        os.system("pkill swayidle")


def main():
    addr = os.getenv('WAYFIRE_SOCKET')
    events_sock = WayfireSocket(addr)
    events_sock.watch(['view-mapped'])
    while True:
        msg = events_sock.read_message()
        if msg["event"] == "view-focused" and msg["view"]["fullscreen"] == True:
            print("view-focused")


if __name__ == '__main__':
    control_swayidle("start")
