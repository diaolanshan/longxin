package org.longxin.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.longxin.domains.Product;
import org.longxin.domains.Users;
import org.longxin.service.FeatureService;
import org.longxin.service.ProductService;
import org.longxin.service.UserPermissionMatrixService;
import org.longxin.service.UserService;
import org.longxin.web.controller.bean.Matrix;
import org.longxin.web.controller.bean.MatrixBean;
import org.longxin.web.controller.bean.PermissionBean;
import org.longxin.web.controller.bean.Surounder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@RequestMapping("permission")
@SessionAttributes({"rounder","matrixs"})
public class PermissionContoller
{
    @Autowired
    UserService userService;
    
    @Autowired
    FeatureService featureService;
    
    @Autowired
    ProductService productService;
    
    @Autowired
    UserPermissionMatrixService userPermissionMatrixService;
    
    private void initSelect(Model model)
    {
        List<Users> users = userService.getAllUsers();
        List<Product> products = productService.getAllProducts();
        
        model.addAttribute("users", users);
        model.addAttribute("products", products);
        model.addAttribute("permssionBean", new PermissionBean());
    }
    
    @RequestMapping(value = "/select", method = RequestMethod.GET)
    public String selectUsersAndFeatures(Model model)
    {
        initSelect(model);
        
        return "/permission/select";
    }
    
    @RequestMapping(value = "/select", method = RequestMethod.POST)
    public String showPermissionMatrix(HttpServletRequest request, Model model)
    {
        String [] selectedUsers = request.getParameter("users").split(",");
        String [] selectedProducts = request.getParameter("products").split(",");
        
        List<Product> products = productService.getProductsByIds(selectedProducts);
        
        Surounder rounder = new Surounder();
        rounder.getBean().addAll(userPermissionMatrixService.constructMatrix(selectedUsers, products));
        model.addAttribute("rounder",rounder);
        model.addAttribute("products", products);
        
        return "/permission/matrix";
    }
    
    @RequestMapping(value = "/updatematrix", method = RequestMethod.POST)
    public String updatePermissionMatrix(@ModelAttribute("rounder")Surounder rounder, Model model)
    {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Users user = userService.findUserByUserName(userDetails.getUsername());
        
        for(MatrixBean bean : rounder.getBean())
        {
            for(Matrix matrix : bean.getMatrixs())
            {
                userPermissionMatrixService.updateMatrix(String.valueOf(matrix.getRowId()), String.valueOf(matrix.getColId()), matrix.getIsChecked(), user);
            }
        }
        
        initSelect(model);
        
        return "/permission/select";
    }
}