package org.longxin.web.controller;

import java.util.List;

import org.longxin.domains.Feature;
import org.longxin.domains.FunctionModule;
import org.longxin.domains.L1Component;
import org.longxin.domains.L2Component;
import org.longxin.domains.L3Component;
import org.longxin.domains.Module;
import org.longxin.domains.Users;
import org.longxin.service.FeatureService;
import org.longxin.service.FunctionModuleService;
import org.longxin.service.L1ComponentService;
import org.longxin.service.L2ComponentService;
import org.longxin.service.L3ComponentService;
import org.longxin.service.ModuleService;
import org.longxin.service.ProductService;
import org.longxin.service.UserPermissionMatrixService;
import org.longxin.service.UserService;
import org.longxin.web.controller.bean.Surounder;
import org.springframework.beans.factory.annotation.Autowired;
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
@RequestMapping("/feature")
@SessionAttributes({"feature", "rounder"})
public class FeatureController
{

    @Autowired
    FeatureService featureService;
    
    @Autowired
    L1ComponentService l1ComponentService;
    
    @Autowired
    L2ComponentService l2ComponentService;
    
    @Autowired
    L3ComponentService l3ComponentService;

    @Autowired
    ModuleService moduleService;
    
    @Autowired
    FunctionModuleService functionModuleService;
    
    @Autowired
    UserService userService;
    
    @Autowired
    UserPermissionMatrixService userPermissionMatrixService;
    
    @Autowired
    ProductService productService;
    
    @RequestMapping(value = "/{productID}", method = RequestMethod.GET)
    public @ResponseBody List<Feature> getFeaturesByProduct(@PathVariable int productID)
    {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Users user = userService.findUserByUserName(userDetails.getUsername());
        return featureService.getFeatureByProductAndPermission(productService.getProjectByID(productID), user);
    }

    @RequestMapping(value = "/view/{featureId}", method = RequestMethod.GET)
    public String viewFeature(@PathVariable int featureId, Model model)
    {
        Feature feature = featureService.getFeatureByID(featureId);
        model.addAttribute("feature", feature);
        model.addAttribute("modules",
                moduleService.getModulesByFeature(feature));
        model.addAttribute("functionModules",
            functionModuleService.getFunctionModulesByFeature(feature));
        return "/feature/view";
    }
    
    @RequestMapping(value = "/update/{featureId}", method = RequestMethod.POST)
    public String updateFeature(@PathVariable int featureId, @ModelAttribute("feature") Feature feature ,Model model)
    {
        featureService.saveFeature(feature);
        model.addAttribute("feature", feature);
        return "redirect:/feature/view/"+featureId;
    }
    
    @RequestMapping(value = "/diagram/{featureId}", method = RequestMethod.GET)
    public String showFeatureDiagram(@PathVariable int featureId,Model model)
    {
        //product
        Feature feature = featureService.getFeatureByIDForDiagram(featureId);
        model.addAttribute("feature", feature);
        
        return "/feature/diagram";
    }

    @RequestMapping(value = "/functiondiagram/{featureId}", method = RequestMethod.GET)
    public String showFeatureFunctionDiagram(@PathVariable int featureId,Model model)
    {
        //product
        Feature feature = featureService.getFeatureByIDForFunctionDiagram(featureId);
        model.addAttribute("feature", feature);
        return "/feature/functiondiagram";
    }
    
    @RequestMapping(value = "/view/{featureId}/add/module", method = RequestMethod.POST)
    public String addModule(@PathVariable int featureId, Module module)
    {
        Feature feature = featureService.getFeatureByID(featureId);
        module.setFeature(feature);
        module.setTemplate(feature.getTemplate());
        moduleService.updateModule(module);
        return "redirect:/feature/view/" + featureId;
    }
    
    @RequestMapping(value = "/view/{featureId}/add/functionmodule", method = RequestMethod.POST)
    public String addFunctionModule(@PathVariable int featureId, FunctionModule functionModule)
    {
        Feature feature = featureService.getFeatureByID(featureId);
        functionModule.setFeature(feature);
        functionModule.setTemplate(feature.getTemplate());
        functionModuleService.saveFunctionModule(functionModule);
        return "redirect:/feature/view/" + featureId;
    }

    @RequestMapping(value = "/module/{id}", method = RequestMethod.DELETE)
    public @ResponseBody String deleteModule(@PathVariable int id)
    {
        moduleService.deleteModule(id);
        
        return "SUCCESS";
    }
    
    @RequestMapping(value="/listdraft", method = RequestMethod.GET)
    public String listDraftComponent(Model model)
    {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Users user = userService.findUserByUserName(userDetails.getUsername());

        List<Integer> features = userPermissionMatrixService.draftFeatures(user.getId());
        StringBuilder displayString = new StringBuilder();
        for (Integer feature : features)
        {
            Feature featureEntity = featureService.getFeatureByID(feature.intValue());
            displayString.append("<div style='font-size:20px'>");
            displayString.append(featureEntity.getProduct().getName()).append(" -- ").append(featureEntity.getProduct().getDescription());
            displayString.append("<div style='padding-left:25px;font-size:20px'>");
            displayString.append(featureEntity.getFeatureName());
            displayString.append(" -- ").append(featureEntity.getDescription());
            List<Integer> modules = userPermissionMatrixService.draftModules(feature.intValue());
            if (modules != null && modules.size() > 0)
            {
                for (Integer module : modules)
                {
                    displayString.append("<div style='padding-left:25px;font-size: 18px'>");
                    Module moduleEntity = moduleService.getModuleByID(module.intValue());
                    displayString.append(moduleEntity.getModuleName());
                    displayString.append(" -- ").append(moduleEntity.getDescription());
                    List<Integer> l1s = userPermissionMatrixService.draftL1Component(module.intValue());
                    if (l1s != null && l1s.size() > 0)
                    {
                        for (Integer l1 : l1s)
                        {
                            displayString.append("<div style='padding-left:25px;font-size: 16px'>");
                            L1Component l1Component = this.l1ComponentService.getL1ComponentByID(l1.intValue());
                            if ((l1Component.getIsDraft()!=null && l1Component.getIsDraft())||this.l1ComponentService.isThereDraftParamterForComponent(l1Component.getId()))
                            { // FIXME
                                displayString.append("<a href='../l1component/view/").append(l1Component.getId()).append("'>").append(l1Component.getName()).append("</a>");
                            }
                            else
                            {
                                displayString.append(l1Component.getName());
                            }
                            displayString.append(" -- ").append(l1Component.getDescription());
                            List<Integer> l2s = userPermissionMatrixService.draftL2Component(l1);
                            if (l2s != null && l2s.size() > 0)
                            {
                                for (Integer l2 : l2s)
                                {
                                    displayString.append("<div style='padding-left:25px;font-size: 14px'>");
                                    L2Component l2Component = this.l2ComponentService.getL2ComponentByID(l2.intValue());
                                    if ((l2Component.getIsDraft()!=null && l2Component.getIsDraft())||this.l2ComponentService.isThereDraftParamterForComponent(l2Component.getId()))
                                    { // FIXME
                                        displayString.append("<a href='../l2component/view/").append(l2Component.getId()).append("'>").append(l2Component.getName())
                                                .append("</a>");
                                    }
                                    else
                                    {
                                        displayString.append(l2Component.getName());
                                    }
                                    displayString.append(" -- ").append(l2Component.getDescription());
                                    List<Integer> l3s = userPermissionMatrixService.draftL3Component(l2);
                                    if (l3s != null && l3s.size() > 0)
                                    {
                                        for (Integer l3 : l3s)
                                        {
                                            displayString.append("<div style='padding-left:25px;;font-size: 13px'>");
                                            L3Component l3Component = this.l3ComponentService.getL3ComponentByID(l3
                                                    .intValue());
                                            if ((l3Component.getIsDraft()!=null && l3Component.getIsDraft())||this.l3ComponentService.isThereDraftParamterForComponent(l3Component.getId()))
                                            { // FIXME
                                                displayString.append("<a href='../l3component/view/").append(l3Component.getId()).append("'>").append(l3Component.getName())
                                                        .append("</a>");
                                            }
                                            else
                                            {
                                                displayString.append(l3Component.getId()).append(l3Component.getName());
                                            }
                                            displayString.append(" -- ").append(l3Component.getDescription());
                                            displayString.append("</div>");
                                        }
                                    }
                                    displayString.append("</div>");
                                }
                            }
                            displayString.append("</div>");
                        }

                    }
                    displayString.append("</div>");
                }
            }
            displayString.append("</div>");
            displayString.append("</div>");
            displayString.append("<hr></hr>");
        }
        model.addAttribute("content", displayString.toString());
        
        return "/feature/listdraft";
    }
    
    @RequestMapping(value="/function/matrix/show/{featureId}", method = RequestMethod.GET)
    public String showFunctionMatrix(@PathVariable int featureId, Model model)
    {
        Surounder rounder = new Surounder();
        rounder.getBean().addAll(featureService.generateFunctionMatrix(featureId));
        model.addAttribute("rounder",rounder);
        model.addAttribute("feauteId", featureId);
        model.addAttribute("modules", moduleService.getModulesByFeatureWithChild(featureService.getFeatureByID(featureId)));
        return "/function/show/matrix";
    }
    
    @RequestMapping(value="/function/matrix/{featureId}/updatematrix", method = RequestMethod.POST)
    public String updateMatrix(@PathVariable int featureId, @ModelAttribute("rounder")Surounder rounder, Model model)
    {
        model.addAttribute("rounder",rounder);
        model.addAttribute("feauteId", featureId);
        model.addAttribute("modules", moduleService.getModulesByFeatureWithChild(featureService.getFeatureByID(featureId)));
        
        featureService.updateFunctionMatrix(rounder, featureId);
        
        return "/function/show/matrix";
    }
    
    public FeatureService getFeatureService()
    {
        return featureService;
    }

    public void setFeatureService(FeatureService featureService)
    {
        this.featureService = featureService;
    }
}
