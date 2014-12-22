package org.longxin.dao.impl;

import java.util.List;

import org.longxin.dao.ProductDAO;
import org.longxin.domains.Product;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class ProductDAOImpl extends HibernateDaoSupport implements ProductDAO {

	@SuppressWarnings("unchecked")
	public List<Product> getAllProducts()
	{
		return this.getHibernateTemplate().find("FROM Product");
	}
	
	public void saveProduct(Product product)
	{
		this.getHibernateTemplate().saveOrUpdate(product);
	}
	
	public void deleteProduct(Product product)
	{
		this.getHibernateTemplate().delete(product);
	}
	
	public Product getProductByID(int id)
	{
		return this.getHibernateTemplate().load(Product.class, id);
	}
}
