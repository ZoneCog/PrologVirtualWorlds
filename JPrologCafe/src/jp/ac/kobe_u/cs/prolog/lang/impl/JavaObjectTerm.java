package jp.ac.kobe_u.cs.prolog.lang.impl;

/**
 * Java-term.<br>
 * The <code>JavaObjectTerm</code> class wraps a java object.<br>
 *
 * <pre>
 *  import java.util.Hashtable;
 *  Object t = Prolog.makeJavaObject(new Hashtable());
 *  Hashtable hash = (Hashtable)(((JavaObjectTerm)t).object());
 * </pre>
 *
 * @author Mutsunori Banbara (banbara@kobe-u.ac.jp)
 * @author Naoyuki Tamura (tamura@kobe-u.ac.jp)
 * @version 1.0
 */
interface JavaObjectTerm extends Term {
  //
  //  /** Returns the object wrapped by this <code>JavaObjectTerm</code>. */
  //  public Object toJava(); //{ return obj; }
  //
  //  /** Returns a <code>java.lang.Class</code> of object wrapped by this <code>JavaObjectTerm</code>. */
  //  public Class getClazz(); //{ return clazz; }
  //
  //  public String toQuotedString(); //{ return toString(); }
  //
  //  /* Object */
  //  public boolean unify(Object t);
  //
  //  /**
  //   * Check whether the wrapped object is convertible with the given Java class type.
  //   * @return the <code>boolean</code> whose value is
  //   * <code>convertible(clazz, type)</code>.
  //   * @see #clazz
  //   * @see Object#convertible(Class, Class)
  //   */
  //  public boolean convertible(Class type); //{ return convertible(clazz, type); }
  //
  //  /**
  //   * Returns the object wrapped by this <code>JavaObjectTerm</code>.
  //   * @return the value of <code>obj</code>.
  //   * @see #obj
  //   */
  //  //    public Object toJava();//{ return obj; }
  //  /* Object */
  //  /**
  //   * Checks <em>term equality</em> of two terms.
  //   * The result is <code>true</code> if and only if the argument is an instance of
  //   * <code>JavaObjectTerm</code>, and
  //   * the pairs of wrapped objects in the two java-term are <em>equal</em>
  //   * by <code>obj.equals(((JavaObjectTerm)o).obj)</code>.
  //   * @param o the object to compare with. This must be dereferenced.
  //   * @return <code>true</code> if the given object represents a java-term
  //   * equivalent to this <code>JavaObjectTerm</code>, false otherwise.
  //   * @see #compareTo
  //   */
  //  public boolean equals(Object o);//
  //
  //  public int hashCode(); //
  //
  //  /** Returns a string representation of this <code>JavaObjectTerm</code>. */
  //  public String toString(); //
  //
  //  /* Comparable */
  //  /**
  //   * Compares two terms in <em>Prolog standard order of terms</em>.<br>
  //   * It is noted that <code>t1.compareTo(t2) == 0</code> has the same
  //   * <code>boolean</code> value as <code>t1.equals(t2)</code>.
  //   * @param anotherTerm the term to compared with. It must be dereferenced.
  //   * @return the value <code>0</code> if two terms are identical;
  //   * a value less than <code>0</code> if this term is <em>before</em> the <code>anotherTerm</code>;
  //   * and a value greater than <code>0</code> if this term is <em>after</em> the <code>anotherTerm</code>.
  //   */
  //  public int compareTo(Object anotherTerm); //
}
