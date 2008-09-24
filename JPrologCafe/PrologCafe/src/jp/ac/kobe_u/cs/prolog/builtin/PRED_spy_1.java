package jp.ac.kobe_u.cs.prolog.builtin;
import jp.ac.kobe_u.cs.prolog.lang.*;
/*
 This file is generated by Prolog Cafe.
 PLEASE DO NOT EDIT!
*/
/**
 <code>spy/1</code> defined in builtins.pl<br>
 @author Mutsunori Banbara (banbara@kobe-u.ac.jp)
 @author Naoyuki Tamura (tamura@kobe-u.ac.jp)
 @author Douglas R. Miles (dmiles@users.sourceforge.net) for Object(s) 
 @version 1.0-dmiles
*/
public class PRED_spy_1 extends PredicateBase {
    static /*Symbol*/Object s1 = makeAtom("spy", 1);
    static /*Symbol*/Object s2 = makeAtom("leap");
    static /*Symbol*/Object s3 = makeAtom("yes");

    public Object arg1;

    public PRED_spy_1(Object a1, Predicate cont) {
        arg1 = a1;
        this.cont = cont;
    }

    public PRED_spy_1(){}

    public void setArgument(Object[] args, Predicate cont) {
        arg1 = args[0];
        this.cont = cont;
    }

    public int arity() { return 1; }

    public String nameUQ() { return "spy"; }

    public void sArg(int i0, Object val) {  switch (i0) {         case 0: arg1 = val;break ;
default: newIndexOutOfBoundsException("setarg" , i0 , val);  }   }


    public Object gArg(int i0) {  switch (i0) {         case 0: return arg1;
default: return newIndexOutOfBoundsException("getarg", i0,null);  }   }


    public String toPrologString(java.util.Collection newParam) {
        return "'spy'(" + argString(arg1,newParam) + ")";
    }

    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); 
    // spy(A):-'$term_to_predicateindicator'(A, B, spy(A)), trace, '$assert_spypoint'(B), '$set_debug_flag'(leap, yes), !
        engine.setB0();
        Object a1, a2, a3, a4;
        Predicate p1, p2, p3, p4;
        a1 = arg1;
    // spy(A):-['$get_level'(B), '$term_to_predicateindicator'(A, C, spy(A)), trace, '$assert_spypoint'(C), '$set_debug_flag'(leap, yes), '$cut'(B)]
        a2 = engine.makeVariable(this);
        //START inline expansion of $get_level(a(2))
        if (! unify(a2,makeInteger(engine.B0))) {
            return fail(engine);
        }
        //END inline expansion
        a3 = engine.makeVariable(this);
        Object[] y1 = {a1};
        a4 = makeStructure(s1, y1);
        p1 = new PRED_$cut_1(a2, cont);
        p2 = new PRED_$set_debug_flag_2(s2, s3, p1);
        p3 = new PRED_$assert_spypoint_1(a3, p2);
        p4 = new PRED_trace_0(p3);
        return exit(engine, new PRED_$term_to_predicateindicator_3(a1, a3, a4, p4));
    }
}
