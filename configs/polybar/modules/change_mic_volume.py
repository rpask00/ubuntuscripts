import subprocess
import argparse


parser = argparse.ArgumentParser()
parser.add_argument('arg1')
args = parser.parse_args()
mic_volumne = args.arg1


subprocess.check_output(["amixer", "-c", "3", "set", "Mic", mic_volumne]).decode()
