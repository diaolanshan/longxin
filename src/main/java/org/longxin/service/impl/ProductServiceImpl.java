package org.longxin.service.impl;

import java.util.Date;
import java.util.List;

import org.longxin.domains.Feature;
import org.longxin.domains.Product;
import org.apache.log4j.Logger;
import org.longxin.dao.ProductDAO;
import org.longxin.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;

public class ProductServiceImpl implements ProductService
{

	protected static Logger logger = Logger.getLogger(ProductServiceImpl.class);

	@Autowired
	ProductDAO productDAO;

	public List<Product> getAllProducts()
	{
		return productDAO.getAllProducts();
	}

	public void saveProduct(Product product)
	{
		product.setCreatedat(new Date());
		productDAO.saveProduct(product);
	}

	public void deleteProduct(Product product)
	{
		productDAO.deleteProduct(product);
	}

	public void deleteProduct(int productID)
	{
		logger.info(String
				.format("Try to delete product with id %s", productID));
		Product product = this.productDAO.getProductByID(productID);
		productDAO.deleteProduct(product);
	}

	public Product getProjectByID(int prodcutID)
	{
		Product product = productDAO.getProductByID(prodcutID);
		for(Feature feature : product.getFeatures())
		{
			feature.getId();
		}
		return product;
	}

	public void cloneProduct(Product product) throws CloneNotSupportedException
	{
		Product cloned = (Product) product.clone(); 
	}
}
