package org.longxin.web.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.longxin.domains.Feature;
import org.longxin.domains.Module;
import org.longxin.domains.Product;
import org.longxin.domains.Users;
import org.longxin.service.FeatureService;
import org.longxin.service.ProductService;
import org.longxin.service.UserService;
import org.longxin.web.controller.bean.FileMeta;
import org.longxin.web.controller.bean.Matrix;
import org.longxin.web.controller.bean.MatrixBean;
import org.longxin.web.controller.bean.ProductSearchBean;
import org.longxin.web.controller.bean.Surounder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
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
@SessionAttributes({"product","rounder"})
public class ProductController
{
    protected static Logger logger = Logger.getLogger(ProductController.class);
    
    @Autowired
    ProductService productService;

    @Autowired
    FeatureService featureService;
    
    @Autowired
    UserService userService;
    
    @Value("#{applicationSetting['fileRoot']}")
    String fileRoot;

    @RequestMapping(method = RequestMethod.GET)
    public String getAllProducts(Model model)
    {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Users user = userService.findUserByUserName(userDetails.getUsername());
        List<Product> products = productService.getProductsByPermission(user);
        model.addAttribute("products", products);
        return "/product/listproducts";
    }

    @RequestMapping(value = "/diagram/{productId}", method = RequestMethod.GET)
    public String showProductDiagram(@PathVariable int productId, Model model)
    {
        // product
        Product product = productService.getProjectByIDForDiagram(productId);
        model.addAttribute("product", product);
        return "/product/diagram";
    }

    @RequestMapping(value = "/functiondiagram/{productId}", method = RequestMethod.GET)
    public String showProductFunctionDiagram(@PathVariable int productId, Model model)
    {
        // product
        Product product = productService.getProjectByIDForFunctionDiagram(productId);
        model.addAttribute("product", product);
        return "/product/functiondiagram";
    }

    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public String searchProduct(Model model)
    {
        model.addAttribute("productSearchBean", new ProductSearchBean());
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Users user = userService.findUserByUserName(userDetails.getUsername());
        model.addAttribute("products", productService.getProductsByPermission(user));
        return "/product/listproducts";
    }

    @RequestMapping(value = "/search", method = RequestMethod.POST)
    public String doSearchProduct(Model model, ProductSearchBean searchForm)
    {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Users user = userService.findUserByUserName(userDetails.getUsername());
        model.addAttribute("productSearchBean", searchForm);
        if (StringUtils.isEmpty(searchForm.getKeyword()))
        {
            model.addAttribute("products", productService.getProductsByPermission(user));
        }
        else
        {
            List<Product> products = productService.searchProductByKeyWords(user, StringUtils.trim(searchForm.getKeyword()));
            model.addAttribute("products", products);
            model.addAttribute("searched", true);
        }
        return "/product/listproducts";
    }

    /**
     * responsible for the product/add GET request.
     */
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String addProduct(Model model)
    {
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
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String addProduct(Product product)
    {
        // UserDetails userDetails = (UserDetails)
        // SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        productService.saveProduct(product);
        return "redirect:/product/list";
    }

    @RequestMapping(value = "/list/{productId}", method = RequestMethod.GET)
    public String listOneProduct(@PathVariable int productId, Model model)
    {
        Product product = productService.getProjectByID(productId);
        model.addAttribute("product", product);
        return "/product/listoneproduct";
    }

    @RequestMapping(value = "/edit/{productId}", method = RequestMethod.GET)
    public String editProduct(@PathVariable int productId, Model model)
    {
        Product product = productService.getProjectByID(productId);
        model.addAttribute("product", product);
        // model.addAttribute("features", featureService.getFeatureByProductId(productId));
        return "/product/editproduct";
    }

    @RequestMapping(value = "/edit/{productId}", method = RequestMethod.POST)
    public String editProduct(Model model, @ModelAttribute("product") Product product)
    {
        productService.saveProduct(product);
        model.addAttribute("product", product);
        return "redirect:/product/list/" + product.getId();
    }

    @RequestMapping(value = "/{productId}", method = RequestMethod.DELETE)
    public @ResponseBody String deleteProduct(@PathVariable int productId, Model model)
    {
        productService.deleteProduct(productId);
        
        return "SUCCESS";
    }

    @RequestMapping(value = "/delete/feature/{featureId}", method = RequestMethod.POST)
    public void deleteFeature(@PathVariable int featureId, Model model)
    {
        featureService.deleteFeatureById(featureId);
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String createNewProduct(Model model)
    {
        Product product = productService.getTemplate();
        
        MatrixBean bean = new MatrixBean(0, "新产品");
        List<Matrix> matrixs = new ArrayList<Matrix>();
        
        for(Feature feature : product.getFeatures())
        {
            for(Module module : feature.getModules())
            {
                matrixs.add(new Matrix(0, module.getId(), Boolean.FALSE));
            }
        }
        bean.getMatrixs().addAll(matrixs);
        
        Surounder rounder = new Surounder();
        rounder.getBean().add(bean);
        model.addAttribute("features", product.getFeatures());
        model.addAttribute("rounder", rounder);
        
        return "/product/create";
    }
    
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String doCreateNewProduct(@ModelAttribute("rounder")Surounder rounder, Model model) throws CloneNotSupportedException
    {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Users user = userService.findUserByUserName(userDetails.getUsername());
        
        productService.createProductBasedOnTemplate(user, rounder);
        
        model.addAttribute("productSearchBean", new ProductSearchBean());
        model.addAttribute("products", productService.getAllProducts());
        return "/product/listproducts";
    }

    @RequestMapping(value = "/attachments/{productId}", method = RequestMethod.POST)
    public @ResponseBody
    LinkedList<FileMeta> listAttachments(@PathVariable int productId)
    {
        LinkedList<FileMeta> files = new LinkedList<FileMeta>();
        File directory = new File(fileRoot + File.separator + "product" + File.separator + productId);
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

    public FeatureService getFeatureService()
    {
        return featureService;
    }

    public void setFeatureService(FeatureService featureService)
    {
        this.featureService = featureService;
    }

    public ProductService getProductService()
    {
        return productService;
    }

    public void setProductService(ProductService productService)
    {
        this.productService = productService;
    }
}
