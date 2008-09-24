package jp.ac.kobe_u.cs.prolog.builtin;
import jp.ac.kobe_u.cs.prolog.lang.*;
/*
 This file is generated by Prolog Cafe.
 PLEASE DO NOT EDIT!
*/
/**
 <code>'$init'/0</code> defined in builtins.pl<br>
 @author Mutsunori Banbara (banbara@kobe-u.ac.jp)
 @author Naoyuki Tamura (tamura@kobe-u.ac.jp)
 @author Douglas R. Miles (dmiles@users.sourceforge.net) for Object(s) 
 @version 1.0-dmiles
*/
public class PRED_$init_0 extends PredicateBase {
    static /*Symbol*/Object s1 = makeAtom("jp.ac.kobe_u.cs.prolog.builtin");
    static /*Symbol*/Object s2 = makeAtom("/", 2);
    static /*Symbol*/Object s3 = makeAtom("$tokens");
    static /*IntegerTerm*/Object si4 = makeInteger(1);
    static Object[] s5 = {s3, si4};
    static /*Structure*/Object s6 = makeStructure(s2, s5);
    static /*Symbol*/Object s7 = makeAtom(":", 2);
    static /*Symbol*/Object s8 = makeAtom(":-", 2);
    static /*Symbol*/Object s9 = makeAtom("$current_operator", 3);
    static /*IntegerTerm*/Object si10 = makeInteger(1200);
    static /*Symbol*/Object s11 = makeAtom("xfx");
    static /*Symbol*/Object s12 = makeAtom(":-");
    static Object[] s13 = {si10, s11, s12};
    static /*Structure*/Object s14 = makeStructure(s9, s13);
    static /*Symbol*/Object s15 = makeAtom("true");
    static Object[] s16 = {s14, s15};
    static /*Structure*/Object s17 = makeStructure(s8, s16);
    static Object[] s18 = {s1, s17};
    static /*Structure*/Object s19 = makeStructure(s7, s18);
    static /*Symbol*/Object s20 = makeAtom("-->");
    static Object[] s21 = {si10, s11, s20};
    static /*Structure*/Object s22 = makeStructure(s9, s21);
    static Object[] s23 = {s22, s15};
    static /*Structure*/Object s24 = makeStructure(s8, s23);
    static Object[] s25 = {s1, s24};
    static /*Structure*/Object s26 = makeStructure(s7, s25);
    static /*Symbol*/Object s27 = makeAtom("fx");
    static Object[] s28 = {si10, s27, s12};
    static /*Structure*/Object s29 = makeStructure(s9, s28);
    static Object[] s30 = {s29, s15};
    static /*Structure*/Object s31 = makeStructure(s8, s30);
    static Object[] s32 = {s1, s31};
    static /*Structure*/Object s33 = makeStructure(s7, s32);
    static /*Symbol*/Object s34 = makeAtom("?-");
    static Object[] s35 = {si10, s27, s34};
    static /*Structure*/Object s36 = makeStructure(s9, s35);
    static Object[] s37 = {s36, s15};
    static /*Structure*/Object s38 = makeStructure(s8, s37);
    static Object[] s39 = {s1, s38};
    static /*Structure*/Object s40 = makeStructure(s7, s39);
    static /*IntegerTerm*/Object si41 = makeInteger(1150);
    static /*Symbol*/Object s42 = makeAtom("package");
    static Object[] s43 = {si41, s27, s42};
    static /*Structure*/Object s44 = makeStructure(s9, s43);
    static Object[] s45 = {s44, s15};
    static /*Structure*/Object s46 = makeStructure(s8, s45);
    static Object[] s47 = {s1, s46};
    static /*Structure*/Object s48 = makeStructure(s7, s47);
    static /*Symbol*/Object s49 = makeAtom("import");
    static Object[] s50 = {si41, s27, s49};
    static /*Structure*/Object s51 = makeStructure(s9, s50);
    static Object[] s52 = {s51, s15};
    static /*Structure*/Object s53 = makeStructure(s8, s52);
    static Object[] s54 = {s1, s53};
    static /*Structure*/Object s55 = makeStructure(s7, s54);
    static /*Symbol*/Object s56 = makeAtom("public");
    static Object[] s57 = {si41, s27, s56};
    static /*Structure*/Object s58 = makeStructure(s9, s57);
    static Object[] s59 = {s58, s15};
    static /*Structure*/Object s60 = makeStructure(s8, s59);
    static Object[] s61 = {s1, s60};
    static /*Structure*/Object s62 = makeStructure(s7, s61);
    static /*Symbol*/Object s63 = makeAtom("dynamic");
    static Object[] s64 = {si41, s27, s63};
    static /*Structure*/Object s65 = makeStructure(s9, s64);
    static Object[] s66 = {s65, s15};
    static /*Structure*/Object s67 = makeStructure(s8, s66);
    static Object[] s68 = {s1, s67};
    static /*Structure*/Object s69 = makeStructure(s7, s68);
    static /*Symbol*/Object s70 = makeAtom("meta_predicate");
    static Object[] s71 = {si41, s27, s70};
    static /*Structure*/Object s72 = makeStructure(s9, s71);
    static Object[] s73 = {s72, s15};
    static /*Structure*/Object s74 = makeStructure(s8, s73);
    static Object[] s75 = {s1, s74};
    static /*Structure*/Object s76 = makeStructure(s7, s75);
    static /*Symbol*/Object s77 = makeAtom("mode");
    static Object[] s78 = {si41, s27, s77};
    static /*Structure*/Object s79 = makeStructure(s9, s78);
    static Object[] s80 = {s79, s15};
    static /*Structure*/Object s81 = makeStructure(s8, s80);
    static Object[] s82 = {s1, s81};
    static /*Structure*/Object s83 = makeStructure(s7, s82);
    static /*Symbol*/Object s84 = makeAtom("multifile");
    static Object[] s85 = {si41, s27, s84};
    static /*Structure*/Object s86 = makeStructure(s9, s85);
    static Object[] s87 = {s86, s15};
    static /*Structure*/Object s88 = makeStructure(s8, s87);
    static Object[] s89 = {s1, s88};
    static /*Structure*/Object s90 = makeStructure(s7, s89);
    static /*Symbol*/Object s91 = makeAtom("block");
    static Object[] s92 = {si41, s27, s91};
    static /*Structure*/Object s93 = makeStructure(s9, s92);
    static Object[] s94 = {s93, s15};
    static /*Structure*/Object s95 = makeStructure(s8, s94);
    static Object[] s96 = {s1, s95};
    static /*Structure*/Object s97 = makeStructure(s7, s96);
    static /*IntegerTerm*/Object si98 = makeInteger(1100);
    static /*Symbol*/Object s99 = makeAtom("xfy");
    static /*Symbol*/Object s100 = makeAtom(";");
    static Object[] s101 = {si98, s99, s100};
    static /*Structure*/Object s102 = makeStructure(s9, s101);
    static Object[] s103 = {s102, s15};
    static /*Structure*/Object s104 = makeStructure(s8, s103);
    static Object[] s105 = {s1, s104};
    static /*Structure*/Object s106 = makeStructure(s7, s105);
    static /*IntegerTerm*/Object si107 = makeInteger(1050);
    static /*Symbol*/Object s108 = makeAtom("->");
    static Object[] s109 = {si107, s99, s108};
    static /*Structure*/Object s110 = makeStructure(s9, s109);
    static Object[] s111 = {s110, s15};
    static /*Structure*/Object s112 = makeStructure(s8, s111);
    static Object[] s113 = {s1, s112};
    static /*Structure*/Object s114 = makeStructure(s7, s113);
    static /*IntegerTerm*/Object si115 = makeInteger(1000);
    static /*Symbol*/Object s116 = makeAtom(",");
    static Object[] s117 = {si115, s99, s116};
    static /*Structure*/Object s118 = makeStructure(s9, s117);
    static Object[] s119 = {s118, s15};
    static /*Structure*/Object s120 = makeStructure(s8, s119);
    static Object[] s121 = {s1, s120};
    static /*Structure*/Object s122 = makeStructure(s7, s121);
    static /*IntegerTerm*/Object si123 = makeInteger(900);
    static /*Symbol*/Object s124 = makeAtom("fy");
    static /*Symbol*/Object s125 = makeAtom("\\+");
    static Object[] s126 = {si123, s124, s125};
    static /*Structure*/Object s127 = makeStructure(s9, s126);
    static Object[] s128 = {s127, s15};
    static /*Structure*/Object s129 = makeStructure(s8, s128);
    static Object[] s130 = {s1, s129};
    static /*Structure*/Object s131 = makeStructure(s7, s130);
    static /*IntegerTerm*/Object si132 = makeInteger(700);
    static /*Symbol*/Object s133 = makeAtom("=");
    static Object[] s134 = {si132, s11, s133};
    static /*Structure*/Object s135 = makeStructure(s9, s134);
    static Object[] s136 = {s135, s15};
    static /*Structure*/Object s137 = makeStructure(s8, s136);
    static Object[] s138 = {s1, s137};
    static /*Structure*/Object s139 = makeStructure(s7, s138);
    static /*Symbol*/Object s140 = makeAtom("\\=");
    static Object[] s141 = {si132, s11, s140};
    static /*Structure*/Object s142 = makeStructure(s9, s141);
    static Object[] s143 = {s142, s15};
    static /*Structure*/Object s144 = makeStructure(s8, s143);
    static Object[] s145 = {s1, s144};
    static /*Structure*/Object s146 = makeStructure(s7, s145);
    static /*Symbol*/Object s147 = makeAtom("==");
    static Object[] s148 = {si132, s11, s147};
    static /*Structure*/Object s149 = makeStructure(s9, s148);
    static Object[] s150 = {s149, s15};
    static /*Structure*/Object s151 = makeStructure(s8, s150);
    static Object[] s152 = {s1, s151};
    static /*Structure*/Object s153 = makeStructure(s7, s152);
    static /*Symbol*/Object s154 = makeAtom("\\==");
    static Object[] s155 = {si132, s11, s154};
    static /*Structure*/Object s156 = makeStructure(s9, s155);
    static Object[] s157 = {s156, s15};
    static /*Structure*/Object s158 = makeStructure(s8, s157);
    static Object[] s159 = {s1, s158};
    static /*Structure*/Object s160 = makeStructure(s7, s159);
    static /*Symbol*/Object s161 = makeAtom("@<");
    static Object[] s162 = {si132, s11, s161};
    static /*Structure*/Object s163 = makeStructure(s9, s162);
    static Object[] s164 = {s163, s15};
    static /*Structure*/Object s165 = makeStructure(s8, s164);
    static Object[] s166 = {s1, s165};
    static /*Structure*/Object s167 = makeStructure(s7, s166);
    static /*Symbol*/Object s168 = makeAtom("@>");
    static Object[] s169 = {si132, s11, s168};
    static /*Structure*/Object s170 = makeStructure(s9, s169);
    static Object[] s171 = {s170, s15};
    static /*Structure*/Object s172 = makeStructure(s8, s171);
    static Object[] s173 = {s1, s172};
    static /*Structure*/Object s174 = makeStructure(s7, s173);
    static /*Symbol*/Object s175 = makeAtom("@=<");
    static Object[] s176 = {si132, s11, s175};
    static /*Structure*/Object s177 = makeStructure(s9, s176);
    static Object[] s178 = {s177, s15};
    static /*Structure*/Object s179 = makeStructure(s8, s178);
    static Object[] s180 = {s1, s179};
    static /*Structure*/Object s181 = makeStructure(s7, s180);
    static /*Symbol*/Object s182 = makeAtom("@>=");
    static Object[] s183 = {si132, s11, s182};
    static /*Structure*/Object s184 = makeStructure(s9, s183);
    static Object[] s185 = {s184, s15};
    static /*Structure*/Object s186 = makeStructure(s8, s185);
    static Object[] s187 = {s1, s186};
    static /*Structure*/Object s188 = makeStructure(s7, s187);
    static /*Symbol*/Object s189 = makeAtom("=..");
    static Object[] s190 = {si132, s11, s189};
    static /*Structure*/Object s191 = makeStructure(s9, s190);
    static Object[] s192 = {s191, s15};
    static /*Structure*/Object s193 = makeStructure(s8, s192);
    static Object[] s194 = {s1, s193};
    static /*Structure*/Object s195 = makeStructure(s7, s194);
    static /*Symbol*/Object s196 = makeAtom("is");
    static Object[] s197 = {si132, s11, s196};
    static /*Structure*/Object s198 = makeStructure(s9, s197);
    static Object[] s199 = {s198, s15};
    static /*Structure*/Object s200 = makeStructure(s8, s199);
    static Object[] s201 = {s1, s200};
    static /*Structure*/Object s202 = makeStructure(s7, s201);
    static /*Symbol*/Object s203 = makeAtom("=:=");
    static Object[] s204 = {si132, s11, s203};
    static /*Structure*/Object s205 = makeStructure(s9, s204);
    static Object[] s206 = {s205, s15};
    static /*Structure*/Object s207 = makeStructure(s8, s206);
    static Object[] s208 = {s1, s207};
    static /*Structure*/Object s209 = makeStructure(s7, s208);
    static /*Symbol*/Object s210 = makeAtom("=\\=");
    static Object[] s211 = {si132, s11, s210};
    static /*Structure*/Object s212 = makeStructure(s9, s211);
    static Object[] s213 = {s212, s15};
    static /*Structure*/Object s214 = makeStructure(s8, s213);
    static Object[] s215 = {s1, s214};
    static /*Structure*/Object s216 = makeStructure(s7, s215);
    static /*Symbol*/Object s217 = makeAtom("<");
    static Object[] s218 = {si132, s11, s217};
    static /*Structure*/Object s219 = makeStructure(s9, s218);
    static Object[] s220 = {s219, s15};
    static /*Structure*/Object s221 = makeStructure(s8, s220);
    static Object[] s222 = {s1, s221};
    static /*Structure*/Object s223 = makeStructure(s7, s222);
    static /*Symbol*/Object s224 = makeAtom(">");
    static Object[] s225 = {si132, s11, s224};
    static /*Structure*/Object s226 = makeStructure(s9, s225);
    static Object[] s227 = {s226, s15};
    static /*Structure*/Object s228 = makeStructure(s8, s227);
    static Object[] s229 = {s1, s228};
    static /*Structure*/Object s230 = makeStructure(s7, s229);
    static /*Symbol*/Object s231 = makeAtom("=<");
    static Object[] s232 = {si132, s11, s231};
    static /*Structure*/Object s233 = makeStructure(s9, s232);
    static Object[] s234 = {s233, s15};
    static /*Structure*/Object s235 = makeStructure(s8, s234);
    static Object[] s236 = {s1, s235};
    static /*Structure*/Object s237 = makeStructure(s7, s236);
    static /*Symbol*/Object s238 = makeAtom(">=");
    static Object[] s239 = {si132, s11, s238};
    static /*Structure*/Object s240 = makeStructure(s9, s239);
    static Object[] s241 = {s240, s15};
    static /*Structure*/Object s242 = makeStructure(s8, s241);
    static Object[] s243 = {s1, s242};
    static /*Structure*/Object s244 = makeStructure(s7, s243);
    static /*IntegerTerm*/Object si245 = makeInteger(550);
    static /*Symbol*/Object s246 = makeAtom(":");
    static Object[] s247 = {si245, s99, s246};
    static /*Structure*/Object s248 = makeStructure(s9, s247);
    static Object[] s249 = {s248, s15};
    static /*Structure*/Object s250 = makeStructure(s8, s249);
    static Object[] s251 = {s1, s250};
    static /*Structure*/Object s252 = makeStructure(s7, s251);
    static /*IntegerTerm*/Object si253 = makeInteger(500);
    static /*Symbol*/Object s254 = makeAtom("yfx");
    static /*Symbol*/Object s255 = makeAtom("+");
    static Object[] s256 = {si253, s254, s255};
    static /*Structure*/Object s257 = makeStructure(s9, s256);
    static Object[] s258 = {s257, s15};
    static /*Structure*/Object s259 = makeStructure(s8, s258);
    static Object[] s260 = {s1, s259};
    static /*Structure*/Object s261 = makeStructure(s7, s260);
    static /*Symbol*/Object s262 = makeAtom("-");
    static Object[] s263 = {si253, s254, s262};
    static /*Structure*/Object s264 = makeStructure(s9, s263);
    static Object[] s265 = {s264, s15};
    static /*Structure*/Object s266 = makeStructure(s8, s265);
    static Object[] s267 = {s1, s266};
    static /*Structure*/Object s268 = makeStructure(s7, s267);
    static /*Symbol*/Object s269 = makeAtom("#");
    static Object[] s270 = {si253, s254, s269};
    static /*Structure*/Object s271 = makeStructure(s9, s270);
    static Object[] s272 = {s271, s15};
    static /*Structure*/Object s273 = makeStructure(s8, s272);
    static Object[] s274 = {s1, s273};
    static /*Structure*/Object s275 = makeStructure(s7, s274);
    static /*Symbol*/Object s276 = makeAtom("/\\");
    static Object[] s277 = {si253, s254, s276};
    static /*Structure*/Object s278 = makeStructure(s9, s277);
    static Object[] s279 = {s278, s15};
    static /*Structure*/Object s280 = makeStructure(s8, s279);
    static Object[] s281 = {s1, s280};
    static /*Structure*/Object s282 = makeStructure(s7, s281);
    static /*Symbol*/Object s283 = makeAtom("\\/");
    static Object[] s284 = {si253, s254, s283};
    static /*Structure*/Object s285 = makeStructure(s9, s284);
    static Object[] s286 = {s285, s15};
    static /*Structure*/Object s287 = makeStructure(s8, s286);
    static Object[] s288 = {s1, s287};
    static /*Structure*/Object s289 = makeStructure(s7, s288);
    static Object[] s290 = {si253, s27, s255};
    static /*Structure*/Object s291 = makeStructure(s9, s290);
    static Object[] s292 = {s291, s15};
    static /*Structure*/Object s293 = makeStructure(s8, s292);
    static Object[] s294 = {s1, s293};
    static /*Structure*/Object s295 = makeStructure(s7, s294);
    static /*IntegerTerm*/Object si296 = makeInteger(400);
    static /*Symbol*/Object s297 = makeAtom("*");
    static Object[] s298 = {si296, s254, s297};
    static /*Structure*/Object s299 = makeStructure(s9, s298);
    static Object[] s300 = {s299, s15};
    static /*Structure*/Object s301 = makeStructure(s8, s300);
    static Object[] s302 = {s1, s301};
    static /*Structure*/Object s303 = makeStructure(s7, s302);
    static /*Symbol*/Object s304 = makeAtom("/");
    static Object[] s305 = {si296, s254, s304};
    static /*Structure*/Object s306 = makeStructure(s9, s305);
    static Object[] s307 = {s306, s15};
    static /*Structure*/Object s308 = makeStructure(s8, s307);
    static Object[] s309 = {s1, s308};
    static /*Structure*/Object s310 = makeStructure(s7, s309);
    static /*Symbol*/Object s311 = makeAtom("//");
    static Object[] s312 = {si296, s254, s311};
    static /*Structure*/Object s313 = makeStructure(s9, s312);
    static Object[] s314 = {s313, s15};
    static /*Structure*/Object s315 = makeStructure(s8, s314);
    static Object[] s316 = {s1, s315};
    static /*Structure*/Object s317 = makeStructure(s7, s316);
    static /*Symbol*/Object s318 = makeAtom("mod");
    static Object[] s319 = {si296, s254, s318};
    static /*Structure*/Object s320 = makeStructure(s9, s319);
    static Object[] s321 = {s320, s15};
    static /*Structure*/Object s322 = makeStructure(s8, s321);
    static Object[] s323 = {s1, s322};
    static /*Structure*/Object s324 = makeStructure(s7, s323);
    static /*Symbol*/Object s325 = makeAtom("rem");
    static Object[] s326 = {si296, s254, s325};
    static /*Structure*/Object s327 = makeStructure(s9, s326);
    static Object[] s328 = {s327, s15};
    static /*Structure*/Object s329 = makeStructure(s8, s328);
    static Object[] s330 = {s1, s329};
    static /*Structure*/Object s331 = makeStructure(s7, s330);
    static /*Symbol*/Object s332 = makeAtom("<<");
    static Object[] s333 = {si296, s254, s332};
    static /*Structure*/Object s334 = makeStructure(s9, s333);
    static Object[] s335 = {s334, s15};
    static /*Structure*/Object s336 = makeStructure(s8, s335);
    static Object[] s337 = {s1, s336};
    static /*Structure*/Object s338 = makeStructure(s7, s337);
    static /*Symbol*/Object s339 = makeAtom(">>");
    static Object[] s340 = {si296, s254, s339};
    static /*Structure*/Object s341 = makeStructure(s9, s340);
    static Object[] s342 = {s341, s15};
    static /*Structure*/Object s343 = makeStructure(s8, s342);
    static Object[] s344 = {s1, s343};
    static /*Structure*/Object s345 = makeStructure(s7, s344);
    static /*IntegerTerm*/Object si346 = makeInteger(300);
    static /*Symbol*/Object s347 = makeAtom("~");
    static Object[] s348 = {si346, s11, s347};
    static /*Structure*/Object s349 = makeStructure(s9, s348);
    static Object[] s350 = {s349, s15};
    static /*Structure*/Object s351 = makeStructure(s8, s350);
    static Object[] s352 = {s1, s351};
    static /*Structure*/Object s353 = makeStructure(s7, s352);
    static /*IntegerTerm*/Object si354 = makeInteger(200);
    static /*Symbol*/Object s355 = makeAtom("**");
    static Object[] s356 = {si354, s11, s355};
    static /*Structure*/Object s357 = makeStructure(s9, s356);
    static Object[] s358 = {s357, s15};
    static /*Structure*/Object s359 = makeStructure(s8, s358);
    static Object[] s360 = {s1, s359};
    static /*Structure*/Object s361 = makeStructure(s7, s360);
    static /*Symbol*/Object s362 = makeAtom("^");
    static Object[] s363 = {si354, s99, s362};
    static /*Structure*/Object s364 = makeStructure(s9, s363);
    static Object[] s365 = {s364, s15};
    static /*Structure*/Object s366 = makeStructure(s8, s365);
    static Object[] s367 = {s1, s366};
    static /*Structure*/Object s368 = makeStructure(s7, s367);
    static /*Symbol*/Object s369 = makeAtom("\\");
    static Object[] s370 = {si354, s124, s369};
    static /*Structure*/Object s371 = makeStructure(s9, s370);
    static Object[] s372 = {s371, s15};
    static /*Structure*/Object s373 = makeStructure(s8, s372);
    static Object[] s374 = {s1, s373};
    static /*Structure*/Object s375 = makeStructure(s7, s374);
    static Object[] s376 = {si354, s124, s262};
    static /*Structure*/Object s377 = makeStructure(s9, s376);
    static Object[] s378 = {s377, s15};
    static /*Structure*/Object s379 = makeStructure(s8, s378);
    static Object[] s380 = {s1, s379};
    static /*Structure*/Object s381 = makeStructure(s7, s380);
    static /*Symbol*/Object s382 = makeAtom("$current_leash");
    static Object[] s383 = {s382, si4};
    static /*Structure*/Object s384 = makeStructure(s2, s383);
    static /*Symbol*/Object s385 = makeAtom("$current_spypoint");
    static /*IntegerTerm*/Object si386 = makeInteger(3);
    static Object[] s387 = {s385, si386};
    static /*Structure*/Object s388 = makeStructure(s2, s387);
    static /*Symbol*/Object s389 = makeAtom("$leap_flag");
    static Object[] s390 = {s389, si4};
    static /*Structure*/Object s391 = makeStructure(s2, s390);
    static /*Symbol*/Object s392 = makeAtom("$consulted_file");
    static Object[] s393 = {s392, si4};
    static /*Structure*/Object s394 = makeStructure(s2, s393);
    static /*Symbol*/Object s395 = makeAtom("$consulted_package");
    static Object[] s396 = {s395, si4};
    static /*Structure*/Object s397 = makeStructure(s2, s396);
    static /*Symbol*/Object s398 = makeAtom("$consulted_predicate");
    static Object[] s399 = {s398, si386};
    static /*Structure*/Object s400 = makeStructure(s2, s399);

    public PRED_$init_0(Predicate cont) {
        this.cont = cont;
    }

    public PRED_$init_0(){}

    public void setArgument(Object[] args, Predicate cont) {
        this.cont = cont;
    }

    public int arity() { return 0; }

    public String nameUQ() { return "$init"; }

    public void sArg(int i0, Object val) {  switch (i0) {default: newIndexOutOfBoundsException("setarg" , i0 , val);  }   }


    public Object gArg(int i0) {  switch (i0) {default: return newIndexOutOfBoundsException("getarg", i0,null);  }   }


    public String toPrologString(java.util.Collection newParam) {
        return "'$init";
    }

    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); 
    // '$init':-'$new_indexing_hash'('jp.ac.kobe_u.cs.prolog.builtin', '$tokens'/1, A), assertz(('$current_operator'(1200, xfx, (:-)):-true)), assertz(('$current_operator'(1200, xfx, (-->)):-true)), assertz(('$current_operator'(1200, fx, (:-)):-true)), assertz(('$current_operator'(1200, fx, (?-)):-true)), assertz(('$current_operator'(1150, fx, (package)):-true)), assertz(('$current_operator'(1150, fx, (import)):-true)), assertz(('$current_operator'(1150, fx, (public)):-true)), assertz(('$current_operator'(1150, fx, (dynamic)):-true)), assertz(('$current_operator'(1150, fx, (meta_predicate)):-true)), assertz(('$current_operator'(1150, fx, (mode)):-true)), assertz(('$current_operator'(1150, fx, (multifile)):-true)), assertz(('$current_operator'(1150, fx, (block)):-true)), assertz(('$current_operator'(1100, xfy, (;)):-true)), assertz(('$current_operator'(1050, xfy, (->)):-true)), assertz(('$current_operator'(1000, xfy, (',')):-true)), assertz(('$current_operator'(900, fy, \+):-true)), assertz(('$current_operator'(700, xfx, =):-true)), assertz(('$current_operator'(700, xfx, \=):-true)), assertz(('$current_operator'(700, xfx, ==):-true)), assertz(('$current_operator'(700, xfx, \==):-true)), assertz(('$current_operator'(700, xfx, @<):-true)), assertz(('$current_operator'(700, xfx, @>):-true)), assertz(('$current_operator'(700, xfx, @=<):-true)), assertz(('$current_operator'(700, xfx, @>=):-true)), assertz(('$current_operator'(700, xfx, =..):-true)), assertz(('$current_operator'(700, xfx, is):-true)), assertz(('$current_operator'(700, xfx, =:=):-true)), assertz(('$current_operator'(700, xfx, =\=):-true)), assertz(('$current_operator'(700, xfx, <):-true)), assertz(('$current_operator'(700, xfx, >):-true)), assertz(('$current_operator'(700, xfx, =<):-true)), assertz(('$current_operator'(700, xfx, >=):-true)), assertz(('$current_operator'(550, xfy, :):-true)), assertz(('$current_operator'(500, yfx, +):-true)), assertz(('$current_operator'(500, yfx, -):-true)), assertz(('$current_operator'(500, yfx, #):-true)), assertz(('$current_operator'(500, yfx, /\):-true)), assertz(('$current_operator'(500, yfx, \/):-true)), assertz(('$current_operator'(500, fx, +):-true)), assertz(('$current_operator'(400, yfx, *):-true)), assertz(('$current_operator'(400, yfx, /):-true)), assertz(('$current_operator'(400, yfx, //):-true)), assertz(('$current_operator'(400, yfx, mod):-true)), assertz(('$current_operator'(400, yfx, rem):-true)), assertz(('$current_operator'(400, yfx, <<):-true)), assertz(('$current_operator'(400, yfx, >>):-true)), assertz(('$current_operator'(300, xfx, ~):-true)), assertz(('$current_operator'(200, xfx, **):-true)), assertz(('$current_operator'(200, xfy, ^):-true)), assertz(('$current_operator'(200, fy, \):-true)), assertz(('$current_operator'(200, fy, -):-true)), '$new_indexing_hash'('jp.ac.kobe_u.cs.prolog.builtin', '$current_leash'/1, B), '$new_indexing_hash'('jp.ac.kobe_u.cs.prolog.builtin', '$current_spypoint'/3, C), '$new_indexing_hash'('jp.ac.kobe_u.cs.prolog.builtin', '$leap_flag'/1, D), '$new_indexing_hash'('jp.ac.kobe_u.cs.prolog.builtin', '$consulted_file'/1, E), '$new_indexing_hash'('jp.ac.kobe_u.cs.prolog.builtin', '$consulted_package'/1, F), '$new_indexing_hash'('jp.ac.kobe_u.cs.prolog.builtin', '$consulted_predicate'/3, G)
        engine.setB0();
        Predicate p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50, p51, p52, p53, p54, p55, p56, p57;
    // '$init':-['$new_indexing_hash'('jp.ac.kobe_u.cs.prolog.builtin', '$tokens'/1, A), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(1200, xfx, (:-)):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(1200, xfx, (-->)):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(1200, fx, (:-)):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(1200, fx, (?-)):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(1150, fx, (package)):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(1150, fx, (import)):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(1150, fx, (public)):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(1150, fx, (dynamic)):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(1150, fx, (meta_predicate)):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(1150, fx, (mode)):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(1150, fx, (multifile)):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(1150, fx, (block)):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(1100, xfy, (;)):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(1050, xfy, (->)):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(1000, xfy, (',')):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(900, fy, \+):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(700, xfx, =):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(700, xfx, \=):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(700, xfx, ==):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(700, xfx, \==):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(700, xfx, @<):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(700, xfx, @>):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(700, xfx, @=<):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(700, xfx, @>=):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(700, xfx, =..):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(700, xfx, is):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(700, xfx, =:=):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(700, xfx, =\=):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(700, xfx, <):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(700, xfx, >):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(700, xfx, =<):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(700, xfx, >=):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(550, xfy, :):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(500, yfx, +):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(500, yfx, -):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(500, yfx, #):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(500, yfx, /\):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(500, yfx, \/):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(500, fx, +):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(400, yfx, *):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(400, yfx, /):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(400, yfx, //):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(400, yfx, mod):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(400, yfx, rem):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(400, yfx, <<):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(400, yfx, >>):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(300, xfx, ~):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(200, xfx, **):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(200, xfy, ^):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(200, fy, \):-true)), assertz('jp.ac.kobe_u.cs.prolog.builtin': ('$current_operator'(200, fy, -):-true)), '$new_indexing_hash'('jp.ac.kobe_u.cs.prolog.builtin', '$current_leash'/1, B), '$new_indexing_hash'('jp.ac.kobe_u.cs.prolog.builtin', '$current_spypoint'/3, C), '$new_indexing_hash'('jp.ac.kobe_u.cs.prolog.builtin', '$leap_flag'/1, D), '$new_indexing_hash'('jp.ac.kobe_u.cs.prolog.builtin', '$consulted_file'/1, E), '$new_indexing_hash'('jp.ac.kobe_u.cs.prolog.builtin', '$consulted_package'/1, F), '$new_indexing_hash'('jp.ac.kobe_u.cs.prolog.builtin', '$consulted_predicate'/3, G)]
        p1 = new PRED_$new_indexing_hash_3(s1, s400, engine.makeVariable(this), cont);
        p2 = new PRED_$new_indexing_hash_3(s1, s397, engine.makeVariable(this), p1);
        p3 = new PRED_$new_indexing_hash_3(s1, s394, engine.makeVariable(this), p2);
        p4 = new PRED_$new_indexing_hash_3(s1, s391, engine.makeVariable(this), p3);
        p5 = new PRED_$new_indexing_hash_3(s1, s388, engine.makeVariable(this), p4);
        p6 = new PRED_$new_indexing_hash_3(s1, s384, engine.makeVariable(this), p5);
        p7 = new PRED_assertz_1(s381, p6);
        p8 = new PRED_assertz_1(s375, p7);
        p9 = new PRED_assertz_1(s368, p8);
        p10 = new PRED_assertz_1(s361, p9);
        p11 = new PRED_assertz_1(s353, p10);
        p12 = new PRED_assertz_1(s345, p11);
        p13 = new PRED_assertz_1(s338, p12);
        p14 = new PRED_assertz_1(s331, p13);
        p15 = new PRED_assertz_1(s324, p14);
        p16 = new PRED_assertz_1(s317, p15);
        p17 = new PRED_assertz_1(s310, p16);
        p18 = new PRED_assertz_1(s303, p17);
        p19 = new PRED_assertz_1(s295, p18);
        p20 = new PRED_assertz_1(s289, p19);
        p21 = new PRED_assertz_1(s282, p20);
        p22 = new PRED_assertz_1(s275, p21);
        p23 = new PRED_assertz_1(s268, p22);
        p24 = new PRED_assertz_1(s261, p23);
        p25 = new PRED_assertz_1(s252, p24);
        p26 = new PRED_assertz_1(s244, p25);
        p27 = new PRED_assertz_1(s237, p26);
        p28 = new PRED_assertz_1(s230, p27);
        p29 = new PRED_assertz_1(s223, p28);
        p30 = new PRED_assertz_1(s216, p29);
        p31 = new PRED_assertz_1(s209, p30);
        p32 = new PRED_assertz_1(s202, p31);
        p33 = new PRED_assertz_1(s195, p32);
        p34 = new PRED_assertz_1(s188, p33);
        p35 = new PRED_assertz_1(s181, p34);
        p36 = new PRED_assertz_1(s174, p35);
        p37 = new PRED_assertz_1(s167, p36);
        p38 = new PRED_assertz_1(s160, p37);
        p39 = new PRED_assertz_1(s153, p38);
        p40 = new PRED_assertz_1(s146, p39);
        p41 = new PRED_assertz_1(s139, p40);
        p42 = new PRED_assertz_1(s131, p41);
        p43 = new PRED_assertz_1(s122, p42);
        p44 = new PRED_assertz_1(s114, p43);
        p45 = new PRED_assertz_1(s106, p44);
        p46 = new PRED_assertz_1(s97, p45);
        p47 = new PRED_assertz_1(s90, p46);
        p48 = new PRED_assertz_1(s83, p47);
        p49 = new PRED_assertz_1(s76, p48);
        p50 = new PRED_assertz_1(s69, p49);
        p51 = new PRED_assertz_1(s62, p50);
        p52 = new PRED_assertz_1(s55, p51);
        p53 = new PRED_assertz_1(s48, p52);
        p54 = new PRED_assertz_1(s40, p53);
        p55 = new PRED_assertz_1(s33, p54);
        p56 = new PRED_assertz_1(s26, p55);
        p57 = new PRED_assertz_1(s19, p56);
        return exit(engine, new PRED_$new_indexing_hash_3(s1, s6, engine.makeVariable(this), p57));
    }
}
