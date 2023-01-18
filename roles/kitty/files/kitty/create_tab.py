from kittens.tui.handler import result_handler


def main():
    pass


@result_handler(no_ui=True)
def handle_result(args, answer, target_window_id, boss):
    for tab in boss.all_tabs:
        tab
