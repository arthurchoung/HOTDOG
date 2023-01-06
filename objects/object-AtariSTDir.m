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

static char *horizontalKnobLeftPixels =
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
;
static char *horizontalKnobMiddlePixels =
"b\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
"b\n"
;
static char *horizontalKnobRightPixels =
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
;






static char *verticalKnobTopPixels =
"bbbbbbbbbbbbbbbbbbb\n"
;
static char *verticalKnobMiddlePixels =
"b.................b\n"
;
static char *verticalKnobBottomPixels =
"bbbbbbbbbbbbbbbbbbb\n"
;

static char *activeHorizontalScrollBarPixels =
"bbbb\n"
"....\n"
"..b.\n"
"....\n"
"b...\n"
"....\n"
"..b.\n"
"....\n"
"b...\n"
"....\n"
"..b.\n"
"....\n"
"b...\n"
"....\n"
"..b.\n"
"....\n"
"b...\n"
"....\n"
"bbbb\n"
"bbbb\n"
"bbbb\n"
;
static char *activeVerticalScrollBarPixels =
"b..b...b...b...b..bbb\n"
"b.................bbb\n"
"bb...b...b...b...bbbb\n"
"b.................bbb\n"
;

static id folderPalette =
@"b #000000\n"
@". #ffffff\n"
;
static id selectedFolderPalette = 
@". #000000\n"
@"b #ffffff\n"
;
static id folderPixels =
@"                   bbbbbbbbbb \n"
@"                  bb........bb\n"
@"  bbbbbbbbbbbbbbbbb..........b\n"
@" b...........................b\n"
@" bbbbbbbbbbbbbbbbbbbbbbbbbb..b\n"
@" b.........................b.b\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"bb..........................bb\n"
@" bbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
;

static id documentPalette =
@"b #000000\n"
@". #ffffff\n"
;
static id selectedDocumentPalette =
@". #000000\n"
@"b #ffffff\n"
;
static id documentPixels =
@"bbbbbbbbbbbbbbbbbbbbbb    \n"
@"b....................b    \n"
@"b....................bbb  \n"
@"b....................b.b  \n"
@"b....................b.bbb\n"
@"b....................b.b.b\n"
@"b....................b.b.b\n"
@"b....................b.b.b\n"
@"b....................b.b.b\n"
@"b....................b.b.b\n"
@"b....................b.b.b\n"
@"b....................b.b.b\n"
@"b....................b.b.b\n"
@"b....................b.b.b\n"
@"b....................b.b.b\n"
@"b....................b.b.b\n"
@"b....................b.b.b\n"
@"b....................b.b.b\n"
@"b....................b.b.b\n"
@"b....................b.b.b\n"
@"b..............bbbbbbb.b.b\n"
@"b..............b....bb.b.b\n"
@"b..............b...bb..b.b\n"
@"b..............b..bb...b.b\n"
@"b..............b.bb....b.b\n"
@"b..............bbb.....b.b\n"
@"bbbbbbbbbbbbbbbbb......b.b\n"
@"  b....................b.b\n"
@"  bbbbbbbbbbbbbbbbbbbbbb.b\n"
@"    b....................b\n"
@"    bbbbbbbbbbbbbbbbbbbbbb\n"
;
static id executablePalette =
@"b #000000\n"
@". #ffffff\n"
;
static id selectedExecutablePalette =
@". #000000\n"
@"b #ffffff\n"
;
static id executablePixels =
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
@"b...........................b \n"
@"b.b.b.b.b.b.b.b.b.b.b.b.b.b.bb\n"
@"b...........................bb\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"b...........................bb\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"  bbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
;

@implementation Definitions(hkukgfdfthfnvbchjgfjygikghjghfjgfjdksfjksdkjffjkdsjfksdj)
+ (id)AtariSTDir
{
    id obj = [@"AtariSTDir" asInstance];
    [obj setValue:[@"." asRealPath] forKey:@"title"];
    [obj calculateDiskUsed];
    return obj;
}
@end

@interface AtariSTDir : IvarObject
{
    time_t _timestamp;
    id _array;
    id _buttonDown;
    id _buttonHover;
    int _buttonDownOffsetX;
    int _buttonDownOffsetY;
    id _buttonDownTimestamp;
    id _selected;

    Int4 _leftArrowRect;
    Int4 _rightArrowRect;
    Int4 _upArrowRect;
    Int4 _downArrowRect;

    Int4 _titleBarRect;
    Int4 _closeButtonRect;
    Int4 _maximizeButtonRect;
    Int4 _titleBarTextRect;
    int _buttonDownX;
    int _buttonDownY;
    int _buttonDownW;
    int _buttonDownH;

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
    id _numberOfItemsText;
    id _diskUsedText;
    id _diskUsedProcess;

    int _disableHorizontalScrollBar;
    int _disableVerticalScrollBar;
}
@end
@implementation AtariSTDir
- (int *)x11WindowMaskPointsForWidth:(int)w height:(int)h
{
    static int points[5];
    points[0] = 5; // length of array including this number

    points[1] = 0; // lower left corner
    points[2] = h-1;

    points[3] = w-1; // upper right corner
    points[4] = 0;
    return points;
}
- (void)updateNumberOfItemsText
{
    id str = nsfmt(@"%d", [_array count]);
    [self setValue:str forKey:@"numberOfItemsText"];
}
- (void)calculateDiskUsed
{
    [self setValue:@"Calculating" forKey:@"diskUsedText"];
    id cmd = nsarr();
    [cmd addObject:@"hotdog-getFileUsage.pl"];
    id process = [cmd runCommandAndReturnProcess];
    [self setValue:process forKey:@"diskUsedProcess"];
}
- (int)fileDescriptor
{
    if (_diskUsedProcess) {
        return [_diskUsedProcess fileDescriptor];
    }
    return -1;
}
- (void)handleFileDescriptor
{
    if (_diskUsedProcess) {
        [_diskUsedProcess handleFileDescriptor];
        id str = [[_diskUsedProcess valueForKey:@"data"] asString];
        int total = [str intValueForKey:@"total"];
                
        str = nsfmt(@"%d", total*1024);
        [self setValue:str forKey:@"diskUsedText"];
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
- (void)updateFromCurrentDirectory:(Int4)r
{
    id bitmap = [Definitions bitmapWithWidth:1 height:1];
    [bitmap useMonacoFont];
    id arr = [@"." contentsOfDirectory];
    arr = [arr asFileArray];
    int x = 40;
    int y = 5;
    for (int i=0; i<[arr count]; i++) {
        id elt = [arr nth:i];
        id palette = nil;
        id pixels = nil;
        id selectedPalette = nil;
        id selectedPixels = nil;
        id fileType = [elt valueForKey:@"fileType"];
        if ([fileType isEqual:@"file"]) {
            id filePath = [elt valueForKey:@"filePath"];
            if ([filePath hasSuffix:@".sh"]) {
                palette = executablePalette;
                pixels = executablePixels;
                selectedPalette = selectedExecutablePalette;
                selectedPixels = executablePixels;
            } else {
                palette = documentPalette;
                pixels = documentPixels;
                selectedPalette = selectedDocumentPalette;
                selectedPixels = documentPixels;
            }
        } else if ([fileType isEqual:@"directory"]) {
            palette = folderPalette;
            pixels = folderPixels;
            selectedPalette = selectedFolderPalette;
            selectedPixels = folderPixels;
        }
        if (!palette || !pixels) {
            continue;
        }
        [elt setValue:palette forKey:@"palette"];
        [elt setValue:pixels forKey:@"pixels"];
        [elt setValue:selectedPalette forKey:@"selectedPalette"];
        [elt setValue:selectedPixels forKey:@"selectedPixels"];
        int w = [Definitions widthForCString:[pixels UTF8String]];
        int h = [Definitions heightForCString:[pixels UTF8String]];
        if (x + w + 5 >= r.w) {
            x = 40;
            y += h + 30;
        }
        [elt setValue:nsfmt(@"%d", x) forKey:@"x"];
        [elt setValue:nsfmt(@"%d", y) forKey:@"y"];
        [elt setValue:nsfmt(@"%d", w) forKey:@"w"];
        [elt setValue:nsfmt(@"%d", h) forKey:@"h"];
        x += w + 50 + 20;
    }
    [self setValue:arr forKey:@"array"];
    [self updateNumberOfItemsText];
}

- (void)handleBackgroundUpdate:(id)event
{
    time_t timestamp = [@"." fileModificationTimestamp];
    if (timestamp != _timestamp) {
        _timestamp = 0;
    }
}
- (BOOL)shouldAnimate
{
    if ([_buttonDown isEqual:@"leftArrow"]) {
    } else if ([_buttonDown isEqual:@"rightArrow"]) {
    } else if ([_buttonDown isEqual:@"upArrow"]) {
    } else if ([_buttonDown isEqual:@"downArrow"]) {
    } else {
        return NO;
    }
    if ([_buttonDown isEqual:_buttonHover]) {
        return YES;
    }
    return NO;
}

- (void)beginIteration:(id)event rect:(Int4)r
{
    if (!_timestamp) {
        _timestamp = [@"." fileModificationTimestamp];
        [self updateFromCurrentDirectory:r];
    }

    if ([_buttonDown isEqual:_buttonHover]) {
        if ([_buttonDown isEqual:@"leftArrow"]) {
            _visibleX -= 10;
            if (_visibleX < _contentXMin) {
                _visibleX = _contentXMin;
            }
        } else if ([_buttonDown isEqual:@"rightArrow"]) {
            _visibleX += 10;
            if (_visibleX > _contentXMax+1 - _visibleW) {
                _visibleX = _contentXMax+1 - _visibleW;
            }
        } else if ([_buttonDown isEqual:@"upArrow"]) {
            _visibleY -= 10;
            if (_visibleY < _contentYMin) {
                _visibleY = _contentYMin;
            }
        } else if ([_buttonDown isEqual:@"downArrow"]) {
            _visibleY += 10;
            if (_visibleY > _contentYMax+1 - _visibleH) {
                _visibleY = _contentYMax+1 - _visibleH;
            }
        }
    }

    _titleBarRect = [Definitions rectWithX:0/*r.x*/ y:0/*r.y*/ w:r.w h:19];
    _titleBarTextRect = _titleBarRect;
    _titleBarTextRect.x = 20 + 4;
    _titleBarTextRect.w -= (20+4)+(22+4);

    _closeButtonRect = _titleBarRect;
    _closeButtonRect.x += 1;
    _closeButtonRect.y += 1;
    _closeButtonRect.w = 17;
    _closeButtonRect.h = 17;

    _maximizeButtonRect = _titleBarRect;
    _maximizeButtonRect.x = _maximizeButtonRect.x+_maximizeButtonRect.w-3-17;
    _maximizeButtonRect.y += 1;
    _maximizeButtonRect.w = 17;
    _maximizeButtonRect.h = 17;

    _leftArrowRect.x = 0;
    _leftArrowRect.y = r.h-21;
    _leftArrowRect.w = 19;
    _leftArrowRect.h = 19;
    _rightArrowRect.x = r.w-21-18;
    _rightArrowRect.y = r.h-21;
    _rightArrowRect.w = 19;
    _rightArrowRect.h = 19;
    _upArrowRect.x = r.w-21;
    _upArrowRect.y = 19+17;
    _upArrowRect.w = 19;
    _upArrowRect.h = 19;
    _downArrowRect.x = r.w-21;
    _downArrowRect.y = r.h-21-18;
    _downArrowRect.w = 19;
    _downArrowRect.h = 19;

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
    _contentXMax += 17 + 1 + 20;
    _contentYMax += 19 + 20 + 17 + 20;
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
    _horizontalKnobX = _leftArrowRect.x+_leftArrowRect.w-1;
    _horizontalKnobMaxVal = _rightArrowRect.x+1-_horizontalKnobX;
    _horizontalKnobW = (double)_horizontalKnobMaxVal*wpct;
    _horizontalKnobMaxVal -= _horizontalKnobW;
    double xpct = (double)(_visibleX-_contentXMin)/(double)(contentWidth-_visibleW);
    if (xpct < 0.0) {
        xpct = 0.0;
    } else if (xpct > 1.0) {
        xpct = 1.0;
    }
    if (![_buttonDown isEqual:@"horizontalKnob"]) {
        _horizontalKnobVal = (double)_horizontalKnobMaxVal*xpct;
    }

    double hpct = (double)_visibleH / (double)contentHeight;
    _verticalKnobY = _upArrowRect.y+_upArrowRect.h-1;
    _verticalKnobMaxVal = _downArrowRect.y+1-_verticalKnobY;
    _verticalKnobH = (double)_verticalKnobMaxVal*hpct;
    _verticalKnobMaxVal -= _verticalKnobH;
    double ypct = (double)(_visibleY-_contentYMin)/(double)(contentHeight-_visibleH);
    if (ypct < 0.0) {
        ypct = 0.0;
    } else if (ypct > 1.0) {
        ypct = 1.0;
    }
    if (![_buttonDown isEqual:@"verticalKnob"]) {
        _verticalKnobVal = (double)_verticalKnobMaxVal*ypct;
    }

    _disableHorizontalScrollBar = 0;
    if (_visibleX == _contentXMin) {
        if (_visibleX + _visibleW - 1 == _contentXMax) {
            _disableHorizontalScrollBar = 1;
        }
    }
    _disableVerticalScrollBar = 0;
    if (_visibleY == _contentYMin) {
        if (_visibleY + _visibleH - 1 == _contentYMax) {
            _disableVerticalScrollBar = 1;
        }
    }
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r context:(id)context
{
    [bitmap useMonacoFont];
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    [bitmap setColor:@"black"];
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        int x = -_visibleX + [elt intValueForKey:@"x"];
        int y = -_visibleY + [elt intValueForKey:@"y"] + 19 + 20;
        int w = [elt intValueForKey:@"w"];
        int h = [elt intValueForKey:@"h"];
        if (_selected == elt) {
            id palette = [elt valueForKey:@"selectedPalette"];
            id pixels = [elt valueForKey:@"selectedPixels"];
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
        id filePath = [elt valueForKey:@"filePath"];
        [bitmap drawBitmapText:filePath centeredAtX:x+w/2 y:y+h-2];
    }


    BOOL hasFocus = NO;
    {
        id windowManager = [@"windowManager" valueForKey];
        unsigned long focusInEventWindow = [[windowManager valueForKey:@"focusInEventWindow"] unsignedLongValue];
        unsigned long win = [[context valueForKey:@"window"] unsignedLongValue];
        if (focusInEventWindow && (focusInEventWindow == win)) {
            hasFocus = YES;
        }
    }
    if (hasFocus) {
        char *palette = "b #000000\n. #ffffff\n";
        char *left = [Definitions cStringForAtariSTActiveTitleBarLeftPixels];
        char *middle = [Definitions cStringForAtariSTActiveTitleBarMiddlePixels];
        char *right = [Definitions cStringForAtariSTActiveTitleBarRightPixels];
        [Definitions drawInBitmap:bitmap left:left palette:palette middle:middle palette:palette right:right palette:palette x:_titleBarRect.x y:_titleBarRect.y w:_titleBarRect.w];

        if ([_buttonDown isEqual:@"closeButton"] && [_buttonHover isEqual:@"closeButton"]) {
            char *reversePalette = ". #000000\nb #ffffff\n";
            char *pixels = [Definitions cStringForAtariSTCloseButtonDownPixels];
            [bitmap drawCString:pixels palette:reversePalette x:_closeButtonRect.x y:_closeButtonRect.y];
        } else if ([_buttonDown isEqual:@"maximizeButton"] && [_buttonHover isEqual:@"maximizeButton"]) {
            char *reversePalette = ". #000000\nb #ffffff\n";
            char *pixels = [Definitions cStringForAtariSTMaximizeButtonDownPixels];
            [bitmap drawCString:pixels palette:reversePalette x:_maximizeButtonRect.x y:_maximizeButtonRect.y];
        }
    } else {
        char *palette = "b #000000\n. #ffffff\n";
        char *left = [Definitions cStringForAtariSTInactiveTitleBarLeftPixels];
        char *middle = [Definitions cStringForAtariSTInactiveTitleBarMiddlePixels];
        char *right = [Definitions cStringForAtariSTInactiveTitleBarRightPixels];
        [Definitions drawInBitmap:bitmap left:left palette:palette middle:middle palette:palette right:right palette:palette x:_titleBarRect.x y:_titleBarRect.y w:_titleBarRect.w];
    }
    if (_titleBarTextRect.w > 0) {
        id text = _title;
        if (!text) {
            text = @"(no title)";
        }

        [bitmap useAtariSTFont];

        text = [[[bitmap fitBitmapString:text width:_titleBarTextRect.w-14] split:@"\n"] nth:0];
        if (text) {
            int textWidth = [bitmap bitmapWidthForText:text];
            int backWidth = textWidth + 14;
            int backX = _titleBarTextRect.x + ((_titleBarTextRect.w - backWidth) / 2);
            int textX = backX + 7;
            if (hasFocus) {
                [bitmap setColor:@"white"];
                [bitmap fillRect:[Definitions rectWithX:backX y:_titleBarTextRect.y+2 w:backWidth h:16]];
                [bitmap setColorIntR:0 g:0 b:0 a:255];
                [bitmap drawBitmapText:text x:textX y:_titleBarTextRect.y+2];
            } else {
                [bitmap setColorIntR:0 g:0 b:0 a:255];
                [bitmap drawBitmapText:text x:textX y:_titleBarTextRect.y+2];
            }
        }

        [bitmap useMonacoFont];
    }

    int infoBarHeight = 18;
    if (infoBarHeight) {
        [bitmap setColor:@"white"];
        [bitmap fillRectangleAtX:r.x y:r.y+19 w:r.w h:infoBarHeight];
        [bitmap setColor:@"black"];
        [bitmap drawLineAtX:r.x y:r.y+19+17 x:r.x+r.w-1 y:r.y+19+17];
        [bitmap useAtariSTFont];
        [bitmap setColorIntR:0 g:0 b:0 a:255];
        id text = nil;
        if (_numberOfItemsText && _diskUsedText) {
            text = nsfmt(@" %@ bytes used in %@ items.", _diskUsedText, _numberOfItemsText);
        } else if (_numberOfItemsText) {
            text = nsfmt(@" %@ items.", _numberOfItemsText);
        } else if (_diskUsedText) {
            text = nsfmt(@" %@ bytes used.", _diskUsedText);
        }
        if (text) {
            [bitmap drawBitmapText:text x:0 y:r.y+19+1];
        }

        char *middle = "bbb";
        char *palette = "b #000000\n";
        [Definitions drawInBitmap:bitmap top:middle palette:palette middle:middle palette:palette bottom:middle palette:palette x:r.x+r.w-3 y:_titleBarRect.h h:infoBarHeight];
    }

    {
        char *middle = "b";
        char *palette = "b #000000\n";
        [Definitions drawInBitmap:bitmap top:middle palette:palette middle:middle palette:palette bottom:middle palette:palette x:0 y:_titleBarRect.h h:r.h-_titleBarRect.h-21];
    }

    {
        char *left = [Definitions cStringForAtariSTBottomBorderLeftPixels];
        char *middle = activeHorizontalScrollBarPixels;
        char *right = [Definitions cStringForAtariSTBottomBorderRightPixels];
        char *palette = "b #000000\n. #ffffff\n";
        if (hasFocus) {
            if (_disableHorizontalScrollBar) {
                left = [Definitions cStringForAtariSTBottomBorderLeftPixels];
                middle = [Definitions cStringForAtariSTBottomBorderMiddlePixels];
                right = [Definitions cStringForAtariSTBottomBorderRightPixels];
            }
        } else {
            left = [Definitions cStringForAtariSTInactiveBottomBorderLeftPixels];
            middle = [Definitions cStringForAtariSTInactiveBottomBorderMiddlePixels];
            right = [Definitions cStringForAtariSTInactiveBottomBorderRightPixels];
        }
        [Definitions drawInBitmap:bitmap left:left middle:middle right:right x:r.x y:r.y+r.h-21 w:r.w palette:palette];

        if (hasFocus && !_disableHorizontalScrollBar) { 
//            [bitmap drawCString:horizontalKnobPixels palette:"b #000000\n. #ffffff\n" x:_horizontalKnobX+_horizontalKnobVal y:r.y+r.h-16];
            [Definitions drawInBitmap:bitmap left:horizontalKnobLeftPixels middle:horizontalKnobMiddlePixels right:horizontalKnobRightPixels x:_horizontalKnobX+_horizontalKnobVal y:r.y+r.h-21 w:_horizontalKnobW palette:palette];
            if ([_buttonDown isEqual:@"horizontalKnob"]) {
                char *h = [Definitions cStringForMacWindowSelectionHorizontal];
                char *v = [Definitions cStringForMacWindowSelectionVertical];
                char *palette = "b #000000\nw #ffffff\n";
                [Definitions drawInBitmap:bitmap left:h middle:h right:h x:_horizontalKnobX+_horizontalKnobVal y:r.y+r.h-21 w:_horizontalKnobW palette:palette];
                [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:_horizontalKnobX+_horizontalKnobVal y:r.y+r.h-21+1 h:19-2];
                [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:_horizontalKnobX+_horizontalKnobVal+_horizontalKnobW-1 y:r.y+r.h-21+1 h:19-2];
                [Definitions drawInBitmap:bitmap left:h middle:h right:h x:_horizontalKnobX+_horizontalKnobVal y:r.y+r.h-21+19-1 w:_horizontalKnobW palette:palette];
            }
        }
    }
    {
        char *top = [Definitions cStringForAtariSTRightBorderTopPixels];
        char *middle = activeVerticalScrollBarPixels;
        char *bottom = [Definitions cStringForAtariSTRightBorderBottomPixels];
        char *palette = "b #000000\n. #ffffff\n";
        if (hasFocus) {
            if (_disableVerticalScrollBar) {
                top = [Definitions cStringForAtariSTRightBorderTopPixels];
                middle = [Definitions cStringForAtariSTRightBorderMiddlePixels];
                bottom = [Definitions cStringForAtariSTRightBorderBottomPixels];
            }
        } else {
            top = [Definitions cStringForAtariSTInactiveRightBorderTopPixels];
            middle = [Definitions cStringForAtariSTInactiveRightBorderMiddlePixels];
            bottom = [Definitions cStringForAtariSTInactiveRightBorderBottomPixels];
            palette = "b #000000\n. #ffffff\n";
        }
        [Definitions drawInBitmap:bitmap top:top palette:palette middle:middle palette:palette bottom:bottom palette:palette x:r.x+r.w-21 y:r.y+19+infoBarHeight h:r.h-19-infoBarHeight-21];

        if (hasFocus && !_disableVerticalScrollBar) {
//            [bitmap drawCString:verticalKnobPixels palette:"b #000000\n. #ffffff\n" x:r.x+r.w-16 y:_verticalKnobY+_verticalKnobVal];
            [Definitions drawInBitmap:bitmap top:verticalKnobTopPixels palette:palette middle:verticalKnobMiddlePixels palette:palette bottom:verticalKnobBottomPixels palette:palette x:r.x+r.w-21 y:_verticalKnobY+_verticalKnobVal h:_verticalKnobH];
            if ([_buttonDown isEqual:@"verticalKnob"]) {
                char *h = [Definitions cStringForMacWindowSelectionHorizontal];
                char *v = [Definitions cStringForMacWindowSelectionVertical];
                char *palette = "b #000000\nw #ffffff\n";
                [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x+r.w-21 y:_verticalKnobY+_verticalKnobVal w:18 palette:palette];
                [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x+r.w-21 y:_verticalKnobY+_verticalKnobVal+1 h:_verticalKnobH-2];
                [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x+r.w-21+18-1 y:_verticalKnobY+_verticalKnobVal+1 h:_verticalKnobH-2];
                [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x+r.w-21 y:_verticalKnobY+_verticalKnobVal+_verticalKnobH-1 w:18 palette:palette];
            }
        }
    }




    if (hasFocus) {
        char *palette = "b #000000\nw #ffffff\n";
        if ([_buttonDown isEqual:@"titleBar"]) {
            char *h = [Definitions cStringForMacWindowSelectionHorizontal];
            char *v = [Definitions cStringForMacWindowSelectionVertical];
            [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y w:r.w-2 palette:palette];
            [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x y:r.y+1 h:r.h-2-2];
            [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x+r.w-1-2 y:r.y+1 h:r.h-2-2];
            [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y+r.h-2-1 w:r.w-2 palette:palette];
        } else if ([_buttonDown isEqual:@"resizeButton"]) {
            char *h = [Definitions cStringForMacWindowSelectionHorizontal];
            char *v = [Definitions cStringForMacWindowSelectionVertical];
            [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y w:r.w-2 palette:palette];
            [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x y:r.y+1 h:r.h-2-2];
            [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x+r.w-1-2 y:r.y+1 h:r.h-2-2];
            [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y+r.h-2-1 w:r.w-2 palette:palette];


            [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x+1 y:r.y+19+18 w:r.w-1-21 palette:palette];
            [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x+1 y:r.y+19+18+1 h:r.h-19-18-21-2];
            [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x+r.w-21-1 y:r.y+19+18+1 h:r.h-19-18-21-2];
            [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x+1 y:r.y+r.h-21-1 w:r.w-1-21 palette:palette];
        }
    }
}

- (void)handleMouseDown:(id)event
{
    {
        id x11dict = [event valueForKey:@"x11dict"];
        unsigned long win = [[x11dict valueForKey:@"window"] unsignedLongValue];
        id windowManager = [@"windowManager" valueForKey];
        [windowManager XRaiseWindow:win];
    }

    [self setValue:nil forKey:@"buttonDown"];
    [self setValue:nil forKey:@"buttonHover"];

    [self setValue:nil forKey:@"selected"];
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    int viewWidth = [event intValueForKey:@"viewWidth"];
    int viewHeight = [event intValueForKey:@"viewHeight"];

    if ([Definitions isX:mouseX y:mouseY insideRect:_leftArrowRect]) {
        if (_disableHorizontalScrollBar) {
            return;
        }
        [self setValue:@"leftArrow" forKey:@"buttonDown"];
        [self setValue:@"leftArrow" forKey:@"buttonHover"];
        _visibleX -= 10;
        if (_visibleX < _contentXMin) {
            _visibleX = _contentXMin;
        }
        return;
    }
    if ([Definitions isX:mouseX y:mouseY insideRect:_rightArrowRect]) {
        if (_disableHorizontalScrollBar) {
            return;
        }
        [self setValue:@"rightArrow" forKey:@"buttonDown"];
        [self setValue:@"rightArrow" forKey:@"buttonHover"];
        _visibleX += 10;
        if (_visibleX > _contentXMax+1 - _visibleW) {
            _visibleX = _contentXMax+1 - _visibleW;
        }
        return;
    }
    if ([Definitions isX:mouseX y:mouseY insideRect:_upArrowRect]) {
        if (_disableVerticalScrollBar) {
            return;
        }
        [self setValue:@"upArrow" forKey:@"buttonDown"];
        [self setValue:@"upArrow" forKey:@"buttonHover"];
        _visibleY -= 10;
        if (_visibleY < _contentYMin) {
            _visibleY = _contentYMin;
        }
        return;
    }
    if ([Definitions isX:mouseX y:mouseY insideRect:_downArrowRect]) {
        if (_disableVerticalScrollBar) {
            return;
        }
        [self setValue:@"downArrow" forKey:@"buttonDown"];
        [self setValue:@"downArrow" forKey:@"buttonHover"];
        _visibleY += 10;
        if (_visibleY > _contentYMax+1 - _visibleH) {
            _visibleY = _contentYMax+1 - _visibleH;
        }
        return;
    }
    if (mouseX >= viewWidth-17) {
        if (mouseY >= viewHeight-17) {
            [self setValue:@"resizeButton" forKey:@"buttonDown"];
            [self setValue:nil forKey:@"buttonHover"];
            _buttonDownX = mouseX;
            _buttonDownY = mouseY;
            _buttonDownW = viewWidth;
            _buttonDownH = viewHeight;
            return;
        }
    }
    if ([Definitions isX:mouseX y:mouseY insideRect:_closeButtonRect]) {
        [self setValue:@"closeButton" forKey:@"buttonDown"];
        [self setValue:@"closeButton" forKey:@"buttonHover"];
        _buttonDownX = mouseX;
        _buttonDownY = mouseY;
        _buttonDownW = viewWidth;
        _buttonDownH = viewHeight;
        return;
    }
    if ([Definitions isX:mouseX y:mouseY insideRect:_maximizeButtonRect]) {
        [self setValue:@"maximizeButton" forKey:@"buttonDown"];
        [self setValue:@"maximizeButton" forKey:@"buttonHover"];
        _buttonDownX = mouseX;
        _buttonDownY = mouseY;
        _buttonDownW = viewWidth;
        _buttonDownH = viewHeight;
        return;
    }
    if ([Definitions isX:mouseX y:mouseY insideRect:_titleBarRect]) {
        [self setValue:@"titleBar" forKey:@"buttonDown"];
        [self setValue:nil forKey:@"buttonHover"];
        _buttonDownX = mouseX;
        _buttonDownY = mouseY;
        _buttonDownW = viewWidth;
        _buttonDownH = viewHeight;
        return;
    }

    if (mouseY > _leftArrowRect.y) {
        if (mouseY < _leftArrowRect.y+_leftArrowRect.h-1) {
            if (_disableHorizontalScrollBar) {
                return;
            }
            if (mouseX < _horizontalKnobX) {
            } else if (mouseX < _horizontalKnobX+_horizontalKnobVal) {
                _visibleX -= _visibleW;
                if (_visibleX < _contentXMin) {
                    _visibleX = _contentXMin;
                }
                return;
            } else if (mouseX < _horizontalKnobX+_horizontalKnobVal+_horizontalKnobW) {
                [self setValue:@"horizontalKnob" forKey:@"buttonDown"];
                _buttonDownX = mouseX - (_horizontalKnobX+_horizontalKnobVal);
                return;
            } else if (mouseX < _horizontalKnobX+_horizontalKnobMaxVal+_horizontalKnobW) {
                _visibleX += _visibleW;
                if (_visibleX > _contentXMax+1 - _visibleW) {
                    _visibleX = _contentXMax+1 - _visibleW;
                }
                return;
            }
        }
    }

    if (mouseX > _upArrowRect.x) {
        if (mouseX < _upArrowRect.x+_upArrowRect.w-1) {
            if (_disableVerticalScrollBar) {
                return;
            }
            if (mouseY < _verticalKnobY) {
            } else if (mouseY < _verticalKnobY+_verticalKnobVal) {
                _visibleY -= _visibleH;
                if (_visibleY < _contentYMin) {
                    _visibleY = _contentYMin;
                }
                return;
            } else if (mouseY < _verticalKnobY+_verticalKnobVal+_verticalKnobH) {
                [self setValue:@"verticalKnob" forKey:@"buttonDown"];
                _buttonDownY = mouseY - (_verticalKnobY+_verticalKnobVal);
                return;
            } else if (mouseY < _verticalKnobY+_verticalKnobMaxVal+_verticalKnobH) {
                _visibleY += _visibleH;
                if (_visibleY > _contentYMax+1 - _visibleH) {
                    _visibleY = _contentYMax+1 - _visibleH;
                }
                return;
            }
        }
    }



    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        int x = -_visibleX + [elt intValueForKey:@"x"];
        int y = -_visibleY + [elt intValueForKey:@"y"] + 19 + 20;
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
                id filePath = [_selected valueForKey:@"filePath"];
                if ([filePath length]) {
                    if ([filePath isDirectory]) {
                        id cmd = nsarr();
                        [cmd addObject:@"hotdog"];
                        [cmd addObject:@"ataristdir"];
                        [cmd addObject:filePath];
                        [cmd runCommandInBackground];
                    } else {
                        id cmd = nsarr();
                        [cmd addObject:@"hotdog-open:.pl"];
                        [cmd addObject:filePath];
                        [cmd runCommandInBackground];
                    }
                }
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
    if (!_buttonDown) {
        return;
    }
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    if ([_buttonDown isEqual:@"leftArrow"]) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_leftArrowRect]) {
            [self setValue:_buttonDown forKey:@"buttonHover"];
        } else {
            [self setValue:nil forKey:@"buttonHover"];
        }
    } else if ([_buttonDown isEqual:@"rightArrow"]) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_rightArrowRect]) {
            [self setValue:_buttonDown forKey:@"buttonHover"];
        } else {
            [self setValue:nil forKey:@"buttonHover"];
        }
    } else if ([_buttonDown isEqual:@"upArrow"]) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_upArrowRect]) {
            [self setValue:_buttonDown forKey:@"buttonHover"];
        } else {
            [self setValue:nil forKey:@"buttonHover"];
        }
    } else if ([_buttonDown isEqual:@"downArrow"]) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_downArrowRect]) {
            [self setValue:_buttonDown forKey:@"buttonHover"];
        } else {
            [self setValue:nil forKey:@"buttonHover"];
        }
    } else if ([_buttonDown isEqual:@"closeButton"]) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_closeButtonRect]) {
            [self setValue:_buttonDown forKey:@"buttonHover"];
        } else {
            [self setValue:nil forKey:@"buttonHover"];
        }
        return;
    } else if ([_buttonDown isEqual:@"maximizeButton"]) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_maximizeButtonRect]) {
            [self setValue:_buttonDown forKey:@"buttonHover"];
        } else {
            [self setValue:nil forKey:@"buttonHover"];
        }
        return;
    } else if ([_buttonDown isEqual:@"titleBar"]) {
        int mouseRootX = [event intValueForKey:@"mouseRootX"];
        int mouseRootY = [event intValueForKey:@"mouseRootY"];
        int viewHeight = [event intValueForKey:@"viewHeight"];

        id dict = [event valueForKey:@"x11dict"];

        int newX = mouseRootX - _buttonDownX;
        int newY = mouseRootY - _buttonDownY;

        [dict setValue:nsfmt(@"%d", newX) forKey:@"x"];
        [dict setValue:nsfmt(@"%d", newY) forKey:@"y"];

        [dict setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
        return;
    } else if ([_buttonDown isEqual:@"resizeButton"]) {
        int viewWidth = [event intValueForKey:@"viewWidth"];
        int viewHeight = [event intValueForKey:@"viewHeight"];

        id dict = [event valueForKey:@"x11dict"];

        int newWidth = mouseX + (_buttonDownW - _buttonDownX);
        if (newWidth < 100) {
            newWidth = 100;
        }
        int newHeight = mouseY + (_buttonDownH - _buttonDownY);
        if (newHeight < 100) {
            newHeight = 100;
        }
        [dict setValue:nsfmt(@"%d %d", newWidth, newHeight) forKey:@"resizeWindow"];
        return;
    } else if ([_buttonDown isEqual:@"horizontalKnob"]) {
        _horizontalKnobVal = mouseX - _horizontalKnobX - _buttonDownX;
        if (_horizontalKnobVal < 0) {
            _horizontalKnobVal = 0;
        } else if (_horizontalKnobVal > _horizontalKnobMaxVal) {
            _horizontalKnobVal = _horizontalKnobMaxVal;
        }

    } else if ([_buttonDown isEqual:@"verticalKnob"]) {
        _verticalKnobVal = mouseY - _verticalKnobY - _buttonDownY;
        if (_verticalKnobVal < 0) {
            _verticalKnobVal = 0;
        } else if (_verticalKnobVal > _verticalKnobMaxVal) {
            _verticalKnobVal = _verticalKnobMaxVal;
        }

    } else {
        [_buttonDown setValue:nsfmt(@"%d", mouseX - _buttonDownOffsetX + _visibleX) forKey:@"x"];
        [_buttonDown setValue:nsfmt(@"%d", mouseY - _buttonDownOffsetY + _visibleY - 19 - 20) forKey:@"y"];
        [self setValue:nil forKey:@"buttonDownTimestamp"];
    }
}

- (void)handleMouseUp:(id)event
{
    if ([_buttonDown isEqual:@"closeButton"] && [_buttonDown isEqual:_buttonHover]) {
        exit(0);
    }
    if ([_buttonDown isEqual:@"maximizeButton"] && [_buttonDown isEqual:_buttonHover]) {
/*
        id x11dict = [event valueForKey:@"x11dict"];
        id windowManager = [event valueForKey:@"windowManager"];
        [windowManager raiseObjectWindow:x11dict];
*/
    }
    if ([_buttonDown isEqual:@"horizontalKnob"]) {
        int contentWidth = _contentXMax - _contentXMin - _visibleW;
        double pct = 0.0;
        if (_horizontalKnobMaxVal) {
            pct = (double)_horizontalKnobVal / (double)_horizontalKnobMaxVal;
        }
        _visibleX = _contentXMin + contentWidth*pct;
    }
    if ([_buttonDown isEqual:@"verticalKnob"]) {
        int contentHeight = _contentYMax - _contentYMin - _visibleH;
        double pct = 0.0;
        if (_verticalKnobMaxVal) {
            pct = (double)_verticalKnobVal / (double)_verticalKnobMaxVal;
        }
        _visibleY = _contentYMin + contentHeight*pct;
    }
    [self setValue:nil forKey:@"buttonDown"];
    [self setValue:nil forKey:@"buttonHover"];
}

@end

