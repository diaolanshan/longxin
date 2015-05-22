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

	@SuppressWarnings("unchecked")
    public List<Product> getAllProducts()
	{
		List<Product> products = productDAO.getAllProducts();
		return products;
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
		return product;
	}
	
	public List<Product> searchProductByKeyWords(String keyword)
	{
	    return productDAO.searchProductByKeyWords(keyword);
	}
	
	public Product getTemplate()
	{
		Product product = productDAO.getTemplate();
		return product;
	}
	
	public int cloneProduct(Integer productId) throws CloneNotSupportedException
	{
		Product product = this.getProjectByID(productId);
		return cloneProduct(product);
	}

	public int cloneProduct(Product product) throws CloneNotSupportedException
	{
		Product cloned = (Product) product.clone(); 
		this.saveProduct(cloned);
		return cloned.getId();
	}
	
	 public List<Product> getProductsByIds(String [] ids)
	 {
	     List<Product> products = this.productDAO.getProductsByIds(ids);
	     for(Product product : products)
	     {
	        for(Feature feature : product.getFeatures())
	        {
	            feature.getFeatureName();
	        }
	     }
	     return products;
	 }
}
