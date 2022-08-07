#!/usr/bin/python3

import sys
import re
import vobject

def encodeQuotes(arg):
    if arg == None:
        return ""
    arg = re.sub(r'\s', r' ', arg)
    arg = arg.replace('\\', '\\\\');
    arg = arg.replace("'", "\\'");
    return arg

path = ''
data = None
if len(sys.argv) < 2:
    data = sys.stdin.read()
else:
    path = sys.argv[1]
    f = open(path, 'r')
    data = f.read()
    f.close()

vcard = vobject.readOne(data)

print('''\
panelHorizontalStripes
panelText:''
''', end='')

if path:
    print('''\
panelText:'%s'
panelText:''
''' % (encodeQuotes(path)), end='')


try:
    for a in vcard.contents['fn']:
        text = encodeQuotes(a.value)
        print('''\
panelMiddleButton:'Full Name: %s'
''' % (text), end='')
except:
    pass

try:
    for a in vcard.contents['org']:
        for b in a.value:
            text = encodeQuotes(b)
            print('''\
panelMiddleButton:'Company: %s'
''' % (text), end='')
except:
    pass

try:
    for a in vcard.contents['photo']:
        text = a.value
        try:
            params = a.params['TYPE']
            params = ["(%s)" % (item) for item in params]
            text += ' '
            text += ' '.join(params)
        except:
            pass
        text = encodeQuotes(text)
        print('''\
panelMiddleButton:'Photo: %s'
''' % (text), end='')
except:
    pass

try:
    for a in vcard.contents['bday']:
        text = encodeQuotes(a.value)
        print('''\
panelMiddleButton:'Birthday: %s'
''' % (text), end='')
except:
    pass

try:
    for a in vcard.contents['tel']:
        text = a.value
        try:
            params = a.params['TYPE']
            params = ['(preferred)' if item == 'pref' else "(%s)" % (item) for item in params]
            text += ' '
            text += ' '.join(params)
        except:
            pass
        text = encodeQuotes(text)
        print('''\
panelMiddleButton:'Phone: %s'
''' % (text), end='')
except:
    pass

try:
    for a in vcard.contents['adr']:
        text = "%s" % (a.value)
        try:
            params = a.params['TYPE']
            params = ['(preferred)' if item == 'pref' else "(%s)" % (item) for item in params]
            text += ' '
            text += ' '.join(params)
        except:
            pass
        text = encodeQuotes(text)
        print('''\
panelMiddleButton:'Address: %s'
''' % (text), end='')
except:
    pass

try:
    for a in vcard.contents['email']:
        text = a.value
        try:
            params = a.params['TYPE']
            params = ['(preferred)' if item == 'pref' else "(%s)" % (item) for item in params]
            text += ' '
            text += ' '.join(params)
        except:
            pass
        text = encodeQuotes(text)
        print('''\
panelMiddleButton:'Email: %s'
''' % (text), end='')
except:
    pass

try:
    for a in vcard.contents['version']:
        text = encodeQuotes(a.value)
        print('''\
panelText:''
panelText:'Version: %s'
''' % (text), end='')
except:
    pass

