package jp.ac.kobe_u.cs.prolog.builtin;
import jp.ac.kobe_u.cs.prolog.lang.*;
/*
 This file is generated by Prolog Cafe.
 PLEASE DO NOT EDIT!
*/
/**
 <code>'$max'/3</code> defined in builtins.pl<br>
 @author Mutsunori Banbara (banbara@kobe-u.ac.jp)
 @author Naoyuki Tamura (tamura@kobe-u.ac.jp)
 @author Douglas R. Miles (dmiles@users.sourceforge.net) for Object(s) 
 @version 1.0-dmiles
*/
public class PRED_$max_3 extends PredicateBase {

    public Object arg1, arg2, arg3;

    public PRED_$max_3(Object a1, Object a2, Object a3, Predicate cont) {
        arg1 = a1;
        arg2 = a2;
        arg3 = a3;
        this.cont = cont;
    }

    public PRED_$max_3(){}

    public void setArgument(Object[] args, Predicate cont) {
        arg1 = args[0];
        arg2 = args[1];
        arg3 = args[2];
        this.cont = cont;
    }

    public int arity() { return 3; }

    public String nameUQ() { return "$max"; }

    public void sArg(int i0, Object val) {  switch (i0) {         case 0: arg1 = val;break ;
         case 1: arg2 = val;break ;
         case 2: arg3 = val;break ;
default: newIndexOutOfBoundsException("setarg" , i0 , val);  }   }


    public Object gArg(int i0) {  switch (i0) {         case 0: return arg1;
         case 1: return arg2;
         case 2: return arg3;
default: return newIndexOutOfBoundsException("getarg", i0,null);  }   }


    public String toPrologString(java.util.Collection newParam) {
        return "'$max'(" + argString(arg1,newParam) + "," + argString(arg2,newParam) + "," + argString(arg3,newParam) + ")";
    }

    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); 
    // '$max'(A, B, C):-'$max'(A, B, C)
        engine.setB0();
        Object a1, a2, a3;
        a1 = arg1;
        a2 = arg2;
        a3 = arg3;
    // '$max'(A, B, C):-['$max'(A, B, C)]
        //START inline expansion of $max(a(1), a(2), a(3))
        try {
            if (! unify(a3,max(Arithmetic.evaluate(a1),Arithmetic.evaluate(a2)))) {
                return fail(engine);
            }
        } catch (BuiltinException e) {
            e.goal = this;
            throw e;
        }
        //END inline expansion
        return exit(engine,cont);
    }
}
