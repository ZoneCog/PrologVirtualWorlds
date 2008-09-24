package jp.ac.kobe_u.cs.prolog.builtin;
import jp.ac.kobe_u.cs.prolog.lang.*;
/*
 This file is generated by Prolog Cafe.
 PLEASE DO NOT EDIT!
*/
/**
 <code>'$sort'/4</code> defined in builtins.pl<br>
 @author Mutsunori Banbara (banbara@kobe-u.ac.jp)
 @author Naoyuki Tamura (tamura@kobe-u.ac.jp)
 @author Douglas R. Miles (dmiles@users.sourceforge.net) for Object(s) 
 @version 1.0-dmiles
*/
class PRED_$sort_4 extends PredicateBase {
    static /*Symbol*/Object s1 = makeAtom("[]");
    static Predicate _fail_0 = new PRED_fail_0();
    static Predicate _$sort_4_var = new PRED_$sort_4_var();
    static Predicate _$sort_4_var_1 = new PRED_$sort_4_var_1();
    static Predicate _$sort_4_var_2 = new PRED_$sort_4_var_2();
    static Predicate _$sort_4_lis = new PRED_$sort_4_lis();
    static Predicate _$sort_4_lis_1 = new PRED_$sort_4_lis_1();
    static Predicate _$sort_4_1 = new PRED_$sort_4_1();
    static Predicate _$sort_4_2 = new PRED_$sort_4_2();
    static Predicate _$sort_4_3 = new PRED_$sort_4_3();

    public Object arg1, arg2, arg3, arg4;

    public PRED_$sort_4(Object a1, Object a2, Object a3, Object a4, Predicate cont) {
        arg1 = a1;
        arg2 = a2;
        arg3 = a3;
        arg4 = a4;
        this.cont = cont;
    }

    public PRED_$sort_4(){}

    public void setArgument(Object[] args, Predicate cont) {
        arg1 = args[0];
        arg2 = args[1];
        arg3 = args[2];
        arg4 = args[3];
        this.cont = cont;
    }

    public int arity() { return 4; }

    public String nameUQ() { return "$sort"; }

    public void sArg(int i0, Object val) {  switch (i0) {         case 0: arg1 = val;break ;
         case 1: arg2 = val;break ;
         case 2: arg3 = val;break ;
         case 3: arg4 = val;break ;
default: newIndexOutOfBoundsException("setarg" , i0 , val);  }   }


    public Object gArg(int i0) {  switch (i0) {         case 0: return arg1;
         case 1: return arg2;
         case 2: return arg3;
         case 3: return arg4;
default: return newIndexOutOfBoundsException("getarg", i0,null);  }   }


    public String toPrologString(java.util.Collection newParam) {
        return "'$sort'(" + argString(arg1,newParam) + "," + argString(arg2,newParam) + "," + argString(arg3,newParam) + "," + argString(arg4,newParam) + ")";
    }

    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); 
        engine_aregs[1] = arg1;
        engine_aregs[2] = arg2;
        engine_aregs[3] = arg3;
        engine_aregs[4] = arg4;
        engine.cont = cont;
        engine.setB0();
        return engine.switch_on_term(_$sort_4_var, _fail_0, _fail_0, _$sort_4_1, _fail_0, _$sort_4_lis);
    }
}

class PRED_$sort_4_var extends PRED_$sort_4 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
        return engine.jtry(_$sort_4_1, _$sort_4_var_1);
    }
}

class PRED_$sort_4_var_1 extends PRED_$sort_4 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
        return engine.retry(_$sort_4_2, _$sort_4_var_2);
    }
}

class PRED_$sort_4_var_2 extends PRED_$sort_4 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
        return engine.trust(_$sort_4_3);
    }
}

class PRED_$sort_4_lis extends PRED_$sort_4 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
        return engine.jtry(_$sort_4_2, _$sort_4_lis_1);
    }
}

class PRED_$sort_4_lis_1 extends PRED_$sort_4 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
        return engine.trust(_$sort_4_3);
    }
}

class PRED_$sort_4_1 extends PRED_$sort_4 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
    // '$sort'([], [], A, B):-true
        Object a1, a2, a3, a4;
        Predicate cont;
        a1 = engine_aregs[1];
        a2 = engine_aregs[2];
        a3 = engine_aregs[3];
        a4 = engine_aregs[4];
        cont = engine.cont;
    // '$sort'([], [], A, B):-[]
        a1 = deref( a1);
        if (isAtomTerm(a1)){
            if (! prologEquals(a1,s1))
                return fail(engine);
        } else if (isVariable(a1)){
             bind(/*VAR*/ a1,s1);
        } else {
            return fail(engine);
        }
        a2 = deref( a2);
        if (isAtomTerm(a2)){
            if (! prologEquals(a2,s1))
                return fail(engine);
        } else if (isVariable(a2)){
             bind(/*VAR*/ a2,s1);
        } else {
            return fail(engine);
        }
        return exit(engine,cont);
    }
}

class PRED_$sort_4_2 extends PRED_$sort_4 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
    // '$sort'([A], [A], B, C):-true
        Object a1, a2, a3, a4, a5;
        Predicate cont;
        a1 = engine_aregs[1];
        a2 = engine_aregs[2];
        a3 = engine_aregs[3];
        a4 = engine_aregs[4];
        cont = engine.cont;
    // '$sort'([A], [A], B, C):-[]
        a1 = deref( a1);
        if (isListTerm(a1)){
            Object[] args = consArgs(a1);
            a5 = args[0];
            if (!unify( s1,args[1]))
                return fail(engine);
        } else if (isVariable(a1)){
            a5 = engine.makeVariable(this);
             bind(a1,makeList(a5, s1));
        } else {
            return fail(engine);
        }
        a2 = deref( a2);
        if (isListTerm(a2)){
            Object[] args = consArgs(a2);
            if (!unify( a5,args[0]))
                return fail(engine);
            if (!unify( s1,args[1]))
                return fail(engine);
        } else if (isVariable(a2)){
             bind(a2,makeList(a5, s1));
        } else {
            return fail(engine);
        }
        return exit(engine,cont);
    }
}

class PRED_$sort_4_3 extends PRED_$sort_4 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
    // '$sort'([A, B|C], D, E, F):-'$halve'(C, [B|C], G, H), '$sort'([A|G], I, E, F), '$sort'(H, J, E, F), '$merge'(I, J, D, E, F)
        Object a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14;
        Predicate p1, p2, p3;
        Predicate cont;
        a1 = engine_aregs[1];
        a2 = engine_aregs[2];
        a3 = engine_aregs[3];
        a4 = engine_aregs[4];
        cont = engine.cont;
    // '$sort'([A, B|C], D, E, F):-['$halve'(C, [B|C], G, H), '$sort'([A|G], I, E, F), '$sort'(H, J, E, F), '$merge'(I, J, D, E, F)]
        a1 = deref( a1);
        if (isListTerm(a1)){
            Object[] args = consArgs(a1);
            a5 = args[0];
            a6 = args[1];
        } else if (isVariable(a1)){
            a5 = engine.makeVariable(this);
            a6 = engine.makeVariable(this);
             bind(a1,makeList(a5, a6));
        } else {
            return fail(engine);
        }
        a6 = deref( a6);
        if (isListTerm(a6)){
            Object[] args = consArgs(a6);
            a7 = args[0];
            a8 = args[1];
        } else if (isVariable(a6)){
            a7 = engine.makeVariable(this);
            a8 = engine.makeVariable(this);
             bind(a6,makeList(a7, a8));
        } else {
            return fail(engine);
        }
        a9 = makeList(a7, a8);
        a10 = engine.makeVariable(this);
        a11 = engine.makeVariable(this);
        a12 = makeList(a5, a10);
        a13 = engine.makeVariable(this);
        a14 = engine.makeVariable(this);
        p1 = new PRED_$merge_5(a13, a14, a2, a3, a4, cont);
        p2 = new PRED_$sort_4(a11, a14, a3, a4, p1);
        p3 = new PRED_$sort_4(a12, a13, a3, a4, p2);
        return exit(engine, new PRED_$halve_4(a8, a9, a10, a11, p3));
    }
}
