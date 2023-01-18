from kittens.tui.handler import result_handler


def main():
    pass

def env_to_str(env):
    """Convert an env list to a series of '--env key=value' parameters and return as a string."""
    # FIXME: running launch with --env params doesn't seem to work - I get this error:
    # Failed to launch child: --env
    # With error: No such file or directory
    # Press Enter to exit.
    # So, skip this for now.
    return ""
    # s = ''
    # for key in env:
    #   s += f"--env {key}={env[key]} "

    # return s.strip()


def cmdline_to_str(cmdline):
    """Convert a cmdline list to a space separated string."""
    s = ""
    for e in cmdline:
        s += f"{e} "

    return s.strip()


def fg_proc_to_str(fg):
    """Convert a foreground_processes list to a space separated string."""
    s = ""
    fg = fg[0]

    # s += f"--cwd {fg['cwd']} {cmdline_to_str(fg['cmdline'])}"
    s += f"{cmdline_to_str(fg['cmdline'])}"

    return s


def convert(session, filepath):
    """Convert a kitty session dict
    into a kitty session file and output it."""
    with open(filepath, "w") as f:
        for os_window in session:
            for tab in os_window["tabs"]:
                f.write(f"new_tab {tab['title']}\n")
                # print('enabled_layouts *)
                f.write(f"layout {tab['layout']}\n")
                # This is a bit of a kludge to set cwd for the tab, as
                if tab["windows"]:
                    f.write(f"cd {tab['windows'][0]['cwd']}\n")

                for w in tab["windows"]:
                    f.write(f"title {w['title']}\n")
                    f.write(
                        f"launch {env_to_str(w['env'])} "
                        f"{fg_proc_to_str(w['foreground_processes'])}\n"
                    )
                    if w["is_focused"]:
                        f.write("focus\n")


def parse_wm_name(session):
    for os_window in session:
        return os_window["wm_name"]


def format_file_name(wmname, filename):
    if filename.endswith(".session"):
        fname = filename.replace(".session", "")
        fname += f"-{wmname}.session"
        return fname


@result_handler(no_ui=True)
def handle_result(args, answer, target_window_id, boss):
    tabid_list = []
    for tab in boss.all_tabs:
        if tab.current_layout.name == "stack":
            tab.last_used_layout()
            tabid_list.append(f"id:{tab.id}")
    session = list(boss.list_os_windows())
    for tabid in tabid_list:
        for tab in boss.match_tabs(tabid):
            tab.goto_layout("stack")
    fname = format_file_name(parse_wm_name(session), args[1])
    convert(session, fname)
