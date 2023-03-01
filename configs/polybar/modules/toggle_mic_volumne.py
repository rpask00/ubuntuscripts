import subprocess
from mic import get_mic_volume

moc_volumne = get_mic_volume()

if moc_volumne == '0%':
    subprocess.check_output(["amixer", "-c", "1", "set", "Mic", "60"]).decode()
else:
    subprocess.check_output(["amixer", "-c", "1", "set", "Mic", "0"]).decode()
