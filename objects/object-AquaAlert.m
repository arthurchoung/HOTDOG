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

@implementation Definitions(Fjewilfmlkdsmvlksdkjffjkjekwljfklwe)
+ (id)testAquaAlert
{
    id obj = [@"AquaAlert" asInstance];
    [obj setValue:@"HJKLJDKLSFJDSKLF" forKey:@"text"];
    [obj setValue:@"OK" forKey:@"okText"];
    [obj setValue:@"Cancel" forKey:@"cancelText"];
    return obj;
}
+ (id)AquaAlert:(id)text
{
    id obj = [@"AquaAlert" asInstance];
    [obj setValue:text forKey:@"text"];
    return obj;
}
@end

static unsigned char button_left[] = {
0,14,0,25, // 0,width,0,height
  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,239,239,239,239,239,239,238,238,238,238,238,238,238,238,238, // 0
  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,234,234,234,193,193,193,155,155,155,129,129,129,109,109,109, 94, 94, 94, 94, 94, 94, // 1
  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,234,234,234,197,197,197,146,146,146,122,122,122,163,163,163,201,201,201,228,228,228,245,245,245,249,249,249, // 2
  0,255,  0,  0,255,  0,  0,255,  0,239,239,239,238,238,238,181,181,181,136,136,136,168,168,168,226,226,226,242,242,242,244,244,244,243,243,243,244,244,244,244,244,244, // 3
  0,255,  0,  0,255,  0,  0,255,  0,238,238,238,184,184,184,138,138,138,187,187,187,237,237,237,240,240,240,239,239,239,239,239,239,241,241,241,240,240,240,241,241,241, // 4
  0,255,  0,  0,255,  0,234,234,234,199,199,199,145,145,145,175,175,175,229,229,229,236,236,236,237,237,237,236,236,236,236,236,236,237,237,237,238,238,238,238,238,238, // 5
  0,255,  0,235,235,235,230,230,230,156,156,156,156,156,156,216,216,216,231,231,231,233,233,233,235,235,235,235,235,235,236,236,236,236,236,236,237,237,237,236,236,236, // 6
  0,255,  0,238,238,238,194,194,194,140,140,140,182,182,182,222,222,222,230,230,230,232,232,232,233,233,233,234,234,234,235,235,235,236,236,236,236,236,236,236,236,236, // 7
  0,255,  0,235,235,235,162,162,162,153,153,153,195,195,195,220,220,220,231,231,231,232,232,232,234,234,234,235,235,235,235,235,235,236,236,236,236,236,236,236,236,236, // 8
235,235,235,227,227,227,131,131,131,169,169,169,196,196,196,205,205,205,228,228,228,233,233,233,233,233,233,234,234,234,236,236,236,235,235,235,235,235,235,237,237,237, // 9
235,235,235,225,225,225,112,112,112,187,187,187,198,198,198,202,202,202,205,205,205,208,208,208,211,211,211,216,216,216,215,215,215,218,218,218,217,217,217,218,218,218, // 10
238,238,238,227,227,227,101,101,101,200,200,200,205,205,205,206,206,206,208,208,208,212,212,212,217,217,217,218,218,218,220,220,220,222,222,222,222,222,222,223,223,223, // 11
238,238,238,226,226,226,108,108,108,195,195,195,210,210,210,209,209,209,215,215,215,216,216,216,219,219,219,221,221,221,223,223,223,224,224,224,227,227,227,227,227,227, // 12
235,235,235,223,223,223,125,125,125,179,179,179,215,215,215,215,215,215,216,216,216,220,220,220,225,225,225,227,227,227,229,229,229,230,230,230,230,230,230,231,231,231, // 13
235,235,235,225,225,225,148,148,148,156,156,156,222,222,222,219,219,219,221,221,221,224,224,224,226,226,226,227,227,227,234,234,234,234,234,234,233,233,233,235,235,235, // 14
239,239,239,231,231,231,179,179,179,125,125,125,214,214,214,227,227,227,227,227,227,231,231,231,231,231,231,235,235,235,234,234,234,236,236,236,238,238,238,240,240,240, // 15
  0,255,  0,235,235,235,217,217,217,135,135,135,169,169,169,234,234,234,237,237,237,236,236,236,239,239,239,241,241,241,242,242,242,243,243,243,243,243,243,243,243,243, // 16
  0,255,  0,234,234,234,223,223,223,173,173,173,127,127,127,198,198,198,248,248,248,244,244,244,247,247,247,247,247,247,247,247,247,248,248,248,245,245,245,249,249,249, // 17
  0,255,  0,235,235,235,230,230,230,214,214,214,155,155,155,134,134,134,204,204,204,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255, // 18
  0,255,  0,  0,255,  0,238,238,238,230,230,230,211,211,211,155,155,155,131,131,131,180,180,180,239,239,239,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255, // 19
  0,255,  0,  0,255,  0,  0,255,  0,238,238,238,229,229,229,211,211,211,166,166,166,128,128,128,133,133,133,173,173,173,209,209,209,236,236,236,252,252,252,255,255,255, // 20
  0,255,  0,  0,255,  0,  0,255,  0,235,235,235,234,234,234,226,226,226,215,215,215,194,194,194,157,157,157,134,134,134,117,117,117,106,106,106, 96, 96, 96, 96, 96, 96, // 21
  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,235,235,235,230,230,230,223,223,223,213,213,213,201,201,201,191,191,191,184,184,184,180,180,180,177,177,177, // 22
  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,239,239,239,238,238,238,235,235,235,233,233,233,229,229,229,226,226,226,225,225,225,225,225,225, // 23
  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,239,239,239,239,239,239,239,239,239,238,238,238,238,238,238,238,238,238 // 24
};
static unsigned char button_middle[] = {
0,1,0,25, // 0,width,0,height
238,238,238, // 0
 94, 94, 94, // 1
249,249,249, // 2
244,244,244, // 3
241,241,241, // 4
238,238,238, // 5
236,236,236, // 6
236,236,236, // 7
236,236,236, // 8
237,237,237, // 9
218,218,218, // 10
223,223,223, // 11
227,227,227, // 12
231,231,231, // 13
235,235,235, // 14
240,240,240, // 15
243,243,243, // 16
249,249,249, // 17
255,255,255, // 18
255,255,255, // 19
255,255,255, // 20
 96, 96, 96, // 21
177,177,177, // 22
225,225,225, // 23
238,238,238 // 24
};
static unsigned char button_right[] = {
0,17,0,25, // 0,width,0,height
238,238,238,238,238,238,238,238,238,238,238,238,239,239,239,240,240,240,239,239,239,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0, // 0
 94, 94, 94, 94, 94, 94, 94, 94, 94,109,109,109,129,129,129,155,155,155,193,193,193,234,234,234,235,235,235,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0, // 1
249,249,249,249,249,249,245,245,245,228,228,228,201,201,201,164,164,164,121,121,121,146,146,146,198,198,198,234,234,234,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0, // 2
244,244,244,244,244,244,244,244,244,243,243,243,244,244,244,242,242,242,226,226,226,168,168,168,136,136,136,181,181,181,238,238,238,239,239,239,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0, // 3
241,241,241,241,241,241,240,240,240,241,241,241,239,239,239,239,239,239,240,240,240,237,237,237,187,187,187,138,138,138,184,184,184,238,238,238,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0, // 4
238,238,238,238,238,238,238,238,238,237,237,237,236,236,236,236,236,236,237,237,237,236,236,236,229,229,229,175,175,175,145,145,145,199,199,199,234,234,234,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0, // 5
236,236,236,236,236,236,237,237,237,236,236,236,236,236,236,235,235,235,235,235,235,233,233,233,231,231,231,216,216,216,156,156,156,155,155,155,230,230,230,235,235,235,  0,255,  0,  0,255,  0,  0,255,  0, // 6
236,236,236,236,236,236,236,236,236,236,236,236,235,235,235,234,234,234,233,233,233,232,232,232,230,230,230,222,222,222,182,182,182,140,140,140,194,194,194,238,238,238,  0,255,  0,  0,255,  0,  0,255,  0, // 7
236,236,236,236,236,236,236,236,236,236,236,236,235,235,235,235,235,235,234,234,234,232,232,232,231,231,231,220,220,220,195,195,195,153,153,153,161,161,161,235,235,235,  0,255,  0,  0,255,  0,  0,255,  0, // 8
237,237,237,237,237,237,235,235,235,235,235,235,236,236,236,234,234,234,233,233,233,233,233,233,228,228,228,205,205,205,196,196,196,169,169,169,131,131,131,227,227,227,235,235,235,  0,255,  0,  0,255,  0, // 9
218,218,218,218,218,218,217,217,217,218,218,218,215,215,215,216,216,216,211,211,211,208,208,208,205,205,205,202,202,202,198,198,198,187,187,187,112,112,112,225,225,225,235,235,235,  0,255,  0,  0,255,  0, // 10
223,223,223,223,223,223,222,222,222,222,222,222,220,220,220,218,218,218,217,217,217,212,212,212,208,208,208,206,206,206,205,205,205,200,200,200,101,101,101,227,227,227,238,238,238,  0,255,  0,  0,255,  0, // 11
227,227,227,227,227,227,227,227,227,224,224,224,223,223,223,221,221,221,219,219,219,216,216,216,215,215,215,209,209,209,210,210,210,195,195,195,107,107,107,226,226,226,238,238,238,  0,255,  0,  0,255,  0, // 12
231,231,231,231,231,231,230,230,230,230,230,230,229,229,229,227,227,227,225,225,225,220,220,220,216,216,216,215,215,215,215,215,215,179,179,179,125,125,125,223,223,223,234,234,234,  0,255,  0,  0,255,  0, // 13
235,235,235,235,235,235,233,233,233,234,234,234,234,234,234,227,227,227,226,226,226,224,224,224,221,221,221,219,219,219,222,222,222,156,156,156,148,148,148,225,225,225,235,235,235,  0,255,  0,  0,255,  0, // 14
240,240,240,240,240,240,238,238,238,236,236,236,234,234,234,235,235,235,231,231,231,231,231,231,227,227,227,227,227,227,214,214,214,125,125,125,179,179,179,231,231,231,239,239,239,  0,255,  0,  0,255,  0, // 15
243,243,243,243,243,243,243,243,243,243,243,243,242,242,242,241,241,241,239,239,239,236,236,236,237,237,237,234,234,234,169,169,169,135,135,135,216,216,216,236,236,236,  0,255,  0,  0,255,  0,  0,255,  0, // 16
249,249,249,249,249,249,245,245,245,248,248,248,247,247,247,247,247,247,247,247,247,244,244,244,248,248,248,199,199,199,127,127,127,173,173,173,223,223,223,234,234,234,  0,255,  0,  0,255,  0,  0,255,  0, // 17
255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,204,204,204,135,135,135,155,155,155,214,214,214,230,230,230,235,235,235,  0,255,  0,  0,255,  0,  0,255,  0, // 18
255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,239,239,239,180,180,180,131,131,131,155,155,155,211,211,211,230,230,230,238,238,238,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0, // 19
255,255,255,255,255,255,252,252,252,236,236,236,209,209,209,173,173,173,133,133,133,128,128,128,165,165,165,211,211,211,230,230,230,238,238,238,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0, // 20
 96, 96, 96, 97, 97, 97, 97, 97, 97,105,105,105,117,117,117,134,134,134,157,157,157,194,194,194,215,215,215,226,226,226,234,234,234,235,235,235,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0, // 21
177,177,177,178,178,178,181,181,181,184,184,184,191,191,191,201,201,201,212,212,212,223,223,223,230,230,230,234,234,234,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0, // 22
224,224,224,224,224,224,226,226,226,226,226,226,229,229,229,233,233,233,235,235,235,238,238,238,239,239,239,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0, // 23
238,238,238,238,238,238,238,238,238,239,239,239,239,239,239,239,239,239,239,239,239,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0 // 24
};

static unsigned char blue_button_left[] = {
0,15,0,25, // 0,width,0,height
  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,239,239,239,239,239,239,238,238,238,238,238,238,238,238,238,238,238,238, // 0
  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,234,234,234,177,177,208,124,124,185, 88, 88,172, 58, 58,160, 37, 37,151, 38, 38,153, 38, 38,153, // 1
  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,234,234,234,183,183,210,113,113,180, 57, 58,163,102,106,187,147,156,210,181,190,225,199,212,236,200,213,237,200,213,237, // 2
  0,255,  0,  0,255,  0,  0,255,  0,239,239,239,238,238,238,162,162,200, 82, 82,170,102,105,185,167,175,220,189,202,233,192,209,235,190,209,235,191,210,236,187,210,236,187,210,236, // 3
  0,255,  0,  0,255,  0,  0,255,  0,238,238,238,167,167,199, 78, 81,169,111,120,192,170,182,224,174,192,229,175,197,231,174,200,232,173,203,233,177,204,234,176,205,234,176,205,234, // 4
  0,255,  0,  0,255,  0,234,234,234,190,190,207, 97,102,169, 72, 94,181,142,168,218,156,184,225,157,190,229,158,193,229,162,196,230,164,198,231,165,198,232,166,199,232,166,199,232, // 5
  0,255,  0,235,235,235,230,230,230,138,138,172, 54, 83,168, 96,141,209,137,177,222,142,183,226,149,188,228,156,192,231,159,194,231,157,193,232,160,194,231,159,195,232,159,195,232, // 6
  0,255,  0,238,238,238,189,189,200, 85,101,157, 25, 94,186,102,159,216,135,179,225,144,185,227,147,189,228,150,189,229,154,191,230,152,191,230,153,191,231,154,193,233,154,193,233, // 7
  0,255,  0,235,235,235,156,156,171, 54, 93,162, 23,111,200,104,161,218,137,181,226,139,184,227,147,188,230,148,190,232,149,190,232,152,192,234,152,192,234,152,193,236,152,193,236, // 8
235,235,235,227,227,227,125,125,140, 35,103,177, 40,123,206, 79,145,210,131,179,226,142,186,231,145,188,233,150,192,234,151,193,237,150,193,235,147,190,236,151,194,238,151,194,238, // 9
235,235,235,225,225,225,107,107,121, 35,115,197, 59,134,211, 76,144,214, 90,154,220, 99,161,225,101,164,228,106,169,234,103,167,233,110,173,238,110,172,236,110,173,238,110,173,238, // 10
238,238,238,227,227,227, 96, 96,108, 39,121,209, 78,147,217, 95,157,221, 98,161,224,110,168,230,114,173,235,116,177,237,115,176,240,120,180,242,123,182,243,119,181,244,119,181,244, // 11
238,238,238,226,226,226,104,104,115, 54,129,204, 89,155,225, 98,161,225,113,172,231,119,176,235,122,181,240,123,182,241,126,185,246,125,185,246,128,189,251,127,188,250,127,188,250, // 12
235,235,235,223,223,223,125,125,125, 71,129,188, 91,159,228,110,171,234,118,176,235,123,184,242,128,188,248,132,191,251,134,194,255,134,196,255,137,197,255,136,197,255,136,197,255, // 13
235,235,235,225,225,225,148,148,148, 78,119,160, 91,162,234,112,173,238,123,182,241,132,190,248,132,192,253,134,193,253,142,202,255,144,203,255,140,201,255,143,204,255,143,204,255, // 14
239,239,239,231,231,231,179,179,179, 86,106,127, 84,154,226,112,178,245,125,187,248,137,196,255,136,196,255,144,203,255,144,204,255,146,206,255,147,208,255,149,210,255,149,210,255, // 15
  0,255,  0,235,235,235,217,217,217,135,135,135, 83,127,172,108,180,250,127,190,255,137,197,255,145,206,255,149,210,255,149,210,255,155,215,255,156,217,255,156,217,255,156,217,255, // 16
  0,255,  0,234,234,234,223,223,223,173,173,173,103,115,129, 97,152,204,128,197,255,140,204,255,149,211,255,152,216,255,155,218,255,157,223,255,158,221,255,159,223,255,159,223,255, // 17
  0,255,  0,235,235,235,230,230,230,214,214,214,155,155,155, 99,117,134,111,164,204,144,215,255,154,220,255,160,225,255,164,228,255,166,228,255,161,226,255,166,230,255,166,230,255, // 18
  0,255,  0,  0,255,  0,238,238,238,230,230,230,211,211,211,155,155,155,111,123,130,119,157,180,148,213,239,162,233,255,165,235,255,167,236,255,168,235,255,172,239,255,172,239,255, // 19
  0,255,  0,  0,255,  0,  0,255,  0,238,238,238,229,229,229,211,211,211,166,166,166,128,128,128,109,126,133,128,165,173,149,204,209,160,227,236,165,241,252,175,249,255,175,249,255, // 20
  0,255,  0,  0,255,  0,  0,255,  0,235,235,235,234,234,234,226,226,226,215,215,215,194,194,194,157,157,157,134,134,134,117,117,117,106,106,106, 96, 96, 96, 96, 96, 96, 96, 96, 96, // 21
  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,235,235,235,230,230,230,223,223,223,213,213,213,201,201,201,191,191,191,184,184,184,180,180,180,177,177,177,177,177,177, // 22
  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,239,239,239,238,238,238,235,235,235,233,233,233,229,229,229,226,226,226,225,225,225,225,225,225,224,224,224, // 23
  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,239,239,239,239,239,239,239,239,239,238,238,238,238,238,238,238,238,238,238,238,238 // 24
};
static unsigned char blue_button_middle[] = {
0,1,0,25, // 0,width,0,height
238,238,238, // 0
 38, 38,153, // 1
200,213,237, // 2
187,210,236, // 3
176,205,234, // 4
166,199,232, // 5
159,195,232, // 6
154,193,233, // 7
152,193,236, // 8
151,194,238, // 9
110,173,238, // 10
119,181,244, // 11
127,188,250, // 12
136,197,255, // 13
143,204,255, // 14
149,210,255, // 15
156,217,255, // 16
159,223,255, // 17
166,230,255, // 18
172,239,255, // 19
175,249,255, // 20
 96, 96, 96, // 21
177,177,177, // 22
224,224,224, // 23
238,238,238 // 24
};
static unsigned char blue_button_right[] = {
0,26,0,25, // 0,width,0,height
238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,239,239,239,240,240,240,239,239,239,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0, // 0
 38, 38,153, 38, 38,153, 38, 38,153, 37, 37,152, 38, 38,153, 38, 38,153, 38, 38,153, 38, 38,153, 38, 38,153, 38, 38,153, 38, 38,153, 38, 38,152, 58, 58,160, 88, 88,172,124,124,185,177,177,208,234,234,234,235,235,235,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0, // 1
200,213,237,200,213,237,200,213,237,200,213,237,200,213,237,200,213,237,200,213,237,200,213,237,200,213,237,200,213,237,200,213,237,199,212,236,181,190,225,147,156,210,103,107,187, 56, 57,163,113,113,180,184,184,210,234,234,234,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0, // 2
187,210,236,187,210,236,187,210,236,187,210,236,187,210,236,187,210,236,187,210,236,187,210,236,187,210,236,187,210,236,187,210,236,191,210,236,190,209,235,192,209,235,189,202,233,167,175,220,103,105,186, 82, 82,170,162,162,200,238,238,238,239,239,239,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0, // 3
176,205,234,176,205,234,176,205,234,176,205,234,176,205,234,176,205,234,176,205,234,176,205,234,176,205,234,176,205,234,176,205,234,177,204,234,173,203,233,174,200,232,175,197,231,174,192,229,170,182,224,110,119,192, 78, 81,169,167,167,199,238,238,238,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0, // 4
166,199,232,166,199,232,166,199,232,166,199,232,166,199,232,166,199,232,166,199,232,166,199,232,166,199,232,166,199,232,166,199,232,165,198,232,164,198,231,162,196,230,158,193,229,157,190,229,156,184,225,142,168,218, 72, 94,181, 96,101,168,189,189,206,234,234,234,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0, // 5
159,195,232,159,195,232,159,195,232,159,195,232,159,195,232,159,195,232,159,195,232,159,195,232,159,195,232,159,195,232,159,195,232,160,194,231,157,193,232,159,194,231,156,192,231,149,188,228,142,183,226,137,177,222, 96,141,209, 54, 83,168,137,137,171,230,230,230,235,235,235,  0,255,  0,  0,255,  0,  0,255,  0, // 6
154,193,233,154,193,233,154,193,233,154,193,233,154,193,233,154,193,233,154,193,233,154,193,233,154,193,233,154,193,233,154,193,233,153,191,231,152,191,230,154,191,230,150,189,229,147,189,228,144,185,227,135,179,225,102,159,216, 25, 94,186, 85,101,157,189,189,200,238,238,238,  0,255,  0,  0,255,  0,  0,255,  0, // 7
152,193,236,152,193,236,152,193,236,152,193,236,152,193,236,152,193,236,152,193,236,152,193,236,152,193,236,152,193,236,152,193,236,152,192,234,152,192,234,149,190,232,148,190,232,147,188,230,139,184,227,137,181,226,104,161,218, 23,111,200, 54, 93,162,155,155,170,235,235,235,  0,255,  0,  0,255,  0,  0,255,  0, // 8
151,194,238,151,194,238,151,194,238,151,194,238,151,194,238,151,194,238,151,194,238,151,194,238,151,194,238,151,194,238,151,194,238,147,190,236,150,193,235,151,193,237,150,192,234,145,188,233,142,186,231,131,179,226, 79,145,210, 40,123,206, 35,104,177,125,125,140,227,227,227,235,235,235,  0,255,  0,  0,255,  0, // 9
110,173,238,110,173,238,110,173,238,110,173,238,110,173,238,110,173,238,110,173,238,110,173,238,110,173,238,110,173,238,110,173,238,110,172,236,110,173,238,103,167,233,106,169,234,101,164,228, 99,161,225, 90,154,220, 76,144,214, 59,134,211, 35,115,197,107,107,121,225,225,225,235,235,235,  0,255,  0,  0,255,  0, // 10
119,181,244,119,181,244,119,181,244,119,181,244,119,181,244,119,181,244,119,181,244,119,181,244,119,181,244,119,181,244,119,181,244,123,182,243,120,180,242,115,176,240,116,177,237,114,173,235,110,168,230, 98,161,224, 95,157,221, 78,147,217, 39,121,209, 96, 96,108,227,227,227,238,238,238,  0,255,  0,  0,255,  0, // 11
127,188,250,127,188,250,127,188,250,127,188,250,127,188,250,127,188,250,127,188,250,127,188,250,127,188,250,127,188,250,127,188,250,128,189,251,125,185,246,126,185,246,123,182,241,122,181,240,119,176,235,113,172,231, 98,161,225, 89,155,225, 54,129,204,103,103,114,226,226,226,238,238,238,  0,255,  0,  0,255,  0, // 12
136,197,255,136,197,255,136,197,255,136,197,255,136,197,255,136,197,255,136,197,255,136,197,255,136,197,255,136,197,255,136,197,255,137,197,255,134,196,255,134,194,255,132,191,251,128,188,248,123,184,242,118,176,235,110,171,234, 91,159,228, 71,129,188,125,125,125,223,223,223,234,234,234,  0,255,  0,  0,255,  0, // 13
143,204,255,143,204,255,143,204,255,143,204,255,143,204,255,143,204,255,143,204,255,143,204,255,143,204,255,143,204,255,143,204,255,140,201,255,144,203,255,142,202,255,134,193,253,132,192,253,132,190,248,123,182,241,112,173,238, 91,162,234, 78,119,160,148,148,148,225,225,225,235,235,235,  0,255,  0,  0,255,  0, // 14
149,210,255,149,210,255,149,210,255,149,210,255,149,210,255,149,210,255,149,210,255,149,210,255,149,210,255,149,210,255,149,210,255,147,208,255,146,206,255,144,204,255,144,203,255,136,196,255,137,196,255,125,187,248,112,178,245, 84,154,226, 86,106,127,179,179,179,231,231,231,239,239,239,  0,255,  0,  0,255,  0, // 15
156,217,255,156,217,255,156,217,255,156,217,255,156,217,255,156,217,255,156,217,255,156,217,255,156,217,255,156,217,255,156,217,255,156,217,255,155,215,255,149,210,255,149,210,255,145,206,255,137,197,255,127,190,255,108,180,250, 83,127,172,135,135,135,216,216,216,236,236,236,  0,255,  0,  0,255,  0,  0,255,  0, // 16
159,223,255,159,223,255,159,223,255,159,223,255,159,223,255,159,223,255,159,223,255,159,223,255,159,223,255,159,223,255,159,223,255,158,221,255,157,223,255,155,218,255,152,216,255,149,211,255,140,204,255,128,197,255, 98,153,204,103,115,129,173,173,173,223,223,223,234,234,234,  0,255,  0,  0,255,  0,  0,255,  0, // 17
166,230,255,166,230,255,166,230,255,166,230,255,166,230,255,166,230,255,166,230,255,166,230,255,166,230,255,166,230,255,166,230,255,161,226,255,166,228,255,164,228,255,160,225,255,154,220,255,144,215,255,111,164,204,100,118,134,155,155,155,214,214,214,230,230,230,235,235,235,  0,255,  0,  0,255,  0,  0,255,  0, // 18
172,239,255,172,239,255,172,239,255,172,239,255,172,239,255,172,239,255,172,239,255,172,239,255,172,239,255,172,239,255,172,239,255,168,235,255,167,236,255,165,235,255,162,233,255,148,213,239,119,157,180,111,123,130,155,155,155,211,211,211,230,230,230,238,238,238,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0, // 19
175,249,255,175,249,255,175,249,255,175,249,255,175,249,255,175,249,255,175,249,255,175,249,255,175,249,255,175,249,255,175,249,255,165,241,252,160,227,236,149,204,209,128,165,173,109,126,133,128,128,128,165,165,165,211,211,211,230,230,230,238,238,238,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0, // 20
 97, 97, 97, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 97, 97, 97, 97, 97, 97,105,105,105,117,117,117,134,134,134,157,157,157,194,194,194,215,215,215,226,226,226,234,234,234,235,235,235,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0, // 21
177,177,177,177,177,177,178,178,178,177,177,177,178,178,178,177,177,177,177,177,177,177,177,177,177,177,177,177,177,177,178,178,178,181,181,181,184,184,184,191,191,191,201,201,201,212,212,212,223,223,223,230,230,230,234,234,234,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0, // 22
225,225,225,225,225,225,225,225,225,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,226,226,226,226,226,226,229,229,229,233,233,233,235,235,235,238,238,238,239,239,239,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0, // 23
238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,238,239,239,239,239,239,239,239,239,239,239,239,239,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0,  0,255,  0 // 24
};



@interface AquaAlert : IvarObject
{
    id _text;
    Int4 _okRect;
    Int4 _cancelRect;
    id _okText;
    id _cancelText;
    char _buttonDown;
    char _buttonHover;
    int _dialogMode;
    int _x11WaitForFocusOutThenClose;
    int _returnKey;
}
@end

@implementation AquaAlert
- (int)preferredWidth
{
    return 480;
}
- (int)preferredHeight
{
    if (!_text) {
        return 288;
    }
    id bitmap = [Definitions bitmapWithWidth:1 height:1];
    [bitmap useWinSystemFont];
    int lineHeight = [bitmap bitmapHeightForText:@"X"];
    id text = [bitmap fitBitmapString:_text width:480-60];
    int textHeight = [bitmap bitmapHeightForText:text];
    textHeight += 16+50+lineHeight;
    if (textHeight > 288) {
        return textHeight;
    }
    return 288;
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [bitmap useWinSystemFont];
    [Definitions drawHorizontalStripesInBitmap:bitmap rect:r];

    // text

    id text = [bitmap fitBitmapString:_text width:r.w-60];
    [bitmap setColor:@"black"];
    [bitmap drawBitmapText:text x:r.x+30 y:r.y+16];

    // ok button

    if (_okText) {
        int textWidth = [bitmap bitmapWidthForText:_okText];
        int innerWidth = 70;
        if (textWidth > innerWidth) {
            innerWidth = textWidth;
        }
        _okRect.x = r.x+r.w-20-(innerWidth+16);
        _okRect.y = r.y+r.h-40;
        _okRect.w = innerWidth+16;
        _okRect.h = 25;
        if ((_buttonDown == 'c') || ((_buttonDown == 'o') && (_buttonHover != 'o'))) {
            [self drawButtonInBitmap:bitmap rect:_okRect :button_left :button_middle :button_right];
        } else {
            [self drawButtonInBitmap:bitmap rect:_okRect :blue_button_left :blue_button_middle :blue_button_right];
        }
        [bitmap setColor:@"black"];
        [bitmap drawBitmapText:_okText x:_okRect.x+(_okRect.w-textWidth)/2 y:_okRect.y+5];
    } else {
        _okRect.x = 0;
        _okRect.y = 0;
        _okRect.w = 0;
        _okRect.h = 0;
    }

    // cancel button

    if (_cancelText) {
        int textWidth = [bitmap bitmapWidthForText:_cancelText];
        int innerWidth = 70;
        if (textWidth > innerWidth) {
            innerWidth = textWidth;
        }
        _cancelRect.w = innerWidth+16;
        _cancelRect.h = 25;
        _cancelRect.x = r.x+r.w-_okRect.w-20-20-_cancelRect.w;
        _cancelRect.y = r.y+r.h-40;
        if ((_buttonDown == 'c') && (_buttonHover == 'c')) {
            [self drawButtonInBitmap:bitmap rect:_cancelRect :blue_button_left :blue_button_middle :blue_button_right];
        } else {
            [self drawButtonInBitmap:bitmap rect:_cancelRect :button_left :button_middle :button_right];
        }


        [bitmap setColor:@"black"];
        [bitmap drawBitmapText:_cancelText x:_cancelRect.x+(_cancelRect.w-textWidth)/2 y:_cancelRect.y+5];
    } else {
        _cancelRect.x = 0;
        _cancelRect.y = 0;
        _cancelRect.w = 0;
        _cancelRect.h = 0;
    }
}
- (void)handleMouseDown:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    if (_okText && [Definitions isX:mouseX y:mouseY insideRect:_okRect]) {
        _buttonDown = 'o';
        _buttonHover = 'o';
    } else if (_cancelText && [Definitions isX:mouseX y:mouseY insideRect:_cancelRect]) {
        _buttonDown = 'c';
        _buttonHover = 'c';
    } else {
        _buttonDown = 0;
        _buttonHover = 0;
    }
}
- (void)handleMouseMoved:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    if (_okText && [Definitions isX:mouseX y:mouseY insideRect:_okRect]) {
        _buttonHover = 'o';
    } else if (_cancelText && [Definitions isX:mouseX y:mouseY insideRect:_cancelRect]) {
        _buttonHover = 'c';
    } else {
        _buttonHover = 0;
    }
}
- (void)handleMouseUp:(id)event
{
    if (_buttonDown == _buttonHover) {
        if (_buttonDown == 'o') {
            if (_dialogMode) {
                exit(0);
            }
            printf("%@\n", _okText);
            id x11dict = [event valueForKey:@"x11dict"];
            [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
        } else if (_buttonDown == 'c') {
            if (_dialogMode) {
                exit(1);
            }
            id x11dict = [event valueForKey:@"x11dict"];
            [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
        }
    }
    _buttonDown = 0;
    _buttonHover = 0;
}
- (void)handleKeyDown:(id)event
{
    id str = [event valueForKey:@"keyString"];
    if ([str isEqual:@"return"] || [str isEqual:@"shift-return"]) {
        _returnKey = 1;
    }
}
- (void)handleKeyUp:(id)event
{
    id str = [event valueForKey:@"keyString"];
    if ([str isEqual:@"return"] || [str isEqual:@"shift-return"]) {
        if (_returnKey) {
            if (_dialogMode) {
                exit(0);
            }
            printf("%@\n", _okText);
            id x11dict = [event valueForKey:@"x11dict"];
            [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
            _returnKey = 0;
        }
    }
}
- (void)drawButtonInBitmap:(id)bitmap rect:(Int4)r :(unsigned char *)left :(unsigned char *)middle :(unsigned char *)right
{
    unsigned char *pixelBytes = [bitmap pixelBytes];
    if (!pixelBytes) {
        return;
    }
    int bitmapWidth = [bitmap bitmapWidth];
    int bitmapHeight = [bitmap bitmapHeight];
    int bitmapBytesPerRow = bitmapWidth*4;

    if (r.x < 0) {
        return;
    }
    if (r.x+r.w >= bitmapWidth) {
        return;
    }
    if (r.y < 0) {
        return;
    }
    if (r.y+r.h >= bitmapHeight) {
        return;
    }

    unsigned char *rgb = left;
if (!rgb) {
    return;
}
    
    int w1;
    int w2;
    int width;
    int height;
    int bytes_per_row;

    width = rgb[1];
    w1 = width;
    height = rgb[3];
    bytes_per_row = width*3;
    for (int y=0; y<height; y++) {
        for (int x=0; x<width; x++) {
            int i = (r.y+y)*bitmapBytesPerRow + (r.x+x)*4;
            int j = y*bytes_per_row + x*3;
            if (!rgb[4+j+2] && (rgb[4+j+1] == 255) && !rgb[4+j+0]) {
                continue;
            }
            pixelBytes[i] = rgb[4+j+2];
            pixelBytes[i+1] = rgb[4+j+1];
            pixelBytes[i+2] = rgb[4+j+0];
            pixelBytes[i+3] = 255;
        }
    }

    rgb = right;
if (!rgb) {
    return;
}

    width = rgb[1];
    w2 = width;
    height = rgb[3];
    bytes_per_row = width*3;
int offset = (r.w - w2) * 4;
    for (int y=0; y<height; y++) {
        for (int x=0; x<width; x++) {
            int i = (r.y+y)*bitmapBytesPerRow + (r.x+x)*4 + offset;
            int j = y*bytes_per_row + x*3;
            if (!rgb[4+j+2] && (rgb[4+j+1] == 255) && !rgb[4+j+0]) {
                continue;
            }
            pixelBytes[i] = rgb[4+j+2];
            pixelBytes[i+1] = rgb[4+j+1];
            pixelBytes[i+2] = rgb[4+j+0];
            pixelBytes[i+3] = 255;
        }
    }

    rgb = middle;
if (!rgb) {
    return;
}

    width = rgb[1];
    height = rgb[3];
    bytes_per_row = width*3;
    for (int y=0; y<height; y++) {
        for (int x=w1; x<r.w-w2; x++) {
            int i = (r.y+y)*bitmapBytesPerRow + (r.x+x)*4;
            int j = y*bytes_per_row;
            if (!rgb[4+j+2] && (rgb[4+j+1] == 255) && !rgb[4+j+0]) {
                continue;
            }
            pixelBytes[i] = rgb[4+j+2];
            pixelBytes[i+1] = rgb[4+j+1];
            pixelBytes[i+2] = rgb[4+j+0];
            pixelBytes[i+3] = 255;
        }
    }
}
- (void)handleFocusOutEvent:(id)event
{
    if (_x11WaitForFocusOutThenClose) {
        id x11dict = [event valueForKey:@"x11dict"];
        [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
    }
}
@end

