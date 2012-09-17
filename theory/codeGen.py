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
'quadrotorForceMoment.wxm']

#for wxmFile in wxmFiles:
    #if not os.path.exists(wxmFile):
        #raise IOError('file does not exist: %s' % wxmFile)
    #errCode = check_call(['maxima','-b',wxmFile])
    #if not errCode == 0:
        #raise SystemExit('maxima return error code %d for file %s' % (errCode,wxmFile) ) 

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

    text = re.sub('[\r\n]+',';\n',text)
    for match in re.finditer('(P<start>.*)\((?P<x>\d),(?P<y>\d)\)(P<end>.*)',text):
        print match.expand('\g<start>['+str((int(match.group('x'))+1))+','
            + str((int(match.group('x'))+1)) + ']\g<end>')

    text = re.sub('%','',text)
    text = re.sub('\*\*','^',text)

    # process text

    # write cpp file
    cppFile = os.path.join(cppPath,name + '.hpp')
    #print cppFile
    with open(cppFile,'w') as f:
        f.write(text)
        #print text
