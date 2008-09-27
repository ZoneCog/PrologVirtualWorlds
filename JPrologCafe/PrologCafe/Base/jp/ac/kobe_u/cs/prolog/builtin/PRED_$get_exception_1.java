/* PRED_$get_exception_1 - at Sun Sep 21 05:38:53 PDT 2008 */
package jp.ac.kobe_u.cs.prolog.builtin;
import jp.ac.kobe_u.cs.prolog.lang.*;
/* used 3 more classes */
/* import java.lang.StringBuilder; */
/* import java.lang.String; */
/* import jp.ac.kobe_u.cs.prolog.builtin.PRED_$get_exception_1; */

class PRED_$get_exception_1 extends PredicateBase
{
    /**
   * 
   */
  private static final long serialVersionUID = 8117931815199551874L;
    Object arg1;

    @Override
    public  int arity() {
        /* flow_0_0_ConstantOperator
 */
return 1;
}
    public  PRED_$get_exception_1() {
    /* flow_0_0_EmptyBlock_1853020275
 */
/* empty */}
    public  PRED_$get_exception_1(Object a1, Predicate cont) {
        /* flow_0_0_PutFieldOperator
 */
this.arg1 = a1;
    this.cont = cont;
}
//    @Override
//    public  String toString() {
//        /* flow_0_0_StringAddOperator
// */
//return "$get_exception(" + this.arg1 + ")";
//}
    @Override
    public  Predicate exec(Prolog engine) {
        /* flow_0_0_LocalStoreOperator
 */
final Object[] engine_aregs = engine.getAreg();
    engine.setB0();
    final Object a1 = this.arg1;
    if (!unify(a1, engine.getException()))
 return this.fail(engine);
    return this.cont;
}
    @Override
    public  void setArgument(Object[] args, Predicate cont) {
    /* flow_0_0_PutFieldOperator
 */
this.arg1 = args[0];
    this.cont = cont;
}}
