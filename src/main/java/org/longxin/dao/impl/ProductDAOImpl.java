package org.longxin.dao.impl;

import java.util.List;

import org.longxin.dao.ProductDAO;
import org.longxin.domains.Product;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class ProductDAOImpl extends HibernateDaoSupport implements ProductDAO {

	@SuppressWarnings("unchecked")
	public List<Product> getAllProducts()
	{
		return this.getHibernateTemplate().find("FROM Product ORDER BY id DESC");
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
		return this.getHibernateTemplate().get(Product.class, id);
	}
	
	@SuppressWarnings("unchecked")
	public Product getTemplate()
	{
		List<Product> products = this.getHibernateTemplate().find("FROM Product WHERE template = ?", Boolean.TRUE);
		return products.get(0);
	}
}
