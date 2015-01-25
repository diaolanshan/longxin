package org.longxin.service;

import java.util.List;

import org.longxin.domains.Product;

public interface ProductService {
	 
	public List<Product> getAllProducts();

	public void saveProduct(Product product);

	public void deleteProduct(Product product);
	
	public Product getProjectByID(int prodcutID);
	
	public void deleteProduct(int productID);
	
	public void cloneProduct(Product product) throws CloneNotSupportedException;
	
	public Product getTemplate();
}
