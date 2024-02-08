#!/usr/bin/env python3
import re
import sys

colors = ["black", "red", "green", "yellow", "blue", "magenta", "cyan", "white"]


def convert_ansi_to_tmux(input_string):
    result = ""
    while True:
        match = re.search(r"(.*?)(\x1b\[((\d+;?)+)m)", input_string)
        if not match:
            break
        result += f"{match.group(1)}#["
        sgr = match.group(3).split(";")
        for i in range(len(sgr)):
            if sgr[i] == "0":
                result += "default"
            elif sgr[i] == "1":
                result += "bright"
            elif re.match(r"(3|4|9|10)(\d)", sgr[i]):
                code_type, code_value = re.match(r"(3|4|9|10)(\d)", sgr[i]).groups()
                if code_type == "3":
                    result += "fg="
                elif code_type == "4":
                    result += "bg="
                elif code_type == "9":
                    result += "fg=bright"
                elif code_type == "10":
                    result += "bg=bright"

                if code_value == "8":  # SGR 38 or 48
                    i += 1
                    if sgr[i] == "5":
                        i += 1
                        result += f"colour{sgr[i]}"
                    elif sgr[i] == "2":
                        result += "#{:02X}{:02X}{:02X}".format(
                            int(sgr[i + 1]), int(sgr[i + 2]), int(sgr[i + 3])
                        )
                        i += 3
                    else:
                        raise ValueError(f"Invalid SGR 38;{sgr[i]}")
                elif code_value == "9":
                    result += "default"
                else:
                    result += colors[int(code_value)]
            else:  # Unknown/ignored SGR code
                continue
            result += ","
        result += "]"
        input_string = input_string[match.end() :]

    result += input_string
    return result


if __name__ == "__main__":
    input_data = sys.stdin.read()
    output_data = convert_ansi_to_tmux(input_data)
    print(output_data)
