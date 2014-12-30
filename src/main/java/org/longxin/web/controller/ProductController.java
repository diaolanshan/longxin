package org.longxin.web.controller;

import org.longxin.domains.Product;
import org.longxin.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/product") 
public class ProductController {

	@Autowired
	ProductService productService;
	
	@RequestMapping(method = RequestMethod.GET)  
    public String getAllProducts(Model model) {  
        //messages = messageBoardService.listMessages();  
        //model.addAttribute("messages", messages);  
        return "messageList";  
    }
	
    /**
     * responsible for the product/add GET request.
     */ 
    @RequestMapping(value="/add", method=RequestMethod.GET) 
    public String addProduct(Model model){ 
        model.addAttribute(new Product()); 
        return "/product/addproduct"; 
    } 
    
    /**
     * Reponsbile for the product/add POST request.
     */
    @RequestMapping(value="/add", method=RequestMethod.POST) 
	public String addProduct(Product product) {
    	UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext()
    		    .getAuthentication()
    		    .getPrincipal();
    	productService.saveProduct(product);
		return "redirect:/product/addproduct";
	}

    @RequestMapping("/list") 
    public String list(Model model){ 
        model.addAttribute("product", productService.getAllProducts()); 
        return "redirect:/product/listproducts"; 
    } 
       
    /**
     * 查询用户信息
     * @see 访问该方法的路径就应该是"/user/具体的用户名"
     * @see 这里value="/{username}"的写法，需要格外注意一下，它是一个路径变量，此时用来接收前台的一个资源
     * @see 这时value="/{username}"就会到方法参数中找@PathVariable String username，并将路径变量值传给username参数
     */ 
    @RequestMapping(value="/{myname}", method=RequestMethod.GET) 
    public String show(@PathVariable String myname, Model model){ 
        //model.addAttribute(users.get(myname)); 
        return "user/show"; 
    } 
       
    /**
     * 编辑用户信息
     * @see 访问该方法的路径就应该是"/user/具体的用户名/update"
     */ 
    @RequestMapping(value="/{id}/update", method=RequestMethod.GET) 
    public String update(@PathVariable String productID, Model model){ 
    	
        model.addAttribute(productService.getProjectByID(Integer.valueOf(productID))); 
        return "/product/update"; 
    } 
    
    @RequestMapping(value="/{id}/update", method=RequestMethod.POST) 
    public String update(Product product){ 
        return "redirect:/user/list";  
    } 
       
    /**
     * delete user
     */ 
    @RequestMapping(value="/{id}/delete", method=RequestMethod.GET) 
    public String delete(@PathVariable String productID){ 
    	productService.deleteProduct(Integer.valueOf(productID));
        return "redirect:/user/list";  
    }  

	public ProductService getProductService() {
		return productService;
	}

	public void setProductService(ProductService productService) {
		this.productService = productService;
	}  
}
