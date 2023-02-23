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

static char *radioPalette =
"b #000000\n"
". #222222\n"
"X #444444\n"
"o #555555\n"
"O #777777\n"
"+ #888888\n"
"@ #999999\n"
"# #AAAAAA\n"
"$ #BBBBBB\n"
"% #DDDDDD\n"
"& #EEEEEE\n"
"* #ffffff\n"
;
static char *radioPixels =
"    XbbX    \n"
"  bo%%%$Xb  \n"
" b$%&***%+b \n"
" o%&**&&%$X \n"
"X%&**&&%%$+X\n"
"b%**&&%%$$+b\n"
"b%*&&%%$$#+b\n"
"X$*&%%$$##+X\n"
" o%%%$$##+X \n"
" b+$$$##++b \n"
"  bo++++Xb  \n"
"    XbbX    \n"
;
static char *radioDownPalette =
"b #000000\n"
". #222222\n"
"X #444444\n"
"o #555555\n"
"O #666666\n"
"+ #777777\n"
"@ #888888\n"
"# #999999\n"
"$ #BBBBBB\n"
"% #DDDDDD\n"
"& #ffffff\n"
;
static char *radioDownPixels =
"    .bb.    \n"
"  .bXXXXXb  \n"
" .XXooOOO+b \n"
" bXooOO+++X \n"
".XooOO+++@#X\n"
"bXoOO+++@@#b\n"
"bXOO+++@@##b\n"
".XO+++@@##$X\n"
" .O++@@##$o \n"
" X++@@##$$b \n"
"  .X###$ob  \n"
"    XbbX    \n"
;
static char *radioSelectedPalette =
"b #000000\n"
". #222222\n"
"X #444444\n"
"o #555555\n"
"O #777777\n"
"+ #888888\n"
"@ #999999\n"
"# #AAAAAA\n"
"$ #BBBBBB\n"
"% #DDDDDD\n"
"& #EEEEEE\n"
"* #ffffff\n"
;
static char *radioSelectedPixels =
"    .bb.    \n"
"  .bXoooXb  \n"
" .XoOOO++@b \n"
" boObbbb@@X \n"
".XObbbbbb@$X\n"
"boObbbbbb$$b\n"
"boObbbbbb$%b\n"
".o+bbbbbb%*X\n"
" .+@bbbb%*X \n"
" .@@@$$%**b \n"
"  .X$$%*Xb  \n"
"    XbbX    \n"
;
static char *radioSelectedDownPalette =
"b #000000\n"
". #222222\n"
"X #444444\n"
"o #555555\n"
"O #666666\n"
"+ #777777\n"
"@ #888888\n"
"# #999999\n"
"$ #BBBBBB\n"
"% #DDDDDD\n"
"& #ffffff\n"
;
static char *radioSelectedDownPixels =
"    .bb.    \n"
"  .bXXXXXb  \n"
" .XXooOOO+b \n"
" bXobbbb++X \n"
".Xobbbbbb@#X\n"
"bXobbbbbb@#b\n"
"bXObbbbbb##b\n"
".XObbbbbb#$X\n"
" .O+bbbb#$o \n"
" X++@@##$$b \n"
"  .X###$ob  \n"
"    XbbX    \n"
;

static char *topBorderPalette =
"b #000000\n"
"o #BBBBBB\n"
"+ #ffffff\n"
;
static char *topBorderLeftPixels =
"bb\n"
"bo\n"
"bo\n"
;
static char *topBorderMiddlePixels =
"b\n"
"o\n"
"+\n"
;
static char *topBorderRightPixels =
"bbb \n"
"oob \n"
"o.bb\n"
;

static char *leftBorderPalette =
"b #000000\n"
". #BBBBBB\n"
"o #ffffff\n"
;

static char *leftBorderPixels =
"b.o\n"
;
static char *rightBorderPalette =
"b #000000\n"
". #555555\n"
"X #999999\n"
;
static char *rightBorderPixels =
"X.bb\n"
;

static char *bottomBorderPalette =
"b #000000\n"
". #555555\n"
"X #777777\n"
"o #888888\n"
"O #999999\n"
"+ #BBBBBB\n"
"@ #cccccc\n"
"# #DDDDDD\n"
"$ #ffffff\n"
;

static char *bottomBorderLeftPixels =
"b++\n"
"b+.\n"
"bbb\n"
"  b\n"
;
static char *bottomBorderMiddlePixels =
"O\n"
".\n"
"b\n"
"b\n"
;
static char *bottomBorderRightPixels =
"O.bb\n"
"..bb\n"
"bbbb\n"
"bbbb\n"
;

static char *okButtonPalette = 
"b #000000\n"
". #0E0E0E\n"
"X #1D1D1D\n"
"o #222222\n"
"O #2C2C2C\n"
"+ #3A3A3A\n"
"@ #494949\n"
"# #585858\n"
"$ #676767\n"
"% #757575\n"
"& #777777\n"
"* #848484\n"
"= #888888\n"
"- #939393\n"
"; #AAAAAA\n"
": #b0b0b0\n"
"> #BBBBBB\n"
", #bfbfbf\n"
"< #cccccc\n"
"1 #CECECE\n"
"2 #DDDDDD\n"
"3 #ffffff\n"
;
static char *okButtonPixels =
"   obbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbo   \n"
"  b222222222222222222222222222222222222222222222222222222222<b  \n"
" b22;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>b \n"
"o22;&obbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbo&;;=o\n"
"b2;&b>2222222222222222222222222222222222222222222222222222>b&;&b\n"
"b2;o>333333333333333333333333333333333333333333333333333332>o;&b\n"
"b2;b233222222222222222222222222222222222222222222222222222;&b;&b\n"
"b2;b232222222222222222222222222222222222222222222222222222;&b;&b\n"
"b2;b2322222222222bbbbX-22222222222222222222222222222222222;&b;&b\n"
"b2;b2322222222222bb2,Xb-2222222222222222222222222222222222;&b;&b\n"
"b2;b2322222222222bb22-bO21@bb@122bb-.b*221#bb@122222222222;&b;&b\n"
"b2;b2322222222222bb222bb2#b**b#22bb%,bb22$b%-b@22222222222;&b;&b\n"
"b2;b2322222222222bb222bb2bb22bb22bb,2bb22bb22bb22222222222;&b;&b\n"
"b2;b2322222222222bb222bb2bb22bb22bb22bb22bbbbbb22222222222;&b;&b\n"
"b2;b2322222222222bb22:bX2bb22bb22bb22bb22bb222222222222222;&b;&b\n"
"b2;b2322222222222bb21+b*2@b--b@22bb22bb22#b$22222222222222;&b;&b\n"
"b2;b2322222222222bbbb.$221@bb@122bb22bb221#bbbb22222222222;&b;&b\n"
"b2;b232222222222222222222222222222222222222222222222222222;&b;&b\n"
"b2;b232222222222222222222222222222222222222222222222222222;&b;&b\n"
"b2;b23222222222222222222222222222222222222222222222222222;;&b;&b\n"
"b2;o>2;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;&&o;&b\n"
"b2;&b>&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&b&;&b\n"
"o<;;&obbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbo&;=&o\n"
" b>;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;=&b \n"
"  b=&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&b  \n"
"   obbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbo   \n"
;
static char *okButtonLeftPixels =
"   obbb\n"
"  b2222\n"
" b22;;;\n"
"o22;&ob\n"
"b2;&b>2\n"
"b2;o>33\n"
"b2;b233\n"
"b2;b232\n"
"b2;b232\n"
"b2;b232\n"
"b2;b232\n"
"b2;b232\n"
"b2;b232\n"
"b2;b232\n"
"b2;b232\n"
"b2;b232\n"
"b2;b232\n"
"b2;b232\n"
"b2;b232\n"
"b2;b232\n"
"b2;o>2;\n"
"b2;&b>&\n"
"o<;;&ob\n"
" b>;;;;\n"
"  b=&&&\n"
"   obbb\n"
;
static char *okButtonMiddlePixels =
"b\n"
"2\n"
";\n"
"b\n"
"2\n"
"3\n"
"2\n"
"2\n"
"2\n"
"2\n"
"2\n"
"2\n"
"2\n"
"2\n"
"2\n"
"2\n"
"2\n"
"2\n"
"2\n"
"2\n"
";\n"
"&\n"
"b\n"
";\n"
"&\n"
"b\n"
;
static char *okButtonRightPixels =
"bbbo   \n"
"222<b  \n"
";;;;>b \n"
"bo&;;=o\n"
"2>b&;&b\n"
"32>o;&b\n"
"2;&b;&b\n"
"2;&b;&b\n"
"2;&b;&b\n"
"2;&b;&b\n"
"2;&b;&b\n"
"2;&b;&b\n"
"2;&b;&b\n"
"2;&b;&b\n"
"2;&b;&b\n"
"2;&b;&b\n"
"2;&b;&b\n"
"2;&b;&b\n"
"2;&b;&b\n"
";;&b;&b\n"
";&&o;&b\n"
"&&b&;&b\n"
"bo&;=&o\n"
";;;=&b \n"
"&&&&b  \n"
"bbbo   \n"
;

static char *okButtonDownPalette =
"b #000000\n"
". #222222\n"
"X #444444\n"
"o #555555\n"
"O #666666\n"
"+ #777777\n"
"@ #888888\n"
"# #999999\n"
"$ #AAAAAA\n"
"% #BBBBBB\n"
"& #cccccc\n"
"* #DDDDDD\n"
"= #EEEEEE\n"
"- #ffffff\n"
;

static char *okButtonDownPixels =
"   .bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb.   \n"
"  b*******************************************************************&b  \n"
" b**$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%b \n"
".**$+.bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb.+$$@.\n"
"b*$+bXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXb+$+b\n"
"b*$.XXooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooO+.$+b\n"
"b*$bXooOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO+@b$+b\n"
"b*$bXoOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO+@b$+b\n"
"b*$bXoOOOOOOO@*---OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO@-OOOOOOOO+@b$+b\n"
"b*$bXoOOOOOO@--+O&OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO=-OOOOOOOO+@b$+b\n"
"b*$bXoOOOOOO*-#OOOO+&--&+OO--#--$OO--#--$OO+&--&+OOO&---O-----OOOOOO+@b$+b\n"
"b*$bXoOOOOOO--+OOOO&-$$-&OO--$+--OO--$+--OO%-$#-&OO%-%O&OO--OOOOOOOO+@b$+b\n"
"b*$bXoOOOOOO--OOOOO--OO--OO--+O--OO--+O--OO--OO--OO--OOOOO--OOOOOOOO+@b$+b\n"
"b*$bXoOOOOOO--OOOOO--OO--OO--OO--OO--OO--OO------OO--OOOOO--OOOOOOOO+@b$+b\n"
"b*$bXoOOOOOO*-#OOOO--OO--OO--OO--OO--OO--OO--OOOOOO--OOOOO--OOOOOOOO+@b$+b\n"
"b*$bXoOOOOOO@-=+OOO&-##-&OO--OO--OO--OO--OO&-%OOOOO&-#OOOO--@OOOOOOO+@b$+b\n"
"b*$bXoOOOOOOO@*---O+&--&+OO--OO--OO--OO--OO+&----OO+&---OO@---OOOOOO+@b$+b\n"
"b*$bXoOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO+@b$+b\n"
"b*$bXoOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO+@b$+b\n"
"b*$bXoOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO++@b$+b\n"
"b*$.XO++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++@@.$+b\n"
"b*$+b+@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@b+$+b\n"
".&$$+.bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb.+$@+.\n"
" b%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$@+b \n"
"  b@+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++b  \n"
"   .bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb.   \n"
;
static char *okButtonDownLeftPixels =
"   .bbb\n"
"  b****\n"
" b**$$$\n"
".**$+.b\n"
"b*$+bXX\n"
"b*$.XXo\n"
"b*$bXoo\n"
"b*$bXoO\n"
"b*$bXoO\n"
"b*$bXoO\n"
"b*$bXoO\n"
"b*$bXoO\n"
"b*$bXoO\n"
"b*$bXoO\n"
"b*$bXoO\n"
"b*$bXoO\n"
"b*$bXoO\n"
"b*$bXoO\n"
"b*$bXoO\n"
"b*$bXoO\n"
"b*$.XO+\n"
"b*$+b+@\n"
".&$$+.b\n"
" b%$$$$\n"
"  b@+++\n"
"   .bbb\n"
;
static char *okButtonDownMiddlePixels =
"b\n"
"*\n"
"$\n"
"b\n"
"X\n"
"o\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"+\n"
"@\n"
"b\n"
"$\n"
"+\n"
"b\n"
;
static char *okButtonDownRightPixels =
"bbb.   \n"
"***&b  \n"
"$$$$%b \n"
"b.+$$@.\n"
"XXb+$+b\n"
"oO+.$+b\n"
"O+@b$+b\n"
"O+@b$+b\n"
"O+@b$+b\n"
"O+@b$+b\n"
"O+@b$+b\n"
"O+@b$+b\n"
"O+@b$+b\n"
"O+@b$+b\n"
"O+@b$+b\n"
"O+@b$+b\n"
"O+@b$+b\n"
"O+@b$+b\n"
"O+@b$+b\n"
"++@b$+b\n"
"+@@.$+b\n"
"@@b+$+b\n"
"b.+$@+.\n"
"$$$@+b \n"
"++++b  \n"
"bbb.   \n"
;

static char *cancelButtonPalette =
"b #000000\n"
". #111111\n"
"X #222222\n"
"o #333333\n"
"O #444444\n"
"+ #555555\n"
"@ #666666\n"
"# #777777\n"
"$ #888888\n"
"% #999999\n"
"& #AAAAAA\n"
"* #BBBBBB\n"
"= #cccccc\n"
"- #DDDDDD\n"
"; #ffffff\n"
;


static char *cancelButtonPixels =
"  XbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbX  \n"
" b*----------------------------------------------------*b \n"
"X*;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;-*X\n"
"b-;;---------------------------------------------------&#b\n"
"b-;----------------------------------------------------&#b\n"
"b-;-------*obbb--------------------------------bb------&#b\n"
"b-;------*bb=-O--------------------------------bb------&#b\n"
"b-;------ob%-----bbbb&--bb%bb$---+bbb--=+bbO=--bb------&#b\n"
"b-;------bb=-------=bb--bb#=bb--@b@-O--@b#%bO--bb------&#b\n"
"b-;------bb-----*.bbbb--bb=-bb--bb-----bb--bb--bb------&#b\n"
"b-;------bb-----.b&*bb--bb--bb--bb-----bbbbbb--bb------&#b\n"
"b-;------ob%----bb-=bb--bb--bb--bb-----bb------bb------&#b\n"
"b-;------&b.=---bb*#bb--bb--bb--+b%----+b@-----bb------&#b\n"
"b-;-------&obbb-$bb$bb--bb--bb--=+bbb--=+bbbb--bb------&#b\n"
"b-;----------------------------------------------------&#b\n"
"b-;----------------------------------------------------&#b\n"
"b-;---------------------------------------------------&&#b\n"
"X*-&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&##X\n"
" b*#####################################################b \n"
"  XbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbX  \n"
;

static char *cancelButtonLeftPixels =
"  Xb\n"
" b*-\n"
"X*;;\n"
"b-;;\n"
"b-;-\n"
"b-;-\n"
"b-;-\n"
"b-;-\n"
"b-;-\n"
"b-;-\n"
"b-;-\n"
"b-;-\n"
"b-;-\n"
"b-;-\n"
"b-;-\n"
"b-;-\n"
"b-;-\n"
"X*-&\n"
" b*#\n"
"  Xb\n"
;
static char *cancelButtonMiddlePixels =
"b\n"
"-\n"
";\n"
"-\n"
"-\n"
"-\n"
"-\n"
"-\n"
"-\n"
"-\n"
"-\n"
"-\n"
"-\n"
"-\n"
"-\n"
"-\n"
"-\n"
"&\n"
"#\n"
"b\n"
;
static char *cancelButtonRightPixels =
"bX  \n"
"-*b \n"
";-*X\n"
"-&#b\n"
"-&#b\n"
"-&#b\n"
"-&#b\n"
"-&#b\n"
"-&#b\n"
"-&#b\n"
"-&#b\n"
"-&#b\n"
"-&#b\n"
"-&#b\n"
"-&#b\n"
"-&#b\n"
"&&#b\n"
"&##X\n"
"##b \n"
"bX  \n"
;

static char *cancelButtonDownPalette =
"b #000000\n"
". #222222\n"
"X #444444\n"
"o #555555\n"
"O #666666\n"
"+ #777777\n"
"@ #888888\n"
"# #999999\n"
"$ #AAAAAA\n"
"% #BBBBBB\n"
"& #cccccc\n"
"* #DDDDDD\n"
"= #EEEEEE\n"
"- #ffffff\n"
;
static char *cancelButtonDownPixels =
"  .bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb.  \n"
" bXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXb \n"
".XXooooooooooooooooooooooooooooooooooooooooooooooooooooO+.\n"
"bXooOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO+@b\n"
"bXoOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO+@b\n"
"bXoOOOOOOO@*---OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO--OOOOOO+@b\n"
"bXoOOOOOO@--+O&OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO--OOOOOO+@b\n"
"bXoOOOOOO*-#OOOOO----@OO--#--$OOO&---OO+&--&+OO--OOOOOO+@b\n"
"bXoOOOOOO--+OOOOOOO+--OO--$+--OO%-%O&OO%-$#-&OO--OOOOOO+@b\n"
"bXoOOOOOO--OOOOO@=----OO--+O--OO--OOOOO--OO--OO--OOOOOO+@b\n"
"bXoOOOOOO--OOOOO=-@@--OO--OO--OO--OOOOO------OO--OOOOOO+@b\n"
"bXoOOOOOO*-#OOOO--O+--OO--OO--OO--OOOOO--OOOOOO--OOOOOO+@b\n"
"bXoOOOOOO@-=+OOO--@$--OO--OO--OO&-#OOOO&-%OOOOO--OOOOOO+@b\n"
"bXoOOOOOOO@*---O$--$--OO--OO--OO+&---OO+&----OO--OOOOOO+@b\n"
"bXoOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO+@b\n"
"bXoOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO+@b\n"
"bXoOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO++@b\n"
".XO++++++++++++++++++++++++++++++++++++++++++++++++++++@@.\n"
" b+@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@b \n"
"  .bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb.  \n"
;
static char *cancelButtonDownLeftPixels =
"  .b\n"
" bXX\n"
".XXo\n"
"bXoo\n"
"bXoO\n"
"bXoO\n"
"bXoO\n"
"bXoO\n"
"bXoO\n"
"bXoO\n"
"bXoO\n"
"bXoO\n"
"bXoO\n"
"bXoO\n"
"bXoO\n"
"bXoO\n"
"bXoO\n"
".XO+\n"
" b+@\n"
"  .b\n"
;
static char *cancelButtonDownMiddlePixels =
"b\n"
"X\n"
"o\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"+\n"
"@\n"
"b\n"
;
static char *cancelButtonDownRightPixels =
"b.  \n"
"XXb \n"
"oO+.\n"
"O+@b\n"
"O+@b\n"
"O+@b\n"
"O+@b\n"
"O+@b\n"
"O+@b\n"
"O+@b\n"
"O+@b\n"
"O+@b\n"
"O+@b\n"
"O+@b\n"
"O+@b\n"
"O+@b\n"
"++@b\n"
"+@@.\n"
"@@b \n"
"b.  \n"
;


#define MAX_RADIO 20

@implementation Definitions(fjewmfnkdslnfsdjffdsjkflsdmkmklfdsjfjdskfjkfjdksfjk)
+ (id)MacPlatinumRadio
{
    id lines = [Definitions linesFromStandardInput];
    id obj = [@"MacPlatinumRadio" asInstance];
    [obj setValue:@"jfkdlsjflkdsjfkljdsklf" forKey:@"text"];
    [obj setValue:lines forKey:@"array"];
    [obj setValue:@"OK" forKey:@"okText"];
    [obj setValue:@"Cancel" forKey:@"cancelText"];
    [obj setValue:@"1" forKey:@"dialogMode"];
    return obj;
}
@end

@interface MacPlatinumRadio : IvarObject
{
    int _dialogMode;
    id _text;
    id _array;
    int _selectedIndex;
    Int4 _rect[MAX_RADIO];
    char _down;
    char _hover;
    Int4 _okRect;
    Int4 _cancelRect;
    id _okText;
    id _cancelText;
}
@end
@implementation MacPlatinumRadio
- (int)preferredWidth
{
    return 640;
}
- (int)preferredHeight
{
    id bitmap = [Definitions bitmapWithWidth:1 height:1];
    int lineHeight = [bitmap bitmapHeightForText:@"X"];
    int radioWidth = [Definitions widthForCString:radioPixels];
    int h = 24;
    int w = 640-89-18;
    {
        id text = [bitmap fitBitmapString:_text width:w];
        h += [bitmap bitmapHeightForText:text] + lineHeight;
    }
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        id text = [elt valueForKey:@"text"];
        if (!text) {
            text = elt;
        }
        text = [bitmap fitBitmapString:text width:w-radioWidth-10-lineHeight];
        h += [bitmap bitmapHeightForText:text] + lineHeight;
    }
    h += 21 + 28 + 21;
    return h;
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [bitmap setColor:@"#dddddd"];
    [bitmap fillRect:r];
    [Definitions drawInBitmap:bitmap left:topBorderLeftPixels middle:topBorderMiddlePixels right:topBorderRightPixels x:r.x y:r.y w:r.w palette:topBorderPalette];
    [Definitions drawInBitmap:bitmap top:leftBorderPixels palette:leftBorderPalette middle:leftBorderPixels palette:leftBorderPalette bottom:leftBorderPixels palette:leftBorderPalette x:r.x y:r.y+3 h:r.h-3];
    [Definitions drawInBitmap:bitmap top:rightBorderPixels palette:rightBorderPalette middle:rightBorderPixels palette:rightBorderPalette bottom:rightBorderPixels palette:rightBorderPalette x:r.x+r.w-4 y:r.y+3 h:r.h-3];
    [Definitions drawInBitmap:bitmap left:bottomBorderLeftPixels middle:bottomBorderMiddlePixels right:bottomBorderRightPixels x:r.x y:r.y+r.h-4 w:r.w palette:bottomBorderPalette];

    {
        char *palette = "b #000000\n. #ffffff\n";
        [bitmap drawCString:[Definitions cStringForBitmapMessageIcon] palette:palette x:28 y:28];
    }

    int x = 89;
    int y = 24;

    int lineHeight = [bitmap bitmapHeightForText:@"X"];

    // text

    {
        int textWidth = r.w - x - 18;
        id text = [bitmap fitBitmapString:_text width:textWidth];
        int textHeight = [bitmap bitmapHeightForText:text];
        [bitmap setColorIntR:0 g:0 b:0 a:255];
        [bitmap drawBitmapText:text x:x y:y];
        y += textHeight + lineHeight;
    }

    // buttons

    int radioWidth = [Definitions widthForCString:radioPixels];
    int radioHeight = [Definitions heightForCString:radioPixels];
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        id text = [elt valueForKey:@"text"];
        if (!text) {
            text = elt;
        }
        _rect[i].x = x;
        _rect[i].y = y;
        text = [bitmap fitBitmapString:text width:r.w-radioWidth-10-(x-r.x)-20];
        int textWidth = [bitmap bitmapWidthForText:text];
        int textHeight = [bitmap bitmapHeightForText:text];
        _rect[i].w = radioWidth+10+textWidth;
        _rect[i].h = textHeight;
        char *pixels = radioPixels;
        char *palette = radioPalette;
        if ((_down==i+1) && (_hover==i+1)) {
            if (_selectedIndex == i) {
                pixels = radioSelectedDownPixels;
                palette = radioSelectedDownPalette;
            } else {
                pixels = radioDownPixels;
                palette = radioDownPalette;
            }
        } else {
            if (_selectedIndex == i) {
                pixels = radioSelectedPixels;
                palette = radioSelectedPalette;
            }
        }
        [bitmap drawCString:pixels palette:palette x:x y:y];
        [bitmap drawBitmapText:text x:x+radioWidth+10 y:y+1];
        y += textHeight + lineHeight;
    }
    // ok button

    if (_okText) {
        _okRect = [Definitions rectWithX:r.w-88 y:r.h-21-28 w:70 h:26];
        Int4 innerRect = _okRect;
//        innerRect.y += 1;
        if ((_down == 'o') && (_hover == 'o')) {
            [Definitions drawInBitmap:bitmap left:okButtonDownLeftPixels middle:okButtonDownMiddlePixels right:okButtonDownRightPixels x:_okRect.x y:_okRect.y w:_okRect.w palette:okButtonPalette];
            [bitmap setColorIntR:255 g:255 b:255 a:255];
            [bitmap drawBitmapText:_okText centeredInRect:innerRect];
        } else {
            [Definitions drawInBitmap:bitmap left:okButtonLeftPixels middle:okButtonMiddlePixels right:okButtonRightPixels x:_okRect.x y:_okRect.y w:_okRect.w palette:okButtonPalette];
            [bitmap setColorIntR:0 g:0 b:0 a:255];
            [bitmap drawBitmapText:_okText centeredInRect:innerRect];
        }
    } else {
        _okRect.x = 0;
        _okRect.y = 0;
        _okRect.w = 0;
        _okRect.h = 0;
    }

    // cancel button

    if (_cancelText) {
        _cancelRect = [Definitions rectWithX:_okRect.x-70-35 y:r.h-21-28+3 w:70 h:20];
        if ((_down == 'c') && (_hover == 'c')) {
            [Definitions drawInBitmap:bitmap left:cancelButtonDownLeftPixels middle:cancelButtonDownMiddlePixels right:cancelButtonDownRightPixels x:_cancelRect.x y:_cancelRect.y w:_cancelRect.w palette:cancelButtonPalette];
            [bitmap setColorIntR:255 g:255 b:255 a:255];
            [bitmap drawBitmapText:_cancelText centeredInRect:_cancelRect];
        } else {
            [Definitions drawInBitmap:bitmap left:cancelButtonLeftPixels middle:cancelButtonMiddlePixels right:cancelButtonRightPixels x:_cancelRect.x y:_cancelRect.y w:_cancelRect.w palette:cancelButtonPalette];
            [bitmap setColorIntR:0 g:0 b:0 a:255];
            [bitmap drawBitmapText:_cancelText centeredInRect:_cancelRect];
        }
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
        _down = 'o';
        _hover = 'o';
        return;
    }
    if (_cancelText && [Definitions isX:mouseX y:mouseY insideRect:_cancelRect]) {
        _down = 'c';
        _hover = 'c';
        return;
    }
    for (int i=0; i<[_array count]; i++) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_rect[i]]) {
            _down = i+1;
            _hover = i+1;
            return;
        }
    }
    _down = 0;
    _hover = 0;
}
- (void)handleMouseMoved:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    if (_okText && [Definitions isX:mouseX y:mouseY insideRect:_okRect]) {
        _hover = 'o';
        return;
    }
    if (_cancelText && [Definitions isX:mouseX y:mouseY insideRect:_cancelRect]) {
        _hover = 'c';
        return;
    }
    for (int i=0; i<[_array count]; i++) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_rect[i]]) {
            _hover = i+1;
            return;
        }
    }
    _hover = 0;
}
- (void)handleMouseUp:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    if (_down && (_down == _hover)) {
        if (_down == 'o') {
            if (_dialogMode) {
                FILE *fp = (_dialogMode == 1) ? stdout : stderr;
                id elt = [_array nth:_selectedIndex];
                id tag = [elt valueForKey:@"tag"];
                fprintf(fp, "%@", (tag) ? tag : elt);
                exit(0);
            }
        } else if (_down == 'c') {
            if (_dialogMode) {
                exit(1);
            }
        } else {
            _selectedIndex = _down-1;
        }
    }
    _down = 0;
}
- (void)handleKeyDown:(id)event
{
    id keyString = [event valueForKey:@"keyString"];
    if ([keyString isEqual:@"return"]) {
        if (_dialogMode) {
            FILE *fp = (_dialogMode == 1) ? stdout : stderr;
            id elt = [_array nth:_selectedIndex];
            id tag = [elt valueForKey:@"tag"];
            fprintf(fp, "%@", (tag) ? tag : elt);
            exit(0);
        }
    }
}
@end

