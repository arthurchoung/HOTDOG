/*

 HOTDOG

 Copyright (c) 2020 Arthur Choung. All rights reserved.

 Email: arthur -at- hotdogpucko.com

 This file is part of HOTDOG.

 HOTDOG is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <https://www.gnu.org/licenses/>.

 */

#import "HOTDOG.h"


@implementation Definitions(fjkdsljflksdjlkfjlskdf)
+ (id)testRadioButtons:(id)filePath
{
    id arr = [@"One Two Three Four Five" split];

    id val = [[filePath linesFromFile] nth:0];
    int index = [arr findObject:val];
    
    id obj = [@"RadioButtons" asInstance];
    [obj setValue:arr forKey:@"choices"];
    [obj setValue:filePath forKey:@"filePath"];
    if (index >= 0) {
        [obj setValue:nsfmt(@"%d", index) forKey:@"selectedIndex"];
    }
    return obj;
}

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
    id _choices;
    id _filePath;
    int _selectedIndex;
    int _downIndex;
    int _hoverIndex;
    int _firstElementY;
}
@end
@implementation RadioButtons
- (id)init
{
    self = [super init];
    if (self) {
        _selectedIndex = -1;
        _downIndex = -1;
        _hoverIndex = -1;
    }
    return self;
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    [bitmap setColor:@"black"];
    char *button = [Definitions cStringForRadioButton];
    char *selected = [Definitions cStringForRadioButtonSelected];
    char *down = [Definitions cStringForRadioButtonDown];
    int width = [Definitions widthForCString:button];
    _firstElementY = r.y+5;
    for (int i=0; i<[_choices count]; i++) {
        int y = _firstElementY+20*i;
        char *str = button;
        if ((_downIndex == i) && (_hoverIndex == i)) {
            str = down;
        }
        [bitmap drawCString:str x:10 y:y c:'b' r:0 g:0 b:0 a:255];
        if (_selectedIndex == i) {
            [bitmap drawCString:selected x:10 y:y c:'b' r:0 g:0 b:0 a:255];
        }
        [bitmap drawBitmapText:[_choices nth:i] x:10+width+10 y:y];
    }
}
- (void)handleMouseDown:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    int y = mouseY - _firstElementY;
    int index = y / 20;
    _downIndex = _hoverIndex = index;
}
- (void)handleMouseUp:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    int y = mouseY - _firstElementY;
    int index = y / 20;
    [self updateSelectedIndex];
    _downIndex = -1;
    _hoverIndex = index;
}
- (void)handleMouseMoved:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    int y = mouseY - _firstElementY;
    int index = y / 20;
    _hoverIndex = index;
}
- (void)updateSelectedIndex
{
    if (_downIndex != _hoverIndex) {
        return;
        }
    int index = _downIndex;
    if (index < 0) {
        return;
    }
    if (index >= [_choices count]) {
        return;
    }
    _selectedIndex = index;
    if (_filePath) {
        [nsfmt(@"%@", [_choices nth:index]) writeToFile:_filePath];
    }
}
@end

