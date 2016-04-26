package edu.unsam.Salieri.HybernateDB;

import edu.unsam.Salieri.Domain.Reserva;
import edu.unsam.Salieri.HybernateDB.RepoHybernateBase;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.HibernateException;
import org.hibernate.classic.Session;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

@SuppressWarnings("all")
public class RepoHybernateReservas extends RepoHybernateBase<Reserva> {
  public Class<Reserva> getEntityType() {
    return Reserva.class;
  }
  
  public void addQueryByExample(final Criteria criteria, final Reserva reserva) {
  }
  
  public Reserva searchById(final Long id) {
    Reserva _xblockexpression = null;
    {
      final Session session = this.openSession();
      Reserva _xtrycatchfinallyexpression = null;
      try {
        Criteria _createCriteria = session.createCriteria(Reserva.class);
        Criteria _setFetchMode = _createCriteria.setFetchMode("usuario", FetchMode.JOIN);
        SimpleExpression _eq = Restrictions.eq("id", id);
        Criteria _add = _setFetchMode.add(_eq);
        Object _uniqueResult = _add.uniqueResult();
        _xtrycatchfinallyexpression = ((Reserva) _uniqueResult);
      } catch (final Throwable _t) {
        if (_t instanceof HibernateException) {
          final HibernateException e = (HibernateException)_t;
          throw new RuntimeException(e);
        } else {
          throw Exceptions.sneakyThrow(_t);
        }
      } finally {
        session.close();
      }
      _xblockexpression = _xtrycatchfinallyexpression;
    }
    return _xblockexpression;
  }
}
