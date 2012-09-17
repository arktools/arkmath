#!/usr/bin/env python
import os
import re

srcPath = os.path.join(os.path.pardir,'src')
sciPath = os.path.join(srcPath,'gen_sci')
cppPath = os.path.join(srcPath,'gen_cpp')
fortranPath = os.path.join(srcPath,'gen_fortran')

# find fortran files
fortranFiles = []
for fileName in os.listdir(fortranPath):
    fortranFiles.append(os.path.join(fortranPath,fileName))

# process fortran files
for fileName in fortranFiles:
    base = os.path.splitext(
        os.path.basename(fileName))
    name = base[0]
    ext = base[1]

    # read fortran file
    with open(fileName,'r') as f:
        text = f.read()

    # process text

    # write cpp file
    cppFile = os.path.join(cppPath,name + '.hpp')
    print cppFile
    with open(cppFile,'w') as f:
        f.write(text)
