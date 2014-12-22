package org.longxin.dao;

import java.util.List;

import org.longxin.domains.Product;

public interface ProductDAO {

	public List<Product> getAllProducts();
	
	public void saveProduct(Product product);
	
	public void deleteProduct(Product product);
	
	public Product getProductByID(int id);
}
