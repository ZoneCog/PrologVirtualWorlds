package jp.ac.kobe_u.cs.prolog.builtin;
import jp.ac.kobe_u.cs.prolog.lang.*;
/*
 This file is generated by Prolog Cafe.
 PLEASE DO NOT EDIT!
*/
/**
 <code>length/2</code> defined in builtins.pl<br>
 @author Mutsunori Banbara (banbara@kobe-u.ac.jp)
 @author Naoyuki Tamura (tamura@kobe-u.ac.jp)
 @author Douglas R. Miles (dmiles@users.sourceforge.net) for Object(s) 
 @version 1.0-dmiles
*/
public class PRED_length_2 extends PredicateBase {
    static /*IntegerTerm*/Object si1 = makeInteger(0);
    static Predicate _length_2_sub_1 = new PRED_length_2_sub_1();
    static Predicate _length_2_1 = new PRED_length_2_1();
    static Predicate _length_2_2 = new PRED_length_2_2();

    public Object arg1, arg2;

    public PRED_length_2(Object a1, Object a2, Predicate cont) {
        arg1 = a1;
        arg2 = a2;
        this.cont = cont;
    }

    public PRED_length_2(){}

    public void setArgument(Object[] args, Predicate cont) {
        arg1 = args[0];
        arg2 = args[1];
        this.cont = cont;
    }

    public int arity() { return 2; }

    public String nameUQ() { return "length"; }

    public void sArg(int i0, Object val) {  switch (i0) {         case 0: arg1 = val;break ;
         case 1: arg2 = val;break ;
default: newIndexOutOfBoundsException("setarg" , i0 , val);  }   }


    public Object gArg(int i0) {  switch (i0) {         case 0: return arg1;
         case 1: return arg2;
default: return newIndexOutOfBoundsException("getarg", i0,null);  }   }


    public String toPrologString(java.util.Collection newParam) {
        return "'length'(" + argString(arg1,newParam) + "," + argString(arg2,newParam) + ")";
    }

    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); 
        engine_aregs[1] = arg1;
        engine_aregs[2] = arg2;
        engine.cont = cont;
        engine.setB0();
        return engine.jtry(_length_2_1, _length_2_sub_1);
    }
}

class PRED_length_2_sub_1 extends PRED_length_2 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
        return engine.trust(_length_2_2);
    }
}

class PRED_length_2_1 extends PRED_length_2 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
    // length(A, B):-var(B), !, '$length'(A, 0, B)
        Object a1, a2, a3;
        Predicate cont;
        a1 = engine_aregs[1];
        a2 = engine_aregs[2];
        cont = engine.cont;
    // length(A, B):-['$get_level'(C), var(B), '$cut'(C), '$length'(A, 0, B)]
        a3 = engine.makeVariable(this);
        //START inline expansion of $get_level(a(3))
        if (! unify(a3,makeInteger(engine.B0))) {
            return fail(engine);
        }
        //END inline expansion
        //START inline expansion of var(a(2))
        a2 = deref( a2);
        if (! isVariable(a2)) {
            return fail(engine);
        }
        //END inline expansion
        //START inline expansion of $cut(a(3))
        a3 = deref( a3);
        if (! isCutter/*Integer*/(a3)) {
            throw new IllegalTypeException("integer", a3);
        } else {
            engine.cut(( a3));
        }
        //END inline expansion
        return exit(engine, new PRED_$length_3(a1, si1, a2, cont));
    }
}

class PRED_length_2_2 extends PRED_length_2 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
    // length(A, B):-'$dlength'(A, 0, B)
        Object a1, a2;
        Predicate cont;
        a1 = engine_aregs[1];
        a2 = engine_aregs[2];
        cont = engine.cont;
    // length(A, B):-['$dlength'(A, 0, B)]
        return exit(engine, new PRED_$dlength_3(a1, si1, a2, cont));
    }
}
