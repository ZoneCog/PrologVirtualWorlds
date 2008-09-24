package jp.ac.kobe_u.cs.prolog.builtin;
import jp.ac.kobe_u.cs.prolog.lang.*;
/*
 This file is generated by Prolog Cafe.
 PLEASE DO NOT EDIT!
*/
/**
 <code>'$builtin_meta_predicates'/3</code> defined in builtins.pl<br>
 @author Mutsunori Banbara (banbara@kobe-u.ac.jp)
 @author Naoyuki Tamura (tamura@kobe-u.ac.jp)
 @author Douglas R. Miles (dmiles@users.sourceforge.net) for Object(s) 
 @version 1.0-dmiles
*/
class PRED_$builtin_meta_predicates_3 extends PredicateBase {
    static /*Symbol*/Object s1 = makeAtom("^");
    static /*IntegerTerm*/Object si2 = makeInteger(2);
    static /*Symbol*/Object s3 = makeAtom("?");
    static /*Symbol*/Object s4 = makeAtom(":");
    static /*Symbol*/Object s5 = makeAtom("[]");
    static /*List*/Object s6 = makeList(s4, s5);
    static /*List*/Object s7 = makeList(s3, s6);
    static /*Symbol*/Object s8 = makeAtom("call");
    static /*IntegerTerm*/Object si9 = makeInteger(1);
    static /*Symbol*/Object s10 = makeAtom("once");
    static /*Symbol*/Object s11 = makeAtom("\\+");
    static /*Symbol*/Object s12 = makeAtom("findall");
    static /*IntegerTerm*/Object si13 = makeInteger(3);
    static /*List*/Object s14 = makeList(s3, s5);
    static /*List*/Object s15 = makeList(s4, s14);
    static /*List*/Object s16 = makeList(s3, s15);
    static /*Symbol*/Object s17 = makeAtom("setof");
    static /*Symbol*/Object s18 = makeAtom("bagof");
    static /*Symbol*/Object s19 = makeAtom("on_exception");
    static /*List*/Object s20 = makeList(s4, s6);
    static /*List*/Object s21 = makeList(s3, s20);
    static /*Symbol*/Object s22 = makeAtom("catch");
    static /*List*/Object s23 = makeList(s4, s7);
    static /*Symbol*/Object s24 = makeAtom("synchronized");
    static /*Symbol*/Object s25 = makeAtom("freeze");
    static Predicate _fail_0 = new PRED_fail_0();
    static Predicate _$builtin_meta_predicates_3_var = new PRED_$builtin_meta_predicates_3_var();
    static Predicate _$builtin_meta_predicates_3_var_1 = new PRED_$builtin_meta_predicates_3_var_1();
    static Predicate _$builtin_meta_predicates_3_var_2 = new PRED_$builtin_meta_predicates_3_var_2();
    static Predicate _$builtin_meta_predicates_3_var_3 = new PRED_$builtin_meta_predicates_3_var_3();
    static Predicate _$builtin_meta_predicates_3_var_4 = new PRED_$builtin_meta_predicates_3_var_4();
    static Predicate _$builtin_meta_predicates_3_var_5 = new PRED_$builtin_meta_predicates_3_var_5();
    static Predicate _$builtin_meta_predicates_3_var_6 = new PRED_$builtin_meta_predicates_3_var_6();
    static Predicate _$builtin_meta_predicates_3_var_7 = new PRED_$builtin_meta_predicates_3_var_7();
    static Predicate _$builtin_meta_predicates_3_var_8 = new PRED_$builtin_meta_predicates_3_var_8();
    static Predicate _$builtin_meta_predicates_3_var_9 = new PRED_$builtin_meta_predicates_3_var_9();
    static Predicate _$builtin_meta_predicates_3_var_10 = new PRED_$builtin_meta_predicates_3_var_10();
    static Predicate _$builtin_meta_predicates_3_con = new PRED_$builtin_meta_predicates_3_con();
    static Predicate _$builtin_meta_predicates_3_1 = new PRED_$builtin_meta_predicates_3_1();
    static Predicate _$builtin_meta_predicates_3_2 = new PRED_$builtin_meta_predicates_3_2();
    static Predicate _$builtin_meta_predicates_3_3 = new PRED_$builtin_meta_predicates_3_3();
    static Predicate _$builtin_meta_predicates_3_4 = new PRED_$builtin_meta_predicates_3_4();
    static Predicate _$builtin_meta_predicates_3_5 = new PRED_$builtin_meta_predicates_3_5();
    static Predicate _$builtin_meta_predicates_3_6 = new PRED_$builtin_meta_predicates_3_6();
    static Predicate _$builtin_meta_predicates_3_7 = new PRED_$builtin_meta_predicates_3_7();
    static Predicate _$builtin_meta_predicates_3_8 = new PRED_$builtin_meta_predicates_3_8();
    static Predicate _$builtin_meta_predicates_3_9 = new PRED_$builtin_meta_predicates_3_9();
    static Predicate _$builtin_meta_predicates_3_10 = new PRED_$builtin_meta_predicates_3_10();
    static Predicate _$builtin_meta_predicates_3_11 = new PRED_$builtin_meta_predicates_3_11();
    static HashtableOfTerm<Predicate> con = new HashtableOfTerm<Predicate>(11);
    static {
        con.put(s1, _$builtin_meta_predicates_3_1);
        con.put(s8, _$builtin_meta_predicates_3_2);
        con.put(s10, _$builtin_meta_predicates_3_3);
        con.put(s11, _$builtin_meta_predicates_3_4);
        con.put(s12, _$builtin_meta_predicates_3_5);
        con.put(s17, _$builtin_meta_predicates_3_6);
        con.put(s18, _$builtin_meta_predicates_3_7);
        con.put(s19, _$builtin_meta_predicates_3_8);
        con.put(s22, _$builtin_meta_predicates_3_9);
        con.put(s24, _$builtin_meta_predicates_3_10);
        con.put(s25, _$builtin_meta_predicates_3_11);
    }

    public Object arg1, arg2, arg3;

    public PRED_$builtin_meta_predicates_3(Object a1, Object a2, Object a3, Predicate cont) {
        arg1 = a1;
        arg2 = a2;
        arg3 = a3;
        this.cont = cont;
    }

    public PRED_$builtin_meta_predicates_3(){}

    public void setArgument(Object[] args, Predicate cont) {
        arg1 = args[0];
        arg2 = args[1];
        arg3 = args[2];
        this.cont = cont;
    }

    public int arity() { return 3; }

    public String nameUQ() { return "$builtin_meta_predicates"; }

    public void sArg(int i0, Object val) {  switch (i0) {         case 0: arg1 = val;break ;
         case 1: arg2 = val;break ;
         case 2: arg3 = val;break ;
default: newIndexOutOfBoundsException("setarg" , i0 , val);  }   }


    public Object gArg(int i0) {  switch (i0) {         case 0: return arg1;
         case 1: return arg2;
         case 2: return arg3;
default: return newIndexOutOfBoundsException("getarg", i0,null);  }   }


    public String toPrologString(java.util.Collection newParam) {
        return "'$builtin_meta_predicates'(" + argString(arg1,newParam) + "," + argString(arg2,newParam) + "," + argString(arg3,newParam) + ")";
    }

    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); 
        engine_aregs[1] = arg1;
        engine_aregs[2] = arg2;
        engine_aregs[3] = arg3;
        engine.cont = cont;
        engine.setB0();
        return engine.switch_on_term(_$builtin_meta_predicates_3_var, _fail_0, _fail_0, _$builtin_meta_predicates_3_con, _fail_0, _fail_0);
    }
}

class PRED_$builtin_meta_predicates_3_var extends PRED_$builtin_meta_predicates_3 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
        return engine.jtry(_$builtin_meta_predicates_3_1, _$builtin_meta_predicates_3_var_1);
    }
}

class PRED_$builtin_meta_predicates_3_var_1 extends PRED_$builtin_meta_predicates_3 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
        return engine.retry(_$builtin_meta_predicates_3_2, _$builtin_meta_predicates_3_var_2);
    }
}

class PRED_$builtin_meta_predicates_3_var_2 extends PRED_$builtin_meta_predicates_3 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
        return engine.retry(_$builtin_meta_predicates_3_3, _$builtin_meta_predicates_3_var_3);
    }
}

class PRED_$builtin_meta_predicates_3_var_3 extends PRED_$builtin_meta_predicates_3 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
        return engine.retry(_$builtin_meta_predicates_3_4, _$builtin_meta_predicates_3_var_4);
    }
}

class PRED_$builtin_meta_predicates_3_var_4 extends PRED_$builtin_meta_predicates_3 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
        return engine.retry(_$builtin_meta_predicates_3_5, _$builtin_meta_predicates_3_var_5);
    }
}

class PRED_$builtin_meta_predicates_3_var_5 extends PRED_$builtin_meta_predicates_3 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
        return engine.retry(_$builtin_meta_predicates_3_6, _$builtin_meta_predicates_3_var_6);
    }
}

class PRED_$builtin_meta_predicates_3_var_6 extends PRED_$builtin_meta_predicates_3 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
        return engine.retry(_$builtin_meta_predicates_3_7, _$builtin_meta_predicates_3_var_7);
    }
}

class PRED_$builtin_meta_predicates_3_var_7 extends PRED_$builtin_meta_predicates_3 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
        return engine.retry(_$builtin_meta_predicates_3_8, _$builtin_meta_predicates_3_var_8);
    }
}

class PRED_$builtin_meta_predicates_3_var_8 extends PRED_$builtin_meta_predicates_3 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
        return engine.retry(_$builtin_meta_predicates_3_9, _$builtin_meta_predicates_3_var_9);
    }
}

class PRED_$builtin_meta_predicates_3_var_9 extends PRED_$builtin_meta_predicates_3 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
        return engine.retry(_$builtin_meta_predicates_3_10, _$builtin_meta_predicates_3_var_10);
    }
}

class PRED_$builtin_meta_predicates_3_var_10 extends PRED_$builtin_meta_predicates_3 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
        return engine.trust(_$builtin_meta_predicates_3_11);
    }
}

class PRED_$builtin_meta_predicates_3_con extends PRED_$builtin_meta_predicates_3 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
        return engine.switch_on_hash(con, _fail_0);
    }
}

class PRED_$builtin_meta_predicates_3_1 extends PRED_$builtin_meta_predicates_3 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
    // '$builtin_meta_predicates'(^, 2, [?, :]):-true
        Object a1, a2, a3;
        Predicate cont;
        a1 = engine_aregs[1];
        a2 = engine_aregs[2];
        a3 = engine_aregs[3];
        cont = engine.cont;
    // '$builtin_meta_predicates'(^, 2, [?, :]):-[]
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
        if (isInteger(a2)){
            if (intValue( a2) != 2)
                return fail(engine);
        } else if (isVariable(a2)){
            bind(/*VAR*/ a2,si2);
        } else {
            return fail(engine);
        }
        if (! unify(s7,a3))
            return fail(engine);
        return exit(engine,cont);
    }
}

class PRED_$builtin_meta_predicates_3_2 extends PRED_$builtin_meta_predicates_3 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
    // '$builtin_meta_predicates'(call, 1, [:]):-true
        Object a1, a2, a3;
        Predicate cont;
        a1 = engine_aregs[1];
        a2 = engine_aregs[2];
        a3 = engine_aregs[3];
        cont = engine.cont;
    // '$builtin_meta_predicates'(call, 1, [:]):-[]
        a1 = deref( a1);
        if (isAtomTerm(a1)){
            if (! prologEquals(a1,s8))
                return fail(engine);
        } else if (isVariable(a1)){
             bind(/*VAR*/ a1,s8);
        } else {
            return fail(engine);
        }
        a2 = deref( a2);
        if (isInteger(a2)){
            if (intValue( a2) != 1)
                return fail(engine);
        } else if (isVariable(a2)){
            bind(/*VAR*/ a2,si9);
        } else {
            return fail(engine);
        }
        if (! unify(s6,a3))
            return fail(engine);
        return exit(engine,cont);
    }
}

class PRED_$builtin_meta_predicates_3_3 extends PRED_$builtin_meta_predicates_3 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
    // '$builtin_meta_predicates'(once, 1, [:]):-true
        Object a1, a2, a3;
        Predicate cont;
        a1 = engine_aregs[1];
        a2 = engine_aregs[2];
        a3 = engine_aregs[3];
        cont = engine.cont;
    // '$builtin_meta_predicates'(once, 1, [:]):-[]
        a1 = deref( a1);
        if (isAtomTerm(a1)){
            if (! prologEquals(a1,s10))
                return fail(engine);
        } else if (isVariable(a1)){
             bind(/*VAR*/ a1,s10);
        } else {
            return fail(engine);
        }
        a2 = deref( a2);
        if (isInteger(a2)){
            if (intValue( a2) != 1)
                return fail(engine);
        } else if (isVariable(a2)){
            bind(/*VAR*/ a2,si9);
        } else {
            return fail(engine);
        }
        if (! unify(s6,a3))
            return fail(engine);
        return exit(engine,cont);
    }
}

class PRED_$builtin_meta_predicates_3_4 extends PRED_$builtin_meta_predicates_3 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
    // '$builtin_meta_predicates'(\+, 1, [:]):-true
        Object a1, a2, a3;
        Predicate cont;
        a1 = engine_aregs[1];
        a2 = engine_aregs[2];
        a3 = engine_aregs[3];
        cont = engine.cont;
    // '$builtin_meta_predicates'(\+, 1, [:]):-[]
        a1 = deref( a1);
        if (isAtomTerm(a1)){
            if (! prologEquals(a1,s11))
                return fail(engine);
        } else if (isVariable(a1)){
             bind(/*VAR*/ a1,s11);
        } else {
            return fail(engine);
        }
        a2 = deref( a2);
        if (isInteger(a2)){
            if (intValue( a2) != 1)
                return fail(engine);
        } else if (isVariable(a2)){
            bind(/*VAR*/ a2,si9);
        } else {
            return fail(engine);
        }
        if (! unify(s6,a3))
            return fail(engine);
        return exit(engine,cont);
    }
}

class PRED_$builtin_meta_predicates_3_5 extends PRED_$builtin_meta_predicates_3 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
    // '$builtin_meta_predicates'(findall, 3, [?, :, ?]):-true
        Object a1, a2, a3;
        Predicate cont;
        a1 = engine_aregs[1];
        a2 = engine_aregs[2];
        a3 = engine_aregs[3];
        cont = engine.cont;
    // '$builtin_meta_predicates'(findall, 3, [?, :, ?]):-[]
        a1 = deref( a1);
        if (isAtomTerm(a1)){
            if (! prologEquals(a1,s12))
                return fail(engine);
        } else if (isVariable(a1)){
             bind(/*VAR*/ a1,s12);
        } else {
            return fail(engine);
        }
        a2 = deref( a2);
        if (isInteger(a2)){
            if (intValue( a2) != 3)
                return fail(engine);
        } else if (isVariable(a2)){
            bind(/*VAR*/ a2,si13);
        } else {
            return fail(engine);
        }
        if (! unify(s16,a3))
            return fail(engine);
        return exit(engine,cont);
    }
}

class PRED_$builtin_meta_predicates_3_6 extends PRED_$builtin_meta_predicates_3 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
    // '$builtin_meta_predicates'(setof, 3, [?, :, ?]):-true
        Object a1, a2, a3;
        Predicate cont;
        a1 = engine_aregs[1];
        a2 = engine_aregs[2];
        a3 = engine_aregs[3];
        cont = engine.cont;
    // '$builtin_meta_predicates'(setof, 3, [?, :, ?]):-[]
        a1 = deref( a1);
        if (isAtomTerm(a1)){
            if (! prologEquals(a1,s17))
                return fail(engine);
        } else if (isVariable(a1)){
             bind(/*VAR*/ a1,s17);
        } else {
            return fail(engine);
        }
        a2 = deref( a2);
        if (isInteger(a2)){
            if (intValue( a2) != 3)
                return fail(engine);
        } else if (isVariable(a2)){
            bind(/*VAR*/ a2,si13);
        } else {
            return fail(engine);
        }
        if (! unify(s16,a3))
            return fail(engine);
        return exit(engine,cont);
    }
}

class PRED_$builtin_meta_predicates_3_7 extends PRED_$builtin_meta_predicates_3 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
    // '$builtin_meta_predicates'(bagof, 3, [?, :, ?]):-true
        Object a1, a2, a3;
        Predicate cont;
        a1 = engine_aregs[1];
        a2 = engine_aregs[2];
        a3 = engine_aregs[3];
        cont = engine.cont;
    // '$builtin_meta_predicates'(bagof, 3, [?, :, ?]):-[]
        a1 = deref( a1);
        if (isAtomTerm(a1)){
            if (! prologEquals(a1,s18))
                return fail(engine);
        } else if (isVariable(a1)){
             bind(/*VAR*/ a1,s18);
        } else {
            return fail(engine);
        }
        a2 = deref( a2);
        if (isInteger(a2)){
            if (intValue( a2) != 3)
                return fail(engine);
        } else if (isVariable(a2)){
            bind(/*VAR*/ a2,si13);
        } else {
            return fail(engine);
        }
        if (! unify(s16,a3))
            return fail(engine);
        return exit(engine,cont);
    }
}

class PRED_$builtin_meta_predicates_3_8 extends PRED_$builtin_meta_predicates_3 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
    // '$builtin_meta_predicates'(on_exception, 3, [?, :, :]):-true
        Object a1, a2, a3;
        Predicate cont;
        a1 = engine_aregs[1];
        a2 = engine_aregs[2];
        a3 = engine_aregs[3];
        cont = engine.cont;
    // '$builtin_meta_predicates'(on_exception, 3, [?, :, :]):-[]
        a1 = deref( a1);
        if (isAtomTerm(a1)){
            if (! prologEquals(a1,s19))
                return fail(engine);
        } else if (isVariable(a1)){
             bind(/*VAR*/ a1,s19);
        } else {
            return fail(engine);
        }
        a2 = deref( a2);
        if (isInteger(a2)){
            if (intValue( a2) != 3)
                return fail(engine);
        } else if (isVariable(a2)){
            bind(/*VAR*/ a2,si13);
        } else {
            return fail(engine);
        }
        if (! unify(s21,a3))
            return fail(engine);
        return exit(engine,cont);
    }
}

class PRED_$builtin_meta_predicates_3_9 extends PRED_$builtin_meta_predicates_3 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
    // '$builtin_meta_predicates'(catch, 3, [:, ?, :]):-true
        Object a1, a2, a3;
        Predicate cont;
        a1 = engine_aregs[1];
        a2 = engine_aregs[2];
        a3 = engine_aregs[3];
        cont = engine.cont;
    // '$builtin_meta_predicates'(catch, 3, [:, ?, :]):-[]
        a1 = deref( a1);
        if (isAtomTerm(a1)){
            if (! prologEquals(a1,s22))
                return fail(engine);
        } else if (isVariable(a1)){
             bind(/*VAR*/ a1,s22);
        } else {
            return fail(engine);
        }
        a2 = deref( a2);
        if (isInteger(a2)){
            if (intValue( a2) != 3)
                return fail(engine);
        } else if (isVariable(a2)){
            bind(/*VAR*/ a2,si13);
        } else {
            return fail(engine);
        }
        if (! unify(s23,a3))
            return fail(engine);
        return exit(engine,cont);
    }
}

class PRED_$builtin_meta_predicates_3_10 extends PRED_$builtin_meta_predicates_3 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
    // '$builtin_meta_predicates'(synchronized, 2, [?, :]):-true
        Object a1, a2, a3;
        Predicate cont;
        a1 = engine_aregs[1];
        a2 = engine_aregs[2];
        a3 = engine_aregs[3];
        cont = engine.cont;
    // '$builtin_meta_predicates'(synchronized, 2, [?, :]):-[]
        a1 = deref( a1);
        if (isAtomTerm(a1)){
            if (! prologEquals(a1,s24))
                return fail(engine);
        } else if (isVariable(a1)){
             bind(/*VAR*/ a1,s24);
        } else {
            return fail(engine);
        }
        a2 = deref( a2);
        if (isInteger(a2)){
            if (intValue( a2) != 2)
                return fail(engine);
        } else if (isVariable(a2)){
            bind(/*VAR*/ a2,si2);
        } else {
            return fail(engine);
        }
        if (! unify(s7,a3))
            return fail(engine);
        return exit(engine,cont);
    }
}

class PRED_$builtin_meta_predicates_3_11 extends PRED_$builtin_meta_predicates_3 {
    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); //anony 
    // '$builtin_meta_predicates'(freeze, 2, [?, :]):-true
        Object a1, a2, a3;
        Predicate cont;
        a1 = engine_aregs[1];
        a2 = engine_aregs[2];
        a3 = engine_aregs[3];
        cont = engine.cont;
    // '$builtin_meta_predicates'(freeze, 2, [?, :]):-[]
        a1 = deref( a1);
        if (isAtomTerm(a1)){
            if (! prologEquals(a1,s25))
                return fail(engine);
        } else if (isVariable(a1)){
             bind(/*VAR*/ a1,s25);
        } else {
            return fail(engine);
        }
        a2 = deref( a2);
        if (isInteger(a2)){
            if (intValue( a2) != 2)
                return fail(engine);
        } else if (isVariable(a2)){
            bind(/*VAR*/ a2,si2);
        } else {
            return fail(engine);
        }
        if (! unify(s7,a3))
            return fail(engine);
        return exit(engine,cont);
    }
}
