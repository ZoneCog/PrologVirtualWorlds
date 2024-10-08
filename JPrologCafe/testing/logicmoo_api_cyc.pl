:-use_module(library(odbc)).  
:-odbc_debug(5).
:-dynamic_transparent(ensureCycCallsProlog/2).
:-include('logicmoo_utils_header.pl'). %<?
%<?
% ===================================================================
% ===================================================================
% ===================================================================
clientEvent(Channel,Agent,[file='cycl.moo'|A]):-!,
	 writeHTMLStdHeader('CycL Assert/Query'),
	 getMooOption(Agent,formula='(#$genls ?X #$Omnivore)',Formula),!,
	 say('<form method="GET">'),
	 showContextHtml(Ctx),
	 say('<p><textarea rows="9" name="formula" cols="40">~w</textarea><br>
	 <input type="submit" value="Assert" name="submit">&nbsp;
	 <input type="submit" value="Query" name="submit">&nbsp;
	 <input type="reset" value="Reset" name="resetButton"></p>  Inference module: ',[Formula]),!,
	 %writeObject(select('inferenceType',['Full','Facts','Asserted','Extreme'])),
	 say('</form>'),!,
	 getMooOption(Agent,ctx,Mt),!,
	 getMooOption(Agent,submit,Submit),!,
	 getMooOption(Agent,inferenceType,IT),!,
	 once((atom_codes(Formula,Chars),getSurfaceFromChars(Chars,Goal,Vars))),
	 balanceBinding(Goal,Assert),
	 getCputime(Before),
	 processRequestCycL(Submit,Formula,Chars,Goal,Assert,Vars,Mt,IT),
	 getCputime(After),Total is After - Before,
	 say('~n<br><b>Total time was ~w secs</b>',[Total]),!,
	 writeHTMLStdFooter,!.

processRequestCycL(Submit,Formula,Chars,Goal,Assert,Vars,Mt,IT):-var(Formula),!.
processRequestCycL('Query',Formula,Chars,Goal,Assert,Vars,Mt,IT):-
      ignore(catch((andCall(Goal),writeCycLVarBindings(Vars),fail),E,say('<br>~n~q',[E]))),!.
processRequestCycL('Assert',Formula,Chars,Goal,Assert,Vars,Mt,IT):-
      say('<pre>'),
      say('<br>asserting...<br>'),
      ignore(writeObject(Assert,Vars)),
      ignore(assertCycLWithTMS(Assert,Vars,Mt,IT)),
      say('</pre>').

      
% 
assertCycLWithTMS(Assert,Vars,Mt,IT):- 
	    getPrologVars(Assert, _, Singles, Multiples),Singles=[X|L],
	    say('~n<font color=red>Assertion veto by Truth Compiler~nReason: Contains variables that are not quantified~nTry using quantifiers like #$forAll or #$thereExists</font>~n'),
	    writeObject([X|L],Vars).
assertCycLWithTMS(Assert,Vars,Mt,IT):-
      say('~ninto ~w',[Mt]),
      invokeOperationProc(verbose,canonicalize(Assert),Mt,TN,Context,Agent,Vars).

processRequestCycL(Submit,Formula,Mt,IT).

writeCycLVarBindings(Vars):-writeObject('<br>'),writeObject(getPrologVars(Vars)),!.

fixSvade:-
   saved(A,B,C,D),
   fixSaved(A,B,C,D,After),
   format('~q.~n',[After]),
   fail.

fixSaved(A,B,C,_,After):-
      A=..[P|List],
      transoutString(List,ListO),
      getConstants(atom,ListO,Items,_,_),
      Vector=..[v|Items],
      append([P|ListO],[B,v(Vector,C)],NewL),
      After=..NewL,!.
   
fixDb:-see('../world/cyc.el'),
   repeat,
      read(Term),
      convertTermNL(Term,Out),
      format('~q.~n',Out),
      Term==end_of_file.


convertTermNL(':-'(Term),':-'(Term)):-nonvar(Term),!.
convertTermNL(Term,Term):-not(compound(Term)),!.
%convertTermNL([T|Erm],Term):-ground([T|Erm]),Term=..['[]'|[T|Erm]],!.
convertTermNL([T|Erm],[T|Erm]):-!.
convertTermNL(Term,List):-functor(Term,[],_),Term=..[_|List],!.
convertTermNL(Term,O):-Term=..List,convertTermNLS(List,ListO),O=..ListO,!.

convertTermNL(Term,Term).
convertTermNLS([],[]).
convertTermNLS([H|T],[HH|TT]):-convertTermNL(H,HH),convertTermNLS(T,TT).


:- style_check(-discontiguous).
:- style_check(-singleton).
:- style_check(-atom).
:- style_check(+string).

:- use_module(library(occurs)).
:-use_module(library(make)).
:-use_module(library(lists)).
%:- ([owl_parser]).

:-redefine_system_predicate(list_undefined).
:-redefine_system_predicate(make:list_undefined).

:-redefine_system_predicate(between/3).

list_undefined.
make:list_undefined.

%:-[cyc_nl].



%:- [tasks_sd2].
%:- [sdom2].
%:- [tasks_sd3].
%:- [sdom3].
%:- [tasks_sd4].
%:- [sdom4].


%kb(Out):-assertion([[ist,Mt,Form],S,D]),once((s2p([ist,Mt,Form],ist(MM,P),Opt),sort(Opt,DSO),P=..PP,append(PP,[MM,prop(DSO,D,S)],PPP),Out=..PPP)).


tellall(Sig):-flag(Sig,_,0),Sig,format('~q.~n',[Sig]),flag(Sig,X,X+1),fail.
tellall(Sig):-!,flag(Sig,X,X),format(user_error,'% ~q total ~d.~n',[Sig,X]).

%:-['plassertions'].
%:-['plconstants'].
%:-['plnarts'].

:-index(asserted(1, 1, 1, 1)).
:-dynamic_transparent(asserted/4).
%:-['asserted'].


loadRCyc(File):-
      see(File),
      repeat,
      read(Term),
      once(loadRCycTerm(Term)),
      Term = end_of_file,seen.

loadRCycTerm(termOfUnit(_,_,_,_)).
loadRCycTerm('.'(X,Y,Z,T)):-!,loadRCycTerm('istFn'(Z,X,Y,T,_)).
loadRCycTerm(X):-X=..[F|ARGS],
         append(Left,[_,_],ARGS),
         NX=..[F|Left],
         catch(loadRCycTerm2(NX),E,(format(user_error,'~q.~n',[E]))),!.

loadRCycTerm2(NX):-once(catch(once(clause(NX,_,_)),_,fail)->true;assert(NX)).

lrc:-loadRCyc('plassertions.pl').

%:-use_module(library(check)).
:-abolish(check:list_undefined/0).
:-abolish(list_undefined/0).
list_undefined.


assertable(Pred,Arg1,Arg2,[],MT):-
         asserted(arity,Pred,2,[]),
         asserted(arg1Isa,Pred,Arg1C,[]),asserted(arg2Isa,Pred,Arg2C,[]),
         asserted(isa,Arg2,Arg2C,[]),asserted(isa,Arg1,Arg1C,[]).

predAccess(Pred,assertedMt):-var(Pred),!,fail.
predAccess(comment,assertedMt).
predAccess(termOfUnit,assertedMt).
predAccess(cyclistNotes,assertedMt).
predAccess(Pred,assertedMt):-asserted(argIsa, Pred, _, ['ProperNameString']).

assertedLocal(PredO,Arg1O,Arg2O,ArgSO):-
   assertedMt(PredO,Arg1O,Arg2O,ArgSO,MT),
   not(Arg2O=[_,_,_,_|_]),
   not(predAccess(PredO,assertedMt)).





:-dynamic_transparent(inferAsserted/4).
%inferAsserted(nearestIsa,X,Y,[]):-asserted(isa,X,Y,[]).
%inferAsserted(nearestGenls,X,Y,[]):-asserted(genls,X,Y,[]).
%inferAsserted(nearestGenlMt,X,Y,[]):-asserted(genlMt,X,Y,[]).

rewriteAssertions:-
%      abolish(asserted/4),dynamic_transparent(asserted/4),
      tell('asserted.pl'),
      format('
:- style_check(-singleton).
:- style_check(-discontiguous).
:- style_check(-atom).
:- style_check(+string).
:-index(asserted(1,1,1,1)).
:-dynamic_transparent(asserted/4).
asserted(A,B,C,D):-inferAsserted(A,B,C,D).
             ~n',[]),!,
      ignore((assertedMt(PredO,Arg1O,Arg2O,ArgSO,MT),
      writeAssertions(assertedMt(PredO,Arg1O,Arg2O,ArgSO,MT)),
      fail)),
      told,
     !. % ['asserted.pl'].

writeAssertions(assertedMt(PredO,Arg1O,Arg2O,ArgSO,MT)):-fail.
writeAssertions(assertedMt(PredO,Arg1O,Arg2O,ArgSO,MT)):-!,
      format('~q.~n',[asserted(PredO,Arg1O,Arg2O,ArgSO)]).


rewriteAssertions2:-
         abolish(asserted/4),
         dynamic_transparent(asserted/4),
      tell('asserted.pl'),
      format('
:- style_check(-singleton).
:- style_check(-discontiguous).
:- style_check(-atom).
:- style_check(+string).
:-index(asserted(1,1,1,1)).
:-dynamic_transparent(asserted/4).
asserted(A,B,C,D):-inferAsserted(A,B,C,D).
             ~n',[]),!,
      ignore((assertedLocal(PredO,Arg1O,Arg2O,ArgSO),format('~q.~n',[asserted(PredO,Arg1O,Arg2O,ArgSO)]),fail)),
      told,
      !. %['asserted.pl'].


assertedMt(PredO,Arg1O,Arg2O,ArgSO,MTO):-assertedMt(PredO,Arg1O,Arg2O,ArgSO,MTO,_Vars).
assertedMt(PredO,Arg1O,Arg2O,ArgSO,MTO,Vars):-
   assertion(_ID,Pred,Rest,MT,EL,_TRUE,_FORWARD,_MONOTONIC,_DEDUCED,_DEPENDANTS,_ARGUMENT,_WHEN20050225,_WHO),
   not(member(Pred,[termOfUnit,comment,cyclistNotes])),
   xform([Pred|Rest],MT,EL,PredO,Arg1O,Arg2O,ArgSO,MTO,Vars).

xform(HL,MT,EL,PredO,Arg1O,Arg2O,ArgSO,MTO,Vars):-   
   cyc:s2p(EL,ELO,EV),
   cyc:s2p(HL,HLO,HV),
   cyc:s2p(MT,MTO,MV),
   append(EV,HV,EH),
   append(EH,MV,VarsI),!,
   safe_sort(VarsI,Vars),!,   
   recode(ELO,HLO,NLO),
   decodeEL(NLO,PredO,Arg1O,Arg2O,ArgSO,MTO).

%   ((functor(HLO,F,_),functor(ELO,F,_)) -> decodeEL(HLO,PredO,Arg1O,Arg2O,ArgSO,MTO);(decodeEL(el(ELO),PredO,Arg1O,Arg2O,ArgSO,MTO);decodeEL(HLO,PredO,Arg1O,Arg2O,ArgSO,MTO))).
%   ((ELO=HLO) -> decodeEL(HLO,PredO,Arg1O,Arg2O,ArgSO,MTO);(decodeEL(el(ELO),PredO,Arg1O,Arg2O,ArgSO,MTO);decodeEL(HLO,PredO,Arg1O,Arg2O,ArgSO,MTO))).


%recode(HL,HL,HL):-!. %var(HL);number(HL);atom(HL),!.
recode(EL,HL,EL):-unify_with_occurs_check(EL,HL),!.
recode(EL,HL,EL):-var(HL),!.
recode(EL,HL,HL):-var(EL),!.
recode([E|EL],[H|HL],[N|NL]):-!,recode(E,H,N),recode(EL,HL,NL).
recode(_,nart(NART),nart(NART)):-!.
recode(nart(NART),_,nart(NART)):-!.
recode(EL,assertionID(_),EL):-!.
recode(assertionID(_),EL,EL):-!.
recode(EL,HL,NL):-EL=..[P|ELL],HL=..[P|HLL],!,recode(ELL,HLL,NLL),NL=..[P|NLL].
recode(EL,HL,EL).
%srecode(EL,HL,HL).
   

safe_sort(Vars,Vars):-var(Vars),!.
safe_sort(VarsI,Vars):-sort(VarsI,Vars).

decodeEL(ELO,PredO,Arg1O,Arg2O,ArgSO,MTO):-
   once(((ELO=..[PredO,Arg1O],Arg2O=[],ArgSO=[]);
   ELO=..[PredO,Arg1O,Arg2O|ArgSO])).
 
cycQuery2(X):-call_with_depth_limit(cycQFull(X),3,L),not(depth_limit_exceeded=L).

%cycQuery2(X):-trand((L=H;genlPreds(L,H,_,_)),arity(L,A,_,_),functor(X,H,A)),X=..[L|XS],append([L|XS],[MT,_],XX),P=..XX,catch(P,_,fail).

cycQ(X):-var(X),!,asserted(F,Arg1,Arg2,Rest),X=..[F,Arg1,Arg2|Rest].
cycQ(X):-ground(X),!,cycQueryBoth(X),!.
cycQ(X):-free_variables(X,[V]),!,cycQuery(X).
cycQ(X):-cycQueryBoth(X).

cycQueryBoth(X):-cycQuery(X).
cycQueryBoth(X):-cycQFull(X).


%constantFind(Name,R):-evalSubL('constant-apropos'(string(Name)),R:_).

cycQueryV(Vars,CycL):-free_variables(Vars,Free),cyc:cycQueryReal(CycL,'EverythingPSC',Free,Backchains,Number,Time,Depth).

cycQFull([P,Arg1,Arg2]):-nonvar(P),nonvar(Arg1),cycQueryV(Arg2,and(relationAllInstance(P,Type,Arg2),isa(Arg1,Type))).
cycQFull([P,Obj,Arg2]):-cycQ(isa(Obj,Type)),cycQPred(relationAllInstance,[P,Type,Arg2]).
cycQFull([P|Rest]):-!,cycQPred(P,Rest).
cycQFull(C):-compound(C),C=..[P|Rest],cycQPred(P,Rest).
%cycQFull(isa(X,Z)):-nonvar(Z),!,((Y=Z);transitive(genls,Y,Z)),ground(Y),not(Z=Y),binPred(isa,X,Y).
cycQFull(and(X,Y)):-cycQ(X),cycQ(Y).
cycQFull(and(X,Y,Z)):-cycQ(X),cycQ(Y),cycQ(Z).
cycQFull(X):- X=..[H|XS], transitive(genlPreds,L,H),debugFmt(genlPreds(L,H)),cycQPred(L,XS).
cycQFull(C):-binPred(implies,A,C),not(contains_term(C,A)),debugFmt(implies(A,C)),cycQFull(A).

binPred(Pred,L,H):-cycQPred(Pred,[L,H]).

cycQPred(P,[Arg1]):-asserted(P,Arg1,[],[]).
cycQPred(P,[Arg1,Arg2|Rest]):-!,asserted(P,Arg1,Arg2,Rest).

transitive(Pred,L,H):- (binPred(Pred,L,M),(H=M;(binPred(Pred,M,M2),(H=M2;(binPred(Pred,M2,M3),
   (H=M3;(binPred(Pred,M3,M4),(H=M4;(binPred(Pred,M4,M5),(H=M5;(binPred(Pred,M5,M6),(H=M6;(binPred(Pred,M6,H)))))))))))))).

worthTry(P).

my_exec(I,J):- catch('$toplevel':'$execute'(I, J),E,(format(user_error,'% ~q.~n',[E]),fail)).

avar(AVAR).
unify_avar(AVAR,F):-compound(F),arg(N,F,C),compound(C),C=avar(AVAR),!.
unify_avar(AVAR,avar(AVAR)):-!.
unify_avar(AVAR,F).
      
      bindIgnore([]):-!.
bindIgnore([X|L]):-ignore(X),bindIgnore(L).




trand(X,Y):-free_variables(X,XX),free_variables(Y,YY),trand2(X,XX,Y,YY).
trand(X,Y,Z):-trand(trand(X,Y),Z).
trand2(X,[],Y,_):-!,X,Y.
trand2(X,_,Y,[]):-!,Y,X.
trand2(X,XX,Y,YY):-length(XX,NX),length(YY,NY),!, ((NY>NX) -> (Y,X) ; (X,Y)).



badQuery(genls(X,X)).

repl_prolog:-put_attr(AVAR,self,AVAR),repl_prolog(AVAR).

repl_prolog(AVAR):-
        flag('$tracing', A, off),
        flag('$break_level', B, B),
        ignore((
        repeat,
        (   '$toplevel':'$module'(C, C),
            (   stream_property(user_input, tty(true))
            ->  '$toplevel':'$system_prompt'(C, B, D),
                '$toplevel':prompt(E, '|    ')
            ;   D='',
                '$toplevel':prompt(E, '')
            ),
            trim_stacks,
            '$toplevel':read_query(D, F, G),
            unify_avar(AVAR,F),
            '$toplevel':prompt(H, E),
            '$toplevel':call_expand_query(F, I, G, J)
        -> my_exec(I,J)
        ),fail)),repl_prolog(AVAR).      
      

%:- [tasks_sd2].
%:- [sdom2].
%:- [tasks_sd3].
%:- [sdom3].
%:- [tasks_sd4].
%:- [sdom4].


qsize(X):-free_variables(X,F),qsizeV(F,X).

qsizeV(F,X):-findall(F,X,L),length(L,N),sort(L,LS),length(LS,NS),format('% Size ~q = ~q:~q~n',[X,N,NS]),member(F,LS).


% ===================================================================
% File 'cyc.pl'
% Purpose: Lower-level connection based utilities for interfacing to CYC from SWI-Prolog
% Maintainer: Douglas Miles
% Contact: $Author: dmiles $@users.sourceforge.net ;
% Version: 'cyc.pl' 1.0.0
% Revision:  $Revision: 1.7 $
% Revised At:   $Date: 2002/07/11 21:57:28 $
% ===================================================================

/*
:-module(cyc,[
	 cycInit/0,
	 getCycConnection/4,
	 finishCycConnection/3,
	 converse/1,
	 converse/2,
	 %evalSubL/2,
	 evalSubL/3,
	 converseRaw/2,
	 cycInfo/0,
         toCycVar/3,
         toCycVar/2,
	 formatCyc/3,
	 toCycApiExpression/2,
	 toCycApiExpression/3,
         isCycConstantGuess/1,
	 cycQuery/1,
	 cycQuery/2,
	 cycQuery/6,
	 cycQuery/8,
	 toMarkUp/4,
	 cycAssert/1,
	 cycAssert/2,
	 cycRetract/1,
	 is_string/1,
	 balanceBinding/2,
	 cycRetract/2,
	 cycRetractAll/1,
	 cycRetractAll/2,
	 isDebug/0,
	 makeConstant/1,
	 ensureMt/1,
	 isCycConstant/1,
	 readCycL/2,
	 termCyclify/2,
         %constant/4,
	 idGen/1,
	 subst/4,
	 unnumbervars/2,
	 defaultAssertMt/1,
         mtForCycL/2,
         assertIfNew/1,
	 getMtForPred/2,
	 isRegisterCycPred/3,
	 registerCycPred/1,
	 %setMooOption/2,
	 %setMooOption/1,
	 %unsetMooOption/1,
	 %isMooOption/1,
	 %isMooOption/2,

         getWordTokens/2,
	 registerCycPred/2,
	 registerCycPred/3,
         getSurfaceFromChars/3,
	 assertThrough/1,
         cycSync/0,
         cycSyncThread/0,
         cycAssertBuffer/1,
         cycAssertBuffer/2,
	 assertThrough/2,
	 assertThrough/2,
	 assertThrough/2,
	 writel/1,
	 writel/2,
	 % atomSplit/2,
	 list_to_conj/2,
	 testCYC/0,

         flush_output_safe/1,

         %processRequestHook/1,

         loadLispFile/1,
           	 
         badConstant/1,
         quoteAtomString/2,
         unquoteAtom/2,
         termCyclifyAtom/2,

	 createCycServer/1,
	 adaptiveServer/1,

         serviceAcceptedClientSocketAtThread/4,
         isCycProcess/2,
         isCycProcess/5,

         read_line_with_nl_p/3,
	 decodeRequest_p/2,
	 invokePrologCommandRDF_p/6,
	 servantProcessCreate_p/1,
	 servantProcessCreate_p/3,
	 servantProcessCreate_p/4,
	 servantProcessCreate_p/5,
	 createProcessedGoal_p/1,
	 cleanOldProcesses_p/0,
         servantProcessSelfClean_p/0,

         showCycProcessHTML/0,
         showCycStatisticsHTML/0,

         dynamic_transparent/1,

         guessConstant/2,

         readUntil/3,
         readCycLTermChars/3,
         readCycLTermChars/2,
         atom_to_number/2,

         %toUppercase/2,
         %toLowercase/2,
         toPropercase/2,
         toCamelcase/2,
         debugFmt/1,
         debugFmt/2,
         debugFmtFast/1,
         logOnFailureIgnore/1,

         trim/2,

         logOnFailure_p/1,

         writeHTMLStdHeader_p/1,
         writeHTMLStdFooter/0,	 
	 sendNote_p/1,
	 sendNote_p/4,
	 writeObject_p/2,
	 writeObject_p/3,
	 writeObject_conj_p/2,

         loadCycL/1,
         cycCacheToDo/1,
         cycCache/1,
         writeFailureLog/2,
         debugOnFailure/2,
         debugOnFailure/1

	 ]).
*/


loadLispFile(Filename):-
   open(Filename,read,H),
   repeat,
   readUntil(10,H,Get),
   doLispLine(Get),
   at_end_of_stream(H).
   
doLispLine(Get):- 
  once(getSurfaceFromChars(Get,Surf,Vars)),
   doLispLine(Surf,Vars). 



s2p(X,X,[]):- (var(X);number(X);is_string(X)),!.
s2p(svar(X,Name),X,[Name=X]):-atom_concat(':',_,Name),!.
s2p(svar(_,Name),Name,[])-!.
s2p(var(X,Name),X,[Name=X]):-!.
s2p([H|T],R,Opt):-!,s2Pred(H,T,R,Opt),!.
s2p(C,R,Opt):-compound(C),C=..[H|T],s2Pred(H,T,R,Opt),!.
s2p(X,X,[]).

s2Pred(H,T,R,Opt):-atom(H),isFn(H),!,s2List(T,TT,Opt),R=[H|TT],!.
s2Pred(H,T,R,Opt):-s2p(H,HH,O1),s2List(T,TT,O2),append(O1,O2,Out),!,((atom(HH),proper_list(TT))-> R=..[H|TT];R=[H|TT]).

s2List(X,X,[]):- (atom(X);var(X);number(X);string(X)),!.
s2List([H|T],[HH|TT],Opt):-s2p(H,HH,O1),s2List(T,TT,O2),append(O1,O2,Opt),!.
s2List(X,Y,Opt):-s2p(X,Y,Opt),!.


isFn(X):-atom_concat(_,'Fn',X),!.
isFn(X):-atom_concat('The',_,X).  
isFn(X):-atom_concat('SKF',_,X).
isFn(X):-atom_concat('MT',_,X).
isFn(X):-name(X,[Cap|_]),char_type(Cap,upper),!.

balanceBindingS2P(X,Z):-
      balanceBinding(X,Y),
      unnumbervars(Y,UN),
      s2p(UN,Z,_),!.

:-dynamic_transparent(cyc:dbCache/2).
doLispLine([P|Surf],Vars):-toUppercase(P,UP),not(UP==P),!,doLispLine([UP|Surf],Vars).
doLispLine(['CYC-ASSERT',quote(STUFF),quote(WHERE)|_],Vars):-!,doLispLine(['CYC-ASSERT',quote(STUFF),(WHERE)|_],Vars).
doLispLine(['CYC-ASSERT',quote(STUFF),(WHERE)|_],Vars):-
         balanceBindingS2P(STUFF,Prolog),
         balanceBindingS2P(WHERE,Mt),
         writeq(Mt:Prolog),nl,
         cycAssertBuffer(Prolog,Mt),!.
         %assertIfNew(cyc:dbCache(Prolog,Mt)),!.
         %writel(ist(WHERE,Prolog):Vars),nl,!.
doLispLine(Surf,Vars):-
      writeq(user_error,Surf:Vars),
      nl(user_error).


cycBaseJavaClass('org.cyc.prolog.JavaRt').


% =====================================
% Utitity
% =====================================


%assertIfNew(CX):-not(ground(CX)),!,throw(assertIfNew(CX)).
assertIfNew(CX):-catch(CX,_,fail),!.
assertIfNew(CX):-asserta(CX),!.

catchIgnore(CX):-ignore(catch(CX,_,true)).

% =====================================
% Database
% =====================================
:-dynamic_transparent(cycCacheToDo/1).
:-dynamic_transparent(cycCache/1).

                    

cycAssertBuffer(Out,Mt):-cycAssertBuffer(Mt:Out).
cycAssertBuffer(_:end_fo_file):-!.
cycAssertBuffer(forward(Out)):-!,cycAssertBuffer((Out)).
cycAssertBuffer(Out):-not(Out=_:_),!,mtForCycL(Out,MT),!,cycAssertBuffer(MT:Out).
cycAssertBuffer(Out):-cycCacheToDo(Out),!.
cycAssertBuffer(Out):-cycCache(Out),!.
cycAssertBuffer(U):-unusedCycL(U),!.
%cycAssertBuffer(Mt:Out):-coerceCyc(Out,CycL)
cycAssertBuffer(Out):-debugFmt('% cycAssertion ~w ~n',[Out]),assertIfNew(cycCacheToDo(Out)),!.
unusedCycL(_:end_fo_file).
%unusedCycL(_:comment(_,_)).
%unusedCycL(_:isa(A,'Property')):-nonvar(A),!.

cycSync:-user:cycCacheToDo(Out),cycSync(Out),fail.
cycSync:-!.%%d3Info.

cycSync(_:end_fo_file):-!.
cycSync(U):-unusedCycL(U),!.
cycSync(Out):-cycCache(Out),!,ignore(retract(cycCacheToDo(Out))).
cycSync(Out):-Out= MT : Assert,!,catch((myCycAssert(MT : Assert),ignore(assertIfNew(cycCache(Out))),ignore(retract(cycCacheToDo(Out)))),E,debugFmt('%%%%%%%%%%%%% ~q',[E])),!.
cycSync(Out):-mtForCycL(Out,Mt),!,cycSync(Mt:Out).

% ===================================================================
%  Predicates need and Assertion Mt
% ===================================================================


mtForCycL(isa(_,'Collection'),'UniversalVocabularyMt').
mtForCycL(isa(_,'Microtheory'),'UniversalVocabularyMt').
mtForCycL(isa(_,'Predicate'),'UniversalVocabularyMt').
mtForCycL(arity(_,_),'UniversalVocabularyMt').
mtForCycL(Out,Mt):-predOfCycL(Out,Pred),!,getMtForPred(Pred,Mt).

predOfCycL(SENT,Y):-member(OP,[forward,and,':',or,implies,not]),SENT=..[OP|LIST],!,member(A,LIST),predOfCycL(A,Y),!.
predOfCycL(CX,Y):-functor(CX,Y,_).


:-dynamic_transparent(mtForPred/2).

getMtForPred(X,Y):-mtForPred(X,Y),!.
getMtForPred(genlMt,'BaseKB').
getMtForPred(CycL,Mt):-nonvar(CycL),functor(CycL,Pred,_),isRegisterCycPred(Mt,Pred,_),!.
getMtForPred(CycL,Mt):-defaultAssertMt(Mt).



'WRITEL'(F):-writel(F).

% ===================================================================
% Cyc Option Switches
%
%  setMooOption(Agent,Var,Value) - sets an option first removing the prevoius value
%
%  isMooOption(Agent,Var,Value). - tests for option
%
% ===================================================================
:-[logicmoo_bb_options].

/*
setMooOption(Agent,[]):-!.
setMooOption(Agent,[H|T]):-!,
      setMooOption(Agent,H),!,
      setMooOption(Agent,T),!.
setMooOption(Agent,Var=_):-var(Var),!.
setMooOption(Agent,_=Var):-var(Var),!.
setMooOption(Agent,(N=V)):-nonvar(N),!,setMooOption_thread(N,V),!.
setMooOption(Agent,N):-atomic(N),!,setMooOption_thread(N,true).
	
setMooOption(Agent,Name,Value):-setMooOption_thread(Name,Value).
setMooOption_thread(Name,Value):-
	((thread_self(Process),
	retractall('$MooOption'(Process,Name,_)),
	asserta('$MooOption'(Process,Name,Value)),!)).


unsetMooOption(Agent,Name=Value):-nonvar(Name),
	unsetMooOption_thread(Name,Value).
unsetMooOption(Agent,Name):-nonvar(Name),
	unsetMooOption_thread(Name,_).
unsetMooOption(Agent,Name):-(retractall('$MooOption'(_Process,Name,_Value))).


unsetMooOption_thread(Name):-
	unsetMooOption_thread(Name,_Value).

unsetMooOption_thread(Name,Value):-
	thread_self(Process),
	retractall('$MooOption'(Process,Name,Value)).
	
getMooOption_nearest_thread(Name,Value):-
	getMooOption_thread(Name,Value),!.
getMooOption_nearest_thread(Name,Value):-
      '$MooOption'(_,Name,Value),!.
getMooOption_nearest_thread(_Name,_Value):-!.



isMooOption(Agent,Name):-isMooOption(Agent,Name,true).
isMooOption(Agent,Name):-isMooOption(Agent,Name,on).
isMooOption(Agent,Name):-isMooOption(Agent,Name,yes).
isMooOption(Agent,Name=Value):-isMooOption(Agent,Name,Value).

isMooOption(Agent,Name,Value):-getMooOption_thread(Name,Value).


getMooOption_thread(Name,Value):-
	((thread_self(Process),
	('$MooOption'(Process,Name,Value);'$MooOption'(_,Name,Value)))),!.

getMooOption(Agent,Name=Value):-nonvar(Name),!,ensureMooOption(Agent,Name,_,Value).
getMooOption(Agent,Name=Default,Value):-nonvar(Name),!,ensureMooOption(Agent,Name,Default,Value).
getMooOption(Agent,Name,Value):-nonvar(Name),!,ensureMooOption(Agent,Name,_,Value).


ensureMooOption(Agent,Name=Default,Value):-
	ensureMooOption(Agent,Name,Default,Value),!.
	
ensureMooOption(Agent,Name,_Default,Value):-
	getMooOption_thread(Name,Value),!.

ensureMooOption(Agent,Name,Default,Default):-
	setMooOption_thread(Name,Default),!.

ensureMooOption(Agent,Name,_Default,Value):-nonvar(Name),!,   
	setMooOption_thread(Name,Value),!.

ensureMooOption(Agent,_Name,Default,Default).

setMooOption(Agent,Name,Value):-setMooOption_thread(Name,Value).

*/
setMooOptionDefaultsHere:-
             (unsetMooOption(Agent,_)),
             setMooOption(Agent,makeConstant='on'),
             setMooOption(Agent,opt_callback='sendNote_p'),
             setMooOption(Agent,cb_consultation='off'),
             setMooOption(Agent,opt_debug='on'),
             setMooOption(Agent,cb_error='off'),
             setMooOption(Agent,cb_result_each='off'),

% User Agent Defaults for 
             setMooOption(Agent,opt_cxt_request='BaseKB'),
             setMooOption(Agent,opt_ctx_assert='BaseKB'),
             setMooOption(Agent,opt_tracking_number='generate'),
             setMooOption(Agent,opt_agent='ua_parse'),
             setMooOption(Agent,opt_precompiled='off'),
             getMooOption(Agent,opt_theory,Context),setMooOption(Agent,opt_theory=Context),
             setMooOption(Agent,opt_notation='cycl'),
             setMooOption(Agent,opt_timeout=2),
             setMooOption(Agent,opt_readonly='off'),
             setMooOption(Agent,opt_debug='off'),
             setMooOption(Agent,opt_compiler='Byrd'),
             setMooOption(Agent,opt_language = 'pnx_nf'),

%Request Limits
             setMooOption(Agent,opt_answers_min=1),
             setMooOption(Agent,opt_answers_max=999), %TODO Default
             setMooOption(Agent,opt_backchains_max=5),
             setMooOption(Agent,opt_deductions_max=100),
             setMooOption(Agent,opt_backchains_max_neg=5),
             setMooOption(Agent,opt_deductions_max_neg=20),
             setMooOption(Agent,opt_forwardchains_max=1000),
             setMooOption(Agent,opt_max_breath=1000), %TODO Default

%Request Contexts
             setMooOption(Agent,opt_explore_related_contexts='off'),
             setMooOption(Agent,opt_save_justifications='off'),
             setMooOption(Agent,opt_deductions_assert='on'),
             setMooOption(Agent,opt_truth_maintence='on'),
             setMooOption(Agent,opt_forward_assertions='on'),
             setMooOption(Agent,opt_deduce_domains='on'),
             setMooOption(Agent,opt_notice_not_say=off),


%Request Pobibility
             setMooOption(Agent,opt_certainty_max=1),
             setMooOption(Agent,opt_certainty_min=1),
             setMooOption(Agent,opt_certainty=1),
             setMooOption(Agent,opt_resource_commit='on'),
   setMooOption(Agent,cycServer,'10.1.1.104':36001),
     setMooOption(Agent,cycCoServer,'10.10.10.198':3679),
     setMooOption(Agent,cycServer,'10.10.10.198':13701),
     setMooOption(Agent,cycServer,'10.10.10.198':3601),
     %setMooOption(Agent,cycCFasl,'10.10.10.198':3615),
     setMooOption(Agent,query(backchains),3),
     setMooOption(Agent,query(number),nil),
     setMooOption(Agent,query(time),20), %max ten seconds maybe?
     setMooOption(Agent,query(depth),nil),
   setMooOption(Agent,defaultAssertOptions,[':DIRECTION', ':FORWARD', ':STRENGTH', ':MONOTONIC']),
   setMooOption(Agent,':DIRECTION', ':FORWARD'),
   setMooOption(Agent,':STRENGTH', ':MONOTONIC'),
   setMooOption(Agent,hookCycPredicates,false),
   setMooOption(Agent,makeConstants,true),
   !.


:-setMooOptionDefaultsHere.
% ===================================================================
% Cyc initialization - call cycInit. once and this fiule will be loaded if not already
% ===================================================================
cycInit.

:-dynamic_transparent('$MooOption'/3).


% ===================================================================
% Connecter to Cyc TCP Server
% ===================================================================

getCycConnection3(SocketId,OutStream,InStream):- 
      ignore(once(isMooOption(Agent,cycServer,Server))),
      getCycConnection(Server,SocketId,OutStream,InStream).

getCycConnection(Server,SocketId,OutStream,InStream):- 
      ignore((var(Server),throw(no_server(getCycConnection(Server,SocketId,OutStream,InStream))))),
      once(nonvar(SocketId);nonvar(OutStream);nonvar(InStream)),
      once(cyc:cycConnection(Server,SocketId,OutStream,InStream);cyc:cycConnectionUsed(Server,SocketId,OutStream,InStream)),!.

getCycConnection(Server,SocketId,OutStream,InStream):-
      retract(cyc:cycConnection(Server,SocketId,OutStream,InStream)),
      ignore(system:retractall(cyc:cycConnectionUsed(Server,SocketId,OutStream,InStream))),
      assertz(cyc:cycConnectionUsed(Server,SocketId,OutStream,InStream)),!.

getCycConnection(Server,SocketId,OutStream,InStream):-
      tcp_socket(SocketId),
      tcp_connect(SocketId,Server),
      tcp_open_socket(SocketId, InStream, OutStream),!,
      debugFmt('Connected to Cyc TCP Server {~w,~w}\n',[InStream,OutStream]),
      assertz(cyc:cycConnectionUsed(Server,SocketId,OutStream,InStream)),!.

finishCycConnection(SocketId,OutStream,InStream):-
      ignore(system:retractall(cyc:cycConnectionUsed(Server,SocketId,OutStream,InStream))),
      ignore(system:retractall(cyc:cycConnection(Server,SocketId,OutStream,InStream))),
      asserta(cyc:cycConnection(Server,SocketId,OutStream,InStream)),!.
      
% ===================================================================
% cycInfo. - Prints Cyc Usage info to current output 
% ===================================================================
cycInfo:- % will add more 
   listing(cycConnection),
   listing(cycConnectionUsed),
%   listing(user:isCycConstantMade),
  % listing('$MooOption'),
   number_of_clauses(cycCache(_)),
   number_of_clauses(cycCacheToDo(_)).

loadCycL(File):-
      see(File),
      repeat,
      read(Term),
      cycAssertBuffer(Term),
      Term=end_of_file,
      seen,cycSync.


cycSyncThread:-
         createProcessedGoal(cycSyncThreadCode),
         debugFmt(createProcessedGoal(cycSyncThreadCode)).

cycSyncThreadCode:-repeat,once((cycSync,sleep(5))),fail.

cycDatabase(CX):-nonvar(CX),cycCacheToDo(CX).
cycDatabase(CX):-nonvar(CX),cycCacheToDo(_:CX).
cycDatabase(CX):-nonvar(CX),cycCache(CX).
cycDatabase(CX):-nonvar(CX),cycCache(_:CX).

cycCache(_:end_of_file).


number_of_clauses(P):-number_of_clauses(P,Y),functor(P,F,A),debugFmt('% number_of_clauses(~q/~q)->~q~n',[F,A,Y]).
number_of_clauses(P,Y):-predicate_property(P, number_of_clauses(Y)),!.
number_of_clauses(P,0).

% ===================================================================
% Invoke SubL
% converseRaw(-Send[,+Receive]).
% 
% ?- converseRaw('(find-constant "Dog")').
% Dog
%
% ===================================================================

converse(Send):-
      converseRaw(Send,Receive),
      debugFmt('% recv> ~s~n',[Receive]).

converse(Send,Receive):-
      converseRaw(Send,ReceiveCodes),
      atom_codes(Receive,ReceiveCodes).

converseRaw(Send,Receive):-
      getCycConnection3(SocketId,OutStream,InStream),
      streamClear(InStream),
      writel(OutStream,Send),
      readSubL(InStream,Get),!,
      finishCycConnection(SocketId,OutStream,InStream),!,
      checkSubLError(InStream,Send,Get,Receive),!.

checkSubLError(InStream,Send,[53,48,48,_|Info],Info):-!, %Error "500 "
      atom_codes(ErrorMsg,Info),%true,
%      streamClear(InStream),
      throw(cyc_error(ErrorMsg,Send)).
checkSubLError(InStream,_,[50,48,48,_|Info],Trim):-!, % "200 "
      %true,
      trim(Info,Trim).
checkSubLError(InStream,Send,Info,Info).

evalSubL(Send,Surface:Vars):-evalSubL(Send,Surface,Vars).

evalSubL(Send,Surface,Vars):-
     converseRaw(Send,Receive),!,
     getSurfaceFromChars(Receive,Surface,Vars).

% ===================================================================
% Lowlevel printng
% ===================================================================

writel(Lisp):-writel(user_output,Lisp).

writel(OutStream,Send):-     
      writel(OutStream,Send,_Vars).

writel(OutStream,N,Vars):-N==[],!,format(OutStream,'NIL~n',[]).
writel(OutStream,Send,Vars):-     
%      (var(Send) ->
 %        throw(cyc_error('Unbound SubL message',Send));
         is_string(Send) ->
	    formatCyc(OutStream,'~s~n',[Send]);
	      % atom(Send) -> formatCyc(OutStream,'~w~n',[Send]);
      	       toCycApiExpression(Send,Vars,STerm),formatCyc(OutStream,'~w~n',[STerm]).
%	       throw(cyc_error('SubL message type not supported',Send)),


formatCyc(OutStream,Format,Args):-
      format(OutStream,Format,Args),
      debugFmt(Format,Args),
      flush_output_safe(OutStream),!.

readSubL(InStream,[G,E,T,Space|Response]):-
      get_code(InStream,G),
      get_code(InStream,E),
      get_code(InStream,T),
      get_code(InStream,Space),
      readCycLTermChars(InStream,Response),!.

% ===================================================================
% Lowlevel readCycLTermChars
% ===================================================================
readCycLTermChars(InStream,Response):-
   readCycLTermChars(InStream,Response,_).
   

readCycLTermChars(InStream,[Start|Response],Type):-
   peek_code(InStream,Start),
   readCycLTermCharsUntil(Start,InStream,Response,Type),
   debugFmt('cyc>~s (~w)~n',[Response,Type]).

readCycLTermCharsUntil(34,InStream,Response,string):-!,
   get_code(InStream,_),
   readUntil(34,InStream,Response),
   streamClear(InStream).

readCycLTermCharsUntil(35,InStream,[35|Response],term):-!,
   get_code(InStream,_),
   readUntil(10,InStream,Response),
   streamClear(InStream).

readCycLTermCharsUntil(84,InStream,[],true):-!,
   streamClear(InStream).

readCycLTermCharsUntil(78,InStream,[],nil):-!,
   streamClear(InStream).

readCycLTermCharsUntil(40,InStream,Trim,cons):-!,
   readCycL(InStream,Trim),
   streamClear(InStream).

readCycLTermCharsUntil(Char,InStream,Response,atom):-!,
   get_code(InStream,_),
   readUntil(10,InStream,Response),
   streamClear(InStream).

% needs better solution!  .01 seconds works but .001 seconds dont :(  meaning even .01 might in some circumstances be unreliable
streamClear(InStream) :- once(wait_for_input([InStream], Inputs,0.1)),Inputs=[],!.
streamClear(InStream) :-get_code(InStream, _),streamClear(InStream).

readUntil(Char,InStream,Response):-
      get_code(InStream,C),
      readUntil(0,Char,C,InStream,Response).
      
readUntil(Prev,Char,Char,InStream,[Char]):-not(Prev=92),!.
readUntil(Prev,Char,C,InStream,[C|Out]):-get_code(InStream,Next),
    ( Next == -1 -> throw(cyc_error(InStream,end_of_stream)) ; readUntil(C,Char,Next,InStream,Out)).


      
% ===================================================================
%  conversion toCycApiExpression
% ===================================================================
toMarkUp(_,Term,Vars,Out):-
   toCycApiExpression(Term,Vars,Out),!.


toCycAtom(B,'#$different'):-member(B,[neq,dif,diff,(\=)]).
%toCycAtom(B,'QUOTE'):-member(B,[('\''),(quote),'QUOTE']).
toCycAtom(B,'()'):-member(B,[(nil),([]),'NIL']).
toCycAtom(B,' '):-member(B,[(holds),('#$holds')]).
toCycAtom(B,'#$or'):-member(B,[(;)]).
%toCycAtom(B,'#$and'):-member(B,[(,)]).
toCycAtom('=>','#$implies').
toCycAtom('<=>','#$equiv').
toCycAtom('=','#$equals').
toCycAtom('==','#$same').




escapeString(R,RS):- (string(R);is_list(R)) ,string_to_atom(R,A),atom_codes(A,Codes),escapeCodes([34,92],92,Codes,RS),!.

escapeCodes(Escaped,EscapeChar,[],[]):-!.
escapeCodes(Escaped,EscapeChar,[EscapeChar,Skip|Source],[EscapeChar,Skip|New]):-!,
   escapeCodes(Escaped,EscapeChar,Source,New),!.
escapeCodes(Escaped,EscapeChar,[Char|Source],[EscapeChar,Char|New]):-member(Char,Escaped),!,
   escapeCodes(Escaped,EscapeChar,Source,New),!.
escapeCodes(Escaped,EscapeChar,[Skipped|Source],[Skipped|New]):-
   escapeCodes(Escaped,EscapeChar,Source,New),!.

is_charlist([X]):-atom(X),not(number(X)),atom_length(X,1).
is_charlist([X|T]):-atom(X),not(number(X)),atom_length(X,1),is_charlist(T),!.

is_codelist([A]):-integer(A),!,A>9,A<129,!.
is_codelist([A|L]):-integer(A),!,A>9,A<129,is_codelist(L).

is_string(X):-atom(X),!,atom_length(X,L),L>1,atom_concat('"',_,X),atom_concat(_,'"',X),!.
is_string(X):-var(X),!,fail.
is_string(string(_)):-!.
is_string("").
is_string(X):-string(X),!.
is_string(L):-is_codelist(L),!.
is_string(L):-is_charlist(L),!.

:-dynamic_transparent(asserted/4).
:-dynamic_transparent(assertion/13).
:-dynamic_transparent(('/')/2).


decyclify(X,X):-var(X),number(X),!.
decyclify([],[]):-!.
decyclify([H|T],[HH|TT]):-!,decyclify(H,HH),decyclify(T,TT),!.
decyclify(X,P):-compound(X),X=..LIST,decyclify(LIST,DL),P=..DL,!.
decyclify(X,X):-not(atom(X)),!.
decyclify(B,A):-atom_concat('#$',A,B),!.
decyclify(B,B):-!.

destringify(X,X):-var(X),number(X),!.
destringify(X,S):-is_string(X),stringToCodelist(X,CL),name(S,CL),!.
destringify([],[]):-!.
destringify([H|T],[HH|TT]):-!,destringify(H,HH),destringify(T,TT),!.
destringify(X,P):-compound(X),X=..LIST,destringify(LIST,DL),P=..DL,!.
destringify(X,X):-not(atom(X)),!.
destringify(B,A):-atom_concat('#$',A,B),!.
destringify(B,B):-!.


%prologPredToCyc(Predicate):-arity(PredicateHead)

stringToCodelist(S,CL):-stringToCodelist2(S,SL),!,escapeString(SL,CS),!,string_to_list(CL,CS),!.

stringToCodelist2(string(S),Codes):-!,stringToCodelist2(S,Codes).
stringToCodelist2([],[]):-!.
stringToCodelist2([[]],[]):-!.
stringToCodelist2([''],[]):-!.
stringToCodelist2([X|T],[X|T]):-is_codelist([X|T]),!.
stringToCodelist2([X|T],Codes):-atom(X),is_charlist([X|T]),!,string_to_list([X|T],Codes),!.
stringToCodelist2(String,Codes):-string(String),!,string_to_atom(String,Atom),atom_codes(Atom,Codes),!.
stringToCodelist2(Atom,Codes):-atom(Atom),atom_codes(Atom,Codes),!.
stringToCodelist2(A,Codes):-toCycApiExpression_l(A,_,L),atom_codes(L,Codes),!.
stringToCodelist2(Term,Codes):-sformat(Codes,'~q',[Term]),true.

toCycApiExpressionEach([],[]).
toCycApiExpressionEach([H|T],[HH|TT]):-toCycApiExpression(H,HH),toCycApiExpressionEach(T,TT),!.

toCycApiExpression(Prolog,CycLStr):-toCycApiExpression(Prolog,[],CycLStr),!.
toCycApiExpression(Prolog,Vars,Chars):-var(Prolog),!,toCycVar(Prolog,Vars,Chars),!.
toCycApiExpression('$VAR'(0),Vars,Chars):-!,sformat(Chars,'?A',[]).
toCycApiExpression('$VAR'(VAR),Vars,Chars):-!,sformat(Chars,'?~p',['$VAR'(VAR)]).
toCycApiExpression([],_,"()"):-!.
toCycApiExpression(B,Vars,A):-atom(B),toCycAtom(B,A),!.
toCycApiExpression(format(S,List),Vars,Out):-!,toCycApiExpressionEach(List,OList),sformat(Out,S,OList),!.
toCycApiExpression(Prolog,Vars,Prolog):- (atom(Prolog);number(Prolog)),!.
toCycApiExpression(string(Rep),Vars,SVar):-free_variables(Rep,[Var]),!,toCycApiExpression(Var,Vars,SVar),!.
toCycApiExpression(string(Rep),Vars,'""'):-Rep==[],!.
toCycApiExpression(string(Rep),Vars,'""'):-Rep==[''],!.
toCycApiExpression(string(Rep),Vars,Chars):-nonvar(Rep),stringToCodelist(Rep,Prolog),!,sformat(Chars,'"~s"',[Prolog]),!.
toCycApiExpression(Rep,Vars,Chars):-is_string(Rep),!,stringToCodelist(Rep,Prolog),sformat(Chars,'"~s"',[Prolog]),!.
toCycApiExpression(listofvars([]),Vars,'NIL'):-!. %listofvars
toCycApiExpression(listofvars([P|List]),Vars,Chars):-!,toCycApiExpression_l([P|List],Vars,Term),sformat(Chars,'\'(~w)',[Term]),!.
toCycApiExpression(nv(List),Vars,Chars):-!,toCycApiExpression_l(List,Vars,Chars),!.
toCycApiExpression(nart(List),Vars,Chars):-!,toCycApiExpression(List,Vars,Chars),!.
toCycApiExpression(svar(_,List),Vars,Chars):-!,toCycApiExpression(List,Vars,Chars),!.
toCycApiExpression(varslist(List),Vars,Chars):-!,toCycApiExpression_vars(List,Vars,Chars),!.
toCycApiExpression(varslist(List,Vars),_,Chars):-!,toCycApiExpression_vars(List,Vars,Chars),!.
toCycApiExpression(quote(List),Vars,Chars):-toCycApiExpression(List,Vars,Term),sformat(Chars,'\'~w',[Term]),!.
toCycApiExpression((PROLOG:VARS),Vars,Chars):-append(Vars,VARS,NewVars),toCycApiExpression(PROLOG,NewVars,Chars),!.
toCycApiExpression(Prolog,Vars,Chars):-compound(Prolog),Prolog=..[P|List],not(P='.'),!,toCycApiExpression([P|List],Vars,Chars),!.
toCycApiExpression([P,A,B],Vars,Chars):-P==(':-'),B==true,toCycApiExpression(A,Vars,Chars),!.
toCycApiExpression([P,A,B],Vars,Chars):-P==(':-'),toCycApiExpression(A,Vars,TA),toCycApiExpression(B,Vars,TB),
                  sformat(Chars,'(#$sentenceImplies ~w ~w)',[TB,TA]),!. % ? enables-Generic ?
toCycApiExpression([P,A,B],Vars,Chars):-P==(':-'),toCycApiExpression(A,Vars,TA),toCycApiExpression(B,Vars,TB),
                  sformat(Chars,'(#$enables-ThingProp ~w ~w)',[TB,TA]),!. % ? enables-Generic ?
toCycApiExpression([P|List],Vars,Chars):-
	       toCycApiExpression_l([P|List],Vars,Term),
	       sformat(Chars,'(~w)',[Term]),!.

toCycApiExpression_l(NIL,Vars,''):-NIL==[].
toCycApiExpression_l([A|Rest],Vars,Chars):- Rest==[],
      toCycApiExpression(A,Vars,Chars),!.
toCycApiExpression_l([A|Rest],Vars,Chars):- is_list(Rest),
      toCycApiExpression(A,Vars,Chars1),
      toCycApiExpression_l(Rest,Vars,Chars2),
      sformat(Chars,'~w ~w',[Chars1,Chars2]),!.
toCycApiExpression_l([A|Rest],Vars,Chars):-
      toCycApiExpression(A,Vars,Chars1),
      toCycApiExpression(Rest,Vars,Chars2),
      sformat(Chars,'~w . ~w',[Chars1,Chars2]),!.

toCycApiExpression_vars(List,Vars,''):-var(List),!.
toCycApiExpression_vars([Var],Vars,Chars):-!,
		  toCycApiExpression_var(Var,Vars,Chars).
toCycApiExpression_vars([Var|Rest],Vars,Chars):-
		  toCycApiExpression_var(Var,Vars,C1),
	       toCycApiExpression_vars(Rest,Vars,C2),
	       sformat(Chars,'~w , ~w',[C1,C2]).

toCycApiExpression_var(Var,Vars,Chars):-
	    Var=..[_,Name,Value],
            %toCycVar(Name,Vars,C1),	 
	    toCycApiExpression(Value,Vars,C2),!,
	    sformat(Chars,'?~w = ~w',[Name,C2]).
toCycApiExpression_var(Value,Vars,Chars):-
	       toCycApiExpression(Value,Vars,Chars).

	       



toCycVar(Var,Val):-toCycVar(Var,_,Val).

toCycVar(Var,[VV|_],NameQ):-nonvar(VV),VV=..[_,Name,VarRef],Var==VarRef,!,sformat(NameQ,'?~w',[Name]).
toCycVar(Var,[_|Rest],Name):-nonvar(Rest),toCycVar(Var,Rest,Name).
toCycVar(VAR,_,VarName):-
      term_to_atom(VAR,AVAR),
      atom_codes(AVAR,[95|CODES]),!,
      catch(sformat(VarName,'?~s',[CODES]),_,VarName='?HYP-VAR').


% ===================================================================
%  Debugging Cyc 
% ===================================================================
     
:-dynamic_transparent(isDebug).

% Uncomment this next line to see Cyc debug messages

isDebug.

isDebug(Call):- isDebug -> Call ; true.


% ===================================================================
%  Cyc Query Cache Control
% ===================================================================


:-dynamic_transparent(cachable_query/1).
:-dynamic_transparent(cached_query/2).



%cachable_query(isa(_,_)).

% ===================================================================
%  Cyc Assert
% ===================================================================

myCycAssert(Mt:CycL):-cycAssert(Mt:CycL).

cycAssert(Mt:CycL):-!,cycAssert(CycL,Mt).
cycAssert(CycL):-
   getMtForPred(CycL,Mt),
   cycAssert(CycL,Mt).

cycAssert(arity(P,A),Mt):-cycAssertNow(isa(P,'FixedArityRelation'),Mt),cycAssertNow(arity(P,A),Mt).
cycAssert(objectFoundInLocation(P,A),Mt):-cycSpatial(P),cycSpatial(A),cycAssertNow(objectFoundInLocation(P,A),Mt).
cycAssert(adjacentTo(P,A),Mt):-cycSpatial(P),cycSpatial(A),cycAssertNow(adjacentTo(P,A),Mt).
cycAssert(pathControl(A,P),Mt):-cycIsa(P,'Path-Simple'),cycIsa(A,'PhysicalDevice'),cycAssertNow(pathControl(A,P),Mt).
cycAssert(pathBetween(P,A,B),Mt):-cycIsa(P,'Path-Simple'),cycSpatial(A),cycSpatial(B),cycAssertNow(pathBetween(P,A,B),Mt).
cycAssert('locatedAtPoint-Spatial'(A,B),Mt):-cycSpatial(A),cycAssertNow('locatedAtPoint-Spatial'(A,B),Mt).
%cycAssert(genlPreds(A,P),Mt):-cycIsa(P,'Relation'),cycIsa(A,'PhysicalDevice'),cycAssertNow(pathControl(A,P),Mt).

cycAssert(genls(P,A),Mt):-cycCollection(P),cycCollection(A),cycAssertNow(genls(P,A),Mt).
cycAssert(CycL,Mt):-cycAssertNow(CycL,Mt).

cycSpatial(A):-cycIsa(A,'SpatialThing-Localized').
cycCollection(A):-cycIsa(A,'Collection').
cycIsa(A,B):-cycAssertNow(isa(A,B),'doom:VocabularyMt').

cycAssertNow(CycL,Mt):-
      system:retractall(cyc:cached_query(_,_)),
      termCyclify(CycL,CycLified),
      termCyclify(Mt,Mtified),
      defaultAssertOptions(DefaultOptions), 
      toCycApiExpression('CYC-ASSERT'(quote(CycLified),quote(Mtified),quote(DefaultOptions)),API),
      converse(API),!.

defaultAssertOptions(Opts):-isMooOption(Agent,defaultAssertOptions,Opts).

:-dynamic_transparent(defaultAssertMt/1).
:-dynamic_transparent(everythingMt/1).

defaultAssertMt('doom:VocabularyMt').
everythingMt('EverythingPSC').

% ===================================================================
%  Cyc Unassert/Retract
% ===================================================================
cycRetract(CycL):-getMtForPred(CycL,Mt),cycRetract(CycL,Mt).
cycRetractAll(CycL):-getMtForPred(CycL,Mt),cycRetractAll(CycL,Mt).

cycRetract(CycL,Mt):-cycQuery(CycL,Mt),!,cycUnassert(CycL,Mt),!.

cycRetractAll(CycL,Mt):-cycQuery(CycL,Mt),cycUnassert(CycL,Mt),fail.
cycRetractAll(CycL,Mt):-!.

cycUnassert(CycL,Mt):-
      system:retractall(cyc:cached_query(_,_)),
      termCyclify(CycL,CycLified),
      termCyclify(Mt,Mtified),
      converse('CYC-UNASSERT'(quote(CycLified),Mtified)).


% ===================================================================
%  Cyc Query
% ===================================================================
cycQuery(CycL):-cycQuery(CycL,'InferencePSC').
cycQuery(CycL,Mt):-
	 queryParams(Backchain,Number,Time,Depth),
	 cycQuery(CycL,Mt,Backchain,Number,Time,Depth).

cycQuery(CycL,Mt,Backchain,Number,Time,Depth):-
      copy_term(CycL,Copy),
      safe_numbervars(Copy,'$VAR',0,_),!,
      cycQuery(Copy,CycL,Mt,Vars,Backchain,Number,Time,Depth).

cycQuery(Copy,CycL,Mt,Vars,Backchain,Number,Time,Depth):-
      cached_query(Copy,Results),!,
      member(CycL,Results).



/*
cycQuery(Copy,CycL,Mt,Result,Backchain,Number,Time,Depth):-cachable_query(Copy),!,
      findall(CycL,cycQueryReal(CycL,Mt,Result,Backchain,Number,Time,Depth),Save),
      (Save=[] -> true ; asserta(cached_query(CycL,Save))),!,
      member(CycL,Save).
*/
cycQuery(Copy,CycL,Mt,Vars,Backchain,Number,Time,Depth):-
      (cycQueryReal(CycL,Mt,Vars,Backchain,Number,Time,Depth)).

/*
	  (clet ((*cache-inference-results* t)
	    (*allow-forward-skolemization*t)  
	    (*compute-inference-results* nil)  
	    (*unique-inference-result-bindings* t) 
	    (*generate-readable-fi-results* t))
	    (without-wff-semantics
	       (ask-template '(?SEL1 ?SEL2)  '?Formula BaseKB 0 nil nil nll )) )
	       
*/
%queryParams(Backchain,Number,Time,Depth).
%queryParams(0,	nil,	nil,	nil). % default
%queryParams(1,	nil,	nil,	nil). % used here

:-dynamic_transparent(double_quotes/1).
:-current_prolog_flag(double_quotes,X),asserta(double_quotes(X)).
:-set_prolog_flag(double_quotes,codes).

queryParams(Backchain,Number,Time,Depth):-
   ignore(isMooOption(Agent,query(backchains),Backchain)),
   ignore(isMooOption(Agent,query(number),Number)),
   ignore(isMooOption(Agent,query(time),Time)),
   ignore(isMooOption(Agent,query(depth),Depth)),!.


cycQueryReal(CycL,Mt,Vars,Backchain,Number,Time,Depth):-
         once((queryParams(Backchain,Number,Time,Depth),
         termCyclify(CycL,CycLified),
         termCyclify(Mt,Mtified),
         ignore(free_variables(CycLified,Vars)))),
      %  backchain number time depth
      sublTransaction(clet('((*cache-inference-results* t)(*compute-inference-results* t)(*unique-inference-result-bindings* t)(*generate-readable-fi-results* t))',
      'without-wff-semantics'('ask-template'(listofvars(Vars),quote(CycLified),quote(Mtified),Backchain,Number,Time,Depth))),Vars).


      %(progn (csetq *pq1* (Cyc-query '(#$doom:frameRelationAllExists #$genls ?X ?Y) #$doom:FrameRelatingMt)) T)
% (clet ((res (car *pq1* )))(csetq *pq1* (cdr *pq1*))res)
      
% ===================================================================
%  Generic Cyc Transactions
% ===================================================================
sublTransaction(SubL,Result):-
      ignore(once(isMooOption(Agent,cycServer,Server))),
   sublTransaction(Server,SubL,Result).

sublTransaction(Server,SubL,Result):-
   once(getCycConnection(Server,SocketId,OutStream,InStream)),
   streamClear(InStream),
   once((gensym('pqsym',PQSYM1),ignore(concat_atom(['*',PQSYM1,'*'],PQSYM)))),
   writel(OutStream,progn(defvar(PQSYM,'NIL'),csetq(PQSYM,'REMOVE-DUPLICATES'(SubL,'#\'TREE-EQUAL')),length(PQSYM))),
   get_code(InStream,G),
   get_code(InStream,E),
   get_code(InStream,T),
   get_code(InStream,Space),
   call_cleanup(
      (getTransactionSize([G,E,T],OutStream,InStream,PQSYM,SubL,Size),transGetResults(Size,OutStream,InStream,PQSYM,Result)),_,
                  (releaseTransaction(PQSYM),finishCycConnection(SocketId,OutStream,InStream))).

getTransactionSize([53,48,48],OutStream,InStream,PQSYM,SubL,Size):-
      get_code(InStream,Quote),
      readUntil(34,InStream,Errors),
      debugFmt('~n% ~w> ~s~n',[PQSYM,Errors]),!,
      streamClear(InStream),
         string_to_atom(Errors,Error),   
         sformat(SCycL,'~q',[SubL]),
      releaseTransaction(PQSYM),
      finishCycConnection(SocketId,OutStream,InStream),
      throw(cyc_error(Error,SCycL)).

getTransactionSize([50,48,48],OutStream,InStream,PQSYM,SubL,Size):-
      readUntil(10,InStream,Sizess),
      debugFmt('~n% ~w> ~s~n',[PQSYM,Sizess]),
      once((trim(Sizess,Sizes),number_codes(Size,Sizes))).

releaseTransaction(PQSYM1):-converse(csetq(PQSYM1,nil)),!.

transGetResults(0,OutStream,InStream,PQSYM,Vars):-!,fail.  % no results
transGetResults(1,OutStream,InStream,PQSYM,Vars):-Vars==[],!. %TRUE with no variables
transGetResults(Size,OutStream,InStream,PQSYM,Vars):- 
         Size<15,% BUG: in the reader os temporalily always ussing this normally <100 is better
         sformat(Send,'(cons (car ~w)(cdr ~w))',[PQSYM,PQSYM]),
         once((writel(OutStream,Send), 
         get_code(InStream,G),
         get_code(InStream,E),
         get_code(InStream,T),
         get_code(InStream,Space),
         readUntil(10,InStream,Result),
         %releaseTransaction(Exit,PQSYM,SocketId,OutStream,InStream),
         debugFmt('~n~s~n',[Result]),
         getSurfaceFromChars(Result,Bindings,_))),!,
         %debugFmt('~q.~n',[Result]),true,
         member(VarSet,Bindings),syncCycLVars(VarSet,Vars).

transGetResults(Size,OutStream,InStream,PQSYM,Result):-
      sformat(Send,'(clet ((res (car ~w )))(csetq ~w (cdr ~w))res)',[PQSYM,PQSYM,PQSYM]),      
      repeat,
      once((writel(OutStream,Send), 
      get_code(InStream,G),
      get_code(InStream,E),
      get_code(InStream,T),
      get_code(InStream,Space),
      peek_code(InStream,PCode),
      readUntil(10,InStream,ResultTrim),
      debugFmt('~n~s~n',[ResultTrim]))),
      eachResult(PCode,InStream,Result,ResultTrim,Cut),
              ((Cut==cut,!);(Cut==fail,!,fail);true).

eachResult(40,InStream,Vars,ResultTrim,more):-
      getSurfaceFromChars(ResultTrim,Results,_),%debugFmt(('~q.~n',[Result])),
      syncCycLVars(Results,Vars),!.
eachResult(78,InStream,Vars,Result,fail). % NIL
%eachResult(78,InStream,Vars,Result,cut). % True/NIL
eachResult(N,InStream,Vars,Result,more):-N=N.
eachResult(35,InStream,Vars,Result,fail). % No solutions 'locatedAt-Spatial' all
eachResult(73,InStream,Vars,Result,fail). % Depth limit exceeded
eachResult(41,InStream,Vars,Result,fail).  % The previous solution was the last

syncCycLVars(Binding,PBinding):- (var(Binding);var(PBinding)),!,once(balanceBinding(Binding,PBinding)).
syncCycLVars(_,[]).
syncCycLVars([Binding|T],[PBinding|VV]):-
      once(balanceBinding(Binding,PBinding)),
      syncCycLVars(T,VV),!.

% ===================================================================
%  SubL Transactions
% ===================================================================


getAllTermAssertions(Term,Result):-termCyclify(Term,CTerm), sublTransaction(mapcar('#\'assertion-el-formula','all-term-assertions'(CTerm)),Result).


%list_to_conj(X,Y):- balanceBinding(X,Y).
list_to_conj(X,Y):-nonvar(X),var(Y),!,list_to_conjs_lr(X,Y).
list_to_conj(X,Y):-list_to_conjs_rl(X,Y).
list_to_conjs_rl(List,(A,B)):-list_to_conjs_rl(A,AL),list_to_conjs_rl(B,BL),append(AL,BL,List).
list_to_conjs_rl(List,(A;B)):-list_to_conjs_rl(A,AL),list_to_conjs_rl(B,BL),append(AL,[or|BL],List).
list_to_conjs_lr([],true):-!.
list_to_conjs_lr([T],T):-!.
list_to_conjs_lr([H|T],(H,TT)):-!,list_to_conjs_lr(T,TT).
   


balanceBinding(Binding,Binding):- (var(Binding);number(Binding)),!.
balanceBinding(string(B),string(B)):-!.
balanceBinding(Binding,BindingP):-atom(Binding),atom_concat('#$',BindingP,Binding),!.
balanceBinding(nart(B),nart(BA)):-balanceBinding(B,BA),!.
balanceBinding(nart(B),(BA)):-!,balanceBinding(B,BA),!.
balanceBinding(string(B),List):-atomSplit(List,B),!.
balanceBinding(string(B),B):-!.
balanceBinding(string([]),""):-!.
balanceBinding(quote(B),BO):-!,balanceBinding(B,BO).
balanceBinding(['noparens','#','G',[GU|ID]],guid([GU|ID])):-!.
balanceBinding([A|L],Binding):-balanceBindingCons(A,L,Binding).
balanceBinding(Binding,Binding):-!.
 
balanceBindingCons(A,L,[A|L]):- (var(A);var(L);A=string(_);number(A)),!.
balanceBindingCons('and-also',L,Binding):-balanceBindingS(L,LO), list_to_conj(LO,Binding),!.
balanceBindingCons('eval',L,Binding):-balanceBindingS(L,LO), list_to_conj(LO,Binding),!.
balanceBindingCons('#$and-also',L,Binding):-balanceBindingS(L,LO), list_to_conj(LO,Binding),!.

balanceBindingCons(A,L,Binding):-
	 balanceBinding(A,AO),
         balanceBindingCons(A,AO,L,Binding).
balanceBindingCons(A,AO,L,Binding):-
         atom(AO),!,
	 balanceBindingS(L,LO),
	 Binding=..[AO|LO],!.
balanceBindingCons(A,AO,L,Binding):-
	 balanceBindingS(L,LO),
	 Binding=[AO|LO],!.

balanceBindingS(Binding,Binding):- (var(Binding);atom(Binding);number(Binding)),!.
balanceBindingS([],[]).
balanceBindingS([V,[L]|M],[LL|ML]):-V=='\'',balanceBindingS(L,LL),balanceBindingS(M,ML).
balanceBindingS([A|L],[AA|LL]):-balanceBinding(A,AA),balanceBindingS(L,LL).
   
:-retract(double_quotes(X)),set_prolog_flag(double_quotes,X).

% ===================================================================
%  Cyclification
%
%    termCyclify(Statement,Cyclified)
%     Makes sure that atoms in Statement are prefixed witbh '#$' when comunicationg with Cyc
%
%    termCyclify(Statement,Cyclified)
%     same as termCyclify/2 but adds the constant names with (CREATE-CONSTANT "~w")
%
% ===================================================================

atom_to_number(Value,Value):-number(Value),!.
atom_to_number(Atom,Value):-catch(atom_number(Atom,Value),_Error,fail),!.
atom_to_number(Atom,Value):-catch((atom_concat('.',_,Atom),atom_concat('0',Atom,Dec),atom_number(Dec,Value)),_Error,fail),!.

termCyclify(Same,Same):- (var(Same);number(Same);string(Same);Same='$VAR'(_)),!.
termCyclify(Var,Value):-var(Var),!,toCycVar(Var,Value).
termCyclify('','""'):-!.
termCyclify([],[]):-!.
termCyclify(string(Before),Before):-var(Before),!.
termCyclify(string(Before),string(Before)):-!.
termCyclify(quote(Before),quote(After)):-!,termCyclify(Before,After).
termCyclify(nart(LIST),(O)):-termCyclify(LIST,O),!.
termCyclify(c(Before),'find-or-create-constant'(string(Before))):-atom(Before),!.
termCyclify(nart(LIST),quote(O)):-termCyclify(LIST,O),!.
termCyclify(c(Before),Before).
termCyclify(':-'(A,B),CA):-B==true,termCyclify(A,CA).
termCyclify(':-'(A,B),['#$sentenceImplies',CB,CA]):-termCyclify(A,CA),termCyclify(B,CB),!.
%termCyclify([C],Term):-compound(C),!,termCyclify(C,Term).
termCyclify(P:C,Term):-ground(P:C),concat_atom([P,':',C],A),!,termCyclify(A,Term),!.
termCyclify(Before,After):-atom(Before),!,termCyclifyAtom(Before,After),!.
termCyclify([B|BL],[A|AL]):-!,termCyclify(B,A),termCyclify(BL,AL),!.
termCyclify(Before,After):- compound(Before),!, Before=..[B|BL],termCyclify(B,CB),termCyclify(BL,CBL),!,After=[CB|CBL].


termCyclifyAtom('','""').
termCyclifyAtom('?','"?"').
termCyclifyAtom(Const,CycL):-constant(Const,_,_,_),!,atom_concat('#$',Const,CycL).
termCyclifyAtom(Before,Before):-atom_length(Before,L),L<3,!.
termCyclifyAtom(Before,After):-
      atom(Before),
      sub_atom(Before,0,1,_,F),!,
      termCyclifyAtom3(F,Before,After),!.

termCyclifyAtom3('#',Before,Before).
termCyclifyAtom3('?',Before,Before).
termCyclifyAtom3(':',Before,Before).
termCyclifyAtom3('(',Before,Before).
termCyclifyAtom3('!',Before,After):-atom_concat('!',After,Before).
termCyclifyAtom3('"',Before,Before).
termCyclifyAtom3(_,Before,After):-atom_to_number(Before,After),!.
termCyclifyAtom3(_,Before,After):-badConstant(Before),quoteAtomString(Before,After).
termCyclifyAtom3(_,Before,After):-atom_concat('#$',Before,After),makeConstant(Before).      

badConstant(Atom):-member(Char,['/','*','"','.',',',' ','!','?','#','%']),concat_atom([S,T|UFF],Char,Atom),!.
quoteAtomString([34|T],Out):-name(Out,[34|T]),!.
quoteAtomString([H|T],Out):-!,append([34,H|T],[34],Quote),name(Out,Quote).
quoteAtomString(QU,QU):-concat_atom(['"'|_],QU),!.
quoteAtomString(UQ,QU):-concat_atom(['"',UQ,'"'],QU),!.

unquoteAtom([34|CodesAtom],New):-atom_codes(Atom,[34|CodesAtom]),concat_atom(LIST,'"',Atom),concat_atom(LIST,'',New),!.
unquoteAtom(Atom,New):-concat_atom(LIST,'"',Atom),concat_atom(LIST,'',New),!.

% ============================================
% Make new CycConstant
% ============================================

:-dynamic_transparent(makeConstant/0).
:-dynamic_transparent(user:isCycConstantMade/1).
:-dynamic_transparent(isCycConstantNever/1).
:-dynamic_transparent(isCycConstantNever/2).
:-dynamic_transparent(isCycConstantGuess/1).
:-dynamic_transparent(isCycConstantGuess/2).


user:isCycConstantMade(isa).
user:isCycConstantMade(genls).
user:isCycConstantMade('UniversalVocabularyMt').
user:isCycConstantMade('BaseKB').
user:isCycConstantMade('Collection').
user:isCycConstantMade('Predicate').
user:isCycConstantMade('Microtheory').
user:isCycConstantMade(X):-constant(X,_,_,_).

%user:isCycConstantMade(X):-nonvar(X),isCycConstantGuess(X).


isCycConstantGuess(X):-nonvar(X),isCycConstant(X).
isCycConstantGuess(X):-nonvar(X),isCycConstantNever(X),!,fail.
isCycConstantGuess(X):-nonvar(X),isCycConstantGuess(H,T),atom_concat(H,T,X).
isCycConstantGuess(X):-member(X,[and,or,isa,not]).
isCycConstantGuess(ist,_).
isCycConstantGuess(implies,_).
isCycConstantGuess(adjacentTo,_).
isCycConstantGuess(objectF,_).

isCycConstantGuess(_,'Genl').
isCycConstantGuess(_,'Genls').
isCycConstantGuess(_,'isa').
isCycConstantGuess(_,'Isa').
isCycConstantGuess(_,'Type').
isCycConstantGuess(_,'Predicate').
isCycConstantGuess(_,'Relation').
isCycConstantGuess(_,'Function').
isCycConstantGuess(_,'Collection').
isCycConstantGuess(_,'Microtheory').
%isCycConstantGuess(_,'Mt').
isCycConstantGuess(object,_).
isCycConstantGuess(inverse,_).
isCycConstantGuess(located,_).


isCycConstantGuess('arg',_).
isCycConstantGuess('genl',_).

isCycConstantNever(X):-nonvar(X),isCycConstantNever(H,T),atom_concat(H,T,X).
isCycConstantNever('doom:',_).
isCycConstantNever(_,'1').
isCycConstantNever(_,'2').
isCycConstantNever(_,'3').
isCycConstantNever(_,'4').

:-dynamic_transparent(termCyclify/2).

isCycConstant(Const):-(var(Const);is_string(Const);number(Const)),!,fail.
isCycConstant(Const):-user:isCycConstantMade(Const),!.
isCycConstant(Const):-cyc:constant(Const,_,_,_),!.
%isCycConstant(Const):-termCyclify(Const,_),!,fail.
isCycConstant(Const):-atom(Const),atom_concat('#$',X,Const),!,isCycConstant(X).
isCycConstant(Const):-sformat(S,'(find-constant "~w")',[Const]),converseRaw(S,R),!,R=[35|_],asserta(user:isCycConstantMade(Const)).


:-dynamic_transparent(aliasConstant/2).
aliasConstant(type_of,isa).
aliasConstant(friendly,friends).
guessConstant(Xs,Y):-string_to_atom(Xs,X),aliasConstant(X,Y),!.
guessConstant(X,Y):-guessConstantFind(X,Y).
%findall(Y,guessConstantFind(X,Y),YY),member(Y,YY).
guessConstantFind(Const,Const):-constant(Const,_,_,_),!.
guessConstantFind(Name,R):-evalSubL('find-constant'(string(Name)),RE,_),isTrue(RE),!,balanceBinding(RE,R).
%guessConstantFind(Name,R):-evalSubL('ps-harvest-nps'(string(Name)),RS,_),isTrue(RS),!,member([_|RE],RS),balanceBinding(RE,R).
guessConstantFind(Name,R):-cycQuery('termStrings'(R,string(Name))),isTrue(R),atom(R).
guessConstantFind(Name,R):-evalSubL('denotation-mapper'(string(Name)),RSR,_),isTrue(RSR),reverse(RSR,RS),!,member([_|RE],RSR),balanceBinding(RE,R).
guessConstantFind(Name,R):-evalSubL('ps-get-cycls-for-np'(string(Name)),RS,_),isTrue(RS),!,member(RE,RS),balanceBinding(RE,R).
%guessConstantFind(Name,R):-cycQuery('wordStrings'(W,string(Name))),isTrue(W),atom(W),cycQuery('denotationRelatedTo'(W,_,_,R)).
guessConstantFind(Name,R):-evalSubL('constant-apropos'(string(Name)),RSR,_),isTrue(RSR),reverse(RSR,RS),!,member(RE,RS),balanceBinding(RE,R).
%guessConstantFind(Name,R):-evalSubL('cyclify'(string([a,Name])),RS,_),isTrue(RS),!,member([_|RE],RS),balanceBinding(RE,R).

:-dynamic_transparent(makeConstant/0).
%makeConstant.

makeConstant(_Const):-not(isMooOption(Agent,makeConstant)),!.
%makeConstant(_Const):-!.
makeConstant(Const):-atom_concat('#$',New,Const),!,makeConstant(New).
makeConstant(Const):-
   (isCycConstant(Const)->true;
   (sformat(String,'(CREATE-CONSTANT "~w")',[Const]),
   debugOnFailure(converse(String)),
   asserta(user:isCycConstantMade(Const)))),!.

%makeConstant(_Const):-!.
killConstant(Const):-atom_concat('#$',New,Const),!,killConstant(New).
killConstant(Const):-
   sformat(String,'(FI-KILL (find-or-create-constant "~w"))',[Const]),
   debugOnFailure(converse(String)),
   retractall(user:isCycConstantMade(Const)),!.

% ============================================
% Make new Microtheory
% ============================================

ensureMt(Mt):-
   makeConstant(Mt),
   cycAssert('BaseKB':'isa'(Mt,'Microtheory')).

ensureGenlMt(Sub,Super):-ensureMt(Sub),ensureMt(Super),
   cycAssert('BaseKB':'genlMt'(Sub,Super)).


% ============================================
% Get An English Paraphrase
% ============================================
genParaphrase(CycL,English):-
      termCyclify(CycL,CycLfied),
      catch(evalSubL('GENERATE-PHRASE'('QUOTE'(CycLfied)),REnglish,_), cyc_error(_,REnglish),true),
      (REnglish=string(English);English=REnglish),!.

% ============================================
% dynamic_transparent Default Microtheory
% ============================================

   %everythingMt(EverythingPSC),
 %  :-cycAssert('BaseKB':'#$genlMt'(Mt,'CourseOfAction-AnalysisMt')). % Puts the defaultAssertMt/1 into Cyc 


% ============================================
% Prolog to Cyc Predicate Mapping
%
%  the following will all do the same things:
%
% ?- registerCycPred('BaseKB':isa/2). 
% ?- registerCycPred('BaseKB':isa(_,_)). 
% ?- registerCycPred(isa(_,_),'BaseKB'). 
% ?- registerCycPred('BaseKB',isa,2). 
%
%  Will make calls 
% ?- isa(X,Y)
%  Query into BaseKB for (isa ?X ?Y) 
%
% ============================================
:-dynamic_transparent(isRegisterCycPred/3).

:-module_transparent(isRegisterCycPred/3).

% ?- registerCycPred('BaseKB':isa/2). 
registerCycPred(Mt:Pred/Arity):-!,
   registerCycPred(Mt,Pred,Arity).
% ?- registerCycPred('BaseKB':isa(_,_)). 
registerCycPred(Mt:Term):-
   functor(Term,Pred,Arity),
   registerCycPred(Mt,Pred,Arity).
registerCycPred(Term):-
   functor(Term,Pred,Arity),
   registerCycPred(Mt,Pred,Arity).
   


% ?- registerCycPred(isa(_,_),'BaseKB'). 
registerCycPred(Term,Mt):-
   functor(Term,Pred,Arity),
   registerCycPred(Mt,Pred,Arity).
   
% ?- registerCycPred('BaseKB',isa,2). 
registerCycPred(Mt,Pred,0):-!,registerCycPred(Mt,Pred,2).
registerCycPred(Mt,Pred,Arity):-isRegisterCycPred(Mt,Pred,Arity),!.
registerCycPred(Mt,Pred,Arity):-
      functor(Term,Pred,Arity),
      ignore(defaultAssertMt(Mt)),
      asserta(( user:Term :- cycQuery(Term,Mt))),
      %asserta(( Mt:Term :- cycQuery(Term,Mt))),
      assertz(isRegisterCycPred(Mt,Pred,Arity)),!.


% ============================================
% Assert Side Effect Prolog to Cyc Predicate Mapping
%
% ============================================

user:exception(undefined_predicate, Pred ,retry):- isMooOption(Agent,hookCycPredicates,true),cycDefineOrFail(Pred).

cycDefineOrFail(Mod:Pred/Arity):-atom_concat('#$',_,Pred),
      cycDefineOrFail(Mod,Pred,Arity).
cycDefineOrFail(Pred/Arity):-atom_concat('#$',_,Pred),registerCycPred(Mod,Pred,Arity).

cycDefineOrFail(Mod,Pred,Arity):-
      atom_concat('#$',_,Mod),
      registerCycPred(Mod,Pred,Arity).
cycDefineOrFail(_,Pred,Arity):-
      registerCycPred(_,Pred,Arity).

% ============================================
% Assert Side Effect Prolog to Cyc Predicate Mapping
%
% ?- assert(isa('Fido','Dog')).
% Will assert (isa Fido Dog) into BaseKB
%
% ?- assert('DogsMt':isa('Fido','Dog')).
% Will assert (isa Fido Dog) into DogsMt
% ============================================
%'$toplevel':assert(X):-assertz(Term).

ifHookRedef(_):-!.
%ifHookRedef(C):-C,!.

:-ifHookRedef((redefine_system_predicate(system:assert(_)),assert((system:assert(Term):-nonvar(Term),assertThrough(Term))))).

assertThrough(Mt:CycL):-assertThrough(Mt,CycL).
assertThrough(CycL):-mtForCycL(CycL,Mt),assertThrough(Mt,CycL).

assertThrough(ToMt,CycL):-
      functor(CycL,Pred,Arity),
      (isRegisterCycPred(Mt,Pred,Arity);atom_concat('#$',_,Pred)),!,
      ignore(ToMt=Mt),cycAssert(CycL,ToMt),!.

assertThrough(ToMt,CycL):-
      (predicate_property(Mod:CycL,_);context_module(Mod);Mod=ToMt),!,
      ignore(Mod=ToMt),
      assertz(Mod:CycL),!.

% ============================================
% Retract (All) Side Effect Prolog to Cyc Predicate Mapping
%
% ?- retractall(isa('Fido','Dog')).
% Will retract (isa Fido Dog) from BaseKB
%
% ?- retractall('DogsMt':isa('Fido','Dog')).
% Will retract (isa Fido Dog) from DogsMt
% ============================================
:-ifHookRedef((redefine_system_predicate(retractall(_)),asserta((retractall(Term):-nonvar(Term),retractAllThrough(Term))))).

retractAllThrough(Mt:CycL):-
      retractAllThrough(Mt,CycL).

retractAllThrough(CycL):-
      retractAllThrough(Mt,CycL).

retractAllThrough(ToMt,CycL):-
      functor(CycL,Pred,Arity),
      isRegisterCycPred(Mt,Pred,Arity),!,
      ignore(ToMt=Mt),
      cycRetract(CycL,ToMt),!.

retractAllThrough(ToMt,CycL):-
      (predicate_property(Mod:CycL,_);context_module(Mod);Mod=ToMt),!,
      ignore(Mod=ToMt),
      system:retractall(Mod:CycL),!.
            
% ============================================
% Retract (First) Side Effect Prolog to Cyc Predicate Mapping
%
% ?- retractall(isa('Fido','Dog')).
% Will retract (isa Fido Dog) from BaseKB
%
% ?- retractall('DogsMt':isa('Fido','Dog')).
% Will retract (isa Fido Dog) from DogsMt
% ============================================
:-ifHookRedef((redefine_system_predicate(retract(_)),asserta((retract(Term):-nonvar(Term),retractOnceThrough(Term))))).

retractOnceThrough(Mt:CycL):-
      retractOnceThrough(Mt,CycL).

retractOnceThrough(CycL):-
      retractOnceThrough(Mt,CycL).

retractOnceThrough(ToMt,CycL):-
      functor(CycL,Pred,Arity),
      isRegisterCycPred(Mt,Pred,Arity),!,
      ignore(ToMt=Mt),
      cycRetract(CycL,ToMt),!.

retractOnceThrough(ToMt,CycL):-
      (predicate_property(Mod:CycL,_);context_module(Mod);Mod=ToMt),!,
      ignore(Mod=ToMt),
      system:retract(Mod:CycL),!.

% ============================================
% Register isa/genls (more for testing :)
% ============================================

% examples
%:-registerCycPred('BaseKB',isa,2).
%:-registerCycPred('BaseKB',genls,2).
:-registerCycPred('BaseKB',genlMt,2).


% ============================================
% Testing 
% ============================================
      
testCYC:-!.

% ===================================================================
/*
isSlot(Var):-var(Var).
isSlot('$VAR'(Var)):-number(Var).
*/

% ===================================================================
% CycL Term Reader
% ===================================================================
:-dynamic_transparent reading_in_comment/0.
:-dynamic_transparent reading_in_string/0.
:-dynamic_transparent read_in_atom/0.

readCycL(CHARS):-readCycL(user_input,CHARS).

readCycL(Stream,[])  :-at_end_of_stream(Stream).     
readCycL(Stream,Trim)  :-
		flag('bracket_depth',_,0),
		retractall(reading_in_comment),
		retractall(reading_in_string),!,
		readCycLChars_p0(Stream,CHARS),!,trim(CHARS,Trim).

readCycLChars_p0(Stream,[]):-at_end_of_stream(Stream),!.
readCycLChars_p0(Stream,[Char|Chars]):-
        get_code(Stream,C),
	cyclReadStateChange(C),
	readCycLChars_p1(C,Char,Stream,Chars),!.
	
readCycLChars_p1(C,Char,Stream,[]):-isCycLTerminationStateChar(C,Char),!.
readCycLChars_p1(C,Char,Stream,[]):- at_end_of_stream(Stream),!.
readCycLChars_p1(C,Char,Stream,Chars):-cyclAsciiRemap(C,Char),
      flag('$prev_char',_,Char),
      readCycLChars_p0(Stream,Chars),!.

isCycLTerminationStateChar(10,32):-reading_in_comment,!.
isCycLTerminationStateChar(13,32):-reading_in_comment,!.
isCycLTerminationStateChar(41,41):-not(reading_in_string),flag('bracket_depth',X,X),(X<1),!.

cyclReadStateChange(_):- reading_in_comment,!.
cyclReadStateChange(34):-flag('$prev_char',Char,Char),   % char 92 is "\" and will escape a quote mark
      (Char=92 -> true;(retract(reading_in_string) ; assert(reading_in_string))),!.
cyclReadStateChange(_):- reading_in_string,!.
cyclReadStateChange(59):- assert(reading_in_comment),!.
cyclReadStateChange(40):-!,flag('bracket_depth',N,N + 1).
cyclReadStateChange(41):-!,flag('bracket_depth',N,N - 1).
cyclReadStateChange(_).

cyclAsciiRemap(X,32):- (not(number(X));X>128;X<32),!.
cyclAsciiRemap(X,X):-!.


% ===================================================================
% CycL Term Parser
% ===================================================================
/*===================================================================
% getSurfaceFromChars/3 does less consistancy checking then conv_to_sterm

Always a S-Expression: 'WFFOut' placing variables in 'VARSOut'

|?-getSurfaceFromChars("(isa a b)",Clause,Vars).
Clause = [isa,a,b]
Vars = _h70

| ?- getSurfaceFromChars("(isa a (b))",Clause,Vars).
Clause = [isa,a,[b]]
Vars = _h70

|?-getSurfaceFromChars("(list a b )",Clause,Vars)
Clause = [list,a,b]
Vars = _h70

| ?- getSurfaceFromChars("(genlMt A ?B)",Clause,Vars).
Clause = [genlMt,'A',_h998]
Vars = [=('B',_h998)|_h1101]

| ?- getSurfaceFromChars("(goals Iran  (not   (exists   (?CITIZEN)   (and    (citizens Iran ?CITIZEN)    (relationExistsInstance maleficiary ViolentAction ?CITIZEN
)))))",Clause,Vars).

Clause = [goals,Iran,[not,[exists,[_h2866],[and,[citizens,Iran,_h2866],[relationExistsInstance,maleficiary,ViolentAction,_h2866]]]]]
Vars = [=(CITIZEN,_h2866)|_h3347]

====================================================================*/
getSurfaceFromChars(V,Term,Vars):-var(V),!,throw(error(getSurfaceFromChars/3,'Arguments are not sufficiently instantiated')).
getSurfaceFromChars(C,TERM,VARS):-atom(C),atom_codes(C,Chars),!,getSurfaceFromChars(Chars,TERM,VARS).
getSurfaceFromChars(C,TERM,VARS):-string(C),string_to_list(C,List),not(C=List),!,getSurfaceFromChars(List,TERM,VARS),!.
getSurfaceFromChars(Chars,TERM,VARS):-trim(Chars,CharsClean),catch(
         (once(getSurfaceFromCleanChars(Chars,TERMO,VARS)),TERM=TERMO),E,TERM=[error,E]).

getSurfaceFromCleanChars([],[end_of_file],_):-!.
getSurfaceFromCleanChars([41|_],[end_of_file],_):-!.
getSurfaceFromCleanChars([59|Comment],[file_comment,Atom],VARS):-atom_codes(Atom,Comment),!.
getSurfaceFromCleanChars(Chars,WFFOut,VARSOut):- 
               once(getWordTokens(Chars,WFFClean)),
               once(getSurfaceFromToks(WFFClean,WFFOut,VARSOut)),
	       retractall(numbered_var(_,_)).
               
getSurfaceFromToks(WFFClean,WFFOut,VARSOut):-
               catch((
               once(phrase(cycl(WFF),WFFClean)),
               collect_temp_vars(VARS),!,
               ((VARS=[],VARSOut=_,WFFOut=WFF);
                    (unnumbervars(VARS,LIST),
                     cyclVarNums(LIST,WFF,WFFOut,VARSOut2) ,
                     list_to_set(VARSOut2,VARSOut1),
                     open_list(VARSOut1,VARSOut)))),E,WFFOut=[error_tok,E,WFFClean]),!.

getSurfaceFromToks(['('|WFFClean],WFFOut,VARSOut):-getSurfaceFromToks(WFFClean,WFFOut,VARSOut),!.

getSurfaceFromToks(WFFClean,[unk_comment,WFFClean],VARSOut):-!.

getSurfaceFromCleanChars(Comment,[unk_comment,Atom],VARS):-atom_codes(Atom,Comment),!.

%===================================================================
% Removes Leading and Trailing whitespaces and non ANSI charsets.
%====================================================================
:-assert(show_this_hide(trim,2)).
:-current_prolog_flag(double_quotes,X),asserta(double_quotes(X)).
:-set_prolog_flag(double_quotes,codes).

trim(S,Y):-flatten(S,S2),
          trim2(S2,Y).

trim2(S,Y):-
      ground(S),%true,
      string_to_list(S,X),
      ltrim(X,R),lists:reverse(R,Rvs), 
      addSpaceBeforeSym(Rvs,Rv),      
      ltrim(Rv,RY),lists:reverse(RY,Y),!.
     
addSpaceBeforeSym([H|T],[H,32|T]):-member(H,"?.!"),!.
addSpaceBeforeSym(H,H).

:-retract(double_quotes(X)),set_prolog_flag(double_quotes,X).
:-set_prolog_flag(double_quotes,string).

ltrim([],[]):-!.
ltrim([32,32,32,32,32,32,32|String],Out) :-trim(String,Out),!.
ltrim([32,32,32,32,32|String],Out) :-trim(String,Out),!.
ltrim([32,32,32|String],Out) :- trim(String,Out),!.
ltrim([32,32|String],Out) :- trim(String,Out),!.
ltrim([P|X],Y):- (isWhitespace(P);not(number(P));P<33;P>128),trim(X,Y),!.
ltrim(X,X).


% ===================================================================
%  CycL String to DCG Converter
% Converts up to 13 forms
%     13 Terms long
%  
% =169 Parens Pairs 'locatedAt-Spatial' the First 2 levels  
% 
% ===================================================================


%?- getSurfaceFromChars("'(ls dfg)",S,V).
%S = quote([ls, dfg])
%V = _G465 

cycl(quote(WFF)) --> ['\''],{!},cycl(WFF).
%cycl(vector(LIST)) -->  ['#','('],{!},cycl_s(LIST),[')'].
cycl(LIST) -->  ['#','('],{!},cycl_s(LIST),[')'].
cycl(nart(LIST)) -->  ['#','<','('],{!},cycl_s(LIST),[')','>'].
cycl(LIST) -->  ['('],{!},cycl_s(LIST),[')'].
cycl(WFF) -->  atomic(WFF), { ! }.

atomic([]) --> ['NIL'].
atomic([]) --> ['nil'].
atomic(WFF) -->  variable(WFF).
atomic(_) --> [UQ|_], {member(UQ,['(',')','<','>','?','.','#']),!,fail}.
atomic(string(WFF)) -->  string(WFF).
atomic(WFF) -->  quantity(WFF).
atomic(WFF) -->  constant(WFF).
atomic(WFF) -->  symname(WFF).

cycl_s(T) -->  ['.'],{!},cycl(T).
cycl_s([A|L]) --> cycl(A),{!} , cycl_s(L).
cycl_s([]) --> [].

quantity(Number) -->  [Number] , {  number(Number),! } .

variable(VN)-->  ['??',A], { var_number(A,VN)   } . 
variable(VN)-->  ['??'], { var_gen(A),var_number(A,VN)   } .     %Anonymous
variable(VN)-->  ['?',A], { var_number(A,VN)   } . 

checkValidConstAtoms(UQ,R):-not(member(UQ,['(',')','<','>','?','.','#'])),
      once(is_list(UQ) -> (string_to_list(RR,UQ),R=string(RR)) ; R=UQ),!.
      %once(user:isCycConstantMade(UQ) -> true; assert(user:isCycConstantMade(UQ))),

                                                %preconditionFor-Props
constant(Constant) -->  ['#$'],{!},symname(C1) , { atom_concat('#$',C1,Constant)}.
constant(Constant) -->  [':'],{!},symname(C1) , { atom_concat(':',C1,Constant)}.
constant(Constant) -->  ['*'],symname(C1),['*'] , { concat_atom(['*',C1,'*'],Constant) } .

string(AA) -->  [[U|Q]] , { string_to_list(AA,[U|Q]),! } .
string(UQ) -->  [UQ] , { (string(UQ);is_string(UQ)),! } .

symname(Sym) -->  [Head,':',UQ] , { checkValidConstAtoms(Head,C1),checkValidConstAtoms(UQ,C2),!,concat_atom([C1,':',C2],Sym) } .
symname(Sym) -->  [UQ] , { checkValidConstAtoms(UQ,Sym),! } .

% Makes up sequencial Variable names for anonymous cycl getPrologVars
var_gen(Atom):-idGen(Number),number_codes(Number,Codes),atom_codes(Atom,[86,65,82|Codes]). % "VAR"

variables_list([list,A]) --> qual_var(A).
variables_list([list,A]) -->  ['('],qual_var(A),[')'],!.
variables_list([list,A,B]) -->  ['('],qual_var(A),qual_var(B),[')'],! .
variables_list([list,A|QV]) -->  ['('],qual_var(A),many_qual_var(QV),[')'],!.
many_qual_var([A]) -->  qual_var(A).
many_qual_var([A|T]) -->  qual_var(A),many_qual_var(T).

% Var/Quality pairs that Sowas ACE examples use

qual_var(VN) --> ['('],variable(VN),[')'].
qual_var(VN) --> variable(VN).
qual_var(VN) --> ['('],variable(VN),qual(_Quality),[')'].

qual(Q) --> constant(Q), { nonvar(Q) }.

% Construct arbitrary list of args
arbitrary([]) -->  [].
arbitrary(VN)-->  ['?',A], { var_number(A,VN)   } . 
arbitrary([Head]) -->  cycl(Head).
arbitrary([A|L]) --> cycl(A) , cycl_s(L).

%======================================================================
% CLSID Generation
% idGen(+Var)
% Creates a new unique number   TODO
%
% Example:
% | ?- idGen(X).
% X = 2234
%======================================================================
idGen(X):-flag(idGen,X,X+1).
     
var_number(A,'$VAR'(VN)):-numbered_var(A,'$VAR'(VN)),!.
var_number(A,'$VAR'(VN)):-flag(get_next_num,VN,VN+1),asserta(numbered_var(A,'$VAR'(VN))),!.

:-dynamic_transparent(numbered_var/2).

% This creates ISO Prolog getPrologVars w/in a CycL/STANDARD expression to be reconstrated as after parsing is complete 

cyclVarNums([],WFF,WFF,_):-!.

cyclVarNums(LIST,'$VAR'(NUM),VAR,[=(SYM,VAR)]):-numbered_var(SYM,'$VAR'(NUM)),
               member(=(SYM,VAR),LIST).

cyclVarNums(_,Atom,Atom,[]):-atomic(Atom).
cyclVarNums(LIST,Term,NewTerm,VARLIST):-Term=..[F|ARGS],cyclVarNums_list(LIST,ARGS,VARARGS,VARLIST),NewTerm=..[F|VARARGS].

cyclVarNums_list(_LIST,[],[],[]).
cyclVarNums_list(LIST,[A|RGS],[V|ARARGS],VARLIST):-
            cyclVarNums(LIST,A,V,VARS1),
            cyclVarNums_list(LIST,RGS,ARARGS,VARS2),
            append(VARS1,VARS2,VARLIST).


unnumbervars(STUFF,UN):-sformat(S,'~W',[STUFF,[quoted(true),character_escapes(true),module(user),numbervars(true),portray(false),double_quotes(true)]]),string_to_atom(S,Atom),atom_to_term(Atom,UN,_).

open_list(V,V):-var(V).
open_list(A,B):-append(A,_,B).

unnumbervars_nil(X,Y):-!,unnumbervars(X,Y).

collect_temp_vars(VARS):-!,(setof(=(Name,Number),numbered_var(Name,Number),VARS);VARS=[]).

%================================================================
% STRING TOKENIZATION                            
%================================================================
:-assert(show_this_hide(tokenize,2)).
:-current_prolog_flag(double_quotes,X),asserta(double_quotes(X)).
:-set_prolog_flag(double_quotes,codes).

toCodeList(string(S),XS):-ground(S),toCodeList(S,XS).
toCodeList([S,L|IST],XS):-atom(S),atom(L),concat_atom([S,L|IST],' ',ATOM),!,toCodeList(ATOM,XS).
toCodeList(S,XS):-ground(S),string_to_list(S,X),trim(X,XS).

%getWordTokens(M,['(',surf,')']):-nonvar(M),member(34,M),!.
getWordTokens(S,Y):-toCodeList(S,XS),once( tokenize3(XS,Y) ). %,debugFmt('~q.~n',[Y]).

isWhitespace(32).
isWhitespace(N):-N<33;N>128.

tokenize3([],[]).
tokenize3([White|T],O):-isWhitespace(White),!, tokenize3(T,O).
tokenize3([C|List],[Token|TList])  :- 
%  append(_,[C|List],CharList), not(isWhitespace(C)),
  get_token(C,List,Token,Rest),
  tokenize3(Rest,TList),!.

%  cyc-> "?"
get_token(35,[36|List],Token,Rest):-not(List=[32|_]),
  get_chars_type(List,Lchars,Rest,Type),!,
  atom_codes(Token,[35, 36|Lchars]).
%  atom_codes(Token,Lchars).

%  cyc-> "#$"
get_token(35,[36|List],Token,Rest):-not(List=[32|_]),
  get_chars_type(List,Lchars,Rest,Type),!,
  atom_codes(Token,[35, 36|Lchars]).
%  atom_codes(Token,Lchars).

%  cyc-> ":"
get_token(58,List,Token,Rest)  :-not(List=[32|_]),
  get_chars_type(List,Lchars,Rest,Type),!,
  atom_codes(Token,[58|Lchars]).

%  cyc-> "~"
get_token(126,List,Token,Rest)  :-not(List=[32|_]),
  get_chars_type(List,Lchars,Rest,Type),!,
  atom_codes(Token,[126|Lchars]).

get_token(A,List,Token,Rest)  :- 
  get_chars_type([A|List],Lchars,Rest,Type),!,
  type_codes(Type,Lchars,Token),!.

type_codes(num,CODES,Num):-catch(number_codes(Num,CODES),_,fail),!.
type_codes(_,[34|Lchars],String):-!,
      reverse(Lchars,[_|Rchars]),
      reverse(Rchars,LcharsNoQuotes),ground(LcharsNoQuotes),string_to_list(String,LcharsNoQuotes).
      %getWordTokens(LcharsNoQuotes,S),
      %string_to_list(O,LcharsNoQuotes).
type_codes(_,Lchars,Token):-!,atom_codes(Token,Lchars).

get_chars_type(L,S,L1,sep)  :-  separator(L,S,L1),!.
get_chars_type([C|L],[C|Lc],L1,S)  :- 
  check_start(S,C),
  get_word_chars(S,L,Lc,L1).

get_word_chars(S,L,Lc,L1)  :- 
  check_end(S,L,Lc,L1).
get_word_chars(S,[C|L],[C|Lc],L1)  :- 
  legal_char(S,C),
  get_word_chars(S,L,Lc,L1).

legal_char(num,C)    :-  digit(C).
legal_char(quote,C)  :-  not(bracket(_,C,_)).
legal_char(symb,C)   :-  valid_char(C).

check_start(Name,S):-bracket(Name,S,_E).
check_start(num, C)   :- start_digit(C).
check_start(symb,C)   :- valid_char(C). %, 'not'(digit(C)).
check_start(string,34) :- !.
check_start(other,C) :- true.

check_end(_,[],[],[])  :-  !.
check_end(num, [C|L],[],[C|L])  :-  'not'(digit(C)),!.
check_end(Name,[E|L],[E],L)  :-  bracket(Name,S,E),!.
%check_end(symb,[C1,C2|L],[],[C1,C2|L])  :-  member([C1,C2],["Fn"]),!.
check_end(symb,[C|L],[],[C|L])  :-  'not'(valid_char(C)).

separator([C,D,E|L],[C,D,E],L)  :-member([C,D,E],["<=>","=:=","=\\=","\\==","@=<","@>=","=..","-->"]),!.
separator([C,D|L],[C,D],L)  :-member([C,D],["~a","=>",":-","\\+","->","\\=","==","@<","@>","=<",">=","#$","//","??"]),!. %,"Fn"
separator([C|L],[C],L)  :- member(C,"*,.()'[\\]`!';= < >^{}?%$#/"),!.

valid_char(46):-!,fail.
valid_char(39):-!,fail.
valid_char(C)  :-  letter(C); digit(C); C = 95 ; C=45 ; C=58; C=39 .
letter(C)  :-   C=45 ; C=58 ; (97 =< C, C =< 122) ; (65 =< C, C =< 90) ; C = 95 ; C=63 .
start_digit(C)   :- member(C,"-01234567890").
digit(C)   :- member(C,"-_.01234567890+eE").

%get_word([C|T],C,T)  :-  member(C,":,.?&amp;%"),!. % ( : , . ?)
get_word([C|T],[C],T)  :- member(C,"=&amp;()`"),!. % (=)
get_word([C,C1|T],[C,C1],T)  :- member([C,C1],["??"]),!. %"Fn",
get_word([C|T],[C|W],T2)  :-  bracket(_,C,C1),!,get_chars(0,C1,T,W,T2).
get_word([C|T],[C|W],T2)  :-  valid_start(C),!, get_chars(1,32,T,W,T2).

get_chars(K,C1,[C|T],[C|W],T2)  :-  valid_char(K,C,C1),!,get_chars(K,C1,T,W,T2).
get_chars(0,C,[C|T],[],T)  :- bracket(_,C,_), !.
get_chars(0,C,[C|T],[C],T)  :-  (C = 41; C = 93),!. % ) or ]
get_chars(1,_C1,[C|T],[],[C|T])  :-  member(C, [10,13|"=,?"]).
%get_chars(2,_C1,[C,C2|T],[],[C,C2|T])  :-  member([C,C2], ["Fn"]).

valid_start(C)  :-  valid(C). %; C = 37.  % (%)
valid_start(35).
valid_char(K,C,C1)  :-  K = 0,!, C \= C1; K = 1, valid(C).

%bracket(quote,39,39).  % single quotes
bracket(quote,34,34).  % double quotes
%bracket(list,91,93).  % square brackets []
%bracket(quote,37,37).  % Literal Percent %%
%bracket(quote,35,35).  % Literal Percent ##

quote_found(0,B,B)  :-  member(B,[34]),!.
quote_found(Q,Q,0).

var_found(0,B,C)  :-  'not'(valid(B)),var_start(C).

var_start(C)  :-  (65 =< C,C =< 90);C = 95;C = 39.

valid(C)  :-   (65 =< C, C =< 90);    % A - Z
             (97 =< C, C =< 122);   % a - z
             (48 =< C, C =< 57);    % 0 - 9
             C = 95; C = 96; C = 39;C = 45;C = 58;C = 63.  % underscore; hyphen; colon; questionmark

:-retract(double_quotes(X)),set_prolog_flag(double_quotes,X).


/*===================================================================
Convert S-Expression originating from user to a Prolog Clause representing the surface level

Recursively creates a Prolog term based on the S-Expression to be done after compiler
                                                 
Examples:

| ?- sterm_to_pterm([a,b],Pterm).
Pterm = a(b)

| ?- sterm_to_pterm([a,[b]],Pterm).    %Note:  This is a special Case
Pterm = a(b)

| ?- sterm_to_pterm([holds,X,Y,Z],Pterm).    %This allows Hilog terms to be Converted
Pterm = _h76(_h90,_h104)                    

| ?- sterm_to_pterm([X,Y,Z],Pterm).   %But still works in normal places
Pterm = _h76(_h90,_h104)                    

| ?- sterm_to_pterm(['AssignmentFn',X,[Y,Z]],Pterm).                                
Pterm = 'AssignmentFn'(_h84,[_h102,_h116])
====================================================================*/

sterm_to_pterm(VAR,VAR):-isSlot(VAR),!.
sterm_to_pterm([VAR],VAR):-isSlot(VAR),!.
sterm_to_pterm([X],Y):-!,nonvar(X),sterm_to_pterm(X,Y).

sterm_to_pterm([S|TERM],PTERM):-isSlot(S),
            sterm_to_pterm_list(TERM,PLIST),            
            PTERM=..[holds,S|PLIST].

sterm_to_pterm([S|TERM],PTERM):-number(S),!,
            sterm_to_pterm_list([S|TERM],PTERM).            
	    
sterm_to_pterm([S|TERM],PTERM):-nonvar(S),atomic(S),!,
            sterm_to_pterm_list(TERM,PLIST),            
            PTERM=..[S|PLIST].

sterm_to_pterm([S|TERM],PTERM):-!,  atomic(S),
            sterm_to_pterm_list(TERM,PLIST),            
            PTERM=..[holds,S|PLIST].

sterm_to_pterm(VAR,VAR):-!.

sterm_to_pterm_list(VAR,VAR):-isSlot(VAR),!.
sterm_to_pterm_list([],[]):-!.
sterm_to_pterm_list([S|STERM],[P|PTERM]):-!,
              sterm_to_pterm(S,P),
              sterm_to_pterm_list(STERM,PTERM).
sterm_to_pterm_list(VAR,[VAR]).



/*
atomSplit(Atom,Words):-var(Atom),!,
   concat_atom(Words,' ',Atom).
atomSplit(Atom,Words):-
   concat_atom(Words1,' ',Atom),
   atomSplit2(Words1,Words),!.

atomSplit2([],[]).
atomSplit2([W|S],[A,Mark|Words]):- member(Mark,['.',',','?']),atom_concat(A,Mark,W),not(A=''),!,atomSplit2(S,Words).
atomSplit2([W|S],[Mark,A|Words]):- member(Mark,['.',',','?']),atom_concat(Mark,A,W),not(A=''),!,atomSplit2(S,Words).
atomSplit2([W|S],[W|Words]):-atomSplit2(S,Words).
*/

% ===================================================================
% Substitution based on ==
% ===================================================================

% Usage: subst(+Fml,+X,+Sk,?FmlSk)

/*
subst(A,B,C,D):- 
      catch(notrace(nd_subst(A,B,C,D)),_,fail),!.
subst(A,B,C,A).

nd_subst(  Var, VarS,SUB,SUB ) :- Var==VarS,!.
nd_subst(  P, X,Sk, P1 ) :- functor(P,_,N),nd_subst1( X, Sk, P, N, P1 ).

nd_subst1( _,  _, P, 0, P  ).
nd_subst1( X, Sk, P, N, P1 ) :- N > 0, P =.. [F|Args], 
            nd_subst2( X, Sk, Args, ArgS ),
            nd_subst2( X, Sk, [F], [FS] ),  
            P1 =.. [FS|ArgS].

nd_subst2( _,  _, [], [] ).
nd_subst2( X, Sk, [A|As], [Sk|AS] ) :- X == A, !, nd_subst2( X, Sk, As, AS).
nd_subst2( X, Sk, [A|As], [A|AS]  ) :- var(A), !, nd_subst2( X, Sk, As, AS).
nd_subst2( X, Sk, [A|As], [Ap|AS] ) :- nd_subst( A,X,Sk,Ap ),nd_subst2( X, Sk, As, AS).
nd_subst2( X, Sk, L, L ).



weak_nd_subst(  Var, VarS,SUB,SUB ) :- Var=VarS,!.
weak_nd_subst(        P, X,Sk,        P1 ) :- functor(P,_,N),weak_nd_subst1( X, Sk, P, N, P1 ).

weak_nd_subst1( _,  _, P, 0, P  ).

weak_nd_subst1( X, Sk, P, N, P1 ) :- N > 0, P =.. [F|Args], weak_nd_subst2( X, Sk, Args, ArgS ),
            weak_nd_subst2( X, Sk, [F], [FS] ),
            P1 =.. [FS|ArgS].

weak_nd_subst2( _,  _, [], [] ).
weak_nd_subst2( X, Sk, [A|As], [Sk|AS] ) :- X = A, !, weak_nd_subst2( X, Sk, As, AS).
weak_nd_subst2( X, Sk, [A|As], [A|AS]  ) :- var(A), !, weak_nd_subst2( X, Sk, As, AS).
weak_nd_subst2( X, Sk, [A|As], [Ap|AS] ) :- weak_nd_subst( A,X,Sk,Ap ),weak_nd_subst2( X, Sk, As, AS).
weak_nd_subst2( X, Sk, L, L ).
*/

% ===================================================================
% PURPOSE
% This File is the bootstrap SWI-Prolog listener to hanndle CYC API requests
% So first is loads the proper files and then starts up the system
% ===================================================================


% ===================================================================
% Prolog Dependant Code
% ===================================================================

    
/*
:-module(system_dependant,
      [getCputime/1,
      safe_numbervars/1,
      unnumbervars/2,
      debugFmt/1,
      debugFmt/2,
      writeFmt/1,
      writeFmt/2,
      writeFmt/3,
      fmtString/2,
      fmtString/3,
      writeFmtFlushed/1,
      writeFmtFlushed/2,
      writeFmtFlushed/3,
      saveUserInput/0,
      writeSavedPrompt/0,
      if_prolog/2,
      callIfPlatformWin32/1,
      callIfPlatformUnix/1,
      at_initialization/1,
      thread_create/3,
      current_thread/2,
      thread_exit/1,
      thread_self/1,
      thread_at_exit/1,
      thread_signal/2,
      thread_join/2,
      prolog_notrace/1,
      prolog_statistics/0,
      main/1]).
      
*/      



% ========================================================================================
% Using getCputime/1 (in Cyc code) since Eclipse prolog (another port for Cyc)  chokes on getCputime/1
% ========================================================================================
%getCputime(Start):-statistics(cputime,Start).
%prolog_statistics:-statistics.
%prolog_notrace(G):-notrace(G).

% ========================================================================================
% Threads 
% ========================================================================================
/*thread_create(Goal,Id,Options):-thread_create((Goal),Id,[Options]).
current_thread(Id,Status):-current_thread(Id,Status).
thread_exit(Goal):-thread_exit(Goal).
thread_self(Id):-thread_self(Id).
thread_at_exit(Goal):-thread_at_exit(Goal).
thread_signal(ID,Goal):-thread_signal(ID,Goal).
thread_join(Id,X):-thread_join(Id,X).
  */
% ========================================================================================
% Some prologs have a printf() type predicate.. so I made up fmtString/writeFmt in the Cyc code that calls the per-prolog mechaism
% in SWI its formzat/N and sformat/N
% ========================================================================================
:-dynamic_transparent(isConsoleOverwritten/0).

writeFmtFlushed(X,Y,Z):-catch((format(X,Y,Z),flush_output_safe(X)),_,true).
writeFmtFlushed(X,Y):-catch((format(X,Y),flush_output),_,true).
writeFmtFlushed(X):- once((atom(X) -> catch((format(X,[]),flush_output),_,true) ; writeFmtFlushed('~q~n',[X]))).

writeFmt(X,Y,Z):-catch(format(X,Y,Z),_,true).
writeFmt(X,Y):-format(X,Y).
writeFmt(X):-format(X,[]).

fmtString(X,Y,Z):-sformat(X,Y,Z).
fmtString(Y,Z):-sformat(Y,Z).

saveUserInput:-retractall(isConsoleOverwritten),flush_output.
writeSavedPrompt:-not(isConsoleOverwritten),!.
writeSavedPrompt:-flush_output.
writeOverwritten:-isConsoleOverwritten,!.
writeOverwritten:-assert(isConsoleOverwritten).

writeErrMsg(Out,E):- message_to_string(E,S),writeFmtFlushed(Out,'<cycml:error>~s</cycml:error>\n',[S]),!.
writeErrMsg(Out,E,Goal):- message_to_string(E,S),writeFmtFlushed(Out,'<cycml:error>goal "~q" ~s</cycml:error>\n',[Goal,S]),!.
writeFileToStream(Dest,Filename):-
        catch((
        open(Filename,'r',Input),
        repeat,
                get_code(Input,Char),
                put(Dest,Char),
        at_end_of_stream(Input),
        close(Input)),E,
        writeFmtFlushed('<cycml:error goal="~q">~w</cycml:error>\n',[writeFileToStream(Dest,Filename),E])).


% ========================================================================================
% safe_numbervars/1 (just simpler safe_numbervars.. will use a rand9ome start point so if a partially numbered getPrologVars wont get dup getPrologVars
% Each prolog has a specific way it could unnumber the result of a safe_numbervars
% ========================================================================================

safe_numbervars(X):-get_time(T),convert_time(T,A,B,C,D,E,F,G),!,safe_numbervars(X,'$VAR',G,_).
safe_numbervars(Copy,X,Z):-numbervars(Copy,X,Z,[attvar(skip)]).
safe_numbervars(Copy,_,X,Z):-numbervars(Copy,X,Z,[attvar(skip)]).
%unnumbervars(X,Y):-term_to_atom(X,A),atom_to_term(A,Y,_).

% ========================================================================================
% Ensure a Module is loaded
% ========================================================================================
/*moduleEnsureLoaded(X):-
        catch(ensure_loaded(X),_,(catch((atom_concat('mod/',X,Y),
        ensure_loaded(Y)),_,debugFmt(';; file find error ~q ~q',[X,E])))).
% ========================================================================================
% Platform specifics
% ========================================================================================
callIfPlatformWin32(G):-prolog_flag(windows,true),!,ignore(G).
callIfPlatformWin32(G):-!.

callIfPlatformUnix(G):-not(prolog_flag(windows,true)),!,ignore(G).
callIfPlatformUnix(G):-!.
*/

/*
:- callIfPlatformWin32(set_prolog_flag(debug_on_error,true)).
:- callIfPlatformUnix(set_prolog_flag(debug_on_error,false)).
:- callIfPlatformUnix(set_prolog_flag(debug_on_error,true)).
*/

% ========================================================================================
% Prolog specific code choices
% ========================================================================================
if_prolog(swi,G):-call(G).  % Run B-Prolog Specifics
if_prolog(_,_):-!.  % Dont run SWI Specificd or others

% used like if_prolog(bp,do_bp_stuff),if_prolog(swi,do_swi_stuff) inline in Cyc code


%at_initialization(V):-at_initialization(V),!,logOnFailureIgnore(V).


englishAsk(String):-!.

% ===========================================================
% SOCKET SERVER - Looks 'locatedAt-Spatial' first charicater of request and decides between:
%  Http, Native or Soap and replies accordingly
% ===========================================================
/*
:-module(cyc_httpd,[
   createCycServer/1,
   adaptiveServer/1,
   read_line_with_nl_p/3,
   decodeRequest_p/2,
   invokePrologCommandRDF_p/6,
   serviceAcceptedClientSocketAtThread/1]).
*/

% :-include(cyc_header).



% :-use_module(cyc_threads).
%% :-ensure_loaded(system_dependant).

:-dynamic_transparent(isKeepAlive/1).

:-dynamic_transparent(isServerCreated/1).
startCycAPIServer:-isServerCreated(_),!.
startCycAPIServer:- createCycServer(4600),!.
createCycServer(BasePort) :-isServerCreated(BasePort),!.
createCycServer(BasePort) :-
         asserta(isServerCreated(BasePort)),
         AsciiPort1 is BasePort+1,
         AsciiPort2 is BasePort+2,
         CFASLPORT is BasePort+14,
         COSRVER is BasePort+79,
        servantProcessCreate(nokill,'Logicmoo/CYC HTTPD/CycL/XML/SOAP Server Socket',adaptiveServer(AsciiPort1),_,[global(0),local(0),trail(0)]),
        servantProcessCreate(nokill,'Prolog HTTPD Server Socket',adaptiveServer(AsciiPort2),_,[global(0),local(0),trail(0)]),
        %servantProcessCreate(nokill,'CFASL Server Socket',cfaslServer(CFASLPORT),_,[]),
        %servantProcessCreate(nokill,'COPROCESSOR Server Socket',coServer(COSRVER),_,[]),
        ensureCycCallsProlog('10.10.10.198',AsciiPort1),!.


attemptServerBind(ServerSocket, Port):-
        catch((tcp_bind(ServerSocket, Port),
        debugFmt('% CYC Prolog API server started on port ~w. \n',[Port])),
        error(E,_),
        debugFmt('% CYC Prolog API server not started on port ~w becasue: "~w"\n',[Port,E])).

traceCall(X):-
   debugFmt('ENTER: ~q ',[X]),
      call(X),
   debugFmt('EXIT: ~q ',[X]).


:- use_module(library(streampool)).

adaptiveServer(Port):-
% streampool_server(Port) :-
        tcp_socket(ServerSocket),
        catch(ignore(tcp_setopt(ServerSocket, reuseaddr)),_,true),
        tcp_bind(ServerSocket, Port),
        tcp_listen(ServerSocket, 5),
        tcp_open_socket(ServerSocket, In, _Out),
        add_stream_to_pool(In, streampool_accept(ServerSocket)),
        stream_pool_main_loop.

streampool_accept(ServerSocket) :-
        tcp_accept(ServerSocket, AcceptFd, Peer),
        tcp_open_socket(AcceptFd, In, Out),
        add_stream_to_pool(In, streampool_servant(AcceptFd,In, Out, Peer)).

streampool_servant(ClientSocket,In, Out, Peer) :-
  %      read_line_to_codes(In, Command),
        ignore(ip(A4,A3,A2,A1)=Peer),
   %  cleanOldProcesses_p,!,
   setMooOption(Agent,'$source_ip',ip(A4,A3,A2,A1)),
   getPrettyDateTime(DateTime),
   %setMooOption(Agent,'$datetime',DateTime),
   sformat(Name,'Dispatcher for ~w.~w.~w.~w  started ~w ',[A4,A3,A2,A1,DateTime]),
   debugFmt('~s',[Name]),!,
  servantProcessCreate(killable,Name,serviceAcceptedClientSocketAtThread([ip(A4,A3,A2,A1)],ClientSocket,In,Out),_,[global(0),local(0),trail(0)]),!,
  delete_stream_from_pool(In).

serviceAcceptedClientSocketAtThread(OClientInfo,ClientSocket,In,Out):-
   %    tcp_open_socket(ClientSocket,In,Out),!,      
       ClientInfo = ['io'(ClientSocket,In,Out)|OClientInfo],
        setMooOption(Agent,'socket',ClientSocket),
        setMooOption(Agent,'$socket_in',In),
        setMooOption(Agent,'$socket_out',Out),!,
        set_prolog_IO(In,Out,user_error),
        ignore(catch(serviceIO(ClientInfo,In,Out),E,debugFmt(E:serviceIO(ClientInfo,In,Out)))),
        flush_output,seen,told,
        ignore(catch(close(In,[force(true)]),_,true)),
	ignore(catch(close(Out,[force(true)]),_,true)),
	ignore(catch(tcp_close_socket(ClientSocket),_,true)),
	thread_exit(ClientInfo).      

/*
set_prolog_IO(In,Out,Err):-
   set_input(In),
   set_output(Out),
   set_err_stream(Err),!.
*/

%getPrettyDateTime(String):-get_time(Time),convert_time(Time, String).


%my_peek_char(In,Char):-debugFmt(my_peek_char(In,Char)),peek_char(In,Char).

serviceIO(ClientInfo,In,Out):-
        peek_char(In,Char),!,
	debugFmt('~q',serviceIOBasedOnChar([firstChar(Char)|ClientInfo],Char,In,Out)),
        serviceIOBasedOnChar([firstChar(Char)|ClientInfo],Char,In,Out),!.

serviceIOBasedOnChar(ClientInfo,'G',In,Out):-!,serviceHttpRequest(ClientInfo,In,Out).
serviceIOBasedOnChar(ClientInfo,'P',In,Out):-!,serviceHttpRequest(ClientInfo,In,Out).

serviceIOBasedOnChar(ClientInfo,'<',In,Out):-!,
         serviceSoapRequest(In,Out).  % see cyc_soap.pl

serviceIOBasedOnChar(ClientInfo,'+',In,Out):-!,
            get0(In,Plus),serviceJavaApiRequest(In,Out).

serviceIOBasedOnChar(ClientInfo,end_of_file,In,Out):-!,throw(end_of_file(In,Out)).

serviceIOBasedOnChar(ClientInfo,'(',In,Out):-!,  
         serviceCycApiRequest(ClientInfo,In,Out).

serviceIOBasedOnChar(ClientInfo,SkipChar,In,Out):- char_type(SkipChar,space),!,
	debugFmt(serviceIOBasedOnChar(ClientInfo,SkipChar)),
        get_char(In,_),
        peek_char(In,Char),!,
	%debugFmt(serviceIOBasedOnChar(ClientInfo,Char,In,Out)),
        serviceIOBasedOnChar(ClientInfo,Char,In,Out),!.

serviceIOBasedOnChar(ClientInfo,ANY,In,Out):-!,serviceJavaApiRequest(In,Out).

% ===========================================================
% PROLOGD for CYC SERVICE
% ===========================================================

readLispStream(In,PrologGoal,ToplevelVars):-readCycL(In,Trim),getSurfaceFromChars(Trim,PrologGoal,ToplevelVars),!.


serviceCycApiRequest(ClientInfo,In,Out):-
   thread_self(Session),
   retractall(isKeepAlive(Session)),
   %asserta(isKeepAlive(Session)),
   tell(Out),
 %  repeat,
	 once((readLispStream(In,PrologGoal,ToplevelVars),debugFmt('remote API Call "~q" ~n',[PrologGoal]))),
	 ignore(once(catch(once(callCycApi(Out,PrologGoal,ToplevelVars)),E,(format(Out,'500 "~q"\n',[E]),format(user_error,'% sent cyc: 500 "~q"\n',[E]))))),
         !.
  %       not(isKeepAlive(Session)).



isCycAPIQuit([A]):-nonvar(A),!,isCycAPIQuit(A).
isCycAPIQuit('API-QUIT').
isCycAPIQuit('api-quit').
isCycAPIQuit('CLOSE-JAVA-API-SOCKET').
isCycAPIQuit('QUIT').
isCycTrue(APIQUIT):-isCycAPIQuit(APIQUIT).
isCycTrue('INITIALIZE-JAVA-API-PASSIVE-SOCKET').

      
'PRINT'(X):-writel(X).

'TEST':-format('"hi"').

cfaslRead(In,Object):-get_code(In,Type),cfaslRead(Type,In,Object).
% CFASL_P_8BIT_INT
cfaslCode('CFASL_P_8BIT_INT',0).
cfaslRead(0,In,Object):-get_code(I,Object).
% CFASL_N_8BIT_INT
cfaslCode('CFASL_N_8BIT_INT',1).
cfaslRead(1,In,Object):-get_code(I,O), Object is -1*O.
% CFASL_P_16BIT_INT
cfaslCode('CFASL_P_16BIT_INT',2).
cfaslRead(2,In,Object):-get_code(I,V1),get_code(I,V2),Object is (V1+V2*256).
% CFASL_N_16BIT_INT
cfaslCode('CFASL_N_16BIT_INT',3).
cfaslRead(3,In,Object):-get_code(I,V1),get_code(I,V2),Object is -1*(V1+V2*256).
% CFASL_P_24BIT_INT
cfaslCode('CFASL_P_24BIT_INT',4).
cfaslRead(4,In,Object):-get_code(I,V1),get_code(I,V2),get_code(I,V3),Object is (V1+V2*256+V3*256*256).
% CFASL_N_24BIT_INT
cfaslCode('CFASL_N_24BIT_INT',5).
cfaslRead(5,In,Object):-get_code(I,V1),get_code(I,V2),get_code(I,V3),Object is -1*(V1+V2*256+V3*256*256).
% CFASL_P_32BIT_INT
cfaslCode('CFASL_P_32BIT_INT',6).
cfaslRead(6,In,Object):-get_code(I,V1),get_code(I,V2),get_code(I,V3),get_code(I,V4),Object is (V1+V2*256+V3*256*256+V4*256*256*256).
% CFASL_N_32BIT_INT
cfaslCode('CFASL_N_32BIT_INT',7).
cfaslRead(7,In,Object):-get_code(I,V1),get_code(I,V2),get_code(I,V3),get_code(I,V4),Object is -1* (V1+V2*256+V3*256*256+V4*256*256*256).
%CFASL_P_FLOAT
cfaslCode('CFASL_P_FLOAT',8).
cfaslRead(8,In,Object):-cfaslRead(In,V1),cfaslRead(In,V2),Object is V1 * 2^V2.
%CFASL_N_FLOAT
cfaslCode('CFASL_N_FLOAT',9).
cfaslRead(9,In,Object):-cfaslRead(In,V1),cfaslRead(In,V2),Object is -1 * V1 * 2^V2.
%CFASL_P_BIGNUM
cfaslCode('CFASL_P_BIGNUM',23).
cfaslRead(23,In,Object):-cfaslRead(In,Len),readBignum(In,Len,0,Object).
readBignum(In,0,N,N):-!.
readBignum(In,Len,SoFar,All):-cfaslRead(In,Num),R is SoFar +Num * (256^Len),Len2 is Len-1,readBignum(In,Len2,R,All).
%CFASL_N_BIGNUM
cfaslCode('CFASL_N_BIGNUM',24).
cfaslRead(24,In,Object):-cfaslRead(In,Len),readBignum(In,Len,0,O),Object is -1 * O.
%CFASL_KEYWORD
cfaslCode('CFASL_KEYWORD',10).
cfaslRead(10,In,Object):-cfaslRead(In,String),string_to_atom(String,O),prependAtom(':',O,Output).
prependAtom(S,Output,Output):-atom_concat(S,_,Output),!.
prependAtom(S,O,Output):-atom_concat(S,O,Output),!.
%CFASL_SYMBOL
cfaslCode('CFASL_SYMBOL',11).
cfaslRead(11,In,Object):-cfaslRead(In,String),string_to_atom(String,Object).
%CFASL_NIL
cfaslCode('CFASL_NIL',12).
cfaslRead(12,In,[]).
%CFASL_LIST
cfaslCode('CFASL_LIST',13).
cfaslRead(13,In,List):-cfaslRead(In,Len),cfaslReadList(In,Len,[],List).
cfaslReadList(In,0,N,N):-!.
cfaslReadList(In,Len,N,List):-cfaslRead(In,O),append(N,[O],Mid),Len2 is Len-1,cfaslReadList(In,Len2,Mid,List).
%CFASL_CONS
cfaslCode('CFASL_DOTTED',17).
cfaslRead(30,In,Out):-cfaslRead(In,Len),cfaslReadList(In,Len,[],List),cfaslRead(In,Dot),append(List,Dot,Out).
%CFASL_VECTOR
cfaslCode('CFASL_VECTOR',14).
cfaslRead(14,In,v(List)):-cfaslRead(In,Len),cfaslReadList(In,Len,[],List).
%CFASL_STRING
cfaslCode('CFASL_STRING',15).
cfaslRead(15,In,List):-cfaslRead(In,Len),cfaslReadString(In,Len,[],List).
cfaslReadString(In,0,N,N):-!.
cfaslReadString(In,Len,N,List):-get_code(In,O),append(N,[O],Mid),Len2 is Len-1,cfaslReadString(In,Len2,Mid,List).
%CFASL_CHARACTER
cfaslCode('CFASL_CHARACTER',16).
cfaslRead(16,In,Char):-get_char(In,Char).
%CFASL_GUID
cfaslCode('CFASL_GUID',25).
cfaslRead(25,In,guid(Data)):-cfaslRead(In,Data).
%CFASL_UNICODE_STRING
cfaslCode('CFASL_UNICODE_STRING',53).
cfaslRead(53,In,List):-cfaslRead(In,Len),cfaslReadString(In,Len,[],List).
%CFASL_UNICODE_CHAR
cfaslCode('CFASL_UNICODE_CHAR',52).
cfaslRead(52,In,Char):-get_char(In,Char).
%CFASL_BYTE_VECTOR
cfaslCode('CFASL_BYTE_VECTOR',26).
cfaslRead(26,In,v(List)):-cfaslRead(In,Len),cfaslReadList(In,Len,[],List).
%CFASL_CONSTANT
cfaslCode('CFASL_CONSTANT',30).
cfaslRead(30,In,Const):-cfaslRead(In,Len),toConstant(Len,Const).
%CFASL_NART
cfaslCode('CFASL_NART',31).
cfaslRead(31,In,Const):-cfaslRead(In,Len),toNart(Len,Const).
%CFASL_ASSERTION
cfaslCode('CFASL_ASSERTION',33).
cfaslRead(33,In,ist(Mt,Form)):-cfaslRead(In,Form),cfaslRead(In,Mt).
%CFASL_VARIABLE
cfaslCode('CFASL_VARIABLE',40).
cfaslRead(40,In,'$VAR'(Form)):-cfaslRead(In,Form).
%CFASL_EXTERNALIZATION
cfaslCode('CFASL_EXTERNALIZATION',51).
cfaslRead(51,In,'QUOTE'(Form)):-cfaslRead(In,Form).
%CFASL_UNKNOWN
cfaslCode('CFASL_HASHTABLE',18).
cfaslCode('CFASL_BTREE_LOW_HIGH',19).
cfaslCode('CFASL_BTREE_LOW',10).
cfaslCode('CFASL_BTREE_HIGH',21).
cfaslCode('CFASL_BTREE_LEAF',22).
cfaslCode('CFASL_RESULT_SET_SLICE',27).
cfaslCode('CFASL_ASSERTION_SHELL',34).
cfaslCode('CFASL_ASSERTION_DEF',35).
cfaslCode('CFASL_SOURCE',36).
cfaslCode('CFASL_SOURCE_DEF',37).
cfaslCode('CFASL_AXIOM',38).
cfaslCode('CFASL_AXIOM_DEF',39).
cfaslCode('CFASL_INDEX',41).
cfaslCode('CFASL_SPECIAL_OBJECT',50).
cfaslCode('CFASL_DICTIONARY',64).
cfaslCode('CFASL_SERVER_DEATH',-1).
cfaslRead(Type,In,E):-cfaslCode(Name,Type),throw(Name).

cfaslServer(Port):-
        tcp_socket(ServerSocket),
   catch(ignore(tcp_setopt(ServerSocket, reuseaddr)),_,true),
        at_halt(tcp_close_socket(ServerSocket)),
        attemptServerBind(ServerSocket, Port),
        tcp_listen(ServerSocket, 655),
        repeat,
	       acceptCFaslClient(ServerSocket),
        fail.
acceptCFaslClient(ServerSocket):-
		tcp_open_socket(ServerSocket, AcceptFd, _),
                cleanOldProcesses_p,!,
		tcp_accept(AcceptFd, ClientSocket, ip(A4,A3,A2,A1)),!,
                getPrettyDateTime(DateTime),
                sformat(Name,'Dispatcher for CFASL ~w.~w.~w.~w  started ~w ',[A4,A3,A2,A1,DateTime]),
                servantProcessCreate(killable,Name,serviceCfaslClient(ClientSocket),_,[global(12800),local(12800),trail(12800)]),!.
serviceCfaslClient(ClientSocket):-
	tcp_open_socket(ClientSocket, In, Out),!,
        setMooOption(Agent,'$socket_in',In),
        setMooOption(Agent,'$socket_out',Out),!,
        servCFasl(In,Out),
        flush_output,
	catch(tcp_close_socket(ClientSocket),_,true),
	thread_exit(complete).

servCFasl(In,Out):-
   thread_self(Session),
   retractall(isKeepAlive(Session)),
   asserta(isKeepAlive(Session)),
   repeat,
      once((
	 once((cfaslRead(In,PrologGoal), 
	    %set_output(Out),set_input(In),
	 debugFmt('%CFASL API Call ~q~n',[PrologGoal]), !,
      callCycApi(PrologGoal,ToplevelVars,Result))),
         cfaslWrite(Out,Result),flush_output_safe(Out))),
       isCycAPIQuit(PrologGoal),!.
%catch(callCycApi(Out,PrologGoal,ToplevelVars),E,format(Out,'500 "~q"\n',[E])),
%flush_output_safe(Out))),
      	
% NUMBER
cfaslWrite(Out,O):-number(O),encodeNumber(O,E),cfaslWriteSeq(Out,E).
cfaslWriteSeq(Out,[]):-!.
cfaslWriteSeq(Out,[V|O]):-put(Out,V),cfaslWriteSeq(Out,O).
% STRING                                                                                                          //53
cfaslWrite(Out,S):-is_string(S),string_to_atom(S,A),atom_codes(A,C),length(C,L),put(Out,53),cfaslWrite(Out,L),cfaslWriteSeq(Out,C).
cfaslWrite(Out,S):-atom(S),atom_concat('"',_,S),unquoteAtom(S,New),atom_codes(New,C),cfaslWrite(Out,C).
% NIL
cfaslWrite(Out,[]):-put(Out,12).
cfaslWrite(Out,'NIL'):-put(Out,12).
% LIST
cfaslWrite(Out,[H|T]):-proper_list([H|T]),length([H|T],N),put(Out,13),cfaslWrite(Out,N),cfaslWriteList(Out,[H|T]).
cfaslWriteList(Out,[]):-!.
cfaslWriteList(Out,[H|T]):-cfaslWrite(Out,H),cfaslWriteList(Out,T).
% CONS
cfaslWrite(Out,[H|T]):-not(proper_list([H|T])),properPart([H|T],PP),length(PP,N),put(Out,17),cfaslWrite(Out,N),cfaslWriteList(Out,PP),improperPart([H|T],IP),cfaslWrite(Out,IP).
% HLVAR
cfaslWrite(Out,'$VAR'(N)):-put(Out,40),cfaslWrite(Out,N).
% ELVAR
cfaslWrite(Out,V):-var(V),term_to_atom(V,A),cfaslWrite(Out,A).
% CFASL_KEYWORD 
cfaslWrite(Out,V):-atom(V),atom_concat(':',N,V),put(Out,10),string_to_atom(S,N),cfaslWrite(Out,S).
%CFASL_SYMBOL
cfaslWrite(Out,V):-atom(V),atom_concat('_',N,V),atom_concat('?',N,VV),cfaslWrite(Out,VV).
cfaslWrite(Out,V):-atom(V),once(toUppercase(V,VU)),VU==V,put(Out,11),string_to_atom(S,N),cfaslWrite(Out,S).
%CONSTANT
cfaslWrite(Out,V):-atom(V),fromConstant(V,Guid),put(Out,30),cfaslWrite(Out,Guid),!.
%GUID
cfaslWrite(Out,guid(Data)):-put(Out,25),cfaslWrite(Out,Data).
%NART
cfaslWrite(Out,nart([H|T])):-put(Out,51),put(Out,31),cfaslWrite(Out,[H|T]).
cfaslWrite(Out,nart(Int)):-put(Out,31),cfaslWrite(Out,Int).
%ASSERTION
cfaslWrite(Out,ist(Mt,Assert)):-put(Out,51),put(Out,33),cfaslWrite(Out,Assert),cfaslWrite(Out,Mt).

%:-module_transparent(assertion/13).
%:-dynamic_transparent(assertion/13).
%:-multifile(assertion/13).

:-module_transparent(constant/4).
%:-dynamic_transparent(constant/4).
%user:constant(A,B,C,D):-cyc:constant(A,B,C,D).

:-dynamic_transparent(constantGuid/2).
constantGuid(Const,ID):-cyc:constant(Const,_,ID,_).
fromConstant(Const,guid(BB)):-constantGuid(Const,Guid),!,atom_codes(Guid,BB).
fromConstant(Const,Id):-constantId(Const,Id),!.
fromConstant(Const,BB):-sformat(S,'(constant-external-id (find-constant "~w"))',[Const]),evalSubL(S,X,_),balanceBinding(X,BB),
         BB=guid(String),string_to_atom(String,Atom),
         asserta(constantGuid(Const,Atom)).

:-dynamic_transparent(constantId/2).
constantId(Const,ID):-cyc:constant(Const,ID,_,_).
toConstant(Len,Const):-constantId(Const,Len),!.
toConstant(Len,Const):-integer(Len),sformat(S,'(find-constant-by-internal-id ~w)',[Len]),evalSubL(S,X,_),balanceBinding(X,BB),
         unhashConstant(BB,Const),
         asserta(constantId(Const,Len)),!.
toConstant(guid(Guid),Const):-!,toConstant(Guid,Const).
toConstant(Guid,Const):-is_string(Guid),!,string_to_atom(Guid,Atom),toConstant(Atom,Const).
toConstant(Guid,Const):-constantGuid(Const,Guid),!.
toConstant(Len,Const):-concat_atom([A,B|C],'-',Len),sformat(S,'(find-constant-by-external-id (string-to-guid "~w"))',[Len]),evalSubL(S,X,_),balanceBinding(X,BB),
         unhashConstant(BB,Const),
         asserta(constantGuid(Const,Len)),!.
toConstant(C,CU):-unhashConstant(C,CU).

isTrue(V):-var(V),!.
isTrue([]):-!,fail.
isTrue('NIL'):-!,fail.
isTrue('nil'):-!,fail.
isTrue('false'):-!,fail.
isTrue('fail'):-!,fail.
isTrue('no'):-!,fail.
isTrue(X:_):-!,isTrue(X).
isTrue(_).



:-module_transparent(nart/3).
toNart(Id,Nart):-user:nart(Id,_,Nart),!.
toNart(Id,Nart):-user:nart(_,Id,Nart),!.
toNart(nart(Nart),nart(Nart)):-!.
toNart(Nart,nart(Nart)).
 

unhashConstant(HConst,Const):-atom_concat('#$',Const,HConst),!.
unhashConstant(Const,Const).

properPart(T,[]):-not(T=[_|_]).
properPart([H|T],[H|CDR]):-properPart(T,CDR).
improperPart(T,T):-not(T=[_|_]).
improperPart([H|T],CDR):-improperPart(T,CDR).






isWhole(O,W):-number(O),W is round(O),atom_number(A2,W),atom_number(A1,O),(atom_concat(A2,'.0',A1);atom_concat(A2,'',A1)).

encodeIntNumber(Int,[NCode|Rest]):-Int<0, NInt is -1 * Int,encodeIntNumber(NInt,[Code|Rest]),NCode is Code+1,!.
encodeIntNumber(Int,[0,Int]):-Int<256.
encodeIntNumber(Int,[2,V1,V2]):-Int<65536,V1 is 255 /\ Int,V2 is ((255*256) /\ Int)>>8.
encodeIntNumber(Int,[4,V1,V2,V3]):-Int<16777216,V1 is 255 /\ Int,V2 is ((255*256) /\ Int)>>8,V3 is ((255*256) /\ Int)>>16.
encodeIntNumber(Int,[6,V1,V2,V3,V4]):-Int<4294967296, V1 is 255 /\ Int,V2 is ((255*256) /\ Int)>>8 ,V3 is ((255*256*256) /\ Int)>>16,V4 is ((255*256*256*256) /\ Int)>>24.
encodeIntNumber(Int,[23|VAL]):-V1 is 255 /\ Int,Int2 is (Int - V1)>>8, encodeIntNumber(Int2,1,REST,Len),encodeIntNumber(Len,LE),append(LE,[V1|REST],VAL).
encodeIntNumber(Int,N,[],N):-Int<1,!.
encodeIntNumber(Int,N,[V1|All],O):-V1 is 255 /\ Int, NN is N+1, IntN is (Int-V1)>>8,encodeIntNumber(IntN,NN,All,O).


%CFASL_P_BIGNUM
%cfaslRead(23
encodeNumber(N,E):-integer(N),!,encodeIntNumber(N,E).
encodeNumber(N,E):-encodeRNumber(N,E).
encodeRNumber(Int,[NCode|Rest]):-Int<0, NInt is -1.0 * Int,encodeRNumber(NInt,[Code|Rest]),NCode is Code+1,!.
%encodeRNumber(N,[8|RESAT]):-isWhole(N,W),!,encodeIntNumber(W,IE),append(IE,[0,0],RESAT).
encodeRNumber(N,[8|STUFF]):-encodeRNumber(N,0,W,RR),encodeIntNumber(W,IE),encodeIntNumber(RR,RE),append(IE,RE,STUFF).

encodeRNumber(N,R,W,R):-isWhole(N,W),!.
encodeRNumber(N,R,NNN,RRR):-NN is N*2,RR is R-1,encodeRNumber(NN,RR,NNN,RRR).


   
%callCycApi(Out,[string("prologProcForCycPred-pos-proc"), ['#$prologCycPred2', 1, _G5354]], [var0=_G5354|_G5514], _G5523).
callCycApi(Out,[string(Predstring), Call],ToplevelVars):- string_to_atom(Predstring,Atom),concat_atom([H|T],'-',Atom),!,
      cycPredCall([H|T],Call,Result),!,
      writel(Out,Result,ToplevelVars),!.
         
callCycApi(Out,PrologGoal,ToplevelVars):-cycGoal(PrologGoal,ToplevelVars,Result),writel(Out,Result,ToplevelVars),!.





:-dynamic_transparent(evalSubLCache/2).


%passAlong([H|T],Y):-X=..[H|T],!,passAlong(X,Y).
%passAlong(X,Y):-evalSubLCache(X,Y),!.
passAlong(X,Y):-toCycApiExpression(X,CycLX),evalSubL(CycLX,Y,Vars),asserta(evalSubLCache(X,Y)).


%notraceTry(Goal):-notrace(ignore(catch(Goal,E,writeCycL(Goal-E)))).


cycGoal(X,Y,Z):-debugFmt('?- ~q.~n',[cycGoal(X,Y,Z)]),fail.
cycGoal([],Vars,[]):-!.
%cycGoal(['END-OF-FILE'|_],_,'NIL'):-!.
cycGoal(['END-OF-FILE'|_],_,'NIL'):-!.
%cycGoal([APIQUIT|_],_,'T'):-isCycTrue(APIQUIT),!.
%writecycGoal(['CONSTANT-INFO-FROM-GUID-STRINGS'|
%cycGoal(['CYC-QUERY',PrologGoal,MT|OPTS],ToplevelVars,Result):-sterm_to_pterm(PrologGoal,PTERM), findall(ToplevelVars,PTERM,Result),!.
%cycGoal(X,Vars,Lisp):- debugFmt(passIn(X)),passAlong(X,Y),toCycApiExpression(Y,Vars,Lisp),debugFmt('\n% Pass back->'),debugFmt(Lisp),!.

cycGoal(['PEVAL', string(EVAL)], _G94, Result):-
      catch((atom_to_term(EVAL,PTERM,ToplevelVars),catch(predicate_property(PTERM,_),_,fail),!,
          debugFmt('?- ~q.~n',[PTERM]),
         catch(findall(ToplevelVars,PTERM,Result),E,Result=[E]),
         debugFmt('-> ~q.~n',[ToplevelVars:Result])),E,Result=[E]),!.


cycGoal(PrologGoal,ToplevelVars,Result):-once(sterm_to_pterm(PrologGoal,PTERM)),catch(predicate_property(PTERM,_),_,fail),!,
          debugFmt('?- ~q.~n',[PTERM]),
         findall(ToplevelVars,PTERM,Result),!,
          debugFmt('-> ~q.~n',[ToplevelVars:Result]),!.
          
%cycGoal([F|A],ToplevelVars,Result):-toUppercase([F|A],FU),not([F|A]==FU),!,cycUCaseGoal(FU,ToplevelVars,Result),!.
cycGoal(X,Y,Z):-functor(X,F,_),sformat(S,'"~q is not defined in the API"',[F]),throw(unknown(S,X)),!.

%cycGoal(['FIND-CONSTANT',STRING],ToplevelVars,Result):-string_to_atom(String,Atom),atom_concat('#$',Atom,Result).
%cycGoal(['DEFVAR',NAME,VALUE|_],ToplevelVars,NAME).


user:keepUpWithAssertions:-
      evalSubL('(assertion-count)',X:Var),
       flag('$cyc_assertion_pointer',_,X-100),
       crawlAssertionsBG.





crawlAssertions:- 
     flag('$cyc_assertion_pointer',_,0),crawlAssertionsBG,crawlAssertionsBG.
   
crawlAssertionsBG:-
createProcessedGoal((
      repeat,
      flag('$cyc_assertion_pointer',Current,Current+1),
      ignore(once(once(catch(cacheAssertionById(Current),_,(flag('$cyc_assertion_pointer',Down,Down-100),sleep(5),fail));flag('$cyc_assertion_pointer',Down,Down-100)))),
      fail)).


:- dynamic_transparent cycAssertionCache/6.
:- index(cycAssertionCache(0,1,1,1,1,0)).
cacheAssertionById(Id):-cycAssertionCache(Id,Assertion,Mt,Strength,Direction,Vars),!.
cacheAssertionById(Id):-getAssertionById(Id,Assertion,Mt,Strength,Direction,Vars),
      asserta(cycAssertionCache(Id,Assertion,Mt,Strength,Direction,Vars)).


getAssertionById(Id,Assertion,Mt,Strength,Direction,Vars):-
      sformat(S,'(clet ((assrt (find-assertion-by-id ~w)))(list (assertion-id assrt) (assertion-formula assrt) (assertion-mt assrt) (assertion-el-formula assrt) (asserted-by assrt)(assertion-truth assrt) (asserted-when assrt)  (GET-ASSERTED-ARGUMENT  asrt) (assertion-direction assrt)  (assertion-strength assrt)))',[Id]),
      evalSubL(S,Surf),
      once(getAssertionById2(Surf,Assertion,Mt,Strength,Direction,Vars)).

getAssertionById2([[[[ist,Mt,[Assertion]]],Strength,Direction]]:Vars,NewAssertion,NewMt,Strength,Direction,GVars):-
         s2p(Assertion,NewAssertion,MoreVars),s2p(Mt,NewMt,MtVars),append(MoreVars,Vars,AllVars1),append(AllVars1,MtVars,AllVars),ssort(AllVars,GVars).
getAssertionById2(Surf:Vars,Surf,'NIL',Strength,Direction,Vars).

ssort(X,[]):-var(X),!.
ssort(X,Y):-sort(X,Y).
s2p(X,X,[]):- (var(X);number(X);string(X)),!.
s2p(Atom,X,[Atom=X]):-atom(Atom),atom_concat(':',_,Atom),hash_term(Atom,Hash),X='$VAR'(Hash),!.
s2p(Atom,[Atom],[]):-atom(Atom),atom_concat('SKF',_,Atom),!.
%s2p(Atom,[X],[Atom=X]):-atom(Atom),atom_concat('SKF',_,Atom),hash_term(Atom,Hash),X='$VAR'(Hash),!.
s2p(var(X,Name),X,[Name=X]).
s2p([H|T],R,Opt):-s2p2(H,T,R,Opt),!.
s2p(X,X,[]).

s2pl(X,X,[]):- (atom(X);var(X);number(X);string(X)),!.
s2pl([H|T],[HH|TT],Opt):-s2p(H,HH,O1),s2pl(T,TT,O2),append(O1,O2,Opt),!.

s2p2(H,T,R,Opt):-is_list(H),s2pl(H,HH,O1),!,s2pl(T,TT,O2),R=[HH|TT],!,append(O1,O2,Opt).
s2p2(H,T,R,Opt):-isFn(H),!,s2pl(T,TT,Opt),R=[H|TT],!.
s2p2(H,T,R,Opt):-s2pl(T,TT,Opt),R=..[H|TT],!.

isFn(X):-not(atom(X)),!.
isFn(X):-atom_concat(_,'Fn',X).
isFn(X):-atom_concat('The',_,X).
isFn(X):-atom_concat('SKF',_,X).
isFn(X):-atom_concat('Mt',_,X).
isFn(X):-name(X,[Cap|_]),char_type(Cap,upper),!.
      
         

'API-QUIT':-'api-quit'.
'api-quit':-thread_self(Session),retractall(isKeepAlive(Session)),told.


listingToString(Pred,RS):-
      findall(':-'(Pred,X),clause(Pred,X),R1),
      termCyclify(R1,R2),
      toCycApiExpression(R2,_,R),escapeString(R,RS),!.


      
      

% ===========================================================
% PROLOGD for OpenCyc SERVICE
% ===========================================================

serviceCycApiRequest5(In,Out):-
       readCycL(In,Trim), 
       isDebug(format('"~s"~n',[Trim])),
       serviceCycApiRequestSubP(In,Trim,Out).
   
serviceCycApiRequestSubP(In,Trim,Out):-
       getSurfaceFromChars(Trim,[Result],ToplevelVars),!,
       balanceBinding(Result,PrologGoal),
        thread_self(Session),
        retractall(isKeepAlive(Session)),
        xmlClearTags,
       invokePrologCommand(Session,In,Out,PrologGoal,ToplevelVars,Returns).

serviceCycApiRequestSubP(Trim):-
       getSurfaceFromChars(Trim,[Result],ToplevelVars),!,
       balanceBinding(Result,PrologGoal),
	 ignore(catch(PrologGoal,_,true)).

% ===========================================================
% PROLOGD for Java SERVICE
% ===========================================================
serviceJavaApiRequest(In,Out):-
        thread_self(Session),
        retractall(isKeepAlive(Session)),
        xmlClearTags,
   %     writeFmt(Out,'<session:id goal="~q">\n',[Session]),
        flush_output,
        repeat,
               ignore((once(( catch(
                        read_term(In,PrologGoal,[variable_names(ToplevelVars),character_escapes(true),syntax_errors(error)]),
                        E,
                        writeErrMsg(Out,E)),
                invokePrologCommand(Session,In,Out,PrologGoal,ToplevelVars,Returns))))),
                notKeepAlive(Out,Session),!.

invokePrologCommand(Session,In,Out,PrologGoal,ToplevelVars,Returns):-
         writeFmt(Out,'<cycml:solutions goal="~q">\n',[PrologGoal:ToplevelVars]),var(PrologGoal),!.

invokePrologCommand(Session,In,Out,PrologGoal,ToplevelVars,Returns):-flush_output,
      set_output(Out),set_input(In),!,
      %   tell(Out),
	PrologGoal,
        inform_xml_vars(PrologGoal,ToplevelVars),
        flush_output,
        xmlExitTags,!.


% ===========================================================
% HTTPD SERVICE
% ===========================================================
%prologHTTPD(Port):-http_server(reply, [port(Port)]).

serviceHttpRequest(ClientInfo,In,Out):-!,
        setMooOption(Agent,client,html),
        readHTTP(In,Request),!,
        tell(Out),
        ignore(reply([clientinfo=ClientInfo|Request])),
        told.


reply(Request) :-
        debugFmt('REQUEST DATA: ~q',[Request]),
        setMooOption(Agent,client,html),!,
        %Set-Cookie: nameTest=valueTest
        writeFmtFlushed('HTTP/1.1 200 OK\nServer: LOGICMOO HTTPD\nContent-Type: text/html\n\n',[]),
        once(processRequest(Request)),!,
        flush_output,!.

% ===================================================================
% Semi-Prolog Dependant Code
% ===================================================================
sigma_ua(X):-processRequest(X).


:-module_transparent(user:processRequestHook/1).
:-dynamic_transparent(user:processRequestHook/1).
:-multifile(user:processRequestHook/1).


% =================================================
% SubL
% =================================================
:-dynamic_transparent(processRequestHook/1).
:-multifile(processRequestHook/1).
:-module_transparent(processRequestHook/1).

user:processRequestHook(ARGS):-member(file='subl.moo',ARGS),!,
      ignore(member(formula=W,ARGS)),
      ignore(W=''),
      writeHTMLStdHeader('SubL Interactor'),
      format('
      <form method="GET">
	<p><textarea rows="9" name="formula" cols="40">~w</textarea><br>
	<input type="submit" value="Call" name="submit">&nbsp;<input type="reset" value="Reset" name="resetButton"></p>
      </form>',[W]),
      writeHTMLStdFooter,!.
	
        
processRequest(X):-   
   catch(once(user:processRequestHook(X)),E,(debugFmt('ERROR: processRequestHook: "~q" \n',[X:E]), fail)),!.
processRequest(X):-
        debugFmt('FAILED: processRequestHook: "~q" \n',[X]),
        once((writeHTMLStdHeader(X),  
        once(showCycProcessHTML),
        % serviceSoapRequest(In,Out),
	writeHTMLStdFooter)),!.
/*

readHTTP(In,DOPTS):-!,
      http_header:http_read_request(In,Request),!,
      getData(Request,Data),!,decodeRequestArguments(Data,DData),!,
     request_to_options(Request,Options),!,
      append(Options,DData,DOPTS),!.

%request_to_options(Request,Options),
request_to_options([],[]):-!.
request_to_options([R|Request],[O|Options]):-r2o(R,O),!,request_to_options(Request,Options),!.

r2o(path(R),file=V):-atom_concat('/',V,R),!.
r2o(R,N=V):-functor(R,N,1),R=..[_,V],!.
r2o(RO,RO).

getData(Request,Data):-member(method(post), Request),http_read_data(Request, Data, []),!.
getData(Request,Data):-member(search(Data), Request),!.
getData(Request,[]).


readHTTP(In,Request):-
        read_line_with_nl(In, Codes, []),
        append([71, 69, 84, _, _],Stuff,Codes), % "GET /"
        append(RequestCodes,[72,84,84,80|_],Stuff),
        atom_codes(RequestEncoded,RequestCodes),
        decodeRequest(RequestEncoded,Request).

readHTTP(In,Request):-
        read_line_with_nl(In, Codes, []),
        append([80, 79, 83, 84,_, _],Stuff,Codes), % "POST /"
        append(RequestCodes,[72,84,84,80|_],Stuff),
        atom_codes(RequestEncoded,RequestCodes),
        decodeRequest(RequestEncoded,Request).


read_line_with_nl(Fd, Codes, Tail) :-
        get_code(Fd, C0),
        read_line_with_nl(C0, Fd, Codes, Tail).
read_line_with_nl(end_of_file, _, Tail, Tail) :- !.
read_line_with_nl(-1, _, Tail, Tail) :- !.
read_line_with_nl(10, _, [10|Tail], Tail) :- !.
read_line_with_nl(C, Fd, [C|T], Tail) :-
        get_code(Fd, C2),
        read_line_with_nl(C2, Fd, T, Tail).

decodeRequest(RequestEncoded,[file=FileT]):-
      www_form_encode(RequestDecoded,RequestEncoded),
      concat_atom([File],'?',RequestDecoded),!,
      decodeRequestAtom(File,FileT).
decodeRequest(RequestEncoded,[file=FileT|ENCARGS]):-
      concat_atom([File|_],'?',RequestEncoded),
      atom_concat(File,'?',FilePart),
      atom_concat(FilePart,ARGS,RequestEncoded),
      concat_atom(ArgList,'&',ARGS),
      decodeRequestAtom(File,FileT),!,
      decodeRequestArguments(ArgList,ENCARGS),!.

decodeRequestArguments([],[]):-!.
decodeRequestArguments([ctx=Value|List],[ctx=CValue,theory=KValue|ARGS]):- concat_atom([KValue,CValue],':',Value),!,
          decodeRequestArguments(List,ARGS).
decodeRequestArguments([Arg|List],[DDName=DDValue|ARGS]):-
          split_nv(Arg,Name,Value),
          decodeRequestAtom(Name,DName),
          decodeRequestAtom(Value,DValue),!,
          decodeRequestArguments(List,ARGS),!,
          unatom(DName,DDName),
          unatom(DValue,DDValue),!.


refixArgs([],[]):-!.
refixArgs([A|RGS],[R|ARGS]):-
      refixArg(A,R),!,
      refixArgs(RGS,ARGS).
refixArg(A=B,AA=BB):-unatom(A,AA),unatom(B,BB).
refixArg(A,AA):-unatom(A,AA).

unatom(B,BB):-atom(B),catch(atom_to_term(B,BB,_),_,fail),ground(BB),!.
unatom(B,B).



%ctx=PrologMOO%3ASTRUCTURAL-ONTOLOGY&amp;

split_nv(Name=Value,Name,Value):-!.
split_nv(Arg,Name,Value):-concat_atom([Name,Value],'=',Arg),!.
split_nv(Arg,Arg,Arg).
                        

decodeRequestAtom(RequestEncoded,X):-www_form_encode(RequestDecoded,RequestEncoded),!,decodeRequestAtom2(RequestDecoded,X),!.
decodeRequestAtom2(A,A):-var(A),!.
decodeRequestAtom2(tn,tn):-!.
decodeRequestAtom2(N,N):-number(N),!.
decodeRequestAtom2(A=B,AA=BB):-decodeRequestAtom2(A,AA),decodeRequestAtom2(B,BB),!.
decodeRequestAtom2(A,T):-catch(atom_to_term(A,T,_),_,fail),number(T),!.
decodeRequestAtom2(A,T):-catch(atom_to_term(A,T,_),_,fail),not(var(T)),not(compound(T)),!.
decodeRequestAtom2(A,T):-atom(A),catch(atom_codes(A,[95|_]),_,fail),catch(atom_to_term(A,T,_),_,fail),!.
decodeRequestAtom2(Request,RequestT):-atom_concat(RequestT,' ',Request),!.
decodeRequestAtom2(Request,Request).

*/
% ===========================================================
% NATIVE SERVICE
% ===========================================================

serviceNativeRequestAsRDF(_,In,Out):-
        writeFmt(Out,'<?xml version="1.0" encoding="ISO-8859-1"?>\n',[]),
        thread_self(Session),
        retractall(isKeepAlive(Session)),
        xmlClearTags,
        repeat,
                catch(
                        read_term(In,PrologGoal,[variable_names(ToplevelVars),character_escapes(true),syntax_errors(error)]),
                        E,
                        writeErrMsg(Out,E)),
                %debugFmt(PrologGoal:ToplevelVars),
                invokePrologCommandRDF(Session,In,Out,PrologGoal,ToplevelVars,Returns),
                notKeepAlive(Out,Session),!.

notKeepAlive(Out,Session):-isKeepAlive(Session),
        write(Out,
                'complete.\n'
                %'<cycml:keepalive/>\n'
                                ),flush_output_safe(Out),!,fail.
notKeepAlive(Out,Session):-flush_output_safe(Out).


keep_alive:-thread_self(Me),retractall(isKeepAlive(Me)),assert(isKeepAlive(Me)),writeFmtFlushed('<keepalive/>\n',[]).
goodbye:-thread_self(Me),retractall(isKeepAlive(Me)),writeFmt('<bye/>/n',[]).


invokePrologCommandRDF(Session,In,Out,PrologGoal,ToplevelVars,Returns):-var(PrologGoal),!.

invokePrologCommandRDF(Session,In,Out,PrologGoal,ToplevelVars,Returns):-
        term_to_atom(Session,Atom),concat_atom(['$answers_for_session',Atom],AnswersFlag),
        writeFmt(Out,'<cycml:solutions goal="~q">\n',[PrologGoal]),
        flag(AnswersFlag,_,0),
        set_output(Out),set_input(In),!,
        getCputime(Start),
        callNondeterministicPrologCommandRDF(Session,AnswersFlag,In,Out,PrologGoal,ToplevelVars),
        xmlExitTags,
        getCputime(End),
        flag(AnswersFlag,Returns,Returns),
%       (Returns > 0 ->
%               writeFmt(Out,'<cycml:yes/>\n',[]) ;
%               writeFmt(Out,'<cycml:no/>\n',[])),!,
        Elapsed is End -Start,
        writeFmt(Out,'</cycml:solutions answers="~w" cputime="~g">\n',[Returns,Elapsed]),!.

callNondeterministicPrologCommandRDF(Session,AnswersFlag,In,Out,PrologGoal,ToplevelVars):-
        ground(PrologGoal),!,
        catch(
                (PrologGoal,
                 flag(AnswersFlag,Answers,Answers+1),
                 writePrologToplevelVarsXML(Out,PrologGoal,AnswersFlag,ToplevelVars)
                 ),
           Err,writeErrMsg(Out,Err,PrologGoal)),!.

callNondeterministicPrologCommandRDF(Session,AnswersFlag,In,Out,PrologGoal,ToplevelVars):-
        catch(
                (PrologGoal,
                 flag(AnswersFlag,Answers,Answers+1),
                 writePrologToplevelVarsXML(Out,PrologGoal,AnswersFlag,ToplevelVars),
                 fail),
           Err,writeErrMsg(Out,Err,PrologGoal)),!.
callNondeterministicPrologCommandRDF(Session,AnswersFlag,In,Out,PrologGoal,ToplevelVars):-!.


writePrologToplevelVarsXML(Out,PrologGoal,AnswersFlag,ToplevelVars):-
         flag(AnswersFlag,Answers,Answers),
        writeFmt(Out,'<cycml:result solution="~w">\n',[Answers]),
        writePrologToplevelVarsXML2(Out,ToplevelVars),
        writeFmt(Out,'</cycml:result>\n',[]),!.

writePrologToplevelVarsXML2(Out,[]):-!.
writePrologToplevelVarsXML2(Out,[Term|REST]):-!,Term=..[_,N,V],
         writeFmtFlushed(Out,'       <cycml:p>~w = ~q</cycml:p>\n',[N,V]),
         writePrologToplevelVarsXML2(Out,REST),!.


writeFmt(A,B,C):-!.
writeFmt(A,B):-!.

writeFmt(A,B,C):-
        writeFmtFlushed(A,B,C).
writeFmt(A,B):-
        writeFmtFlushed(A,B).


throwCyc(Module,Type,Details):-
        current_prolog_flag(debug_on_error, DebugOnError),
        set_prolog_flag(debug_on_error, false),!,
        throw(cycException(Module,Type,Details,DebugOnError)),
        ifInteractive(debugFmt('Post throwCyc')),!.

ifInteractive(X):-X.


% ===========================================================
% NATIVE SOAPD SERVER FOR SWI-PROLOG
% ===========================================================

			    
%:-module(cyc_soap,[]).

% :-include('cyc_header.pl').

:-dynamic_transparent(xmlCurrentOpenTags/2).

serviceSoapRequest(In,Out):-
      debugFmt('SOAP Request'),
        catch(read_do_soap(stream(In),Out),E,
        writeFmt(Out,'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n<error>~w</error>\n',[E])),
        flush_output_safe(Out).


read_do_soap(Source):-
        open(Source,read,Stream),
        read_do_soap(Stream,user_output).

read_do_soap(Source,Out):-
       thread_self(Self),
        write(Out,'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n'),
       % writeFmt(Out,'<?xml version="1.0" encoding="ISO-8859-1"?>\n<answer thread="~w">\n',[Self]),
        flush_output_safe(Out),
        load_structure(Source,RDF,[]),
        structure_to_options(RDF,Options),
%       writeFmt(user_error,'structure="~q"\noptions="~q"\n',[RDF,Options]),
        flush_output_safe(user_error),
        processRequest([client=soap|Options]).
        %writeFmt(Out,'</answer>\n',[]).


% request
structure_to_options([element(request, Options, [Atom])],[submit=ask,sf=Atom|Options]):-!.

% assert
structure_to_options([element(assert, Options, [Atom])],[submit=assert,sf=Atom|Options]):-!.
structure_to_options([element(asssertion, Options, [Atom])],[submit=assert,sf=Atom|Options]):-!.
structure_to_options([element(assertion, Options, [Atom])],[submit=assert,sf=Atom|Options]):-!.

% get inner
structure_to_options([element(Ptag, ['xmlns:cyc'=Server], Inner)],[opt_server=Server,opt_outter=Ptag|Out]):-!,
        structure_to_options(Inner,Out).


writeFmtServer(A,B):-format(A,B),flush.
writeFmtServer(O,A,B):-format(A,B),flush_output_safe(O).

xmlOpenTag(Name):-thread_self(Self),asserta(xmlCurrentOpenTags(Self,A)),writeFmtServer('<~w>',[Name]),!.
xmlOpenTagW(Out,Name,Text):-thread_self(Self),asserta(xmlCurrentOpenTags(Self,A)),writeFmtServer(Out,'~w',[Text]),!.

xmlCloseTag(Name):-thread_self(Self),ignore(retract(xmlCurrentOpenTags(Self,A))),writeFmtServer('</~w>',[Name]),!.
xmlCloseTagW(Name,Text):-thread_self(Self),ignore(retract(xmlCurrentOpenTags(Self,A))),writeFmtServer('~w',[Text]),!.
xmlCloseTagW(Out,Name,Text):-thread_self(Self),ignore(retract(xmlCurrentOpenTags(Self,A))),writeFmtServer(Out,'~w',[Text]),!.

xmlClearTags:-thread_self(Self),retractall(xmlCurrentOpenTags(Self,A)).

xmlExitTags:-thread_self(Self),retract(xmlCurrentOpenTags(Self,A)),writeFmtServer('</~w>',[Name]),fail.
xmlExitTags.


% ===========================================================
% Insert
% ===========================================================
parse_cyc_soap(Options):-memberchk(submit=assert,Options),!,
        getMooOption(Agent,opt_ctx_assert='BaseKB',Ctx),
        getMooOption(Agent,opt_theory='doom:DataMt',Context),
        getMooOption(Agent,sf=surf,Assertion),
        atom_codes(Assertion,Assertion_Chars),
        getMooOption(Agent,user='Web',User),
        getMooOption(Agent,interp='cycl',Interp),
        logOnFailure(getMooOption(Agent,tn=_,EXTID)),
        %sendNote(user,'Assert',formula(NEWFORM),'Ok.'). %,logOnFailure(saveCycCache)
        logOnFailure(getCleanCharsWhitespaceProper(Assertion_Chars,Show)),!,
        xml_assert(Show,Ctx,Context,User).

xml_assert(Show,Ctx,Context,User):-
        getSurfaceFromChars(Show,STERM,Vars),
        toCycApiExpression(STERM,NEWFORM),
        xml_assert(Show,NEWFORM,Vars,Ctx,Context,User).

xml_assert(Show,Ctx,Context,User):-!,
        writeFmt('<assertionResponse accepted="false">\nUnable to parse: "~s"\n</assertionResponse>\n',[Show]).

xml_assert(Show,NEWFORM,Vars,Ctx,Context,User):-
        logOnFailure(getTruthCheckResults(tell,[untrusted],surface,NEWFORM,Ctx,STN,Context,Vars,Maintainer,Result)),
        (Result=accept(_) ->
                        (
                        once(invokeInsert([trusted,canonicalize,to_mem],surface,NEWFORM,Ctx,EXTID,Context,Vars,User)),
                        write('<assertionResponse accepted="true">\nOk.\n</assertionResponse>\n')
                        )
                        ;
                        (
                        Result=notice(FormatStr,Args),
                        write('<assertionResponse accepted="false">\n'),
                        writeFmt(FormatStr,Args),
                        write('\n</assertionResponse>\n')
                        )
        ),!.

xml_assert(Show,NEWFORM,Vars,Ctx,Context,User):-!.


% ===========================================================
% Ask a Request
% ===========================================================
parse_cyc_soap(Options):-memberchk(submit=ask,Options),!,make,
        %write('<!DOCTYPE cyc:ask SYSTEM "/opt/tomcat-4.0/webapps/cyc-1.4b1/dtd/java_prolog.dtd">\n'),
        write('<cycml:ask xmlns:cycml="http://localhost">\n'),
        getMooOption(Agent,opt_ctx_request='BaseKB',Ctx),
        getMooOption(Agent,opt_theory='doom:DataMt',Context),
        getMooOption(Agent,sf=surf,Askion),
        atom_codes(Askion,Askion_Chars),
        getMooOption(Agent,user='Web',User),
        getMooOption(Agent,interp='cycl',Interp),
         logOnFailure(getCleanCharsWhitespaceProper(Askion_Chars,Show)),!,
         logOnFailure(getSurfaceFromChars(Show,STERM,Vars)),!,
         logOnFailure(toCycApiExpression(STERM,NEWFORM)),!,
              logOnFailure(once(( NEWFORM=comment(_) ->
                     (writeFmt('<cycml:error>Syntax Error: Unmatched parentheses in "~s"</cycml:error>\n',[Show]),!,FORM=_) ;(!,
                     logOnFailure(invokeRequest_xml(NEWFORM,ChaseVars,Ctx,TrackingAtom,Context,User,Vars,CPU))
                     )))),
        write('</cycml:ask>\n').

:-dynamic_transparent(invokeRequestToBuffer(NEWFORM,ChaseVars,Ctx,TrackingAtom,Context,User,Vars,CPU)).

invokeRequest_xml(NEWFORM,ChaseVars,Ctx,TrackingAtom,Context,User,Vars,CPU):-
        invokeRequestToBuffer(NEWFORM,ChaseVars,Ctx,TrackingAtom,Context,User,Vars,CPU),
        final_answer(Logic:How),
        invoke_final_answer(Logic,How,CPU).

invoke_final_answer(possible,How,CPU):-!,
        writeFmt('<requestResponse yesno="~w" numBindings="0" seconds="~w"/>\n',[How,CPU]).

invoke_final_answer(Logic,How,CPU):-
        writeFmt('<requestResponse yesno="~w" numBindings="~w" seconds="~w">\n<bindings>\n',[Logic,How,CPU]),
        cite_xml_buffered_answers,
        write('</bindings>\n</requestResponse>\n').


cite_xml_buffered_answers:-
        retract(requestBuffer_db(UResultsSoFar,Result,Explaination,Status)),
        once(inform_xml_agent(UResultsSoFar,Result,Explaination,Status)),fail.

% Call to write Summary
/*
cite_xml_buffered_answers:-
        final_answer(Logic:How),
        debugFmt(final_answer(Logic:How)),
        inform_xml_agent(How, ['Summary'=Logic|_G14093],final_answer(Logic:How),final_answer(Logic:How) ).
*/
cite_xml_buffered_answers:-!.

:-dynamic_transparent(cycassertgaffast/4).

cycassertgaffast(P,X,Y,Mt):-
   termCyclify(P,CP),
   termCyclify(X,CX),
   termCyclify(Y,CY),
   termCyclify(Mt,CMT),
   evalSubL('cyc-assert'(quote([CP,CX,CY]),quote(CMT)),_),!.
      

removalPredicateCodedInProlog(Pred,Prolog).

prologEval(X,Y):-Y is X + 111.
prologEval(X,Y):-Y is X + 211.

ensureCycCallsProlog(Host,Port):-
   sformat(SFormat,'(progn (define callprologpred (outval) (clet ((*retval* nil)(*stream* (OPEN-TCP-STREAM *prolog-host* *prolog-port*)))
   (prin1 outval *stream*)(force-output *stream*)(terpri *stream*)(force-output *stream*)(csetq *retval* (read *stream*))
   (close *stream*)(ret *retval*))) (defvar *prolog-host* "~w")(csetq *prolog-host* "~w")(defvar *prolog-port* ~w)(csetq *prolog-port* ~w))',[Host,Host,Port,Port]),
   evalSubL(SFormat,_,_),

   asserta((ensureCycCallsProlog(_,Port):-!)),!.
      
                                    
%odbc_current_table(CON, Table, Facet).


numberArgs(_,[]):-!.
numberArgs(N,[A|Args]):-ignore(N=A),NN is N+1,numberArgs(NN,Args),!.


cycPredCall([Pred, neg, Proc], Stuff, Stuff):-ground(Stuff),!,cycPredCall([Pred, pos, Proc], Stuff,R),!,R=[].
cycPredCall([Pred, pos, proc], [P|Args],[[P|Args]]):-!,numberArgs(0,Args),!.
 
cycPredCall(X,Y,[]):-attach_console,true,debugFmt(cycPredCall(X,Y)),!.
cycPredCall([Prolog,pos|_],[CycPred|CallArgs],Result):-is_list(CallArgs),Call=..[Prolog|CallArgs],!,findall([CycPred|CallArgs],catch(Call,_,fail),Result).
cycPredCall([Prolog,neg|_],[CycPred|CallArgs],[]):-!.
cycPredCall(Predstring,Call,[Call]):-!.

prologProcForCycPred(X,X).
  

dsnForDB('AdventureWorks','AdventureWorks').
connectionForDB(DB,CON):-odbc_current_connection(CON,database_name(DB)),!.
connectionForDB(DB,CON):-dsnForDB(DB,DSN),odbc_connect(DSN, CON,[ /*user('Administrator'),%password(Password),%alias(wordnet),*/open(once)]),!.

databaseForSource('AdventureWorksSource','AdventureWorks').
tableForSource('AdventureWorksSource',addressInfo,'Person.Address').
predicatesOfSource('AdventureWorksSource',addressInfo).

selectAll(Predicate,ROWS):-
   predicatesOfSource(Source,Predicate),
   tableForSource(Source,Predicate,Table),
   databaseForSource(Source,DB),
   connectionForDB(DB,CON),
   queryOfPredicate(Predicate,Query),
   odbc_query(CON,Query,ROWS).

queryOfPredicate(addressInfo,'SELECT * FROM Person.Address').

%rowInfo


insert_child(Child, Mother, Father, Affected) :- 
        odbc_query(parents,'INSERT INTO parents (name,mother,father) VALUES ("mary", "christine", "bob")',affected(Affected)).


% defineRemovalPred(prologEval,prologEval). 
defineRemovalPred(Predname,Prologname):-
   evalSubL('find-or-create-constant'(string(Predname)),_),
   termCyclify(Predname,CPredname),
   cycassertgaffast(isa,CPredname,'VariableArityRelation','UniversalVocabularyMt'),!,
   cycassertgaffast(comment,CPredname,string(['Defined via the defineRemovalPred',CPredname,'->',Prologname]),'UniversalVocabularyMt'),
   cycassertgaffast(isa,CPredname,'RemovalModuleSupportedPredicate-Specific','CycAPIMt'),
  % cycassertgaffast(arity,CPredname,2,'UniversalVocabularyMt'),!,
   atom_concat(':removal-',Predname,RemovalPrefix),
   atom_concat(RemovalPrefix,'-pos',RemovalPos),
   atom_concat(RemovalPrefix,'-neg',RemovalNeg),
   atom_concat(Prologname,'-pos-proc',RemovalPosProc),
   atom_concat(Prologname,'-neg-proc',RemovalNegProc),
   evalSubL('inference-removal-module'(RemovalPos,quote(
   [':sense',':pos',':predicate',% ':module-subtype' , ':kb',          
   CPredname,':cost-expression',0,':completeness',':complete',':input-verify-pattern',':anything',
   ':output-generate-pattern',[':call',RemovalPosProc,':input']])),_),
   evalSubL('inference-removal-module'(RemovalNeg,quote(
   [':sense',':neg',':predicate',     %  ':module-subtype' , ':kb',
   CPredname,':cost-expression',0,':completeness',':complete',':input-verify-pattern',':anything',
   ':output-generate-pattern',[':call',RemovalNegProc,':input']])),_),
   evalSubL('register-solely-specific-removal-module-predicate'(CPredname),_),!,
   evalSubL('define'(RemovalPosProc,['value'],ret(callprologpred(list(string(RemovalPosProc),'value')))),_),!,
   evalSubL('define'(RemovalNegProc,['value'],ret(callprologpred(list(string(RemovalNegProc),'value')))),_),!.


  /*
  
(define callprologpred (values) (print values) (ret NIL))
(define callprologpred (values) (print values) (ret (list '(1 2))))



(inference-removal-module :removal-gameNear-unbound-unbound
 '(:sense :pos 
	:predicate #$doom:gameNear 
   	:cost-expression 0 :completeness :complete 
	:input-extract-pattern (:template (#$doom:gameNear (:bind value-1) (:bind value-2)) ((:value value-1) (:value value-2)))
	:input-verify-pattern :anything
	:output-generate-pattern (:call removal-gameNear-pos-uu :input)
	:output-construct-pattern  (#$doom:gameNear (:call first :input) (:call second :input))))
(inference-removal-module :removal-gameNear-bound-bound 
'( :sense :pos 
	:predicate #$doom:gameNear 
	:check t 
	:required-pattern (#$doom:gameNear :fully-bound :fully-bound)
	:cost-expression 0 :completeness :complete
	:input-extract-pattern (:template (#$doom:gameNear (:bind value-1) (:bind value-2)) ((:value value-1) (:value value-2)))
	:input-verify-pattern :anything
	:output-check-pattern (:call removal-gameNear-pos-bb (:tuple (value-1 value-2) ((:value value-1) (:value value-2))))))


(define removal-gameNear-pos-bu (value) (clet ((*newvalue* value)) (csetq *newvalue* (GAME-EVAL (list "gameNear-pbu" value))) (ret  *newvalue* )))
(define removal-gameNear-pos-ub (value) (clet ((*newvalue* value)) (csetq *newvalue* (GAME-EVAL (list "gameNear-pub" value))) (ret  *newvalue* )))
(define removal-gameNear-pos-bb (vvs) (clet ((*newvalue* vvs)) (csetq *newvalue* (GAME-EVAL (list "gameNear-pbb" vvs))) (ret  *newvalue* )))
(define removal-gameNear-pos-uu (vvs) (clet ((*newvalue* vvs)) (csetq *newvalue* (GAME-EVAL (list "gameNear-puu" vvs))) (ret  *newvalue* )))
(register-solely-specific-removal-module-predicate #$doom:gameNear)
                                     */
    /*
"(tableName TABLE STRING) 
isSKSI(prologSKSIConnect,'TheList'(
prologSKSIConnect(DataSrc,Result):-
       cycQueryOnce(tableName(DataSrc,TablName),
     cycQueryOnce(usernameForAccount(DataSrc,Username)),
     cycQueryOnce(passwordForAccount(DataSrc,Password)),
                */


% ===========================================================
% Send to debugger
% ===========================================================
inform_xml_agent(UResultsSoFar,Result,InExplaination,Status):-
        debugFmt(inform_xml_agent(UResultsSoFar,Result,InExplaination,Status)),fail.

% ===========================================================
% Hide certain returns
% ===========================================================
inform_xml_agent(-1,Result,Explaination,Status).

inform_xml_agent(0, ['Result'=none|A], 'Unproven', done(possible:searchfailed)).
inform_xml_agent(_, ['Result'=true|A], found(_), done(true:_)).
inform_xml_agent(_, ['Summary'=_|_G5892], _, _).

% ===========================================================
% Write Answers
% ===========================================================
:-dynamic_transparent(length_explaination/2).

inform_xml_agent(UResultsSoFar,Result,InExplaination,Status):-
        writeFmt('<binding>\n',[]),
        inform_xml_vars(Result,Vars),
        length_explaination(InExplaination,InLength),
        findall(Length-Explaination,
                (retract(inform_xml_agent_buffer_db(_,Result,Explaination,_)),
                 length_explaination(Explaination,Length)
                 ),KeyList),
        keysort([(InLength-InExplaination)|KeyList],[(_-ChoiceExplaination)|_]),
        inform_xml_explaination(InLength,ChoiceExplaination,Result),
        writeFmt('</binding>\n',[]).

inform_xml_vars(Result,Vars):-
        length_var(Result,NumVar),
        writeFmt('<variables numVars="~w">\n',[NumVar]),
        inform_each_variable(Result,Vars),
        writeFmt('</variables>\n',[]).

length_var([],0).
length_var([A|'$VAR'(_)],1).
length_var([A|L],N):-
          length_var(L,NN),
          N is NN +1.

inform_each_variable([],Vars).
inform_each_variable('$VAR'(_),Vars).
inform_each_variable([NV|Rest],Vars):-
        inform_nv(NV,Vars),
        inform_each_variable(Rest,Vars).


inform_nv('$VAR'(_),Vars).
inform_nv(Name=Value,Vars):-
        toMarkUp(cycl,Name,Vars,OName),
        toMarkUp(cycl,Value,Vars,OValue),
        writeFmt('<var varName="~w" value="~w"/>\n',[OName,OValue]).


inform_xml_explaination(InLength,ChoiceExplaination,Result):-
        writeFmt('<explaination numSteps="~w">',[InLength]),
        flag(explaination_linenumber,_,0),
        writeObject_explaination(ChoiceExplaination,Result),
        writeFmt('</explaination>\n').

writeObject_explaination(deduced,_).
writeObject_explaination('$VAR'(_),_).
writeObject_explaination(explaination(Choice1) ,Result):-!,
        writeObject_explaination(Choice1,Result),!.
writeObject_explaination(Choice1 * Choice2 ,Result):-!,
        writeObject_explaination(Choice1,Result), !,
        writeObject_explaination(Choice2,Result),!.
writeObject_explaination(Choice1,Result):-!,
             write('<explainationStep isRule="true">\n<originalRule>\n'),
             toMarkUp(html,Choice1,Result,Out),!,
             ignore(write_escaped(Out)),
             write('\n</originalRule>\n</explainationStep>\n').
/*
write_escaped([O|T]):-!,
        write_e_codes([O|T]),!.
write_escaped(Out):-atom(Out),!,
        atom_codes(Out,Codes),!,write_escaped(Codes),!.
write_escaped(String):- !,
        string_to_atom(String,Atom),
         atom_codes(Atom,Codes),!,
        write_e_codes(Codes),!.

write_e_codes([]):-!.
write_e_codes([E|Cs]):-!,
        write_e(E),!,
        write_e_codes(Cs),!.
write_e(34):-write('&amp;qt;'),!.
write_e(60):-write('&amp;lt;'),!.
write_e(62):-write('&amp;gt;'),!.
write_e(C):-put_code(C),!.
*/


% ===================================================================
% writeIfOption(class(input),message(input),respoinse(output))
% generic call interface that was hooked into the belief engine with "ua_set_agent_callback(console_post)"
%This is not a predicate the useragent calls, but one that is called by the belief module to communicate  a question to the useragent or inform it of something.  
% The useragent decides if it can answer the a question and if not itself may ask a human user that is using it.
% There is three arguments to the my_callback predicate: Class, Message and Response
%
% Whenever the belief engine calls 'my_callback' only the first two arguments (Class,Message) are bound to supply information relevant to a Server invoked request.
%
% Class is a programmer defined message catagory  
% The Class is inteded to contain user defined message names that are sent as a callback function that is sent to the user's module consultation 
% Is is the type of Message catagory for the user agent.. A list of these are in TABLE 1.1 in <http://10.10.10.198/cyc_interface_advanced.html>
% (Class is always a ground Term)
%
% Message is a prolog term in the writeFmt defined by it's Class
% Each Class has a one known Message writeFmt shown in the table.   
% Message sometimes is ground term. 
%
%
% Response has normally has 2 response single_bindings: continue or abort
% This response is sent back to the belief_engine.
% If the belief_engine didn't receive 'abort', then it moves to the next stage in the command.
% 
% ===================================================================

			  /*      				   
:-module(cyc_generation,
	 [ 
	 debugFmt/1,
	 debugFmt/2,
	 debugFmtFast/1,
	 logOnFailureIgnore/1,
	 setMooOptionExplicitWriteSettings/0,
	 setMooOptionImplicitWriteSettings/0,
	 sendNote_p/1,
	 sendNote_p/4,
	 writeFailureLog/2,
	 debugOnFailure/2,
	 writeObject_p/2,
	 writeObject_p/3,
	 writeObject_conj_p/2]).
					 */

% :-include('cyc_header.pl').

% :-use_module(cyc_globalisms).

% ==========================================================
%  Sending Notes
% ==========================================================
 

logOnFailureIgnore(X):-ignore(logOnFailure(X)),!.

writeModePush(_Push):-!.
writeModePop(_Pop):-!.

%debugFmt([-1]).
%debugFmt([[-1]]).
%debugFmt(T):- isMooOption(Agent,opt_debug=off),!.
debugFmt(Stuff):-!,debugFmt('% ~w~n',[Stuff]).
debugFmt(T):-!,
	((
	if_prolog(swi,
		(prolog_current_frame(Frame),
		prolog_frame_attribute(Frame,level,Depth),!,
		Depth2 = (Depth-25))),
	writeFmt(';;',[T]),!,
	indent_e(Depth2),!,
	writeFmt('~q\n',[T]))),!.

indent_e(X):- catch((X < 2),_,true),write(' '),!.
indent_e(X):-XX is X -1,!,write(' '), indent_e(XX).

%debugFmt(C,T):- isMooOption(Agent,opt_debug=off),!.
debugFmt(_,F):-F==[-1];F==[[-1]].
debugFmt(F,A):-
        nl(user_error),
        format(user_error,F,A),
        nl(user_error),
        flush_output_safe(user_error),!.

debugFmt(C,T):-!,
	((
	writeFmt('<font size=+1 color=~w>',[C]),
	debugFmt(T),
        writeFmt('</font>',[]))),!.

dumpstack_argument(T):-isMooOption(Agent,opt_debug=off),!.  
	
dumpstack_argument(Frame):-
	write(frame=Frame),write(' '),
	dumpstack_argument(1,Frame).

dumpstack_argument(1,Frame):-!,
	prolog_frame_attribute(Frame,goal,Goal),!,
	write(goal=Goal),write('\n').
	
dumpstack_argument(N,Frame):-
	prolog_frame_attribute(Frame,argument(N),O),!,
	write(N=O),write(' '),
	NN is N +1,
	dumpstack_argument(NN,Frame).
	
dumpstack_argument(N,Frame):-!,write('\n').
	
:-dynamic_transparent(mods/1).

write_response_begin:-!.
write_response_end:-!.

sendNote(X):-var(X),!.
sendNote(X):-mods(X),!.
sendNote(X):-!,assert(mods(X)).
sendNote(X).			 

sendNote(To,From,Subj,Message):-sendNote(To,From,Subj,Message,_).

sendNote(To,From,Subj,Message,Vars):-
	not(not((safe_numbervars((To,From,Subj,Message,Vars)),
	%debugFmt(sendNote(To,From,Subj,Message,Vars)),
	catch(sendNote_1(To,From,Subj,Message,Vars),E,
	writeFmt('send note ~w ~w \n <HR>',[E,sendNote(To,From,Subj,Message,Vars)]))))).


sendNote_1(To,From,Subj,surf,Vars):-!.
sendNote_1(To,From,[],surf,Vars):-!.
sendNote_1(To,From,[],end_of_file,Vars):-!.
sendNote_1(doug,From,_,_,Vars):-!.
sendNote_1(extreme_debug,From,_,_,Vars):-!.
sendNote_1(debug,'Belief',_,_,Vars):-!.

%sendNote_1(canonicalizer,From,Subj,Message,Vars):-!.


sendNote_1(canonicalizer,From,Subj,Message,Vars):-
            toMarkUp(cycl,From,Vars,SFrom),
            toMarkUp(cycl,nv(Subj),Vars,SS),
            toMarkUp(cycl,nv(Message),Vars,SA),
            writeFmt('<font color=red>canonicalizer</font>: ~w "~w" (from ~w). \n',[SA,SS,SFrom]),!.

/*

sendNote_1(debug,From,Subj,Message,Vars):- %isMooOption(Agent,disp_notes_nonuser=on),!,
            toMarkUp(cycl,From,Vars,SFrom),
            toMarkUp(cycl,Subj,Vars,SS),
            toMarkUp(cycl,Message,Vars,SA),
            writeFmt('% debug: ~w "~w" (from ~w). \n',[SA,SS,SFrom]).
sendNote_1(debug,From,Subj,Message,Vars):-!.
*/

            /*


sendNote_1(To,From,Subj,Message,Vars):- isMooOption(Agent,client=consultation),  !, 
            toMarkUp(cycl,To,Vars,STo),
            toMarkUp(cycl,From,Vars,SFrom),
            toMarkUp(cycl,nv(Subj),Vars,S),
            toMarkUp(cycl,nv(Message),Vars,A),
            fmtString(Output,'~w (~w from ~w) ',[A,S,SFrom]),
	    sayn(Output),!.

sendNote_1(To,From,'Rejected',Message,Vars):- isMooOption(Agent,client=automata),  !.

sendNote_1(To,From,Subj,Message,Vars):- isMooOption(Agent,client=automata),  !, 
            toMarkUp(cycl,To,Vars,STo),
            toMarkUp(cycl,From,Vars,SFrom),
            toMarkUp(cycl,nv(Subj),Vars,S),
            toMarkUp(cycl,nv(Message),Vars,A),
            writeFmt(user_error,'% ~w (~w from ~w) ',[A,S,SFrom]).

sendNote_1(To,From,Subj,Message,Vars):- isMooOption(Agent,client=html),  !, %  In Html
            toMarkUp(cycl,To,Vars,STo),
            toMarkUp(cycl,From,Vars,SFrom),
            toMarkUp(cycl,nv(Subj),Vars,S),
            toMarkUp(html,nv(Message),Vars,A),
            writeFmt('<hr><B>To=<font color=green>~w</font> From=<font color=green>~w</font> Subj=<font color=green>~w</font></B><BR>~w\n',[To,From,S,A]),!.

sendNote_1(To,From,Subj,Message,Vars):- isMooOption(Agent,client=console),!, % In CYC
            toMarkUp(cycl,To,Vars,STo),
            toMarkUp(cycl,From,Vars,SFrom),
            toMarkUp(cycl,nv(Subj),Vars,SS),
            toMarkUp(cycl,nv(Message),Vars,SA),
            writeFmt(user_error,'; ~w: ~w "~w" (from ~w). \n',[STo,SA,SS,SFrom]),!.
  
sendNote_1(To,From,Subj,Message,Vars):-  % In CYC
            toMarkUp(cycl,To,Vars,STo),
            toMarkUp(cycl,From,Vars,SFrom),
            toMarkUp(cycl,nv(Subj),Vars,SS),
            toMarkUp(cycl,nv(Message),Vars,SA),
            writeFmt(user_error,'; ~w: ~w "~w" (from ~w). \n',[STo,SA,SS,SFrom]),!.

sendNote(To,From,Subj,Message,Vars):-!.
                                                                       */
debugFmtFast(X):-writeq(X),nl.

logOnFailure(assert(X,Y)):- catch(assert(X,Y),_,Y=0),!.
logOnFailure(assert(X)):- catch(assert(X),_,true),!.
logOnFailure(assert(X)):- catch(assert(X),_,true),!.
%logOnFailure(X):-catch(X,E,true),!.
logOnFailure(X):-catch(X,E,(writeFailureLog(E,X),!,catch((true,X),_,fail))),!.
logOnFailure(X):- writeFailureLog('Predicate Failed',X),!.


flush_output_safe(X):-catch(flush_output(X),_,true),!.
flush_output_safe(X).

writeFailureLog(E,X):-
		writeFmt(user_error,'\n% error:  ~q ~q\n',[E,X]),flush_output_safe(user_error),!,
		%,true.
		writeFmt('\n;; error:  ~q ~q\n',[E,X]),!,flush_output. %,format([E,X]).
		
debugOnFailure(assert(X,Y)):- catch(assert(X,Y),_,Y=0),!.
debugOnFailure(assert(X)):- catch(assert(X),_,true),!.
debugOnFailure(assert(X)):- catch(assert(X),_,true),!.
debugOnFailure(X):-catch(X,E,(writeFailureLog(E,X),(fail))),!.
debugOnFailure(X):-true,call(X).

debugOnFailure(arg_domains,CALL):-!,logOnFailure(CALL),!.
debugOnFailure(Module,CALL):-debugOnFailure(Module:CALL),!.


noDebug(CALL):-CALL.
	


%unknown(Old, autoload).
/*
% ================================================================
%   Serialize Objects to XML
% ================================================================


%%writeObject(OBJ,Vars):-!. %,writeq(OBJ),!.
%writeObject(OBJ,Vars):-!,catch(writeq(OBJ),_,true),nl,!.

writeObject(quiet,Term,Vars):-!.

writeObject(Verbose,Term,Vars):-writeObject(Term,Vars).

		
writeObject(OBJ,Vars):- isMooOption(Agent,client=html),!,
		((toMarkUp(html,OBJ,Vars,Chars),write(Chars))),!.
		
writeObject(OBJ,Vars):- isMooOption(Agent,client=atomata),!,
		((toMarkUp(cycl,OBJ,Vars,Chars),write(Chars))),!.

writeObject(OBJ,Vars):- isMooOption(Agent,client=console),!,
		((toMarkUp(cycl,OBJ,Vars,Chars),write(Chars))),!.

writeObject(OBJ,Vars):- !,
		((toMarkUp(cycl,OBJ,Vars,Chars),write(Chars))),!.


writeObject_conj(A,Vars):-isSlot(A),!,
	writeObject(A,Vars).

writeObject_conj(and(A,true),Vars):-!,
	writeObject_conj(A,Vars).

writeObject_conj(and(true,A),Vars):-!,
	writeObject_conj(A,Vars).

writeObject_conj(and(A,B),Vars):-!,
	writeObject_conj(A,Vars),
	writeObject_conj('\n\n Also \n\n ',Vars),
	writeObject_conj(B,Vars).

writeObject_conj(Output,Vars):-
	%write(Output),nl.
	writeObject(Output,Vars).
*/

:-dynamic_transparent(resolve_skolem/2).
:-dynamic_transparent(final_answer/1).

ignoreOnce(X):-ignore(once(X)).

writeIfOption(C,P):-ignoreOnce(writeCycEvent(C,P,_)).
writeIfOption(C,M,Vars):-ignoreOnce(writeCycEvent(C,M,Vars)).


write_val(Any,Vars):- isMooOption(Agent,client=html)
      -> write_val_xml(Any,Vars) ;
      (toMarkUp(cycl,Any,Vars,Chars),write(Chars),nl).
%      write_sterm(Any,Vars).
      
write_val_xml(Any,Vars):-
      toMarkUp(leml,Any,Vars,Chars),write(Chars),nl.
                                        /*

:-dynamic_transparent(telling_file).               

writeCycEvent(_,_,_):-isMooOption(Agent,disp_hide_all=true),!.
writeCycEvent(_,_,_):-telling_file,!.
writeCycEvent(Class,_,_):-isMooOption(Agent,Class=false),!.
writeCycEvent(Class,_,_):-isMooOption(Agent,disp_explicit=true),not(isMooOption(Agent,_Class=true)),!.

writeCycEvent(request_start,Note,Vars):-!,
         (isMooOption(Agent,client=html) -> 
          (writeFmt('<Answer>\n'),le_push('Answer'));
          true).

writeCycEvent(request_end,(Result,Normal,Elapsed,Num,Bindings),Vars):-!, 
                  (isMooOption(Agent,client=html) -> 
                     ((    
                       (toMarkUp(leml,note('user',logicEngine,Result,(Result,Normal,Elapsed,Num,Bindings)),Vars,Chars),once((var(Chars);write(Chars)))),
                       writeFmt('<Summary result="~w" solutions="~d" bindings="~d" cpu="~f"/>\n</Answer>\n',[Result,Num,Bindings,Elapsed]),
                       le_pull('Answer')
                     ));
                       writeFmt('\n%%  ~w solutions="~d" bindings="~d" cpu="~f"\n',[Result,Num,Bindings,Elapsed])).

writeCycEvent(Class,Message,Vars):-not(isMooOption(Agent,client=html)),!, toMarkUp(cycl,[Class,Message],Vars,Chars),write(Chars),nl.
writeCycEvent(Class,Message,Vars):-isMooOption(Agent,client=html),!, event_to_chars(leml,Class,_Message,Vars,Chars),write(Chars),nl.
writeCycEvent(cb_consultation, assertion([PredicateI|ConsultTemplate],_Context_atom,_SN), continue):- 
               agentConsultation(_Context_atom,[PredicateI|ConsultTemplate], _ListOfGafsAsserted).
writeCycEvent(_,_,_):-!.

                                                         */
/*
Where the parameters are some string syntax or other straightforward data
structure and we've used I to signify a parameter that is used by the
function and O to signify a parameter that is returned by the
function.  If that were forall it had, we think that is sufficient for
the bulk of interactions.  Everything else is helpful but not strictly
essential.  Because of that, we believe that it is possible to run
our system with just the above commands after startup.

   We have shown a number of features implemented such as

  - explaination trees
  - belief execution time and search controls
  - compilation
  - consultation mode

The expanded API is
*/          
%=================================================================
%  CONSULTATION MANAGEMENT DIRECTIVES
%=================================================================

/*
where the xxxNative versions take the disp_modification WFSform and the other
versions take STANDARD.  Consultation mode has a cycl default interface too:
*/



/* ; where the list is of arguments
missing that is requested from the user.  The default is to ask for
any and forall arguments that are missing

%TODO

ua_consultationModeEvery() ; ask the user for as many inputs as he's willing

to give
etc. ; other modes...

A further expansion to handle communication with a user agent external to
Prolog would add a message sent to a socket that process is listening to.
and a message string sent from Prolog to the user agent to request user input

"userInputRequest predicateName<cr>"

Where <cr> indicates a carriage return or some other suitable delimiter.

*/


% User Agent
:-dynamic_transparent('$MooOption'/3).
:-dynamic_transparent(saved_note/4).
:-dynamic_transparent(act_mem/3).


% ===========================================================
% THREAD SERVICE
% ===========================================================

% imports these models from SWI-Prolog
% thread_create(Goal,Id,Options)
% current_thread(Id,Status)
% thread_at_exit(Goal)
% thread_self(Id)
% thread_at_exit(Id,Goal)
% thread_join(Id,_)

/*
:-module(cyc_threads,
      [ 
      	 servantProcessCreate_p/1,
	 servantProcessCreate_p/3,
	 servantProcessCreate_p/4,
	 servantProcessCreate_p/5,
	 isCycProcess/2,
	 isCycProcess/5,
	 createProcessedGoal_p/1,
	 servantProcessSelfClean_p/0,
	 showCycStatisticsHTML/0,
	 cleanOldProcesses_p/0,
	 showCycProcessHTML/0]).
  */
% :-include('cyc_header.pl').

:-dynamic_transparent(isCycProcess/5).


createProcessedGoal(Goal):-
      servantProcessCreate((thread_at_exit((
	 (thread_self(Id),thread_exit(i_am_done(Id))))),Goal),Id,[]).


servantProcessCreate(Perms,Name,Goal,Id,Options):-
        thread_create((thread_at_exit(servantProcessSelfClean_p),Goal),Id,Options),
        asserta(isCycProcess(Perms,Name,Goal,Id,Options)).

servantProcessCreate(Name,Goal,Id,Options):-
        thread_create((thread_at_exit(servantProcessSelfClean_p),Goal),Id,Options),
        asserta(isCycProcess(killable,Name,Goal,Id,Options)).

servantProcessCreate(Goal,Id,Options):-
        thread_create((thread_at_exit(servantProcessSelfClean_p),Goal),Id,Options),
        asserta(isCycProcess(killable,thread(Id),Goal,Id,Options)).

servantProcessCreate(Goal):-servantProcessCreate(Goal,_Id,[global(0),local(0),trail(0)]),!.

isCycProcess(ID,Goal):-
        isCycProcess(_,_,Goal,ID,_).

debugProcess(T):-
	thread_signal(T, (attach_console, true)).


servantProcessSelfClean_p:-
      thread_self(Id),
      retractall(isCycProcess(_Perms,_Name,_Goal,Id,_Options)).




showCycStatisticsHTML:-
   writeFmt('<pre>'),prolog_statistics,
   threads,
   writeFmt('<br>'),
   writeFmt('</pre>').

showCycProcessHTML:-
        once(showCycStatisticsHTML),
        writeFmt('<hr><table border=1 width=80%><th>Id</th><th>Name</th><th>Status</th><th>Actions</th><th>Options</th><th>Goals</th>',[]),
        ignore((current_thread(Id,Status),
        isCycProcess(Perms,Name,Goal,Id,Options),
        once(writeCycProcessesHTML(Perms,Name,Goal,Id,Options,Status)),
        fail)),writeFmt('</table>',[]),!.


writeCycProcessesHTML(nokill,Name,Goal,Id,Options,Status):-
        writeFmt('<tr><td>~w</td><td><nobr>~w</td><td>~w</td><td>nokill</a></td><td>~w</td><td>~w</td><tr>\n ',[Id,Name,Status,Options,Goal]),!.

writeCycProcessesHTML(Perms,Name,Goal,Id,Options,Status):-
        writeFmt('<tr><td>~w</td><td><nobr>~w</td><td>~w</td><td><A href="controlpanel.jsp?killable=~w">Kill</a></td><td>~w</td><td>~w</td><tr>\n ',[Id,Name,Status,Id,Options,Goal]),!.

cleanOldProcesses_p:-
        saveUserInput,
        current_thread(Id,Status),
        handleProcessStatus(Id,Status),fail.
cleanOldProcesses_p:-writeSavedPrompt,!.
cleanOldProcesses_p:-!.

handleProcessStatus(Id,running):-!. %Normal
handleProcessStatus(Id,exited(complete)):-!,thread_join(Id,_),!.
handleProcessStatus(Id,true):-!, debugFmt('% Process ~w complete.\n',[Id]),!,thread_join(Id,_),!.
handleProcessStatus(Id,exception(Error)):-!, debugFmt('% Process ~w exited with exceptions: ~q \n',[Id,Error]),!. %,thread_join(Id,_),!.
handleProcessStatus(Id,O):-!, debugFmt('% Process ~w exited "~q". \n',[Id,O]),!,thread_join(Id,_),!.

mutex_call(Goal,Id):-
                        mutex_create(Id),
                        mutex_lock(Id),!,
                        with_mutex(Id,Goal),!,
                        mutex_unlock_all.



%:-defaultAssertMt(Mt),!,ensureMt(Mt),cycAssert('BaseKB':'#$genlMt'(Mt,'InferencePSC')). % Puts the defaultAssertMt/1 into Cyc 
%:-defaultAssertMt(Mt),ensureMt(Mt).



/*
% ===========================================================
% HTML
% ===========================================================

writeHTMLStdHeader(Title):-
   format('
   <html>
   <head>
   <meta http-equiv="Content-Language" content="en-us">
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <meta name="Keywords" content="PROLOG Artificial Intelligence Ontology AI MOO DARPA Douglas Miles">
   <meta name="Description" content="PROLOG Artificial Intelligence Ontology AI DARPA MOO">
   <title>MOO Engine - ~w</title>
   </head>
   <body>
          <a href="browse.moo">Browse</a> 
	    <a href="english.moo">English</a>
	    <a href="cycl.moo">CycL</a>
	    <a href="subl.moo">SubLisp</a>
	    <a href="daml.moo">Daml</a>
	    <a href="wn.moo">WordNet</a>
	    <a href="cycml.moo">CycML</a>
	    <a href="prolog.moo">Prolog</a>
	    <a href="settings.moo">Settings</a>
	    <a href="system.moo">System</a>
	    <a href="help.moo">Help</a>
	  <br><font size=+1>Create/Edit</font>
	   <a href="predicate.moo">Predicate</a>
	   <a href="function.moo">Function</a>
	   <a href="collection.moo">Collection</a>
	   <a href="microtheory.moo">Microtheory</a>
	  <font size=+1>Tests</font>
	   <a href="inference_tests.moo">Inference</a><br>
       <br><font size=+1 color=green><b>~w</b></font><br>
   ',[Title,Title]).

writeHTMLStdFooter:-
   format('
   </body>
   </html>',[X]).



 
clauseForVirtual(Predicate/Arity,Head):-functor(Head,Predicate,Arity),!.
clauseForVirtual(Predicate,Predicate).
clauseForVirtual(Predicate,Call):-not(atom(Predicate)),!.
clauseForVirtual(Term,asserted(Data,Mt,Vars,List)):-asserted(Data,Mt,Vars,List),once(memberchk(Term,List)).
clauseForVirtual(Predicate,Call):-Call=..[Predicate,_].
clauseForVirtual(Predicate,Call):-Call=..[Predicate,_,_].
clauseForVirtual(Predicate,Call):-Call=..[Predicate,_,_,_].
clauseForVirtual(Predicate,Call):-Call=..[Predicate,_,_,_,_].

getClauseDB(saved(Data,Mt,Vars,List),saved(Data,Mt,Vars,List)):-!.
getClauseDB(Head,imported_from(X,Head)):-predicate_property(Head,imported_from(X)).
getClauseDB(Head,implimentedInCode(Head)):-predicate_property(Head,built_in),!.
getClauseDB(Head,implimentedInCode(Head)):-predicate_property(Head,foreign),!.
getClauseDB(Head,entails(VirtualClauses,Head)):-clause(Head,VirtualClauses).


htmlListing(Predicate):-
      format('<pre>'),
      clauseForVirtual(Predicate,Head),
      getClauseDB(Head,VirtualClauses),
      writeHtml(VirtualClauses),fail.

htmlListing(Predicate):-
      make,
      format('~nEnd of Clauses with ~w</pre>',[Predicate]),!.

writeHtml(linkEach([])):-!.
writeHtml(linkEach([H|T])):-writeHtml(linkFor(H)),
      writeHtml(nl),writeHtml(linkEach(T)).
writeHtml(nl):-format('<br>').

writeHtml(linkFor(H)):-
	 my_www_form_encode(H,E),
	 format('<A href="browse.moo?find=~w">~w</A>',[E,H]).
%writeHtml((H:-T)):-!,writeHtml(prologEntails(T,H)).      
writeHtml(Clauses):-
        flag(indent,_,0),
      numbervars(Clauses,0,_),%true,
      toCycApiExpression(html(Clauses),[],O),!,
      format('~w~n',[O]).

my_www_form_encode(X,Y):-www_form_encode(X,Y).


writeHyperLink(NameFmt,NameArgs,UrlFmt,UlrArgs):-
      format('<a href="'),format(UrlFmt,UlrArgs),
      format('">'),format(NameFmt,NameArgs),format('</a>'),!.

writeCheckbox(Name,Text,Default):-
      getMooOption(Agent,Name=Default,Value),
      valueToCheckMark(Value,OnOff,More),
      format('<label for="~w"><input id="~w" type="checkbox" name="~w" value="~w" ~w>~w</label>',[Name,Name,Name,OnOff,More,Text]).

writeSpaces(N):-not(number(N)),!.
writeSpaces(N):-N<1,!.
writeSpaces(N):-format('&nbsp;'),NN is N-1,writeSpaces(NN),!.


valueToCheckMark(Value,'ON','CHECKED'):-memberchk(Value,['ON',yes,true,'TT','T','True','Yes']).
valueToCheckMark(Value,'OFF',' ').
*/

:-set_prolog_flag(double_quotes,string).

:-[plnarts].
:-[plconstants].
%:-[asserted].
%:-[plassertions].
%:-ensureCycCallsProlog.

/*

(#$implies 
  (#$and 
    (#$natFunction ?PARTITION #$ThePartition) 
    (#$partitionedInto ?COL ?PARTITION) 
    (#$elementOf ?SPEC  (#$FormulaArgSetFn ?PARTITION))
    (#$elementOf ?SPEC2 (#$FormulaArgSetFn ?PARTITION))

  (#$different ?SPEC ?SPEC2)) 
  (#$disjointWith ?SPEC ?COL))  
*/



