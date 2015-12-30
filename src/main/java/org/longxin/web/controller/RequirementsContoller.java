package org.longxin.web.controller;

import java.util.List;

import org.longxin.domains.Product;
import org.longxin.domains.Requirements;
import org.longxin.service.ProductService;
import org.longxin.service.RequirementsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/requirements")
public class RequirementsContoller
{
    @Autowired
    RequirementsService requirementsService;
    
    @Autowired
    ProductService productService;
    
    @RequestMapping(value = "/{productId}", method = RequestMethod.GET)
    protected String getRequirementsByProject(@PathVariable String productId, Model model)
    {
        Product product = this.productService.getProjectByID(Integer.valueOf(productId));
        List<Requirements> requirements = requirementsService.getRequirementsByProduct(product);
        
        model.addAttribute("product", product);
        model.addAttribute("requirements", requirements);
        
        return "/requirements/view";
    }
    
    @RequestMapping(value = "/save/{productId}", method = RequestMethod.POST)
    public @ResponseBody
    ModelMap saveNewRequirement(@PathVariable String productId, @RequestBody Requirements requirement)
    {
        Product product = this.productService.getProjectByID(Integer.valueOf(productId));
        requirement.setProduct(product);
//        requirement.setCloseDate(new Date());
//        requirement.setCreateDate(new Date());
//        requirement.setUpdateDate(new Date());
        this.requirementsService.saveOrUpdateRequirements(requirement);
        return new ModelMap("success", 1);
    }
    
    @RequestMapping(value = "/update/{productId}", method = RequestMethod.POST)
    public @ResponseBody
    ModelMap updateRequirement(@PathVariable String productId, @RequestBody Requirements requirement)
    {
        Product product = this.productService.getProjectByID(Integer.valueOf(productId));
        requirement.setProduct(product);
//        requirement.setCloseDate(new Date());
//        requirement.setCreateDate(new Date());
//        requirement.setUpdateDate(new Date());
        this.requirementsService.saveOrUpdateRequirements(requirement);
        return new ModelMap("success", 1);
    }
    
    @RequestMapping(value="/delete/{requirementId}", method = RequestMethod.POST)
    public @ResponseBody ModelMap deleteRequirement(@PathVariable String requirementId)
    {
        this.requirementsService.deleteRequirement(Integer.valueOf(requirementId));
        
        return new ModelMap("success", 1);
    }
    
    @RequestMapping(value = "/check", method = RequestMethod.GET)
    public @ResponseBody boolean checkSequenceName(String sequenceName)
    {
        List<Requirements> requirements = requirementsService.getRequirementBySeqName(sequenceName);
        if (requirements == null || requirements.size() == 0)
        {
            return true;
        }
        return  false;
    }
}

