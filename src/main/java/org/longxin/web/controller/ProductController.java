package org.longxin.web.controller;

import org.longxin.domains.Product;
import org.longxin.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
     * 添加新用户
     * @see 访问/user/add时，GET请求就执行addUser(Model model)方法，POST请求就执行addUser(User user)方法
     */ 
    @RequestMapping(value="/add", method=RequestMethod.GET) 
    public String addUser(Model model){ 
        //这里要传给前台一个空对象，否则会报告java.lang.IllegalStateException异常 
        //异常信息为Neither BindingResult nor plain target object for bean name 'user' available as request attribute 
        //并且传过去的key值要与前台modelAttribute属性值相同，即model.addAttribute("user", new User()); 
        //我们也可以写成下面这种方式，此时SpringMVC会自动把对象名转换为小写值作为key，即User-->user 
        model.addAttribute(new Product()); 
        return "/product/addproduct"; 
    } 
    
    @RequestMapping(value="/add", method=RequestMethod.POST) 
    public String addUser(Product product){ //这里参数中的user就应该与add.jsp中的modelAttribute="user"一致了 
        productService.saveProduct(product);
    	return "redirect:/product/addproduct"; 
    } 
//       
//    /**
//     * 列出所有用户信息
//     */ 
    @RequestMapping("/list") 
    public String list(Model model){ 
        model.addAttribute("users", productService.getAllProducts()); 
        return "redirect:/product/list"; 
    } 
//       
//    /**
//     * 查询用户信息
//     * @see 访问该方法的路径就应该是"/user/具体的用户名"
//     * @see 这里value="/{username}"的写法，需要格外注意一下，它是一个路径变量，此时用来接收前台的一个资源
//     * @see 这时value="/{username}"就会到方法参数中找@PathVariable String username，并将路径变量值传给username参数
//     */ 
//    @RequestMapping(value="/{myname}", method=RequestMethod.GET) 
//    public String show(@PathVariable String myname, Model model){ 
//        model.addAttribute(users.get(myname)); 
//        return "user/show"; 
//    } 
//       
//    /**
//     * 编辑用户信息
//     * @see 访问该方法的路径就应该是"/user/具体的用户名/update"
//     */ 
//    @RequestMapping(value="/{myname}/update", method=RequestMethod.GET) 
//    public String update(@PathVariable String myname, Model model){ 
//        model.addAttribute(users.get(myname)); 
//        return "user/update"; 
//    } 
//    @RequestMapping(value="/{myname}/update", method=RequestMethod.POST) 
//    public String update(User user){ 
//        users.put(user.getUsername(), user); 
//        return "redirect:/user/list"; //也可以retun "forward:/user/list",此时浏览器地址栏会有不同 
//    } 
//       
//    /**
//     * 删除用户信息
//     */ 
//    @RequestMapping(value="/{myname}/delete", method=RequestMethod.GET) 
//    public String delete(@PathVariable String myname){ 
//        users.remove(myname); 
//        return "redirect:/user/list"; //删除完成后显示当前存在的所有用户信息 
//    }  

	public ProductService getProductService() {
		return productService;
	}

	public void setProductService(ProductService productService) {
		this.productService = productService;
	}  
}
