"""
rearrange partations

Format :

python3 file_sorter.py input.file output.file
"""


import sys

if len(sys.argv) > 1:
    name = sys.argv[1]
    with open(name, 'r') as f:
        data = f.read()

data = list(map(int, data.split()))

x = [[d, i] for i, d in enumerate(data, 1)]
x.sort()
out_name  = sys.argv[2]
with open(out_name, "w") as f:
    for c in x:
        f.write(str(c[1]) + "\n")