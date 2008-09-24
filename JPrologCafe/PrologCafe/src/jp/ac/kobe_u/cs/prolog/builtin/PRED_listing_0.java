package jp.ac.kobe_u.cs.prolog.builtin;
import jp.ac.kobe_u.cs.prolog.lang.*;
/*
 This file is generated by Prolog Cafe.
 PLEASE DO NOT EDIT!
*/
/**
 <code>listing/0</code> defined in builtins.pl<br>
 @author Mutsunori Banbara (banbara@kobe-u.ac.jp)
 @author Naoyuki Tamura (tamura@kobe-u.ac.jp)
 @author Douglas R. Miles (dmiles@users.sourceforge.net) for Object(s) 
 @version 1.0-dmiles
*/
public class PRED_listing_0 extends PredicateBase {
    static /*Symbol*/Object s1 = makeAtom("user");

    public PRED_listing_0(Predicate cont) {
        this.cont = cont;
    }

    public PRED_listing_0(){}

    public void setArgument(Object[] args, Predicate cont) {
        this.cont = cont;
    }

    public int arity() { return 0; }

    public String nameUQ() { return "listing"; }

    public void sArg(int i0, Object val) {  switch (i0) {default: newIndexOutOfBoundsException("setarg" , i0 , val);  }   }


    public Object gArg(int i0) {  switch (i0) {default: return newIndexOutOfBoundsException("getarg", i0,null);  }   }


    public String toPrologString(java.util.Collection newParam) {
        return "'listing";
    }

    public Predicate exec(Prolog engine) { enter(engine); Object[] engine_aregs = engine.getAreg(); 
    // listing:-'$listing'(A, user)
        engine.setB0();
    // listing:-['$listing'(A, user)]
        return exit(engine, new PRED_$listing_2(engine.makeVariable(this), s1, cont));
    }
}
