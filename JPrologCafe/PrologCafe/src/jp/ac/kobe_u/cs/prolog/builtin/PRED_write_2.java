package jp.ac.kobe_u.cs.prolog.builtin;
import jp.ac.kobe_u.cs.prolog.lang.*;
/*
 This file is generated by Prolog Cafe.
 PLEASE DO NOT EDIT!
*/
/**
 <code>write/2</code> defined in builtins.pl<br>
 @author Mutsunori Banbara (banbara@kobe-u.ac.jp)
 @author Naoyuki Tamura (tamura@kobe-u.ac.jp)
 @author Douglas R. Miles (dmiles@users.sourceforge.net) for Object(s) 
 @version 1.0-dmiles
*/
public class PRED_write_2 extends PredicateBase {
    static /*Symbol*/Object s1 = makeAtom("numbervars", 1);
    static /*Symbol*/Object s2 = makeAtom("true");
    static Object[] s3 = {s2};
    static /*Structure*/Object s4 = makeStructure(s1, s3);
    static /*Symbol*/Object s5 = makeAtom("[]");
    static /*List*/Object s6 = makeList(s4, s5);

    public Object arg1, arg2;

    public PRED_write_2(Object a1, Object a2, Predicate cont) {
        arg1 = a1;
        arg2 = a2;
        this.cont = cont;
    }

    public PRED_write_2(){}

    public void setArgument(Object[] args, Predicate cont) {
        arg1 = args[0];
        arg2 = args[1];
        this.cont = cont;
    }

    public int arity() { return 2; }

    public String nameUQ() { return "write"; }

    public void sArg(int i0, Object val) {  switch (i0) {         case 0: arg1 = val;break ;
         case 1: arg2 = val;break ;
default: newIndexOutOfBoundsException("setarg" , i0 , val);  }   }


    public Object gArg(int i0) {  switch (i0) {         case 0: return arg1;
         case 1: return arg2;
default: return newIndexOutOfBoundsException("getarg", i0,null);  }   }


    public String toPrologString(java.util.Collection newParam) {
        return "'write'(" + argString(arg1,newParam) + "," + argString(arg2,newParam) + ")";
    }

    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); 
    // write(A, B):-write_term(A, B, [numbervars(true)])
        engine.setB0();
        Object a1, a2;
        a1 = arg1;
        a2 = arg2;
    // write(A, B):-[write_term(A, B, [numbervars(true)])]
        return exit(engine, new PRED_write_term_3(a1, a2, s6, cont));
    }
}
