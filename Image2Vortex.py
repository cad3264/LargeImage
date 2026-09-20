from PIL import Image
import tkinter as tk
from tkinter import filedialog

root = tk.Tk()
root.withdraw()

file_path = filedialog.askopenfilename(title="What image to convert?")
assert file_path

savefile = filedialog.asksaveasfile(title="Where to save the file?",defaultextension=".luau",filetypes=[("Vortex scripts",".luau")])
assert savefile

img = Image.open(file_path).convert("RGB")

pixels = img.load()
w, h = img.size

final = ""

for x in range(w):
    for y in range(h):
        r, g, b = pixels[x, y]
        if len(final) != 0:
            final += "+"
        final += str(r) + "_" + str(g) + "_" + str(b)

print(final)

savefile.write("return {\"" + final + "\"," + str(w) + "," + str(h) + "}")
savefile.close()
