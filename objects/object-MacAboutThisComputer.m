#import "HOTDOG.h"

#define MAX_BUTTONS 9

static unsigned char *button_left =
"   b\n"
" bb.\n"
" b..\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
;
static unsigned char *button_middle =
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
".\n"
".\n"
;
static unsigned char *button_right =
"b   \n"
".bb \n"
"..b \n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
;

@implementation Definitions(fjeklwjflksdjf)
+ (id)MacAboutThisComputer
{
    id dict;
    id arr = nsarr();
    id result;

    dict = nsdict();
    [dict setValue:@"Overview" forKey:@"text"];
    [dict setValue:@"['hotdog-aboutOverview.pl'] | runCommandAndReturnOutput | asString" forKey:@"message"];
    [arr addObject:dict];

    dict = nsdict();
    [dict setValue:@"Monitors" forKey:@"text"];
    [dict setValue:@"['hotdog-aboutMonitors.pl'] | runCommandAndReturnOutput | asString" forKey:@"message"];
    [arr addObject:dict];

    dict = nsdict();
    [dict setValue:@"Memory" forKey:@"text"];
    [dict setValue:@"['hotdog-aboutMemory.pl'] | runCommandWithSudoAndReturnOutput | asString" forKey:@"message"];
    [arr addObject:dict];

    dict = nsdict();
    [dict setValue:@"Drives" forKey:@"text"];
    [dict setValue:@"['hotdog-aboutDrives.pl'] | runCommandAndReturnOutput | asString" forKey:@"message"];
    [arr addObject:dict];

    [self setValue:arr forKey:@"array"];

    id obj = [@"MacAboutThisComputer" asInstance];
    [obj setValue:arr forKey:@"array"];
    return obj;
}
@end


@interface MacAboutThisComputer : IvarObject
{
    Int4 _rect[MAX_BUTTONS];
    id _array;
    id _result;
    int _selected;
    char _buttonDown;
    char _buttonHover;
}
@end
@implementation MacAboutThisComputer
- (void)beginIteration:(id)event rect:(Int4)r
{
    if (!_result) {
        id message = [[_array nth:_selected] valueForKey:@"message"];
        id result = [nsdict() evaluateMessage:message];
        if (!result) {
            result = nsfmt(@"Unable to evaluate message: %@", message);
        }
        [self setValue:result forKey:@"result"];
    }
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{

    int width = 0;
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        id text = [elt valueForKey:@"text"];
        int textWidth = [bitmap bitmapWidthForText:text];
        width += textWidth + 20 - 1;
    }

    [bitmap setColor:@"white"];
    [bitmap fillRect:r];

    int x = 10 + (r.w-width-20)/2;
    int y = r.y+10;
    for (int i=0; i<[_array count]; i++) {
        if (i >= MAX_BUTTONS) {
            break;
        }
        id elt = [_array nth:i];
        id text = [elt valueForKey:@"text"];
        int textWidth = [bitmap bitmapWidthForText:text];
        char *palette;
        if ((_buttonDown == i+1) && (_buttonDown == _buttonHover)) {
            if (i == _selected) {
                palette = ". #0000aa\nb #000000\nw #ffffff\n";
            } else {
                palette = ". #aaaaaa\nb #000000\nw #ffffff\n";
            }
        } else {
            if (i == _selected) {
                palette = ". #0000ff\nb #000000\nw #ffffff\n";
            } else {
                palette = ". #ffffff\nb #000000\nw #ffffff\n";
            }
        }
        _rect[i].x = x;
        _rect[i].y = y;
        _rect[i].w = textWidth+20-1;
        _rect[i].h = 20;
        [Definitions drawInBitmap:bitmap left:button_left middle:button_middle right:button_right x:x y:y w:textWidth+20 palette:palette];
        if (i == _selected) {
            [bitmap setColor:@"white"];
        } else {
            [bitmap setColor:@"black"];
        }
        [bitmap drawBitmapText:text x:x+10 y:r.y+15];
        x += textWidth+20-1;
    }

    [bitmap setColor:@"black"];
    [bitmap drawRectangleAtX:r.x+10 y:r.y+34 w:r.w-20 h:r.h-44];
    [bitmap setColor:@"blue"];
    [bitmap fillRectangleAtX:r.x+10 y:r.y+30 w:r.w-20 h:5];

    [bitmap setColor:@"black"];
    Int4 r1 = [Definitions rectWithX:r.x+20 y:r.y+44 w:r.w-40 h:r.h-64];
    if (_result) {
        id str = [bitmap fitBitmapString:_result width:r1.w];
        [bitmap drawBitmapText:str x:r1.x y:r1.y];
    }
}

- (void)handleMouseDown:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    for (int i=0; i<[_array count]; i++) {
        if (i >= MAX_BUTTONS) {
            break;
        }
        if ([Definitions isX:mouseX y:mouseY insideRect:_rect[i]]) {
            _buttonDown = i+1;
            return;
        }
    }
}
- (void)handleMouseMoved:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    for (int i=0; i<[_array count]; i++) {
        if (i >= MAX_BUTTONS) {
            break;
        }
        if ([Definitions isX:mouseX y:mouseY insideRect:_rect[i]]) {
            _buttonHover = i+1;
            return;
        }
    }
    _buttonHover = 0;
}
- (void)handleMouseUp:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    for (int i=0; i<[_array count]; i++) {
        if (i >= MAX_BUTTONS) {
            break;
        }
        if ([Definitions isX:mouseX y:mouseY insideRect:_rect[i]]) {
            if (_buttonDown) {
                if (_buttonDown == _buttonHover) {
                    _selected = _buttonDown-1;
                    [self setValue:nil forKey:@"result"];
                }
            }
            break;
        }
    }
    _buttonDown = 0;
}

@end

