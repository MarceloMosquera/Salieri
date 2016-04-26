package edu.unsam.Salieri.HybernateDB;

import com.google.common.base.Objects;
import edu.unsam.Salieri.Domain.Usuario;
import edu.unsam.Salieri.HybernateDB.RepoHybernateBase;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;

@SuppressWarnings("all")
public class RepoHybernateUsuarios extends RepoHybernateBase<Usuario> {
  public Class<Usuario> getEntityType() {
    return Usuario.class;
  }
  
  public void addQueryByExample(final Criteria criteria, final Usuario usuario) {
    String _nombre = usuario.getNombre();
    boolean _notEquals = (!Objects.equal(_nombre, null));
    if (_notEquals) {
      String _nombre_1 = usuario.getNombre();
      SimpleExpression _eq = Restrictions.eq("nombre", _nombre_1);
      criteria.add(_eq);
    }
  }
}
