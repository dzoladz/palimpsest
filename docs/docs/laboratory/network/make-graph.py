from graphviz import Source
from pathlib import Path
import os

input_file = str(
    Path(Path.cwd(),
         'lab_network.dot'
         )
)

output_file = str(
    Path(Path.cwd(),
         'img',
         'lab_network.png'
         )
)

os.system('dot -Tpng ' + input_file + ' -o ' + output_file)

source = Source.from_file(input_file)
source.view()
