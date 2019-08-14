#!/usr/bin/env python3
import re
import socket
from subprocess import check_output


def eval_position(position, status):
    try:
        if status[position] == 1:
            return 1
        else:
            return 0
    except IndexError:
        return 0


thing = check_output(["/usr/bin/vcgencmd", "get_throttled"]).strip()
thing = re.sub(b'throttled=', b'', thing)
scale = 16
num_of_bits = 8
thing = b'0x50005'
status = list(bin(int(thing, scale))[2:].zfill(num_of_bits)[::-1])

status_dict = {'uv': eval_position(0, status),
               'afc': eval_position(1, status),
               'ct': eval_position(2, status),
               'euv': eval_position(16, status),
               'eafc': eval_position(17, status),
               'et': eval_position(18, status)}

metrics = "throttling,host={} ".format(socket.gethostname())
metrics = metrics+"under_voltage={uv},arm_frequency_capped={afc},currently_throttled={ct},ever_under_voltage={euv},ever_arm_frequency_capped={eafc},ever_throttled={et}".format(**status_dict)
print(metrics)

