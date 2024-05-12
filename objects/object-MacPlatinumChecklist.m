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

static char *checkboxPalette =
"b #000000\n"
". #888888\n"
"X #DDDDDD\n"
"o #EEEEEE\n"
"O #ffffff\n"
;

static char *checkboxPixels =
"bbbbbbbbbbbb\n"
"bOOOOOOOOOXb\n"
"bOXXXXXXXX.b\n"
"bOXXXXXXXX.b\n"
"bOXXXXXXXX.b\n"
"bOXXXXXXXX.b\n"
"bOXXXXXXXX.b\n"
"bOXXXXXXXX.b\n"
"bOXXXXXXXX.b\n"
"bOXXXXXXXX.b\n"
"bX.........b\n"
"bbbbbbbbbbbb\n"
;
static char *checkboxDownPalette =
"b #000000\n"
". #111111\n"
"X #333333\n"
"o #555555\n"
"O #777777\n"
"+ #999999\n"
"@ #AAAAAA\n"
"# #BBBBBB\n"
"$ #DDDDDD\n"
"% #EEEEEE\n"
"& #ffffff\n"
;
static char *checkboxDownPixels =
"bbbbbbbbbbbb\n"
"boooooooooOb\n"
"boOOOOOOOO+b\n"
"boOOOOOOOO+b\n"
"boOOOOOOOO+b\n"
"boOOOOOOOO+b\n"
"boOOOOOOOO+b\n"
"boOOOOOOOO+b\n"
"boOOOOOOOO+b\n"
"boOOOOOOOO+b\n"
"bO+++++++++b\n"
"bbbbbbbbbbbb\n"
;
static char *checkboxSelectedPalette = 
"b #000000\n"
". #333333\n"
"X #555555\n"
"o #777777\n"
"O #888888\n"
"+ #AAAAAA\n"
"@ #BBBBBB\n"
"# #DDDDDD\n"
"$ #EEEEEE\n"
"% #ffffff\n"
;
static char *checkboxSelectedPixels =
"bbbbbbbbbbbb  \n"
"b%%%%%%%%%#bb \n"
"b%########bbo+\n"
"b%#######bbb+ \n"
"b%######bbXb  \n"
"b%bb###bboob  \n"
"b%#bb#bbo+Ob  \n"
"b%#+bbbo+#Ob  \n"
"b%##+bo+##Ob  \n"
"b%###o+###Ob  \n"
"b#OOOOOOOOOb  \n"
"bbbbbbbbbbbb  \n"
;
static char *checkboxSelectedDownPalette =
"b #000000\n"
". #444444\n"
"X #555555\n"
"o #777777\n"
"O #999999\n"
"+ #EEEEEE\n"
"@ #ffffff\n"
;
static char *checkboxSelectedDownPixels =
"bbbbbbbbbbbb  \n"
"bXXXXXXXXXobb \n"
"bXoooooooobbXo\n"
"bXooooooobbbo \n"
"bXoooooobb.b  \n"
"bXbbooobb.Xb  \n"
"bXobbobb.XOb  \n"
"bXoXbbb.XoOb  \n"
"bXooXb.XooOb  \n"
"bXooo.XoooOb  \n"
"boOOOOOOOOOb  \n"
"bbbbbbbbbbbb  \n"
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


#define MAX_CHECKBOXES 20

@implementation Definitions(fjewmfnkdslnfsdjflfjdskfjksldjfkkfjdksjf)
+ (id)MacPlatinumChecklist
{
    id lines = [Definitions linesFromStandardInput];
    id obj = [@"MacPlatinumChecklist" asInstance];
    [obj setValue:@"jfkdlsjflkdsjfkljdsklf" forKey:@"text"];
    [obj setValue:lines forKey:@"array"];
    [obj setValue:@"OK" forKey:@"okText"];
    [obj setValue:@"Cancel" forKey:@"cancelText"];
    [obj setValue:@"1" forKey:@"dialogMode"];
    return obj;
}
@end

@interface MacPlatinumChecklist : IvarObject
{
    int _dialogMode;
    id _text;
    id _array;
    BOOL _checked[MAX_CHECKBOXES];
    Int4 _rect[MAX_CHECKBOXES];
    char _down;
    char _hover;
    Int4 _okRect;
    Int4 _cancelRect;
    id _okText;
    id _cancelText;
    int _HOTDOGNOFRAME;
    int _buttonDownX;
    int _buttonDownY;
}
@end
@implementation MacPlatinumChecklist
- (id)init
{
    self = [super init];
    if (self) {
        _HOTDOGNOFRAME = 1;
    }
    return self;
}
- (int *)x11WindowMaskPointsForWidth:(int)w height:(int)h
{
    static int points[9];
    points[0] = 9; // length of array including this number

    points[1] = 0; // lower left corner
    points[2] = h-1;

    points[3] = 1; // lower left corner
    points[4] = h-1;

    points[5] = w-1; // upper right corner
    points[6] = 0;

    points[7] = w-1; // upper right corner
    points[8] = 1;
    return points;
}
- (BOOL)getCheckedForIndex:(int)index
{
    if ((index >= 0) && (index < MAX_CHECKBOXES)) {
        return _checked[index];
    }
    return NO;
}
- (void)setChecked:(BOOL)checked forIndex:(int)index
{
    if ((index >= 0) && (index < MAX_CHECKBOXES)) {
        _checked[index] = checked;
    }
}
- (int)preferredWidth
{
    return 640;
}
- (int)preferredHeight
{
    id bitmap = [Definitions bitmapWithWidth:1 height:1];
    int lineHeight = [bitmap bitmapHeightForText:@"X"];
    int checkboxWidth = [Definitions widthForCString:checkboxPixels];
    int h = 24;
    int w = 640;
    {
        id text = [bitmap fitBitmapString:_text width:w-89-18];
        h += [bitmap bitmapHeightForText:text] + lineHeight;
    }
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        id text = [elt valueForKey:@"text"];
        if (!text) {
            text = elt;
        }
        text = [bitmap fitBitmapString:text width:w-checkboxWidth-10-lineHeight];
        h += [bitmap bitmapHeightForText:text] + lineHeight/2;
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

    int checkboxWidth = [Definitions widthForCString:checkboxPixels];
    int checkboxHeight = [Definitions heightForCString:checkboxPixels];
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        id text = [elt valueForKey:@"text"];
        if (!text) {
            text = elt;
        }
        _rect[i].x = x;
        _rect[i].y = y;
        text = [bitmap fitBitmapString:text width:r.w-checkboxWidth-10-(x-r.x)-20];
        int textWidth = [bitmap bitmapWidthForText:text];
        int textHeight = [bitmap bitmapHeightForText:text];
        _rect[i].w = checkboxWidth+10+textWidth;
        _rect[i].h = textHeight;
        char *pixels = checkboxPixels;
        char *palette = checkboxPalette;
        if ((_down==i+1) && (_hover==i+1)) {
            if ([self getCheckedForIndex:i]) {
                pixels = checkboxSelectedDownPixels;
                palette = checkboxSelectedDownPalette;
            } else {
                pixels = checkboxDownPixels;
                palette = checkboxDownPalette;
            }
        } else {
            if ([self getCheckedForIndex:i]) {
                pixels = checkboxSelectedPixels;
                palette = checkboxSelectedPalette;
            }
        }
        [bitmap drawCString:pixels palette:palette x:x y:y];
        [bitmap drawBitmapText:text x:x+checkboxWidth+10 y:y+1];
        y += textHeight + lineHeight/2;
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
    {
        id x11dict = [event valueForKey:@"x11dict"];
        unsigned long win = [[x11dict valueForKey:@"window"] unsignedLongValue];
        id windowManager = [@"windowManager" valueForKey];
        [windowManager XRaiseWindow:win];
    }

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
    _down = 'b';
    _hover = 0;
    _buttonDownX = mouseX;
    _buttonDownY = mouseY;
}
- (void)handleMouseMoved:(id)event
{
    if (_down == 'b') {
        int mouseRootX = [event intValueForKey:@"mouseRootX"];
        int mouseRootY = [event intValueForKey:@"mouseRootY"];

        id dict = [event valueForKey:@"x11dict"];

        int newX = mouseRootX - _buttonDownX;
        int newY = mouseRootY - _buttonDownY;

        [dict setValue:nsfmt(@"%d", newX) forKey:@"x"];
        [dict setValue:nsfmt(@"%d", newY) forKey:@"y"];

        [dict setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
        return;
    }

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
                [self exitWithDialogMode];
            }
        } else if (_down == 'c') {
            if (_dialogMode) {
                exit(1);
            }
        } else {
            if ([self getCheckedForIndex:_down-1]) {
                [self setChecked:NO forIndex:_down-1];
            } else {
                [self setChecked:YES forIndex:_down-1];
            }
        }
    }
    _down = 0;
}
- (void)handleKeyDown:(id)event
{
    id keyString = [event valueForKey:@"keyString"];
    if ([keyString isEqual:@"return"]) {
        if (_dialogMode) {
            [self exitWithDialogMode];
        }
    }
}
- (void)exitWithDialogMode
{
    BOOL first = YES;
    FILE *fp = (_dialogMode == 1) ? stdout : stderr;
    for (int i=0; i<[_array count]; i++) {
        if ([self getCheckedForIndex:i]) {
            id elt = [_array nth:i];
            id tag = [elt valueForKey:@"tag"];
            if (first) {
                first = NO;
            } else {
                if (_dialogMode == 1) {
                    NSOut(@" ");
                } else {
                    NSErr(@" ");
                }
            }
            if (_dialogMode == 1) {
                NSOut(@"%@", (tag) ? tag : elt);
            } else {
                NSErr(@"%@", (tag) ? tag : elt);
            }
        }
    }
    exit(0);
}
@end

