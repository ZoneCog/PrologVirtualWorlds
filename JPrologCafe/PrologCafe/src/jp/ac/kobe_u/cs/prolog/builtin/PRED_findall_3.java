package jp.ac.kobe_u.cs.prolog.builtin;
import jp.ac.kobe_u.cs.prolog.lang.*;
/*
 This file is generated by Prolog Cafe.
 PLEASE DO NOT EDIT!
*/
/**
 <code>findall/3</code> defined in builtins.pl<br>
 @author Mutsunori Banbara (banbara@kobe-u.ac.jp)
 @author Naoyuki Tamura (tamura@kobe-u.ac.jp)
 @author Douglas R. Miles (dmiles@users.sourceforge.net) for Object(s) 
 @version 1.0-dmiles
*/
public class PRED_findall_3 extends PredicateBase {
    static /*Symbol*/Object s1 = makeAtom("type", 1);
    static /*Symbol*/Object s2 = makeAtom("callable");
    static Object[] s3 = {s2};
    static /*Structure*/Object s4 = makeStructure(s1, s3);
    static /*Symbol*/Object s5 = makeAtom("findall", 3);
    static /*IntegerTerm*/Object si6 = makeInteger(2);
    static Predicate _findall_3_sub_1 = new PRED_findall_3_sub_1();
    static Predicate _findall_3_1 = new PRED_findall_3_1();
    static Predicate _findall_3_2 = new PRED_findall_3_2();

    public Object arg1, arg2, arg3;

    public PRED_findall_3(Object a1, Object a2, Object a3, Predicate cont) {
        arg1 = a1;
        arg2 = a2;
        arg3 = a3;
        this.cont = cont;
    }

    public PRED_findall_3(){}

    public void setArgument(Object[] args, Predicate cont) {
        arg1 = args[0];
        arg2 = args[1];
        arg3 = args[2];
        this.cont = cont;
    }

    public int arity() { return 3; }

    public String nameUQ() { return "findall"; }

    public void sArg(int i0, Object val) {  switch (i0) {         case 0: arg1 = val;break ;
         case 1: arg2 = val;break ;
         case 2: arg3 = val;break ;
default: newIndexOutOfBoundsException("setarg" , i0 , val);  }   }


    public Object gArg(int i0) {  switch (i0) {         case 0: return arg1;
         case 1: return arg2;
         case 2: return arg3;
default: return newIndexOutOfBoundsException("getarg", i0,null);  }   }


    public String toPrologString(java.util.Collection newParam) {
        return "'findall'(" + argString(arg1,newParam) + "," + argString(arg2,newParam) + "," + argString(arg3,newParam) + ")";
    }

    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); 
        engine_aregs[1] = arg1;
        engine_aregs[2] = arg2;
        engine_aregs[3] = arg3;
        engine.cont = cont;
        engine.setB0();
        return engine.jtry(_findall_3_1, _findall_3_sub_1);
    }
}

class PRED_findall_3_sub_1 extends PRED_findall_3 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
        return engine.trust(_findall_3_2);
    }
}

class PRED_findall_3_1 extends PRED_findall_3 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
    // findall(A, B, C):-callable(B), !, new_hash(D), '$findall'(D, A, B, C)
        Object a1, a2, a3, a4, a5;
        Predicate p1, p2, p3;
        Predicate cont;
        a1 = engine_aregs[1];
        a2 = engine_aregs[2];
        a3 = engine_aregs[3];
        cont = engine.cont;
    // findall(A, B, C):-['$get_level'(D), callable(B), '$cut'(D), new_hash(E), '$findall'(E, A, B, C)]
        a4 = engine.makeVariable(this);
        //START inline expansion of $get_level(a(4))
        if (! unify(a4,makeInteger(engine.B0))) {
            return fail(engine);
        }
        //END inline expansion
        a5 = engine.makeVariable(this);
        p1 = new PRED_$findall_4(a5, a1, a2, a3, cont);
        p2 = new PRED_new_hash_1(a5, p1);
        p3 = new PRED_$cut_1(a4, p2);
        return exit(engine, new PRED_callable_1(a2, p3));
    }
}

class PRED_findall_3_2 extends PRED_findall_3 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
    // findall(A, B, C):-illarg(type(callable), findall(A, B, C), 2)
        Object a1, a2, a3, a4;
        Predicate cont;
        a1 = engine_aregs[1];
        a2 = engine_aregs[2];
        a3 = engine_aregs[3];
        cont = engine.cont;
    // findall(A, B, C):-[illarg(type(callable), findall(A, B, C), 2)]
        Object[] y1 = {a1, a2, a3};
        a4 = makeStructure(s5, y1);
        return exit(engine, new PRED_illarg_3(s4, a4, si6, cont));
    }
}
