package jp.ac.kobe_u.cs.prolog.lang;
import java.io.Serializable;
/**
 * The superclass of classes for Prolog exceptions.<br>
 *
 * @author Mutsunori Banbara (banbara@kobe-u.ac.jp)
 * @author Naoyuki Tamura (tamura@kobe-u.ac.jp)
 * @version 1.0
 */
public abstract class PrologException extends RuntimeException implements Serializable {
   public static final long serialVersionUID = 1L;
    /** Constructs a new Prolog exception. */
    public PrologException() {}

    /** Returns the message term of this object. */
    abstract public Object getMessageTerm();
}
