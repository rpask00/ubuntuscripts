import subprocess
import argparse

from utils import get_mic_id

parser = argparse.ArgumentParser()
parser.add_argument('arg1')
args = parser.parse_args()
mic_volumne = args.arg1

mic_id = get_mic_id()


subprocess.check_output(["amixer", "-c", mic_id, "set", "Mic", mic_volumne]).decode()
