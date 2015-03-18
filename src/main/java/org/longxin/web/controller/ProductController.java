package org.longxin.web.controller;

import java.io.File;
import java.util.LinkedList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.longxin.domains.Product;
import org.longxin.service.FeatureService;
import org.longxin.service.ProductService;
import org.longxin.web.controller.bean.FileMeta;
import org.longxin.web.controller.bean.ProductSearchBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@RequestMapping("/product") 
@SessionAttributes("product")
public class ProductController {

	@Autowired
	ProductService productService;
	
	@Autowired
	FeatureService featureService;
	
	/**
	 * Used to generate the product menu.
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/menu", method = RequestMethod.GET)
	public @ResponseBody List<Product> getAllProductsForMenu(Model model)
	{
		List<Product> products = productService.getAllProducts();
		return products;
	}
	
	@RequestMapping(method = RequestMethod.GET)  
    public String getAllProducts(Model model) {  
		List<Product> products = productService.getAllProducts();
		model.addAttribute("products", products);
        return "/product/listproducts";  
    }
	
	@RequestMapping(value = "/diagram/{productId}", method = RequestMethod.GET)
	public String showProductDiagram(@PathVariable int productId,Model model)
	{
		//product
		Product product = productService.getProjectByID(productId);
		model.addAttribute("product", product);
		return "/product/diagram";
	}
	
	@RequestMapping(value = "/functiondiagram/{productId}", method = RequestMethod.GET)
	public String showProductFunctionDiagram(@PathVariable int productId,Model model)
	{
		//product
		Product product = productService.getProjectByID(productId);
		model.addAttribute("product", product);
		return "/product/functiondiagram";
	}
	
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String searchProduct(Model model)
	{
		model.addAttribute("productSearchBean", new ProductSearchBean());
		model.addAttribute("products", productService.getAllProducts());
		return "/product/listproducts";
	}
	
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public String doSearchProduct(Model model, ProductSearchBean searchForm)
	{
		model.addAttribute("productSearchBean", searchForm);
		//System.out.println(searchForm.getKeyword());
		if (StringUtils.isEmpty(searchForm.getKeyword()))
		{
			model.addAttribute("products", productService.getAllProducts());
		} else
		{
			List<Product> products = productService.searchProductByKeyWords(StringUtils.trim(searchForm.getKeyword()));
			model.addAttribute("products", products);
		}
		return "/product/listproducts";
	}
	
    /**
     * responsible for the product/add GET request.
     */ 
    @RequestMapping(value="/add", method=RequestMethod.GET) 
    public String addProduct(Model model){ 
        model.addAttribute(new Product()); 
        return "/product/addproduct"; 
    } 
    
	@RequestMapping(value = "/clone/{productId}", method = RequestMethod.GET)
	public String cloneProduct(@PathVariable int productId, Model model) throws CloneNotSupportedException
	{
	    int clonedProductId = productService.cloneProduct(productId);
		return "redirect:/product/list/" + clonedProductId;
	}
    
    /**
     * Reponsbile for the product/add POST request.
     */
    @RequestMapping(value="/add", method=RequestMethod.POST) 
	public String addProduct(Product product) {
    	//UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	productService.saveProduct(product);
		return "redirect:/product/list";
	}

    @RequestMapping(value ="/list/{productId}", method = RequestMethod.GET) 
    public String listOneProduct(@PathVariable int productId, Model model){ 
		Product product = productService.getProjectByID(productId);
        model.addAttribute("product", product); 
		model.addAttribute("features", featureService.getFeatureByProduct(product));
        return "/product/listoneproduct"; 
    } 
      
    @RequestMapping(value = "/edit/{productId}", method = RequestMethod.GET)
	public String editProduct(@PathVariable int productId, Model model)
	{
		Product product = productService.getProjectByID(productId);
		model.addAttribute("product", product);
		//model.addAttribute("features", featureService.getFeatureByProductId(productId));
		return "/product/editproduct";
	}
	
	@RequestMapping(value = "/edit/{productId}", method = RequestMethod.POST)
	public String editProduct(Model model, @ModelAttribute("product") Product product)
	{
		productService.saveProduct(product);
		model.addAttribute("product", product);
		model.addAttribute("features", featureService.getFeatureByProduct(product));
		return "redirect:/product/list/"+product.getId();
	}
	
	@RequestMapping(value = "/delete/{productId}", method = RequestMethod.POST)
	public void deleteProduct(@PathVariable int productId,Model model)
	{
		Product p = productService.getProjectByID(productId);
		p.setOwner(null);
		productService.saveProduct(p);
		productService.deleteProduct(productId);
	}
	
	@RequestMapping(value = "/delete/feature/{featureId}", method = RequestMethod.POST)
    public void deleteFeature(@PathVariable int featureId,Model model)
    {
        featureService.deleteFeatureById(featureId);
    }
	
	@RequestMapping(value = "/attachments/{productId}", method = RequestMethod.POST)
	public @ResponseBody LinkedList<FileMeta> listAttachments(@PathVariable int productId)
	{
		String fileRoot = "d:\temp\files";
		LinkedList<FileMeta> files = new LinkedList<FileMeta>();
		File directory = new File(fileRoot + File.separator + "product"
				+ File.separator + productId);
		if (directory.exists())
		{
			for (File file : directory.listFiles())
			{
				FileMeta meta = new FileMeta();
				meta.setFileName(file.getName());
				files.add(meta);
			}
		}
		return files;
	}
	
	public FeatureService getFeatureService() {
		return featureService;
	}

	public void setFeatureService(FeatureService featureService) {
		this.featureService = featureService;
	}

	public ProductService getProductService() {
		return productService;
	}

	public void setProductService(ProductService productService) {
		this.productService = productService;
	}  
}
