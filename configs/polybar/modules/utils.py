import re
import subprocess


def get_mic_id():
    output = subprocess.check_output(['pactl', 'list'], text=True)
    text = subprocess.check_output(['grep', 'LCS_USB_Audio'], input=output, text=True)
    text = subprocess.check_output(['head', '-n', '1'], input=text, text=True)

    device_id = re.search(r'device_id="(\d+)"', text).group(1)
    return device_id


def get_mic_volume():
    try:
        mic_id = get_mic_id()
    except:
        return "---"

    output = subprocess.check_output(["amixer", "-c", mic_id]).decode()
    output = output.split('\n')[-2]

    pattern = r'\[(.*?)\]'
    match = re.search(pattern, output)

    if match:
        return match.group(1).strip()
    else:
        return "---"
