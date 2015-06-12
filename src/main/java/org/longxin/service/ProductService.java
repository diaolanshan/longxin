package org.longxin.service;

import java.util.List;

import org.longxin.domains.Product;
import org.longxin.domains.Users;
import org.longxin.web.controller.bean.Surounder;

public interface ProductService {
	 
	public List<Product> getAllProducts();

	public void saveProduct(Product product);

	public void deleteProduct(Product product);
	
	public Product getProjectByID(int prodcutID);
	
	public Product getProjectByIDForDiagram(int prodcutID);
	
	public Product getProjectByIDForFunctionDiagram(int prodcutID);
	
	public List<Product> searchProductByKeyWords(String keyword);
	
	public void deleteProduct(int productID);
	
	public int cloneProduct(Integer productId) throws CloneNotSupportedException;
	
	public Product getTemplate();
	
	public List<Product> getProductsByIds(String [] ids);
	
	public void createProductBasedOnTemplate(Users owner, Surounder rounder) throws CloneNotSupportedException;
}
