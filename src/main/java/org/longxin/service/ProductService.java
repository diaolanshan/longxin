package org.longxin.service;

import java.util.List;

import org.longxin.domains.Product;

public interface ProductService {
	 
	public List<Product> getAllProducts();

	public void saveProduct(Product product);

	public void deleteProduct(Product product);
	
	public Product getProjectByID(int prodcutID);
	
	public List<Product> searchProductByKeyWords(String keyword);
	
	public void deleteProduct(int productID);
	
	public int cloneProduct(Product product) throws CloneNotSupportedException;
	
	public int cloneProduct(Integer productId) throws CloneNotSupportedException;
	
	public Product getTemplate();
}
