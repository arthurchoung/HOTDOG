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

static id builtinMain =
@"class:HotDogStandFileManagerIcon name:File%20Manager x:20 y:20\n"
@"class:HotDogStandControlPanelIcon name:Control%20Panel x:120 y:20\n"
@"class:HotDogStandPrintManagerIcon name:Print%20Manager x:220 y:20\n"
@"class:HotDogStandClipboardViewerIcon name:Clipboard%20Viewer x:320 y:20\n"
@"class:HotDogStandMSDOSPromptIcon name:MS-DOS%20Prompt x:440 y:20\n"
@"class:HotDogStandWindowsSetupIcon name:Windows%20Setup x:20 y:80\n"
@"class:HotDogStandPIFEditorIcon name:PIF%20Editor x:130 y:95\n"
@"class:HotDogStandWriteIcon name:Read%20Me x:220 y:80\n"
;

static id builtinAccessories =
@"class:HotDogStandWriteIcon name:Write x:20 y:20\n"
@"class:HotDogStandPaintbrushIcon name:Paintbrush x:120 y:20\n"
@"class:HotDogStandTerminalIcon name:Terminal x:220 y:20\n"
@"class:HotDogStandNotepadIcon name:Notepad x:320 y:20\n"
@"class:HotDogStandRecorderIcon name:Recorder x:420 y:20\n"
@"class:HotDogStandCardfileIcon name:Cardfile x:20 y:80\n"
@"class:HotDogStandCalendarIcon name:Calendar x:120 y:80\n"
@"class:HotDogStandCalculatorIcon name:Calculator x:220 y:80\n"
@"class:HotDogStandClockIcon name:Clock x:320 y:80\n"
@"class:HotDogStandObjectPackagerIcon name:Object%20Packager x:420 y:80\n"
@"class:HotDogStandCharacterMapIcon name:Character%20Map x:20 y:140\n"
@"class:HotDogStandMediaPlayerIcon name:Media%20Player x:120 y:140\n"
@"class:HotDogStandSoundRecorderIcon name:Sound%20Recorder x:220 y:140\n"
;
static id builtinGames =
@"class:HotDogStandSolitaireIcon name:Solitaire x:20 y:20\n"
@"class:HotDogStandMinesweeperIcon name:Minesweeper x:100 y:20\n"
;

@implementation Definitions(fmeiowfmkdsljvklxcmkljfkldfjkdsjfks)
+ (id)HotDogStandBuiltInDir:(id)builtin
{
    id obj = [@"HotDogStandDir" asInstance];
    [obj setValue:builtin forKey:@"title"];

    [obj setValue:@"1" forKey:@"doNotUpdate"];

    id str = nil;
    if ([builtin isEqual:@"Main"]) {
        str = builtinMain;
    } else if ([builtin isEqual:@"Accessories"]) {
        str = builtinAccessories;
    } else if ([builtin isEqual:@"Games"]) {
        str = builtinGames;
    }
    
    if (str) {
        id lines = [str split:@"\n"];
        id arr = nsarr();
        for (int i=0; i<[lines count]; i++) {
            id elt = [lines nth:i];
            id className = [elt valueForKey:@"class"];
            id name = [elt valueForKey:@"name"];
            int x = [elt intValueForKey:@"x"];
            int y = [elt intValueForKey:@"y"];

            if (!className) {
                continue;
            }
        
            id dict = nsdict();
            id object = [className asInstance];
            [object setValue:name forKey:@"path"];
            int w = [object preferredWidth];
            int h = [object preferredHeight];
            [dict setValue:object forKey:@"object"];
            [dict setValue:nsfmt(@"%d", x) forKey:@"x"];
            [dict setValue:nsfmt(@"%d", y) forKey:@"y"];
            [dict setValue:nsfmt(@"%d", w) forKey:@"w"];
            [dict setValue:nsfmt(@"%d", h) forKey:@"h"];
            [dict setValue:name forKey:@"filePath"];
            [arr addObject:dict];
        }
        [obj setValue:arr forKey:@"array"];
    }
    return obj;
}
@end



@interface HotDogStandDir : IvarObject
{
    BOOL _doNotUpdate;
    time_t _timestamp;
    id _array;
    id _buttonDown;
    id _buttonHover;
    int _buttonDownOffsetX;
    int _buttonDownOffsetY;
    id _buttonDownTimestamp;
    Int4 _leftArrowRect;
    Int4 _rightArrowRect;
    Int4 _upArrowRect;
    Int4 _downArrowRect;

    Int4 _titleBarRect;
    Int4 _closeButtonRect;
    Int4 _lowerButtonRect;
    Int4 _raiseButtonRect;
    Int4 _titleTextRect;
    int _buttonDownX;
    int _buttonDownY;
    int _buttonDownW;
    int _buttonDownH;

    double _diskFreePct;
    int _horizontalKnobX;
    int _horizontalKnobW;
    int _horizontalKnobVal;
    int _horizontalKnobMaxVal;
    int _verticalKnobY;
    int _verticalKnobH;
    int _verticalKnobVal;
    int _verticalKnobMaxVal;

    int _contentXMin;
    int _contentXMax;
    int _contentYMin;
    int _contentYMax;
    int _visibleX;
    int _visibleY;
    int _visibleW;
    int _visibleH;

    id _title;

    id _dragX11Dict;

    id _path;
    int _iteration;
}
@end
@implementation HotDogStandDir
- (int)preferredWidth
{
    return 600;
}
- (int)preferredHeight
{
    return 360;
}

- (void)beginIteration:(id)event rect:(Int4)r
{
    if (!_iteration) {
        if (_title) {
            id x11dict = [event valueForKey:@"x11dict"];
            [x11dict setValue:_title forKey:@"changeWindowName"];
        }
        _iteration = 1;
    }

    int titleBarHeight = 20;
    int closeButtonWidth = 24;
    int lowerButtonWidth = 26;
    int raiseButtonWidth = 26;
    _titleBarRect.x = 0;//r.x;
    _titleBarRect.y = 0;//r.y;
    _titleBarRect.w = r.w;
    _titleBarRect.h = titleBarHeight;
    _closeButtonRect.x = 4;//r.x+4
    _closeButtonRect.y = 0;//r.y
    _closeButtonRect.w = closeButtonWidth;
    _closeButtonRect.h = titleBarHeight;
    _lowerButtonRect.x = /*r.x+*/r.w-3-lowerButtonWidth-raiseButtonWidth+2;
    _lowerButtonRect.y = 0;//r.y
    _lowerButtonRect.w = lowerButtonWidth;
    _lowerButtonRect.h = titleBarHeight;
    _raiseButtonRect.x = /*r.x+*/r.w-3-raiseButtonWidth;
    _raiseButtonRect.y = 0;//r.y
    _raiseButtonRect.w = raiseButtonWidth;
    _raiseButtonRect.h = titleBarHeight;
    _titleTextRect.x = /*r.x+*/4+closeButtonWidth+2;
    _titleTextRect.y = /*r.y+*/2;
    _titleTextRect.w = _lowerButtonRect.x - _titleTextRect.x - 2;
    _titleTextRect.h = titleBarHeight;

    _leftArrowRect.x = /*r.x+*/2;
    _leftArrowRect.y = /*r.y+*/r.h-16;
    _leftArrowRect.w = 11;
    _leftArrowRect.h = 14;
    _rightArrowRect.x = /*r.x+*/r.w-16-2-11;
    _rightArrowRect.y = /*r.y+*/r.h-16;
    _rightArrowRect.w = 11;
    _rightArrowRect.h = 14;
    _upArrowRect.x = /*r.x+*/r.w-16+1;
    _upArrowRect.y = /*r.y+*/titleBarHeight;
    _upArrowRect.w = 14;
    _upArrowRect.h = 12;
    _downArrowRect.x = /*r.x+*/r.w-16+1;
    _downArrowRect.y = /*r.y+*/r.h-18-12;
    _downArrowRect.w = 14;
    _downArrowRect.h = 12;

    _contentXMin = 0;
    _contentXMax = 0;
    _contentYMin = 0;
    _contentYMax = 0;
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        int x = [elt intValueForKey:@"x"];
        int y = [elt intValueForKey:@"y"];
        int w = [elt intValueForKey:@"w"];
        int h = [elt intValueForKey:@"h"];
        if (x < _contentXMin) {
            _contentXMin = x;
        }
        if (x+w > _contentXMax) {
            _contentXMax = x+w;
        }
        if (y < _contentYMin) {
            _contentYMin = y;
        }
        if (y+h > _contentYMax) {
            _contentYMax = y+h+16;
        }
    }
//    _contentXMax += 14 + 20;
//    _contentYMax += 20 + 10 + 20;
    _visibleW = r.w;
    _visibleH = r.h;
    if (_contentXMin > _visibleX) {
        _contentXMin = _visibleX;
    }
    if (_contentXMax < _visibleX+_visibleW-1) {
        _contentXMax = _visibleX+_visibleW-1;
    }
    if (_contentYMin > _visibleY) {
        _contentYMin = _visibleY;
    }
    if (_contentYMax < _visibleY+_visibleH-1) {
        _contentYMax = _visibleY+_visibleH-1;
    }
    int contentWidth = _contentXMax - _contentXMin;
    int contentHeight = _contentYMax - _contentYMin;
    double wpct = (double)_visibleW / (double)contentWidth;
    _horizontalKnobX = _leftArrowRect.x+_leftArrowRect.w+4;
    _horizontalKnobMaxVal = (_rightArrowRect.x-5)-_horizontalKnobX;
    _horizontalKnobW = (double)_horizontalKnobMaxVal*wpct;
    _horizontalKnobMaxVal -= _horizontalKnobW;
    double xpct = (double)(_visibleX-_contentXMin)/(double)(contentWidth-_visibleW);
    if (xpct < 0.0) {
        xpct = 0.0;
    } else if (xpct > 1.0) {
        xpct = 1.0;
    }
    _horizontalKnobVal = (double)_horizontalKnobMaxVal*xpct;

    double hpct = (double)_visibleH / (double)contentHeight;
    _verticalKnobY = _upArrowRect.y+_upArrowRect.h+4;
    _verticalKnobMaxVal = (_downArrowRect.y-5)-_verticalKnobY;
    _verticalKnobH = (double)_verticalKnobMaxVal*hpct;
    _verticalKnobMaxVal -= _verticalKnobH;
    double ypct = (double)(_visibleY-_contentYMin)/(double)(contentHeight-_visibleH);
    if (ypct < 0.0) {
        ypct = 0.0;
    } else if (ypct > 1.0) {
        ypct = 1.0;
    }
    _verticalKnobVal = (double)_verticalKnobMaxVal*ypct;


    
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r context:(id)context
{
    [bitmap useWinSystemFont];
    [bitmap setColor:@"red"];
    [bitmap fillRect:r];
    [bitmap setColor:@"white"];
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        int x = -_visibleX + [elt intValueForKey:@"x"];
        int y = -_visibleY + [elt intValueForKey:@"y"];
        int w = [elt intValueForKey:@"w"];
        int h = [elt intValueForKey:@"h"];
        id object = [elt valueForKey:@"object"];

        if ([elt intValueForKey:@"isSelected"]) {
            Int4 r1;
            r1.x = r.x+x;
            r1.y = r.y+y;
            r1.w = w;
            r1.h = h;
            if ([object respondsToSelector:@selector(drawInBitmap:rect:context:)]) {
                id dict = nsdict();
                [dict setValue:@"1" forKey:@"isSelected"];
                [object drawInBitmap:bitmap rect:r1 context:dict];
            }
        } else {
            Int4 r1;
            r1.x = r.x+x;
            r1.y = r.y+y;
            r1.w = w;
            r1.h = h;
            if ([object respondsToSelector:@selector(drawInBitmap:rect:context:)]) {
                [object drawInBitmap:bitmap rect:r1 context:nil];
            }
        }
    }
}

- (void)handleMouseDown:(id)event
{
    [self setValue:nil forKey:@"buttonDown"];
    [self setValue:nil forKey:@"buttonHover"];

    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    int viewWidth = [event intValueForKey:@"viewWidth"];
    int viewHeight = [event intValueForKey:@"viewHeight"];
    
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        int x = -_visibleX + [elt intValueForKey:@"x"];
        int y = -_visibleY + [elt intValueForKey:@"y"];
        int w = [elt intValueForKey:@"w"];
        int h = [elt intValueForKey:@"h"];
        if ((mouseX >= x) && (mouseX < x+w) && (mouseY >= y) && (mouseY < y+h)) {
            [self setValue:elt forKey:@"buttonDown"];
            if (![elt intValueForKey:@"isSelected"]) {
                for (int j=0; j<[_array count]; j++) {
                    id jelt = [_array nth:j];
                    [jelt setValue:nil forKey:@"isSelected"];
                    [jelt setValue:@"1" forKey:@"needsRedraw"];
                }
                [elt setValue:@"1" forKey:@"isSelected"];
                [elt setValue:@"1" forKey:@"needsRedraw"];
            }
            _buttonDownOffsetX = mouseX - x;
            _buttonDownOffsetY = mouseY - y;
            struct timeval tv;
            gettimeofday(&tv, NULL);
            id timestamp = nsfmt(@"%ld.%06ld", tv.tv_sec, tv.tv_usec);
            if (_buttonDownTimestamp && ([timestamp doubleValue] - [_buttonDownTimestamp doubleValue] <= 0.3)) {

                id command = [elt valueForKey:@"doubleClickCommand"];
                if (command) {
                    [command runCommandInBackground];
                }
                [self setValue:nil forKey:@"buttonDown"];
                [self setValue:nil forKey:@"buttonDownTimestamp"];
            } else {
                [self setValue:timestamp forKey:@"buttonDownTimestamp"];
            }
            return;
        }
    }

    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        [elt setValue:nil forKey:@"isSelected"];
        [elt setValue:@"1" forKey:@"needsRedraw"];
    }



}

- (void)handleMouseMoved:(id)event
{
    if (!_buttonDown) {
        return;
    }
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];


    id x11dict = [event valueForKey:@"x11dict"];
    int mouseRootX = [event intValueForKey:@"mouseRootX"];
    int mouseRootY = [event intValueForKey:@"mouseRootY"];

    if (!_dragX11Dict) {

        int selectedCount = 0;
        int minX = 0;
        int minY = 0;
        int maxX = 0;
        int maxY = 0;
        for (int i=0; i<[_array count]; i++) {
            id elt = [_array nth:i];
            if (![elt intValueForKey:@"isSelected"]) {
                continue;
            }
            int x = [elt intValueForKey:@"x"];
            int y = [elt intValueForKey:@"y"];
            int w = [elt intValueForKey:@"w"];
            int h = [elt intValueForKey:@"h"];
            if (!selectedCount) {
                minX = x;
                minY = y;
                maxX = x+w-1;
                maxY = y+h-1;
            } else {
                if (x < minX) {
                    minX = x;
                }
                if (y < minY) {
                    minY = y;
                }
                if (x+w-1 > maxX) {
                    maxX = x+w-1;
                }
                if (y+h-1 > maxY) {
                    maxY = y+h-1;
                }
            }
            selectedCount++;
        }
        int selectionWidth = maxX - minX + 1;
        int selectionHeight = maxY - minY + 1;

        id bitmap = [Definitions bitmapWithWidth:selectionWidth height:selectionHeight];
        id context = nsdict();
        [context setValue:@"1" forKey:@"isSelected"];
        for (int i=0; i<[_array count]; i++) {
            id elt = [_array nth:i];
            if (![elt intValueForKey:@"isSelected"]) {
                continue;
            }
            int x = [elt intValueForKey:@"x"];
            int y = [elt intValueForKey:@"y"];
            int w = [elt intValueForKey:@"w"];
            int h = [elt intValueForKey:@"h"];
            id object = [elt valueForKey:@"object"];
            Int4 r;
            r.x = x - minX;
            r.y = y - minY;
            r.w = w;
            r.h = h;
            if ([object respondsToSelector:@selector(drawInBitmap:rect:context:)]) {
                [object drawInBitmap:bitmap rect:r context:context];
            }
        }

        int x = [_buttonDown intValueForKey:@"x"] + _buttonDownOffsetX - minX;
        int y = [_buttonDown intValueForKey:@"y"] + _buttonDownOffsetY - minY;
        _buttonDownOffsetX = x;
        _buttonDownOffsetY = y;

        id selectionBitmap = [@"SelectionBitmap" asInstance];
        [selectionBitmap setValue:bitmap forKey:@"bitmap"];
        id windowManager = [event valueForKey:@"windowManager"];
        id newx11dict = [windowManager openWindowForObject:selectionBitmap x:mouseRootX - _buttonDownOffsetX y:mouseRootY - _buttonDownOffsetY w:selectionWidth h:selectionHeight overrideRedirect:YES];
        [self setValue:newx11dict forKey:@"dragX11Dict"];
    } else {

        int newX = mouseRootX - _buttonDownOffsetX;
        int newY = mouseRootY - _buttonDownOffsetY;

        [_dragX11Dict setValue:nsfmt(@"%d", newX) forKey:@"x"];
        [_dragX11Dict setValue:nsfmt(@"%d", newY) forKey:@"y"];

        [_dragX11Dict setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
    }
}

- (void)handleMouseUp:(id)event
{
    if (_dragX11Dict) {

        id windowManager = [event valueForKey:@"windowManager"];
        unsigned long window = [_dragX11Dict unsignedLongValueForKey:@"window"];
        int mouseRootX = [event intValueForKey:@"mouseRootX"];
        int mouseRootY = [event intValueForKey:@"mouseRootY"];

        unsigned long underneathWindow = [windowManager topMostWindowUnderneathWindow:window x:mouseRootX y:mouseRootY];
        if (underneathWindow) {
            id underneathx11dict = [windowManager dictForObjectWindow:underneathWindow];
            id x11dict = [event valueForKey:@"x11dict"];
            if (underneathx11dict == x11dict) {
//                [nsfmt(@"Dropped onto %@", x11dict) showAlert];
            } else {
                id object = [underneathx11dict valueForKey:@"object"];
                if ([object respondsToSelector:@selector(handleDragAndDrop:)]) {
                    [object handleDragAndDrop:_dragX11Dict];
                } else {
//                    [nsfmt(@"Dropped onto window %lu", underneathWindow) showAlert];
                }
            }
        } else {
//            [@"Dropped onto desktop" showAlert];
        }

        [_dragX11Dict setValue:@"1" forKey:@"shouldCloseWindow"];
        [self setValue:nil forKey:@"dragX11Dict"];
    }
    [self setValue:nil forKey:@"buttonDown"];
    [self setValue:nil forKey:@"buttonHover"];
}

@end


