package org.longxin.service.impl;

import java.util.Date;
import java.util.List;

import org.longxin.domains.Feature;
import org.longxin.domains.FunctionModule;
import org.longxin.domains.L1Component;
import org.longxin.domains.L1ComponentParameter;
import org.longxin.domains.L2Component;
import org.longxin.domains.L2ComponentParameter;
import org.longxin.domains.L3Component;
import org.longxin.domains.L3ComponentParameter;
import org.longxin.domains.Module;
import org.longxin.domains.Product;
import org.longxin.domains.Users;
import org.apache.log4j.Logger;
import org.longxin.dao.FeatureDAO;
import org.longxin.dao.L1ComponentDAO;
import org.longxin.dao.L1ComponentParameterDAO;
import org.longxin.dao.L2ComponentDAO;
import org.longxin.dao.L2ComponentParameterDAO;
import org.longxin.dao.L3ComponentDAO;
import org.longxin.dao.L3ComponentParameterDAO;
import org.longxin.dao.ModuleDAO;
import org.longxin.dao.ProductDAO;
import org.longxin.service.FeatureService;
import org.longxin.service.ModuleService;
import org.longxin.service.ProductService;
import org.longxin.web.controller.bean.Matrix;
import org.longxin.web.controller.bean.MatrixBean;
import org.longxin.web.controller.bean.Surounder;
import org.springframework.beans.factory.annotation.Autowired;

public class ProductServiceImpl implements ProductService
{
	protected static Logger logger = Logger.getLogger(ProductServiceImpl.class);

	@Autowired
	ProductDAO productDAO;
	
	@Autowired
	FeatureDAO featureDAO;
	
	@Autowired
    ModuleDAO moduleDAO;
	
	@Autowired
    FeatureService featureService;
    
    @Autowired
    ModuleService moduleService;
	
	@Autowired
    L1ComponentDAO l1ComponentDAO;
	
	@Autowired
    L2ComponentDAO l2ComponentDAO;
	
	@Autowired
    L3ComponentDAO l3ComponentDAO;
	
	@Autowired
    L1ComponentParameterDAO l1ComponentParameterDAO;
    
    @Autowired
    L2ComponentParameterDAO l2ComponentParameterDAO;
    
    @Autowired
    L3ComponentParameterDAO l3ComponentParameterDAO;

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
	
    public Product getProjectByIDForDiagram(int prodcutID)
    {
        Product product = productDAO.getProductByID(prodcutID);
        for (Feature feature : product.getFeatures())
        {
            if (feature.getModules() != null)
            {
                for (Module module : feature.getModules())
                {
                    if (module.getL1Components() != null)
                    {
                        for (L1Component l1Component : module.getL1Components())
                        {
                            if (l1Component.getL2Components() != null)
                            {
                                for (L2Component l2Component : l1Component.getL2Components())
                                {
                                    if (l2Component.getL3Components() != null)
                                    {
                                        for (L3Component l3Component : l2Component.getL3Components())
                                        {
                                            l3Component.getName();
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return product;
    }
    
    public Product getProjectByIDForFunctionDiagram(int prodcutID)
    {
        Product product = productDAO.getProductByID(prodcutID);
        for (Feature feature : product.getFeatures())
        {
            if (feature.getFunctionModules() != null)
            {
                for (FunctionModule module : feature.getFunctionModules())
                {
                    if (module.getL1Components() != null)
                    {
                        for (L1Component l1Component : module.getL1Components())
                        {
                            if (l1Component.getL2Components() != null)
                            {
                                for (L2Component l2Component : l1Component.getL2Components())
                                {
                                    if (l2Component.getL3Components() != null)
                                    {
                                        for (L3Component l3Component : l2Component.getL3Components())
                                        {
                                            l3Component.getName();
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return product;
    }
	
	public List<Product> searchProductByKeyWords(String keyword)
	{
	    List<Product> products = productDAO.searchProductByKeyWords(keyword);
	    
	    List<L3ComponentParameter> l3Parameters = this.l3ComponentParameterDAO.searchByKeywords(keyword);
	    
	    List<L2ComponentParameter> l2Parameters = this.l2ComponentParameterDAO.searchByKeywords(keyword);
	    
	    List<L1ComponentParameter> l1Parameters = this.l1ComponentParameterDAO.searchByKeywords(keyword);
	    
	    List<L1Component> l1s = this.l1ComponentDAO.searchByKeywords(keyword);
	    
	    List<L2Component> l2s = this.l2ComponentDAO.searchByKeywords(keyword);
	    
	    List<L3Component> l3s = this.l3ComponentDAO.searchByKeywords(keyword);
	    
	    List<Module> modules = this.moduleDAO.searchByKeywords(keyword);
	    
	    List<Feature> features = this.featureDAO.searchByKeywords(keyword);
	    
        for (L3ComponentParameter l3Parameter : l3Parameters)
        {
            boolean parentExist = false;
            for (L3Component l3 : l3s)
            {
                if (l3.getId() == l3Parameter.getL3Component().getId())
                {
                    l3.getTempL3Parameters().add(l3Parameter);
                    parentExist = true;
                    break;
                }
            }
            
            if(!parentExist)
            {
                l3Parameter.getL3Component().getTempL3Parameters().add(l3Parameter);
                l3s.add(l3Parameter.getL3Component());
            }
        }
        
        for (L3Component l3 : l3s)
        {
            boolean parentExist = false;
            for (L2Component l2 : l2s)
            {
                if (l2.getId() == l3.getL2Component().getId())
                {
                    l2.getTempL3Components().add(l3);
                    parentExist = true;
                    break;
                }
            }
            
            if(!parentExist)
            {
                l3.getL2Component().getTempL3Components().add(l3);
                l2s.add(l3.getL2Component());
            }
        }
        
        for (L2ComponentParameter l2Parameter : l2Parameters)
        {
            boolean parentExist = false;
            for (L2Component l2 : l2s)
            {
                if (l2.getId() == l2Parameter.getL2Component().getId())
                {
                    l2.getTempL2Parameters().add(l2Parameter);
                    parentExist = true;
                    break;
                }
            }
            
            if(!parentExist)
            {
                l2s.add(l2Parameter.getL2Component());
                l2Parameter.getL2Component().getTempL2Parameters().add(l2Parameter);
            }
        }
        
        //Add l2Component to l1Component
        for (L2Component l2 : l2s)
        {
            boolean parentExist = false;
            for (L1Component l1 : l1s)
            {
                if (l1.getId() == l2.getL1Component().getId())
                {
                    l1.getTempL2Components().add(l2);
                    parentExist = true;
                    break;
                }
            }
            
            if(!parentExist)
            {
                l2.getL1Component().getTempL2Components().add(l2);
                l1s.add(l2.getL1Component());
            }
        }
        
        //Add l1ComponentParameter to l1Component
        for (L1ComponentParameter l1Parameter : l1Parameters)
        {
            boolean parentExist = false;
            for (L1Component l1 : l1s)
            {
                if (l1.getId() == l1Parameter.getL1Component().getId())
                {
                    l1.getTempL1Parameters().add(l1Parameter);
                    parentExist = true;
                    break;
                }
            }
            
            if(!parentExist)
            {
                l1Parameter.getL1Component().getTempL1Parameters().add(l1Parameter);
                l1s.add(l1Parameter.getL1Component());
            }
        }
        
        //Add L1Component to Module
        for (L1Component l1 : l1s)
        {
            boolean parentExist = false;
            for (Module module : modules)
            {
                if (module.getId() == l1.getModule().getId())
                {
                    module.getTempL1Components().add(l1);
                    parentExist = true;
                    break;
                }
            }
            
            if(!parentExist)
            {
                l1.getModule().getTempL1Components().add(l1);
                modules.add(l1.getModule());
            }
        }
        
        //Add Module to Feature
        for (Module module : modules)
        {
            boolean parentExist = false;
            for (Feature feature : features)
            {
                if (feature.getId() == module.getFeature().getId())
                {
                    feature.getTempModules().add(module);
                    parentExist = true;
                    break;
                }
            }
            
            if(!parentExist)
            {
                module.getFeature().getTempModules().add(module);
                features.add(module.getFeature());
            }
        }
        
        for (Feature feature : features)
        {
            boolean parentExist = false;
            for (Product product : products)
            {
                if (product.getId() == feature.getProduct().getId())
                {
                    product.getTempFeatures().add(feature);
                    parentExist = true;
                    break;
                }
            }
            
            if(!parentExist)
            {
                feature.getProduct().getTempFeatures().add(feature);
                products.add(feature.getProduct());
            }
        }
	    
	    return products;
	}
	
	public Product getTemplate()
	{
		Product product = productDAO.getTemplate();
		
		//force load modules
		for(Feature feature : product.getFeatures())
		{
		    System.out.println(feature.getFeatureName());
		    for(Module module : feature.getModules())
		    {
		        module.getModuleName();
		    }
		}
		return product;
	}
	
	public int cloneProduct(Integer productId) throws CloneNotSupportedException
	{
		Product product = this.getProjectByID(productId);
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
	 
    public void createProductBasedOnTemplate(Users owner, Surounder rounder) throws CloneNotSupportedException
    {
        Product product = new Product();
        product.setName("新产品");
        product.setTemplate(Boolean.FALSE);
        product.setOwner(owner);
        this.saveProduct(product);

        MatrixBean matrixBean = rounder.getBean().get(0);
        for (Matrix matrix : matrixBean.getMatrixs())
        {
            Boolean featureExist = false;
            if (matrix.getIsChecked())
            {
                int moduleId = matrix.getColId();
                Module module = moduleService.getModuleByID(moduleId);
                Feature newFeature = null;
                if (product.getFeatures() != null)
                {
                    for (Feature feature : product.getFeatures())
                    {
                        if (feature.getFeatureName().equalsIgnoreCase(module.getFeature().getFeatureName()))
                        {
                            newFeature = feature;
                            featureExist = true;
                            break;
                        }
                    }
                }
                if (product.getFeatures() == null || !featureExist)
                {
                    newFeature = (Feature) module.getFeature().shadowClone();
                    newFeature.setProduct(product);
                    featureService.saveFeature(newFeature);
                    product.getFeatures().add(newFeature);
                }
                Module newModule = module.clone();
                newModule.setFeature(newFeature);
                moduleService.updateModule(newModule);
            }
        }
	 }
}
