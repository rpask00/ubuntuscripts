import subprocess
import re


# Uruchamia polecenie amixer -c 1 i przechwytuje wynik jako zmienną tekstową

def get_mic_volume():
    output = subprocess.check_output(["amixer", "-c", "2"]).decode()
    output = output.split('\n')[-2]

    pattern = r'\[(.*?)\]'
    match = re.search(pattern, output)

    if match:
        return match.group(1).strip()
    else:
        return "---"


print(get_mic_volume())