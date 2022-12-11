#import "HOTDOG.h"

static char *oldManPalette =
". #DB2B00\n"
"X #FF9B3B\n"
"o #ffffff\n"
;
static id oldManPixels =
@"     XXXXXX     \n"
@"    oXoXXoXo    \n"
@"    XX XX XX    \n"
@"    XX XX XX    \n"
@"    .oXXXXo.    \n"
@"   .oooooooo.   \n"
@"  ..oo    oo..  \n"
@" ..oo.oooo.oo.. \n"
@"X..o..oooo..o..X\n"
@"X.....oooo.....X\n"
@"X... ..oo.. ...X\n"
@" ... ...... ... \n"
@" ... ...... ... \n"
@"  . ........ .  \n"
@"    ........    \n"
@"   ..XX..XX..   \n"
;

@implementation Definitions(fjeklwjfklsdmklfmklsd)
+ (id)OldMan
{
    return [@"OldMan" asInstance];
}
@end

@interface OldMan : IvarObject
{
    int _iteration;
    int _mouseDown;
    id _oldManPixels;
    int _oldManWidth;
    int _oldManHeight;
    id _scaledFont;
    id _text;
    int _scrollY;
}
@end
@implementation OldMan
- (id)init
{
    self = [super init];
    if (self) {
        id obj;
        obj = [oldManPixels asXYScaledPixels:3];
        [self setValue:obj forKey:@"oldManPixels"];
        _oldManWidth = [Definitions widthForCString:[obj UTF8String]];
        _oldManHeight = [Definitions heightForCString:[obj UTF8String]];
/*
        obj = [Definitions scaleFont:2
                :[Definitions arrayOfCStringsForC64Font]
                :[Definitions arrayOfWidthsForC64Font]
                :[Definitions arrayOfHeightsForC64Font]
                :[Definitions arrayOfXSpacingsForC64Font]];
        [self setValue:obj forKey:@"scaledFont"];
*/
    }
    return self;
}
- (BOOL)shouldAnimate
{
    if (_mouseDown) {
        return NO;
    }
    return YES;
}
- (void)beginIteration:(id)event rect:(Int4)r
{
    _iteration++;
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    if (_scaledFont) {
        [bitmap useFont:[[_scaledFont nth:0] bytes]
                    :[[_scaledFont nth:1] bytes]
                    :[[_scaledFont nth:2] bytes]
                    :[[_scaledFont nth:3] bytes]];
    } else {
        [bitmap useAtariSTFont];
    }

    [bitmap setColor:@"black"];
    [bitmap fillRect:r];

    int x = (r.w - _oldManWidth)/2;
    int y = _scrollY + 10;
    [bitmap drawCString:[_oldManPixels UTF8String] palette:oldManPalette x:x y:y];

    if (!_text) {
        return;
    }

    y += _oldManHeight+20;
    id text = _text;
    if (!_mouseDown) {
        int textlen = [text length];
        int len = _iteration / 5;
        if (len < textlen) {
            text = [text stringToIndex:len];
        }
    }
    [bitmap setColor:@"white"];
    x = 10;
    int w = r.w-20;
    text = [bitmap fitBitmapString:text width:w];
    [bitmap drawBitmapText:text x:x y:y];
}
- (void)handleMouseDown:(id)event
{
    _mouseDown = 1;
}
- (void)handleScrollWheel:(id)event
{
    int dy = [event intValueForKey:@"scrollingDeltaY"];
    _scrollY -= dy;
}
@end

