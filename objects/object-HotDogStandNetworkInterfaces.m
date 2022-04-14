/*

 HOT DOG Linux

 Copyright (c) 2020 Arthur Choung. All rights reserved.

 Email: arthur -at- hotdoglinux.com

 This file is part of HOT DOG Linux.

 HOT DOG Linux is free software: you can redistribute it and/or modify
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

#include <sys/time.h>

static id programsPalette =
@". #000000\n"
@"r #ff0000\n"
@"X #ffff00\n"
@"o #AAAA55\n"
@"O #0000AA\n"
@"+ #0000ff\n"
@"@ #00ffff\n"
@"# #868A8E\n"
@"$ #C3C7CB\n"
@"% #ffffff\n"
;
static id programsPixels =
@"           ................     \n"
@"          .$$$$$$$$$$$$$$%#.    \n"
@"         .%%%%%%%%%%%%%%%##.    \n"
@"        .$$$$$$$$$$$$$$$$##.    \n"
@"        .$$############$$##.    \n"
@"        .$#............%$##.    \n"
@"        .$#.++++++++++.%$##.    \n"
@"        .$#.+@++++++++.%$##.    \n"
@"        .$#.+@++++++++.%$##.    \n"
@"        .$#.++++++++++.%$##.    \n"
@"     ...........++++++.%$##.    \n"
@"   ..%X%X%X%X%X%#.O+++.%$##.    \n"
@"  .X%o..$X%Xo..X%X.O++.%$##.    \n"
@" .X%o.$.oooo.X.oX%o....%$##.    \n"
@" .%Xo.X......$.oooo.$%%$$##.... \n"
@" .ooo.$X$X$X$X$.ooo.##$$$#.##%#.\n"
@" ....$X.X.X.X$X$..........##%##.\n"
@"   .$X$X.X.X$X$oo.####$$$$$%###.\n"
@"  .$X$X.X.X.X$Xoo.#$$$%%%%%####.\n"
@"  .%%%%%%%%%%%ooo.##$$$$$$$####.\n"
@"  .X$X$X$X$X$Xooo.###$$$$$$####.\n"
@"  .$X$X$X$X$X$oo...##$$$$$$###. \n"
@"  .X$X$X$X$X$Xo.%#.##$$$$$$##.  \n"
@" ..............%##.#########.   \n"
@".%%%%%%%%%%%%%%###..........    \n"
@".%$$$$$$$$$$$$$###.             \n"
@".%rr$rr$rr$$$$$##.              \n"
@".###############.               \n"
@" ...............                \n"
;

@implementation Definitions(hkukgfddfjkfnvbchjgfjygikghjghfjgfjdksfjksfjdsklfjksdljfdkslmdfsjfksvdj)
+ (id)HotDogStandNetworkInterfaces
{
    id observercmd = nsarr();
    [observercmd addObject:@"hotdog-monitorNetworkInterfaces"];
    id observer = [observercmd runCommandAndReturnProcess];
    if (!observer) {
NSLog(@"unable to run observer command %@", observercmd);
exit(1);
    }

    id obj = [@"HotDogStandNetworkInterfaces" asInstance];
    [obj setValue:observer forKey:@"observer"];
    return obj;
}
@end

@interface HotDogStandNetworkInterfaces : IvarObject
{
    time_t _timestamp;
    id _array;
    id _buttonDown;
    int _buttonDownOffsetX;
    int _buttonDownOffsetY;
    id _buttonDownTimestamp;
    id _selected;
    id _observer;
}
@end
@implementation HotDogStandNetworkInterfaces
- (int)fileDescriptor
{
    if (_observer) {
        return [_observer fileDescriptor];
    }
    return -1;
}
- (void)handleFileDescriptor
{
    if (_observer) {
        [_observer handleFileDescriptor];
        id data = [_observer valueForKey:@"data"];
        id lastLine = nil;
        for(;;) {
            id line = [data readLine];
//NSLog(@"line '%@'", line);
            if (!line) {
                break;
            }
            lastLine = line;
        }
        if (lastLine) {
            _timestamp = 0;
        }
        return;
    }
}
- (int)preferredWidth
{
    return 600;
}
- (int)preferredHeight
{
    return 360;
}
- (void)updateArray:(Int4)r
{
    id cmd = nsarr();
    [cmd addObject:@"hotdog-listNetworkInterfaces.pl"];
    id lines = [[[cmd runCommandAndReturnOutput] asString] split:@"\n"];
    int x = 50;
    int y = 5;
    int w = [Definitions widthForCString:[programsPixels UTF8String]];
    int h = [Definitions heightForCString:[programsPixels UTF8String]];
    id results = nsarr();
    for (int i=0; i<[lines count]; i++) {
        id line = [lines nth:i];
        id interface = [[line valueForKey:@"interface"] percentDecode];
        if (![interface length]) {
            continue;
        }
        id type = [[line valueForKey:@"type"] percentDecode];
        id up = [[line valueForKey:@"up"] percentDecode];
        id lowerUp= [[line valueForKey:@"lowerUp"] percentDecode];
        id operstate = [[line valueForKey:@"operstate"] percentDecode];
        id address = [[line valueForKey:@"address"] percentDecode];
        id dhcpcdcmd = nsarr();
        [dhcpcdcmd addObject:@"pgrep"];
        [dhcpcdcmd addObject:@"-f"];
        [dhcpcdcmd addObject:nsfmt(@"dhcpcd.*%@", interface)];
        id dhcpcd = [[dhcpcdcmd runCommandAndReturnOutput] asString];
        [dhcpcd chomp];
        id wirelesscmd = nsarr();
        [wirelesscmd addObject:@"iwconfig"];
        [wirelesscmd addObject:interface];
        id wirelessarr = [[[wirelesscmd runCommandAndReturnOutput] asString] split:@"\n"];
        int wireless = 0;
        for (int j=0; j<[wirelessarr count]; j++) {
            id elt = [wirelessarr nth:j];
NSLog(@"wireless elt '%@'", elt);
            if ([elt hasPrefix:interface]) {
                if ([elt containsString:@"ESSID:"]) {
                    wireless = 1;
                }
            }
        }
        id dict = nsdict();
        [dict setValue:interface forKey:@"interface"];
        [dict setValue:type forKey:@"type"];
        [dict setValue:up forKey:@"up"];
        [dict setValue:lowerUp forKey:@"lowerUp"];
        [dict setValue:operstate forKey:@"operstate"];
        [dict setValue:address forKey:@"address"];
        [dict setValue:dhcpcd forKey:@"dhcpcd"];
        [dict setValue:nsfmt(@"%d", wireless) forKey:@"wireless"];
        [dict setValue:nsfmt(@"%d", x) forKey:@"x"];
        [dict setValue:nsfmt(@"%d", y) forKey:@"y"];
        [dict setValue:nsfmt(@"%d", w) forKey:@"w"];
        [dict setValue:nsfmt(@"%d", h) forKey:@"h"];
        [dict setValue:programsPalette forKey:@"palette"];
        [dict setValue:programsPixels forKey:@"pixels"];
        [dict setValue:programsPalette forKey:@"selectedPalette"];
        [dict setValue:programsPixels forKey:@"selectedPixels"];
        [results addObject:dict];
        y += h + 30;
        if (y > r.h-5-30) {
            y = 5;
            x += 120;
        }
    }
    [self setValue:results forKey:@"array"];
}

- (void)beginIteration:(id)event rect:(Int4)r
{
    if (!_timestamp) {
        _timestamp = 1;
        [self updateArray:r];
    }
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [bitmap useWinSystemFont];
    [bitmap setColor:@"red"];
    [bitmap fillRect:r];
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        int x = [elt intValueForKey:@"x"];
        int y = [elt intValueForKey:@"y"];
        int w = [elt intValueForKey:@"w"];
        int h = [elt intValueForKey:@"h"];
        if (_selected == elt) {
            id palette = [elt valueForKey:@"palette"];
            id pixels = [elt valueForKey:@"pixels"];
            if (palette && pixels) {
                [bitmap drawCString:[pixels UTF8String] palette:[palette UTF8String] x:r.x+x y:r.y+y];
            }
        } else {
            id palette = [elt valueForKey:@"palette"];
            id pixels = [elt valueForKey:@"pixels"];
            if (palette && pixels) {
                [bitmap drawCString:[pixels UTF8String] palette:[palette UTF8String] x:r.x+x y:r.y+y];
            }
        }
        id text = [elt valueForKey:@"interface"];
        if ([text length]) {
            if (_selected == elt) {
                int textWidth = [Definitions bitmapWidthForText:text];
                [bitmap setColor:@"black"];
                [bitmap fillRect:[Definitions rectWithX:x+w/2-textWidth/2 y:y+h+2 w:textWidth h:18]];
                [bitmap setColor:@"white"];
                [bitmap drawBitmapText:text centeredAtX:x+w/2 y:y+h-2];
            } else {
                [bitmap setColor:@"white"];
                [bitmap drawBitmapText:text centeredAtX:x+w/2 y:y+h-2];
            }
        }
    }
}

- (void)handleMouseDown:(id)event
{
    [self setValue:nil forKey:@"selected"];
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        int x = [elt intValueForKey:@"x"];
        int y = [elt intValueForKey:@"y"];
        int w = [elt intValueForKey:@"w"];
        int h = [elt intValueForKey:@"h"];
        if ((mouseX >= x) && (mouseX < x+w) && (mouseY >= y) && (mouseY < y+h)) {
            [self setValue:elt forKey:@"buttonDown"];
            [self setValue:elt forKey:@"selected"];
            _buttonDownOffsetX = mouseX - x;
            _buttonDownOffsetY = mouseY - y;
            struct timeval tv;
            gettimeofday(&tv, NULL);
            id timestamp = nsfmt(@"%ld.%06ld", tv.tv_sec, tv.tv_usec);
            if (_buttonDownTimestamp && ([timestamp doubleValue] - [_buttonDownTimestamp doubleValue] <= 0.3)) {
                //_selected
                [self setValue:nil forKey:@"buttonDownTimestamp"];
            } else {
                [self setValue:timestamp forKey:@"buttonDownTimestamp"];
            }
            break;
        }
    }
}

- (void)handleMouseMoved:(id)event
{
    if (_buttonDown) {
        int mouseX = [event intValueForKey:@"mouseX"];
        int mouseY = [event intValueForKey:@"mouseY"];
        [_buttonDown setValue:nsfmt(@"%d", mouseX - _buttonDownOffsetX) forKey:@"x"];
        [_buttonDown setValue:nsfmt(@"%d", mouseY - _buttonDownOffsetY) forKey:@"y"];
        [self setValue:nil forKey:@"buttonDownTimestamp"];
    }
}

- (void)handleMouseUp:(id)event
{
    [self setValue:nil forKey:@"buttonDown"];
}

- (void)handleRightMouseDown:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        int x = [elt intValueForKey:@"x"];
        int y = [elt intValueForKey:@"y"];
        int w = [elt intValueForKey:@"w"];
        int h = [elt intValueForKey:@"h"];
        if ((mouseX >= x) && (mouseX < x+w) && (mouseY >= y) && (mouseY < y+h)) {
            [self setValue:elt forKey:@"selected"];
            id arr = nsarr();
            id interface = [_selected valueForKey:@"interface"];
            id type = [_selected valueForKey:@"type"];
            id up = [_selected valueForKey:@"up"];
            id lowerUp= [_selected valueForKey:@"lowerUp"];
            id operstate = [_selected valueForKey:@"operstate"];
            id address = [_selected valueForKey:@"address"];
            id dhcpcd = [_selected valueForKey:@"dhcpcd"];
            id wireless = [_selected valueForKey:@"wireless"];
            id dict = nil;
            dict = nsdict();
            [dict setValue:nsfmt(@"Interface: %@", interface) forKey:@"displayName"];
            [arr addObject:dict];
            dict = nsdict();
            [dict setValue:nsfmt(@"Type: %@", type) forKey:@"displayName"];
            [arr addObject:dict];
            dict = nsdict();
            [dict setValue:nsfmt(@"Up: %@", up) forKey:@"displayName"];
            [arr addObject:dict];
            dict = nsdict();
            [dict setValue:nsfmt(@"Lower Up: %@", lowerUp) forKey:@"displayName"];
            [arr addObject:dict];
            dict = nsdict();
            [dict setValue:nsfmt(@"Operstate: %@", operstate) forKey:@"displayName"];
            [arr addObject:dict];
            dict = nsdict();
            [dict setValue:nsfmt(@"Address: %@", address) forKey:@"displayName"];
            [arr addObject:dict];
            dict = nsdict();
            [dict setValue:nsfmt(@"dhcpcd: %@", dhcpcd) forKey:@"displayName"];
            [arr addObject:dict];
            dict = nsdict();
            [dict setValue:nsfmt(@"Wireless: %@", wireless) forKey:@"displayName"];
            [arr addObject:dict];
            [arr addObject:nsdict()];
            if ([interface isEqual:@"lo"]) {
            } else if ([dhcpcd length]) {
                dict = nsdict();
                [dict setValue:@"Kill dhcpcd" forKey:@"displayName"];
                [dict setValue:nsfmt(@"NSArray|addObject:'kill'|addObject:'%@'|runCommandWithSudoAndReturnOutput;setValue:'0' forKey:'timestamp'", dhcpcd) forKey:@"messageForClick"];
                [arr addObject:dict];
            } else {
                dict = nsdict();
                [dict setValue:@"Run dhcpcd" forKey:@"displayName"];
                [dict setValue:nsfmt(@"NSArray|addObject:'hotdog-connectNetworkInterface.pl'|addObject:'%@'|runCommandAndReturnOutput;setValue:'0' forKey:'timestamp'", interface) forKey:@"messageForClick"];
                [arr addObject:dict];
            }
            if ([arr count]) {
                id menu = [arr asMenu];
                [menu setValue:self forKey:@"contextualObject"];
                int mouseRootX = [event intValueForKey:@"mouseRootX"];
                int mouseRootY = [event intValueForKey:@"mouseRootY"];
                id windowManager = [event valueForKey:@"windowManager"];
                [windowManager openButtonDownMenuForObject:menu x:mouseRootX y:mouseRootY w:0 h:0];
            }
            break;
        }
    }
}
@end

