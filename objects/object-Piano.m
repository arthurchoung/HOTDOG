#import "HOTDOG.h"

@implementation Definitions(jklmklsafmklasdmflkasdmklfm)
+ (id)Piano
{
    return [@"Piano" asInstance];
}
@end

static unsigned char *white_key =
"bbbbbbbbbbbbb\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
"b           b\n"
".b         b.\n"
"..bbbbbbbbb..\n"
;
static unsigned char *black_key =
"bbbbbbbb\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
"b      b\n"
".bbbbbb.\n"
;
@interface Piano : IvarObject
{
    char _noteOn[256];
}
@end
@implementation Piano
- (void)setNoteOn:(int)i
{
    if ((i >= 0) && (i <= 255)) {
        _noteOn[i] = 1;
    }
}
- (void)setNoteOff:(int)i
{
    if ((i >= 0) && (i <= 255)) {
        _noteOn[i] = 0;
    }
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    int pianoheight = [Definitions heightForCString:white_key];
    int pianoy = r.y + r.h - pianoheight - 5;
    
    char pianox[640];
    for (int i=0; i<640; i++) {
        pianox[i] = 0;
    }
    for (int i=0; i<52; i++) {
        int x = 5+i*12;
        pianox[x] = 1;
    }
    for (int i=0; i<51; i++) {
        if (i % 7 == 1) {
            continue;
        }
        if (i % 7 == 4) {
            continue;
        }
        int x = 5+i*12+8;
        pianox[x] = 1;
    }
    {
        char count = 0;
        for (int i=0; i<640; i++) {
            if (pianox[i]) {
                count++;
                pianox[i] = count;
            }
        }
    }
    
    [bitmap setColor:@"#0000aa"];
    [bitmap fillRect:r];
    for (int i=0; i<52; i++) {
        int x = 5+i*12;
        int pianokey = pianox[x];
        if (_noteOn[pianokey]) {
            [bitmap drawCString:white_key palette:"b #000000\n  #0088ff" x:x y:pianoy];
        } else {
            [bitmap drawCString:white_key palette:"b #000000\n  #ffffff" x:x y:pianoy];
        }
    }
    for (int i=0; i<51; i++) {
        if (i % 7 == 1) {
            continue;
        }
        if (i % 7 == 4) {
            continue;
        }
        int x = 5+i*12+8;
        int pianokey = pianox[x];
        if (_noteOn[pianokey]) {
            [bitmap drawCString:black_key palette:"b #000000\n  #0088ff" x:x y:pianoy];
        } else {
            [bitmap drawCString:black_key palette:"b #000000\n  #000000" x:x y:pianoy];
        }
    }
}
- (void)handleKeyDown:(id)event
{
    id keyString = [event valueForKey:@"keyString"];
    if ([keyString length] == 1) {
        char *cstr = [keyString UTF8String];
        int c = *cstr - 'a';
        if (c >= 0 && c <= 255) {
            _noteOn[c] = 1;
        }
    }
}
@end

