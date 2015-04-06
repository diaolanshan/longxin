package org.longxin.web.controller;

import org.apache.commons.lang.StringUtils;
import org.longxin.domains.L1Component;
import org.longxin.domains.L1ComponentParameter;
import org.longxin.domains.L2Component;
import org.longxin.domains.Users;
import org.longxin.service.L1ComponentParameterService;
import org.longxin.service.L1ComponentService;
import org.longxin.service.L2ComponentService;
import org.longxin.util.OperationType;
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
@RequestMapping("/l1component")
@SessionAttributes({"component", "parameter"})
public class L1ComponentController<T> extends ComponentContoller
{
    @Autowired
    L1ComponentParameterService l1ComponentParameterService;

    @Autowired
    L1ComponentService l1ComponentService;

    @Autowired
    L2ComponentService l2ComponentService;

    @RequestMapping(value = "/view/{l1id}", method = RequestMethod.GET)
    public String viewL1Component(@PathVariable int l1id, Model model)
    {
        L1Component component = l1ComponentService.getL1ComponentByID(l1id);
        model.addAttribute("component", component);
        model.addAttribute("parameters", l1ComponentParameterService.getL1Paramters(component));
        model.addAttribute("parameter", new L1ComponentParameter());
        model.addAttribute("l2components", l1ComponentService.getL2ComponentsByL1(component));
        return "/l1/view";
    }

    @RequestMapping(value = "/diagram/{componentId}", method = RequestMethod.GET)
    public String showDiagram(@PathVariable int componentId, Model model)
    {
        L1Component component = l1ComponentService.getL1ComponentByID(componentId);
        model.addAttribute("component", component);
        return "/l1component/diagram";
    }

    @RequestMapping(value = "/functiondiagram/{componentId}", method = RequestMethod.GET)
    public String showFunctionDiagram(@PathVariable int componentId, Model model)
    {
        L1Component component = l1ComponentService.getL1ComponentByID(componentId);
        model.addAttribute("component", component);
        return "/l1component/functiondiagram";
    }

    @RequestMapping(value = "/update/{l1id}", method = RequestMethod.POST)
    public String updateComponent(
        @PathVariable int l1id,
        @ModelAttribute("component") L1Component component,
        Model model)
    {
        l1ComponentService.updateL1Component(component);
        model.addAttribute("component", component);
        return "redirect:/l1component/view/" + l1id;
    }

    @RequestMapping(value = "/view/{l1id}/add/parameter", method = RequestMethod.POST)
    public @ResponseBody
    ModelMap addComponentParameter(@PathVariable int l1id, @RequestBody L1ComponentParameter l1Parameter)
    {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Users user = userService.findUserByUserName(userDetails.getUsername());
        
        L1Component component = l1ComponentService.getL1ComponentByID(l1id);
        l1Parameter.setL1Component(component);
        if (!userService.isApproveRequired(user))
        {
            // user has the super role, no need to approve this.
            l1Parameter.setIsDraft(Boolean.FALSE);
        }
        else if (!component.getTemplate())
        {
            l1Parameter.setIsDraft(Boolean.TRUE);
        }
        
        l1ComponentParameterService.addParameter(l1Parameter);
        
        //track the change.
        trackChange(l1Parameter, user, OperationType.ADD);
        
        return new ModelMap("success", 1);
    }

    @RequestMapping(value = "/delete/parameter/{parameterid}", method = RequestMethod.POST)
    public void deleteComponentParameter(@PathVariable int parameterid)
    {
        l1ComponentParameterService.deleteParameter(parameterid);
    }

    @RequestMapping(value = "/view/approve/parameter/{parameterId}", method = RequestMethod.GET)
    public @ResponseBody
    ModelMap approveComponentParameter(@PathVariable int parameterId)
    {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Users user = userService.findUserByUserName(userDetails.getUsername());

        L1ComponentParameter parameter = l1ComponentParameterService.getL1ComponentParamtersByID(parameterId);

        trackChange(parameter, user, OperationType.APPROVE);

        parameter.setIsDraft(Boolean.FALSE);
        parameter.setParameterValue(parameter.getDraftValue());
        parameter.setDraftValue(null);

        l1ComponentParameterService.updateParameter(parameter);
        return new ModelMap("success", 1);
    }

    @RequestMapping(value = "/view/decline/parameter/{parameterId}", method = RequestMethod.GET)
    public @ResponseBody
    ModelMap declineComponentParameter(@PathVariable int parameterId)
    {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Users user = userService.findUserByUserName(userDetails.getUsername());

        L1ComponentParameter parameter = l1ComponentParameterService.getL1ComponentParamtersByID(parameterId);

        trackChange(parameter, user, OperationType.DECLINE);

        parameter.setIsDraft(Boolean.FALSE);
        parameter.setDraftValue(null);

        l1ComponentParameterService.updateParameter(parameter);
        return new ModelMap("success", 1);
    }

    @RequestMapping(value = "/view/{l1id}/update/parameter", method = RequestMethod.POST)
    public @ResponseBody
    ModelMap updateComponentParameter(@PathVariable int l1id, @RequestBody L1ComponentParameter json)
    {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Users user = userService.findUserByUserName(userDetails.getUsername());

        L1Component component = l1ComponentService.getL1ComponentByID(l1id);
        json.setL1Component(component);
        json.setIsDraft(Boolean.TRUE); // By default, it should be true.

        trackChange(json, user, OperationType.CHANGE);
        
        if (!userService.isApproveRequired(user))
        {
            // user has the super role, no need to approve this.
            json.setIsDraft(Boolean.FALSE);
            json.setParameterValue(json.getDraftValue());
        }
        else if (!component.getTemplate())
        {
            if (StringUtils.isNotEmpty(json.getOptions()))
            {
                String[] options = StringUtils.split(json.getOptions(), ",");
                for (String option : options)
                {
                    if (StringUtils.containsIgnoreCase(option, json.getDraftValue()))
                    {
                        json.setParameterValue(json.getDraftValue());
                        json.setIsDraft(Boolean.FALSE);
                    }
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

        l1ComponentParameterService.updateParameter(json);
        return new ModelMap("success", 1);
    }
   
    @RequestMapping(value = "/view/{l1Id}/add/component", method = RequestMethod.POST)
    public String addL2Componment(@PathVariable int l1Id, L2Component l2Component)
    {
        L1Component l1Component = l1ComponentService.getL1ComponentByID(l1Id);
        l2Component.setL1Component(l1Component);
        l2Component.setTemplate(l1Component.getTemplate());
        l2ComponentService.addL2Component(l2Component);
        return "redirect:/l1component/view/" + l1Id;
    }

    @RequestMapping(value = "/delete/component/{l2Id}", method = RequestMethod.POST)
    public void deleteL2Componment(@PathVariable int l2Id)
    {
        l2ComponentService.deleteL2Component(l2Id);
    }
}
