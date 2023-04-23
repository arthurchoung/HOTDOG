#!/usr/bin/python3

import re
import os
import vobject

print('''\
panelHorizontalStripes
panelText:''
panelText:'Contacts'
panelText:''
''', end='')

arr = []

for path in os.listdir('.'):
    if not path.lower().endswith('.vcf'):
        continue
    vcard = None
    try:
        with open(path, 'r') as f:
            vcard = vobject.readOne(f.read())
    except:
        pass
    if not vcard:
        continue
    elt = {}
    arr.append(elt)
    elt['path'] = path
    elt['fullName'] = ''
    try:
        elt['fullName'] = vcard.contents['fn'][0].value
    except:
        pass

#return {vcard.contents['fn'][0].value: [tel.value for tel in vcard.contents['tel']] }

def sortLettersBeforeNumbers(a):
    key = ''
    try:
        key = a['fullName']
    except:
        pass

    order = 'a'
    if len(key) > 0:
        if key[0].isdigit():
            order = 'b'
    else:
        order = 'c'
    return (order, key.lower())

arr = sorted(arr, key=sortLettersBeforeNumbers)

count = len(arr)
i = 0
buttonType = 'panelTopButton'
while i < count:
    if i == 1:
        buttonType = 'panelMiddleButton'
    if i == count-1:
        if count == 1:
            buttonType = 'panelSingleButton'
        else:
            buttonType = 'panelBottomButton'
    elt = arr[i]
    print('''\
=fullName%d=%s
=path%d=%s
%s:(fullName%d) message:[NSArray|addObject:'hotdog'|addObject:'VCFPanel'|addObject:(path%d)|runCommandInBackground]
''' % (i, elt['fullName'], i, elt['path'], buttonType, i, i), end='')
    i += 1

if count == 0:
    print('''\
panelText:'No contacts found.'
''', end='')

