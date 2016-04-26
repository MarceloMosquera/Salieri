package edu.unsam.Salieri.HybernateDB;

import com.google.common.base.Objects;
import edu.unsam.Salieri.Domain.Vuelo;
import edu.unsam.Salieri.HybernateDB.RepoHybernateBase;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

@SuppressWarnings("all")
public class RepoHybernateVuelos extends RepoHybernateBase<Vuelo> {
  public Class<Vuelo> getEntityType() {
    return Vuelo.class;
  }
  
  public void addQueryByExample(final Criteria criteria, final Vuelo vuelo) {
    String _nroVuelo = vuelo.getNroVuelo();
    boolean _notEquals = (!Objects.equal(_nroVuelo, null));
    if (_notEquals) {
      String _nroVuelo_1 = vuelo.getNroVuelo();
      SimpleExpression _eq = Restrictions.eq("nombre", _nroVuelo_1);
      criteria.add(_eq);
    }
  }
}
