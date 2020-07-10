/*

 PEEOS

 Copyright (c) 2020 Arthur Choung. All rights reserved.

 Email: arthur -at- peeos.org

 This file is part of PEEOS.

 PEEOS is free software: you can redistribute it and/or modify it
 under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <https://www.gnu.org/licenses/>.

 */

#import "PEEOS.h"


@implementation Definitions(fjkdsljflksdjlkfjlskdf)
+ (char *)cStringForRadioButtonSelected
{
    return
"            \n"
"            \n"
"            \n"
"    bbbb    \n"
"   bbbbbb   \n"
"   bbbbbb   \n"
"   bbbbbb   \n"
"   bbbbbb   \n"
"    bbbb    \n"
"            \n"
"            \n"
"            \n"
;
}
+ (char *)cStringForRadioButton
{
    return
"    bbbb    \n"
"  bb    bb  \n"
" b        b \n"
" b        b \n"
"b          b\n"
"b          b\n"
"b          b\n"
"b          b\n"
" b        b \n"
" b        b \n"
"  bb    bb  \n"
"    bbbb    \n"
;
}
+ (char *)cStringForRadioButtonDown
{
    return
"    bbbb    \n"
"  bbbbbbbb  \n"
" bbb    bbb \n"
" bb      bb \n"
"bb        bb\n"
"bb        bb\n"
"bb        bb\n"
"bb        bb\n"
" bb      bb \n"
" bbb    bbb \n"
"  bbbbbbbb  \n"
"    bbbbb   \n"
;
}
@end

@interface RadioButtons : IvarObject
{
    int _selectedIndex;
    int _downIndex;
    int _hoverIndex;
}
@end
@implementation RadioButtons
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    [bitmap setColor:@"black"];
    char *button = [Definitions cStringForRadioButton];
    char *selected = [Definitions cStringForRadioButtonSelected];
    char *down = [Definitions cStringForRadioButtonDown];
    for (int i=1; i<10; i++) {
        int y = r.y+20*i;
        char *str = button;
        if ((_downIndex == i) && (_hoverIndex == i)) {
            str = down;
        }
        [bitmap drawCString:str x:20 y:y c:'b' r:0 g:0 b:0 a:255];
        if (_selectedIndex == i) {
            [bitmap drawCString:selected x:20 y:y c:'b' r:0 g:0 b:0 a:255];
        }
    }
}
- (void)handleMouseDown:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    int index = mouseY / 20;
    _downIndex = _hoverIndex = index;
}
- (void)handleMouseUp:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    int index = mouseY / 20;
    _downIndex = 0;
    _hoverIndex = index;
    _selectedIndex = index;
}
- (void)handleMouseMoved:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    int index = mouseY / 20;
    _hoverIndex = index;
}
@end

