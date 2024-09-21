#/usr/bin/env python3
import argparse
import subprocess
import time
import random

parser = argparse.ArgumentParser()
parser.add_argument('-c', '--cmd', required=True)
parser.add_argument('-d', '--delay', type=str, default="0")
parser.add_argument('-s', '--delay_strategy', type=str, default="fixed", choices=["fixed", "uniform", "exponential", "gauss"])
parser.add_argument('-r', "--repeat", type=int, default=1)

args = parser.parse_args()

def calc_random_delay(params, dist):
    if dist == "fixed":
        return int(params)
    if dist == "uniform":
        params_list = params.split(",")
        a = 0 if len(params_list) == 1 else int(params_list[0])
        b = int(params_list[-1])
        return random.uniform(a, b)
    if dist == "exponential":
        return random.expovariate(float(params))
    if dist == "gauss":
        mean, std = params.split(",")
        return random.gauss(float(mean), float(std))
    return 0

while True:
    delay = calc_random_delay(args.delay, args.delay_strategy)
    print(time.strftime("%Y-%m-%d %H:%M:%S"), f"waiting {delay} seconds")
    time.sleep(delay)
    print(time.strftime("%Y-%m-%d %H:%M:%S"), f"running {args.cmd}")
    subprocess.run(args.cmd, shell=True)
    args.repeat -= 1
    print(time.strftime("%Y-%m-%d %H:%M:%S"), f"remain rounds {args.repeat}")
    if args.repeat == 0:
        break
