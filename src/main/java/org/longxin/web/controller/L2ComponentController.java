package org.longxin.web.controller;

import org.apache.commons.lang.StringUtils;
import org.longxin.domains.L2Component;
import org.longxin.domains.L2ComponentParameter;
import org.longxin.domains.L3Component;
import org.longxin.domains.Users;
import org.longxin.service.L2ComponentParameterService;
import org.longxin.service.L2ComponentService;
import org.longxin.service.L3ComponentService;
import org.longxin.service.UserPermissionMatrixService;
import org.longxin.service.UserService;
import org.longxin.util.OperationType;
import org.longxin.util.Roles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@RequestMapping("/l2component")
@SessionAttributes({"component"})
public class L2ComponentController extends ComponentContoller
{
    @Autowired
    L2ComponentParameterService l2ComponentParameterService;

    @Autowired
    L2ComponentService l2ComponentService;

    @Autowired
    L3ComponentService l3ComponentService;

    @Autowired
    UserService userService;
    
    @Autowired
    UserPermissionMatrixService userPermissionMatrixService;

    @RequestMapping(value = "/view/{l2id}", method = RequestMethod.GET)
    public String viewL2Component(@PathVariable int l2id, Model model)
    {
        L2Component component = l2ComponentService.getL2ComponentByID(l2id);
        model.addAttribute("component", component);
        model.addAttribute("parameters", l2ComponentParameterService.getL2Paramters(component));
        model.addAttribute("parameter", new L2ComponentParameter());
        model.addAttribute("l3components", l3ComponentService.getL3ComponentsByL2(component));
        
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Users user = userService.findUserByUserName(userDetails.getUsername());
        if(user.getRole()==Roles.ROLE_ADMIN)
        {
            model.addAttribute("isAllowed", "true");
        }else
        {
            model.addAttribute("isAllowed", userPermissionMatrixService.isUserAllowedForFeature(user.getId(), l2ComponentService.getFeatureId(component.getId())));
        }
        
        return "/l2/view";
    }

    @RequestMapping(value = "/diagram/{componentId}", method = RequestMethod.GET)
    public String showDiagram(@PathVariable int componentId, Model model)
    {
        L2Component component = l2ComponentService.getL2ComponentByIDForDiagram(componentId);
        model.addAttribute("component", component);
        return "/l2component/diagram";
    }

    @RequestMapping(value = "/functiondiagram/{componentId}", method = RequestMethod.GET)
    public String showFunctionDiagram(@PathVariable int componentId, Model model)
    {
        L2Component component = l2ComponentService.getL2ComponentByIDForDiagram(componentId);
        model.addAttribute("component", component);
        return "/l2component/functiondiagram";
    }

    @RequestMapping(value = "/update/{l2id}", method = RequestMethod.POST)
    public String updateComponent(
        @PathVariable int l2id,
        @ModelAttribute("component") L2Component component,
        Model model)
    {
        l2ComponentService.updateL2Component(component);
        model.addAttribute("component", component);
        return "redirect:/l2component/view/" + l2id;
    }

    @RequestMapping(value = "/view/{l2id}/add/parameter", method = RequestMethod.POST)
    public @ResponseBody
    ModelMap addComponentParameter(@PathVariable int l2id, @RequestBody L2ComponentParameter l2Parameter)
    {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Users user = userService.findUserByUserName(userDetails.getUsername());

        L2Component component = l2ComponentService.getL2ComponentByID(l2id);
        l2Parameter.setL2Component(component);
        if (!userService.isApproveRequired(user))
        {
            // user has the super role, no need to approve this.
            l2Parameter.setIsDraft(Boolean.FALSE);
        }
        else if (!component.getTemplate())
        {
            l2Parameter.setIsDraft(Boolean.TRUE);
        }
       
        l2ComponentParameterService.addParameter(l2Parameter);
        
        //track the change.
        trackChange(l2Parameter, user, OperationType.ADD);
        
        return new ModelMap("success", 1);
    }

    @RequestMapping(value = "/parameter/{parameterid}", method = RequestMethod.DELETE)
    public @ResponseBody ModelMap deleteComponentParameter(@PathVariable int parameterid)
    {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Users user = userService.findUserByUserName(userDetails.getUsername());
        trackChange(l2ComponentParameterService.getL2ComponentParamtersByID(parameterid), user, OperationType.DELETE);
        
        l2ComponentParameterService.deleteParameter(parameterid);
        
        return new ModelMap("success", 1);
    }
    
    @RequestMapping(value = "/view/approve/parameter/{parameterId}", method = RequestMethod.POST)
    public @ResponseBody
    ModelMap approveComponentParameter(@PathVariable int parameterId, @RequestBody L2ComponentParameter parameter)
    {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Users user = userService.findUserByUserName(userDetails.getUsername());
        
        trackChange(parameter, user, OperationType.APPROVE);
        
        parameter = l2ComponentParameterService.getL2ComponentParamtersByID(parameterId);

        parameter.setIsDraft(Boolean.FALSE);
        parameter.setParameterValue(parameter.getDraftValue());
        parameter.setDraftValue(null);

        l2ComponentParameterService.updateParameter(parameter);
        return new ModelMap("success", 1);
    }

    @RequestMapping(value = "/view/decline/parameter/{parameterId}", method = RequestMethod.POST)
    public @ResponseBody
    ModelMap declineComponentParameter(@PathVariable int parameterId, @RequestBody L2ComponentParameter parameter)
    {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Users user = userService.findUserByUserName(userDetails.getUsername());

        trackChange(parameter, user, OperationType.DECLINE);
        
        parameter = l2ComponentParameterService.getL2ComponentParamtersByID(parameterId);

        parameter.setIsDraft(Boolean.FALSE);
        parameter.setDraftValue(null);

        l2ComponentParameterService.updateParameter(parameter);
        return new ModelMap("success", 1);
    }

    @RequestMapping(value = "/view/{l2id}/update/parameter", method = RequestMethod.POST)
    public @ResponseBody
    ModelMap updateComponentParameter(@PathVariable int l2id, @RequestBody L2ComponentParameter json)
    {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Users user = userService.findUserByUserName(userDetails.getUsername());

        L2Component component = l2ComponentService.getL2ComponentByID(l2id);
        json.setL2Component(component);
        json.setIsDraft(Boolean.TRUE); // By default, it should be true.

        trackChange(json, user, OperationType.CHANGE);
        
        if (!userService.isApproveRequired(user))
        {
            // user has the super role, no need to approve this.
            json.setIsDraft(Boolean.FALSE);
            json.setParameterValue(json.getDraftValue());
        }
        else
        {
            if (StringUtils.isNotEmpty(json.getOptions()))
            {
                if (StringUtils.containsIgnoreCase(json.getOptions(), json.getDraftValue()))
                {
                    json.setParameterValue(json.getDraftValue());
                    json.setIsDraft(Boolean.FALSE);
                }
            }
            else if (json.getMinValue() != null && json.getMaxValue() != null)
            {
                float minValue = Float.valueOf(json.getMinValue());
                float maxValue = Float.valueOf(json.getMaxValue());
                float draftValue = Float.valueOf(json.getDraftValue());

                if (minValue <= draftValue && draftValue <= maxValue)
                {
                    json.setParameterValue(json.getDraftValue());
                    json.setIsDraft(Boolean.FALSE);
                }
            }
        }

        l2ComponentParameterService.updateParameter(json);
        return new ModelMap("success", 1);
    }

    @RequestMapping(value = "/view/{l2Id}/add/component", method = RequestMethod.POST)
    public String addL3Componment(@PathVariable int l2Id, L3Component l3Component)
    {
        L2Component l2Component = l2ComponentService.getL2ComponentByID(l2Id);
        l3Component.setL2Component(l2Component);
        l3Component.setTemplate(l2Component.getTemplate());
        l3Component.setIsDraft(!l3Component.getTemplate());
        l3ComponentService.addL3Component(l3Component);
        return "redirect:/l2component/view/" + l2Id;
    }

    @RequestMapping(value = "/component/{l3Id}", method = RequestMethod.DELETE)
    public @ResponseBody ModelMap deleteL3Componment(@PathVariable int l3Id)
    {
        l3ComponentService.deleteL3Component(l3Id);
        
        return new ModelMap("success", 1);
    }
}
