import pyautogui
import random

type_interval = random.uniform(0.1, 0.5)
# Get the size of the primary monitor.
screenWidth, screenHeight = pyautogui.size()

# Move the mouse to XY coordinates.
pyautogui.moveTo(100, 150, duration=type_interval)

# Click the mouse.
pyautogui.click(100, 150, duration=type_interval, button='right')

# Type a string using the keyboard.
pyautogui.write('Hello world!', interval=type_interval)  # type with quarter-second pause in between each key

# Press the 'esc' key.
pyautogui.press('esc')

# Press the 'ctrl-c' hotkey combination.
pyautogui.hotkey('ctrl', 'c')

# Press the 'enter' key.
pyautogui.press('enter')