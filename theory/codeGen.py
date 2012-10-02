#!/usr/bin/env python
import os
import re
from subprocess import check_call

srcPath = os.path.join(os.path.pardir,'src')
sciPath = os.path.join(srcPath,'gen_sci')
cppPath = os.path.join(srcPath,'gen_cpp')
fortranPath = os.path.join(srcPath,'gen_fortran')

wxmFiles = [
'dynamicsWindFrame.wxm',
'dynamicsBodyFrame.wxm',
'navigationEuler.wxm',
'navigationEquations.wxm',
'quadrotorWindFrame.wxm',
'quadrotorBodyFrame.wxm',
'quadrotorForceMoment.wxm'
]

for wxmFile in wxmFiles:
    if not os.path.exists(wxmFile):
        raise IOError('file does not exist: %s' % wxmFile)
    errCode = check_call(['maxima','-b',wxmFile])
    if not errCode == 0:
        raise SystemExit('maxima return error code %d for file %s' % (errCode,wxmFile) ) 

# find fortran files
fortranFiles = []
for fileName in os.listdir(fortranPath):
    fortranFiles.append(os.path.join(fortranPath,fileName))

def indexReplace(match):
    x = int(match.group('x')) - 1
    y = int(match.group('y')) - 1
    return '(%d,%d)' % (x,y)

def trigReplace(match):
    trig = match.group('trig')
    var = match.group('var')
    return trig + var.title() 

# process fortran files
for fileName in fortranFiles:

    # filename parts
    base = os.path.splitext(
        os.path.basename(fileName))
    name = base[0]
    ext = base[1]

    # read fortran file
    with open(fileName,'r') as f:
        text = f.read()

    # process text

    # remove % before greek variables
    text = re.sub('%','',text) 

    # cleanup end of line
    text = re.sub('[\r\n]+',';\n',text)

    # remove 0 lines
    text = re.sub('.*=\s*0\s*;\n','',text) 

    # fix indices for boost style
    text = re.sub('\((?P<x>\d),(?P<y>\d)\)', indexReplace, text)

    # make trig symbols sin(cos) look like sinCos so they can be computed once by the program
    text = re.sub('(?P<trig>sin|cos|tan|sec|cot|csc)\((?P<var>\w+)\)',trigReplace,text)

    # fix exponent
    text = re.sub('\*\*','^',text)

    # use aa for a*a in quaterions
    text = re.sub('(?P<lead>[^\w])(?P<var>[abcd])\^2', '\g<lead>\g<var>\g<var>', text)

    # write cpp file
    cppFile = os.path.join(cppPath,name + '.hpp')
    #print cppFile
    with open(cppFile,'w') as f:
        f.write(text)
