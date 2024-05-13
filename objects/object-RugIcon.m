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

static char *rugPalette =
"\\ #000000\n"
". #351A1C\n"
"X #3A1C23\n"
"o #3C2426\n"
"O #342B35\n"
"+ #3B251C\n"
"@ #4F171D\n"
"# #790D16\n"
"$ #7E1B14\n"
"% #79171A\n"
"& #6C181A\n"
"* #4B271E\n"
"= #77231C\n"
"- #6A291D\n"
"; #4D1B24\n"
": #771A24\n"
"> #6B1824\n"
", #472727\n"
"< #562A29\n"
"1 #59362B\n"
"2 #573934\n"
"3 #4F2F30\n"
"4 #692A26\n"
"5 #762726\n"
"6 #633B2C\n"
"7 #673629\n"
"8 #77382A\n"
"9 #673934\n"
"0 #773A34\n"
"q #6D2A34\n"
"w #5A4538\n"
"e #554433\n"
"r #6A442B\n"
"t #77462B\n"
"y #674736\n"
"u #784836\n"
"i #7A5539\n"
"p #6C5338\n"
"a #76623C\n"
"s #7A5843\n"
"d #6A5345\n"
"f #786850\n"
"g #584D44\n"
"h #683E42\n"
"j #831817\n"
"k #860D16\n"
"l #92261D\n"
"z #89281B\n"
"x #881A24\n"
"c #862926\n"
"v #942A26\n"
"b #883929\n"
"n #873C33\n"
"m #95382D\n"
"M #A7312E\n"
"N #88462C\n"
"B #874935\n"
"V #964936\n"
"C #875438\n"
"Z #955738\n"
"A #944E2B\n"
"S #A74638\n"
"D #AC5139\n"
"F #94643B\n"
"G #A9663C\n"
"H #9B551B\n"
"J #865B43\n"
"K #945843\n"
"L #A75844\n"
"P #896647\n"
"I #956749\n"
"U #937253\n"
"Y #AB6E4A\n"
"T #9B7862\n"
"R #C5774C\n"
"E #C2573D\n"
"W #B58A54\n"
"Q #B48A67\n"
"! #C58951\n"
"~ #C2946C\n"
"^ #BE8683\n"
"/ #C69D94\n"
"( #C28784\n"
") #C9A297\n"
"_ #DCCACC\n"
"` #E4DCDA\n"
"' #E5DAC9\n"
"] #EFE6D6\n"
"[ #F8F4EB\n"
"{ #FEFEFE\n"
"} #F9F6F3\n"
"| #F4EEE9\n"
;

static char *rugPixels =
"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\n"
"\"{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{\"\n"
"\"{{[|}}|[}}|}{|[}}||}}|}}[|}}||{}|}}[|}}|}}[|}}[[}}|[{[|}}||}}|[{\"\n"
"\"{}''|[''[|'][]'[['][]'][''[|''}]'][''[|'][]'][''[|'][]'|[''[|']}\"\n"
"\"{|~(~(((^(((((^((((((((^((^(^(^(^(Q((((^(~(((^((^(((^(^(((((^~(|\"\n"
"\"{_#lzzllllllllllllllllllllllvvvlzlvllllllvllllllllllllllllllllj`\"\n"
"\"{_=VNPNBsbCCnJBBPNCJnJCnsBBJNCinBnPBNPNBJnCCtJBBJnCJbJCnPBNPNVv`\"\n"
"\"{_$NBJAVZVZZVJVVKVVKVZZVJVVZVZZVZVKVVJVVJVCZVKVVJVVCVZZVKVVJuBv`\"\n"
"\"{_jCC8Cu16Z7170911Zru7Z170u91Zr261uC190u96Z7rtC17y0916Z1<uuBJCv`\"\n"
"\"{_$bcA6,X;1273,392<,,,,21o,<7<,>k>,<7<,,11,,,,<99<,279,+X*rZbNv`\"\n"
"\"{_$BBt,:lc;1u2dwt6,TQT,1toou6,:575:oyro,B12QQUorrwd1N,<xl4,BCBv`\"\n"
"\"{_$BB7>mIBc*3y<wwXTIKPT,262e+x4uIt5%ow2y1,QPZUU.w2<d,,lZFm>uCBv`\"\n"
"\"{_$bb6:VQDx,39c7,.TIIK~oo88o.x4P!i4$o387o,~KIYT.38c93;xIWV&unNv`\"\n"
"\"{_$CC7>cVxXwpw2wy,JTYUP,r22y,>5ru65>,y3w6,UUYTs,yw3wy2;cAv@tJCv`\"\n"
"\"{_$NbN*@:*ry<2d2tuXJUI.9tX.t0o>555>ou6XXu6,UUs.u82p1<y1;:;,ZBBv`\"\n"
"\"{_$NbNy3Xyy,<<;333r,Xo6<,33,36,>:>,6,33,336XX,63<,,33<r2.3yZnNv`\"\n"
"\"{_$CC73yye<BuuButrZBBBZtuBBuuABurrBZrBBBttZNBBArtBKtrB<eyw3BJCv`\"\n"
"\"{_$bb831Bq<AbJNbJnNCcCBbCtnJbuCbBbJ0nJ8BJbuJcsnnsbNJmV39u2,BnNv`\"\n"
"\"{_$NB73n49<NuZZVZVZZVZZVKVVKVZKVZVKZVZVZZVZZVZZVKVZCuB<9-n3tCBv`\"\n"
"\"{_$CC0,yd3<BpGYCU!WuY97B<<yff2<F!Z<wffy<1B79UuW!UCYGiC<3dy,BJCv`\"\n"
"\"{_$bctee1w1NcZCJY!mIwUU3<Kye2,iy5pi+geuJ,1UPyYS!YJZZcV1d1w2Bbmv`\"\n"
"\"{_$CCArIYyNAuZIYmYyY1X0Uus6,,NYc;vWt,,9suU4.yIpLmYPIiZtpYJrZJCv`\"\n"
"\"{_$BB8PPyYrNuZWY0fuP3*8<39trt5#5z%#bttt63<8*1CiPnYWGuCtUyIJBCBv`\"\n"
"\"{_$N5RPrHd!A5GWKPiUiX5q4otzzz28pPpt7zzzt,494XsUiIL!G5DWyHuPR8Nv`\"\n"
"\"{_jCiBPirICBiCKVpPPUu,8,t8%k%CPPdPPi%k&bt*N*sUPPpVZKsZJPriPZJCv`\"\n"
"\"{_$NbNtUUJtN8AssI12Iitbp8%6%9uCPsICu9:9%9ubriI11PssZbAtJUIrZnVv`\"\n"
"\"{_$NnNwuiwrN0CJw.4*1tz%sf5j148bdfpm877%qfs%zr3<4.ysZNZryuyeZBBv`\"\n"
"\"{_$Ci83ww2<BC7pI<98t87#9d%477574J47847=%dq%7btq0;UyusC<ewe3BJCv`\"\n"
"\"{_$Nb8<1n9<NcA0iC4Ab#59#k57k%6dw2yd7j#6=##75kbV4CstZcB30u1<umNv`\"\n"
"\"{_$BB7<n49<BuN,9y,3Ny:4756%LV%y2qey%VS#6=65%yt<*y9,ZiC<24n<uCBv`\"\n"
"\"{_$BC03yd3<BBt<Jd3tyU9k4y#SfUm<9A9<mUUm#y5kgUyr1sJ<CCC<2dy,BJCv`\"\n"
"\"{_$Nc8wywg6Nc82J7t8#9%57&6#LV<ZwgyC>VV#6&75%q%bt1J1BbB1wyw2BnNv`\"\n"
"\"{_$CiNrLYutAiN,,uc44k54jv&6kk99yZyy4k%6&v%75k75cr,<CsZtiRKrZJCv`\"\n"
"\"{_jNntZSvLuN0Du7Phj574jKUv57jmy787yv%6%vUZ%444%hP7BGnCuLvDZCBBv`\"\n"
"\"{_$N5!ML~lRA5Gs7Ud#594lIUS%61#mu3uv#66#SUIj495%dU1PY5GRv~VSRnVv`\"\n"
"\"{_$CitKDmLBCiGI4p5=1#74jS&6%56#vuvj6%%1#Vj74#6%5y-YYsCBLmDZCJCv`\"\n"
"\"{_jbbNrLLBuN5GGq3t8#Lk74&6%>%57%A%6%::x6#74jL#8t38YIcAtCEZrZnNv`\"\n"
"\"{_$NBteddw7N0ZN3OtlLfYk46j>fd:=N7N%#ff%%y4jUfLlrO3NL0Crwpy2BBBv`\"\n"
"\"{_jCi03wy22Nitrd6i5vUm&744#d9jN1X6m#99#757%mUv4i6y0CiC32dw,BJCv`\"\n"
"\"{_$Nc037n8<N=A0rb%6:l&7%k74#bA1;x,1Ab%75#%6%l47%bruZcB3081<Bmmv`\"\n"
"\"{_$CC73nq1<BB86N9qk6-9%59%7C7,;xBk<,7C7%95%756%q9N1BCC<29n,uCCv`\"\n"
"\"{_jBt83yg2<NB86tfd&%65#dUei1Xw:vVl5gX6iwTy#5r%>ffi7BBC12uy,BCBv`\"\n"
"\"{_$bvteyrw6Nbt3N4::6&75:2ir344<BCB<44,up2%57%9$:5N3BbAryMneCmNv`\"\n"
"\"{_$CiNrUTBtAsC31l%6#Mk1=:at5cvx>c>xcc4ti%57%M%9%m13ZsCtsTPrZJCv`\"\n"
"\"{_$NbBPCyIiNbN<it7jVUK$47i3:cc<xM#<cq>3i74jKUm%7Cy<V8ZiIrJPCnVv`\"\n"
"\"{_jN8RPtHw!A8ZfN87%VULj4Nu9s>9&DDS:8>J2t84xKUS%65NPK8GWeHyIR0Vv`\"\n"
"\"{_jCitIJyUuCpG~Bk56#M%18N,pn;>SS>SS@@Vy<N47jm#9:kB~YiCiIyJPBJCv`\"\n"
"\"{_$NcArITytNcZWm4:$9&75N4>o<#D!LdY!S#<,>4N47%y$:4AWLcVtiWJrZmVv`\"\n"
"\"{_$BBtew6w6NtAA4fd:$65N,@Jd@D!WCcPW!S@s0;3N=1%>ff5AFuC6g6y2BCBv`\"\n"
"\"{_$Bi83yd3<BuAusUUs:5N,rD>5DMLCBSBFLSS45D61N=&fUUsuFiZ32py,BJCv`\"\n"
"\"{_$bc0,nSq<NcBwFUYFwN6cGF>MD>dcSImnd>EMqFYx6NwFUUFwZcB<qSn,Bmmv`\"\n"
"\"{_$Ci83ww23BiAtdUUd%:N<1S45SSYPBmBIGSM45D31N%&ffUdtGiC<2yw3BJCv`\"\n"
"\"{_$BNt2yyw9A8ZA%fd#%6-N3@ug@S!!PcI!!S@d0X1b4y%&fd&ZFuBryuy2BBBv`\"\n"
"\"{_$NbNuITitN5FWm&:56#44N7@+<#SRDgDRM#<o>9b44#9%:&BWG5ZtsYItZnNv`\"\n"
"\"{_$CiNICyIiCiG~nk56#S%78N,pB;@MD>DM@;Vp<N44jS#65kB~YiKCIrCPCJCv`\"\n"
"\"{_jN5RPuAy!AcBsN84%LfLk4tu3i:8>SEm40&s1tu4jIUVk68BpZ8GWyArURcVv`\"\n"
"\"{_$BNtPJyUuNtN<yN6%mUV%77i*:qc<kM#<cq>1i74jVUm&7Ny4VuCuIyPPBBBv`\"\n"
"\"{_$iiNrIYutAiB3rm%9&v%6%:ar5cmx>5>xvcqta:%2jv%9#m63KsZtuWJrZJCv`\"\n"
"\"{_jbctey2w6Nct2b95%6&7%:gir,<<<BZB<<<otpwx=7&6jqqN2BcV2y1weBmmv`\"\n"
"\"{_$CB03wd2<BC8ruff#=9-#df2ieogxlVx5gXrp2Uyk-6%%fdi1uCC<2sw,BCBv`\"\n"
"\"{_$BB7<480,But6bq5%9:6%57k1C73,xB#,3rB7%9:%7&9%4qb6CiB<057<tJBv`\"\n"
"\"{_$bc83V6<<NcA0rm:7&v#6%k75#bA1,:,rAb#47k=6%v%6:by0ZcB<30n,Bmmv`\"\n"
"\"{_$Ci93wwe<Bstuy1i%mUV%774%dy#b6oym#dy%577%VTm=a1d6CsC<wgw3BJCv`\"\n"
"\"{_$NbNedierA8DN3OtvKfKk49$>fd#-N0b=#df#=64jIUSvrO3VG0Arwiy1ZBBv`\"\n"
"\"{_$NbNpLDKrN8FYq2N8#Sk7-#y%>%-7%A#6=%:=6#44jS#8N35YY8BrKDLuCnNv`\"\n"
"\"{_$CiBDDVDZCpGI-p5-6#64lS#6%57kmumk65=6#Dj47#9&5p-YYsCZDVDLKsCv`\"\n"
"\"{_jN=YMLWvRV5Gs7Yd#=64cUfS#67kmy3ym#77#LfUk46%:dU1PG5FRvQVSRcVv`\"\n"
"\"{_$BB8KSvYuNuZ06P9#q47%VUv47kmy7b7rm%7-vTS%747%9P1uGuZuYvDKBBBv`\"\n"
"\"{_$BiArKYytVit,,rcq4k:7$l-475<upCyr4-4q>l%6&k44cy,,CiZtrYKrZJCv`\"\n"
"\"{_$bbtww1g1Nc8yK2ub%y%5747jYV>BwggB>KKk647::y%bt9I9BbB1w2w2BmVv`\"\n"
"\"{_jCi8,ws3qNC8<is,tpT9k46#SUUv<9A9<MUUM%r5kdUpr3ui,CCC<2sw,BJCv`\"\n"
"\"{_$BN73q50*NtN,9y;,yyj47=9#Lm%g2<wy#VS#9$75jpr,;r9,ZBC<0573tBBv`\"\n"
"\"{_$Nv0,By3<N5Z0iJq77b77k%56%%6dy2yd7%%6%:%74b7q4Js0Z5B<3uB,CmNv`\"\n"
"\"{_jCi82ew2<BJ4pI@00884#9f&%77844K44077%:f0k4n8q0@TrtJC3wee3BPCv`\"\n"
"\"{_$NbA1sKwtA8ZP1.<,9rb%fd:5740Vsasm047%5fdjzy2,<.2PFbZrwZd1ZnBv`\"\n"
"\"{_$NbtiIPI8N8AiIU2rIsrby8%6%6CCPsICC9%1%urNrsU6eYPiZnB8IPIiCBBv`\"\n"
"\"{_$CCzBitPFAiZLVyIUPy,n,tN%k:iFPdPFi%k%N7*b,uUUPymLFsZIJtinmJCv`\"\n"
"\"{_$bbM9iApWA5G!YUpUuX894,rcbz98yPy57lbv7o895XiPiUI!G5GWyAi5SnVv`\"\n"
"\"{_$BB-CPpYtBuZWY0UuP1,8<19r6uck%zj#brrr93<5,yPsUnRWYuB0UpIi0JCv`\"\n"
"\"{_$CBA6PY2NAuCiYmYrY2,yIuJ7,,tW=<b!to,9JuI6,yIuGSGCZuZtyYJ6FCCv`\"\n"
"\"{_$Nc82y3w1bcDICYWSIyUY<,Cyww,ypnpC7wwpi,<UUpLD~YiIDcN1w3w2BmNv`\"\n"
"\"{_$CC03eJ<2CiGYCFWWtI8AN<<uss6<ZWZ<rPsr1<B46ItWWFCYGiC31s2,BJCv`\"\n"
"\"{_$NN72450,N0BbbCbNCbBBbCNbCbNCbNbCNbCbBCbCNbCnbCbBi0C<8=q<tBBv`\"\n"
"\"{_$Nb0,Bp3<AbCbbCbNizCtbinbCbNBbBbibbibNCmBBbCbbCbNCbA<3yu,BnNv`\"\n"
"\"{_$CC82wew3077B077Atu8A77Nn07At676tA78BB77A8BtA770B7703www3uJCv`\"\n"
"\"{_$NbAyo.2t,13,3<32,o.12<,,331,>:>o133,,<11+o,1<33,<2,u1X,yZnNv`\"\n"
"\"{_jBNN,>j;1y31p2tyXUTUX6uoottX%545>ourX,t1,TTP.utwd33y1*x>,CBBv`\"\n"
"\"{_$CC7>bZc;2dw,wy*UULUT,e22y,&5uir5&oy2w2,TUITJ,yw1gd3;vZb@tJCv`\"\n"
"\"{_$Nv6&AQLx,37c8o.QIIKQ,o98ooj4J!i4joo89o,~ZIYT.,5v1,;jYQV&umnv`\"\n"
"\"{_$Bi7>mZNc,1w*ww.UUKITo2w2wo:4uJy55+w2y2,TIZTP.yw<y1;cAZm>uJCv`\"\n"
"\"{_$BBt,>jj*2C3detuXUQTX7uootr.:545&,r8o,u1,TQPXurwd1C<;xj&,CBBv`\"\n"
"\"{_$NcCr,oo1123,3112,,+112,,311,>x&,123,,311,,o1113,<221oo,rZbNv`\"\n"
"\"{_$CC8Nt-6A7170077Atu7A770071A8111tA170n77A8utN1-00767A7<NtNJCv`\"\n"
"\"{_$N8CbnCbuBbCbbCbNBbCNbCNNCbNBbNbBNbCbNCbNBbCbbCbNCbBBbCbbC8Vv`\"\n"
"\"{_$ABCbBibCCbCNnCbBCbCBbCNNCbBCbBbCNbCnBCbCBbCBbCnNCmCBbCNNCbVv`\"\n"
"\"{_#=j$j=jzjjz$jj$jjj$j$j$jjjj$j=jj$jjjj$jj$jjj=jj=jjjj$jj$$j=$%`\"\n"
"\"{|////////////////)///)//////////)/////////////////)///////^//)[\"\n"
"\"{}''|[''}]']}`'[['][]'][]'[|''}]'][''[[']}]']}''[|']}]'][''[|']}\"\n"
"\"{{}[}{}}{}[}}}}}}}}{}}}{[}{{}}{}}}}[[{}[}}}}}{}}}}[}{}[}}}}{{}}{\"\n"
"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\"\n"
;


@interface RugIcon : IvarObject
{
    id _path;
    BOOL _buttonDown;
    int _buttonDownX;
    int _buttonDownY;
    id _buttonDownTimestamp;

    id _dragX11Dict;
}
@end
@implementation RugIcon
- (int)preferredWidth
{
    static int w = 0;
    if (!w) {
        w = [Definitions widthForCString:rugPixels];
        if ([_path length]) {
            id bitmap = [Definitions bitmapWithWidth:1 height:1];
            [bitmap useWinSystemFont];
            int textWidth = [bitmap bitmapWidthForText:_path];
            if (textWidth > w) {
                w = textWidth;
            }
        }
    }
    return w;
}
- (int)preferredHeight
{
    static int h = 0;
    if (!h) {
        h = [Definitions heightForCString:rugPixels];
        if ([_path length]) {
            id bitmap = [Definitions bitmapWithWidth:1 height:1];
            [bitmap useWinSystemFont];
            int textHeight = [bitmap bitmapHeightForText:_path];
            h += textHeight;
        }
    }
    return h;
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r context:(id)context
{
    BOOL hasFocus = NO;
    {
        id windowManager = [@"windowManager" valueForKey];
        unsigned long focusInEventWindow = [[windowManager valueForKey:@"focusInEventWindow"] unsignedLongValue];
        unsigned long win = [[context valueForKey:@"window"] unsignedLongValue];
        if (focusInEventWindow && (focusInEventWindow == win)) {
            hasFocus = YES;
        }
    }

    int w = [Definitions widthForCString:rugPixels];
    int h = [Definitions heightForCString:rugPixels];

    [bitmap drawCString:rugPixels palette:rugPalette x:r.x+(r.w-w)/2 y:r.y];

    if ([_path length]) {
        [bitmap useWinSystemFont];
        int textWidth = [bitmap bitmapWidthForText:_path];
        int textHeight = [bitmap bitmapHeightForText:_path];
        if (hasFocus) {
            [bitmap setColor:@"black"];
        } else {
            [bitmap setColor:@"white"];
        }
        [bitmap fillRectangleAtX:r.x+(r.w-textWidth)/2 y:r.y+h w:textWidth h:textHeight];
        if (hasFocus) {
            [bitmap setColor:@"white"];
        } else {
            [bitmap setColor:@"black"];
        }
        [bitmap drawBitmapText:_path x:r.x+(r.w-textWidth)/2 y:r.y+h];
    }

    id windowManager = [@"windowManager" valueForKey];
    unsigned long win = [[context valueForKey:@"window"] unsignedLongValue];
    if (win) {
        [windowManager addMaskToWindow:win bitmap:bitmap];
    }
}

- (void)handleMouseDown:(id)event
{
    id windowManager = [@"windowManager" valueForKey];
    id x11dict = [event valueForKey:@"x11dict"];

    {
        unsigned long win = [[x11dict valueForKey:@"window"] unsignedLongValue];
        if (win) {
            [windowManager XRaiseWindow:win];
        }
    }

    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    _buttonDown = YES;
    _buttonDownX = mouseX;
    _buttonDownY = mouseY;

    id timestamp = [Definitions gettimeofday];
    if (_buttonDownTimestamp) {
        if ([timestamp doubleValue]-[_buttonDownTimestamp doubleValue] <= 0.3) {
            [self setValue:nil forKey:@"buttonDownTimestamp"];
            if ([self respondsToSelector:@selector(handleDoubleClick)]) {
                [self handleDoubleClick];
            }
            return;
        }
    }
    [self setValue:timestamp forKey:@"buttonDownTimestamp"];
}

- (void)handleMouseMoved:(id)event
{
    id x11dict = [event valueForKey:@"x11dict"];

    if (!_buttonDown && !_dragX11Dict) {
        return;
    }

    int mouseRootX = [event intValueForKey:@"mouseRootX"];
    int mouseRootY = [event intValueForKey:@"mouseRootY"];

    if (!_dragX11Dict) {
        id windowManager = [event valueForKey:@"windowManager"];
        id objectWindows = [windowManager valueForKey:@"objectWindows"];
        for (int i=0; i<[objectWindows count]; i++) {
            id elt = [objectWindows nth:i];
            [elt setValue:nil forKey:@"isSelected"];
        }
        [x11dict setValue:@"1" forKey:@"isSelected"];

        id newx11dict = [Definitions selectedBitmapForSelectedItemsInArray:objectWindows buttonDownElt:x11dict offsetX:_buttonDownX y:_buttonDownY mouseRootX:mouseRootX y:mouseRootY windowManager:windowManager];

        [self setValue:newx11dict forKey:@"dragX11Dict"];
    } else {

        int newX = mouseRootX - [_dragX11Dict intValueForKey:@"buttonDownOffsetX"];
        int newY = mouseRootY - [_dragX11Dict intValueForKey:@"buttonDownOffsetY"];

        [_dragX11Dict setValue:nsfmt(@"%d", newX) forKey:@"x"];
        [_dragX11Dict setValue:nsfmt(@"%d", newY) forKey:@"y"];

        [_dragX11Dict setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
    }
}
- (void)handleMouseUp:(id)event
{
    _buttonDown = NO;
    id x11dict = [event valueForKey:@"x11dict"];
    if (_dragX11Dict) {

        id windowManager = [event valueForKey:@"windowManager"];
        unsigned long window = [_dragX11Dict unsignedLongValueForKey:@"window"];
        int mouseRootX = [event intValueForKey:@"mouseRootX"];
        int mouseRootY = [event intValueForKey:@"mouseRootY"];

        BOOL success = NO;

        unsigned long underneathWindow = [windowManager topMostWindowUnderneathWindow:window x:mouseRootX y:mouseRootY];
        if (underneathWindow) {
            id underneathx11dict = [windowManager dictForObjectWindow:underneathWindow];
            if (underneathx11dict == x11dict) {
            } else {
                id object = [underneathx11dict valueForKey:@"object"];
                if ([object respondsToSelector:@selector(handleDragAndDrop:)]) {
                    [object handleDragAndDrop:x11dict];
                    success = YES;
                }
            }
        }
        if (!success) {
            int newX = mouseRootX - _buttonDownX;
            int newY = mouseRootY - _buttonDownY;
            [x11dict setValue:nsfmt(@"%d", newX) forKey:@"x"];
            [x11dict setValue:nsfmt(@"%d", newY) forKey:@"y"];
            [x11dict setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
        }

        [_dragX11Dict setValue:@"1" forKey:@"shouldCloseWindow"];
        [self setValue:nil forKey:@"dragX11Dict"];
    }
}
- (void)handleRightMouseDown:(id)event
{
    id windowManager = [event valueForKey:@"windowManager"];
    int mouseRootX = [event intValueForKey:@"mouseRootX"];
    int mouseRootY = [event intValueForKey:@"mouseRootY"];

    id obj = nil;//[[menuCSV parseCSVFromString] asMenu];
    if (obj) {
        [obj setValue:self forKey:@"contextualObject"];
        [windowManager openButtonDownMenuForObject:obj x:mouseRootX y:mouseRootY w:0 h:0];
    }
}
- (void)handleDoubleClick
{
    [@"It's a rug.\n\nIt really ties the screen together." showAlert];
}
@end

