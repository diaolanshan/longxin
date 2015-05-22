package org.longxin.web.controller;

import org.apache.commons.lang.StringUtils;
import org.longxin.domains.L3Component;
import org.longxin.domains.L3ComponentParameter;
import org.longxin.domains.Users;
import org.longxin.service.L3ComponentParameterService;
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
@RequestMapping("/l3component")
@SessionAttributes("component")
public class L3ComponentController extends ComponentContoller
{
	@Autowired
	L3ComponentParameterService l3ComponentParameterService;
	
	@Autowired
	L3ComponentService l3ComponentService;
	
	@Autowired
    UserService userService;

    @Autowired
    UserPermissionMatrixService userPermissionMatrixService;

	@RequestMapping(value = "/view/{l3id}", method = RequestMethod.GET)
	public String viewL3Component(@PathVariable int l3id, Model model)
	{
		L3Component component = l3ComponentService.getL3ComponentByID(l3id);
		model.addAttribute("component", component);
		model.addAttribute("parameters",
				l3ComponentParameterService.getL3Paramters(component));
		model.addAttribute("parameter", new L3ComponentParameter());
		
		UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Users user = userService.findUserByUserName(userDetails.getUsername());
        if(user.getRole()==Roles.ROLE_ADMIN)
        {
            model.addAttribute("isAllowed", "true");
        }else
        {
            model.addAttribute("isAllowed", userPermissionMatrixService.isUserAllowedForFeature(user.getId(), l3ComponentService.getFeatureId(component.getId())));
        }
        
		return "/l3/view";
	}

	@RequestMapping(value = "/diagram/{componentId}", method = RequestMethod.GET)
	public String showDiagram(@PathVariable int componentId, Model model)
	{
		L3Component component = l3ComponentService
				.getL3ComponentByID(componentId);
		model.addAttribute("component", component);
		return "/l3component/diagram";
	}

	@RequestMapping(value = "/update/{l3id}", method = RequestMethod.POST)
	public String updateComponent(@PathVariable int l3id, @ModelAttribute("component") L3Component component ,Model model)
	{
		l3ComponentService.updateL3Component(component);
		model.addAttribute("component", component);
		return "redirect:/l3component/view/"+l3id;
	}

	@RequestMapping(value = "/view/{l3id}/add/parameter", method = RequestMethod.POST)
	public @ResponseBody ModelMap addComponentParameter(@PathVariable int l3id,
			@RequestBody L3ComponentParameter l3Parameter)
	{
	    UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Users user = userService.findUserByUserName(userDetails.getUsername());
        
		L3Component component = l3ComponentService.getL3ComponentByID(l3id);
		l3Parameter.setL3Component(component);
        if (!userService.isApproveRequired(user))
        {
            // user has the super role, no need to approve this.
            l3Parameter.setIsDraft(Boolean.FALSE);
        }
        else if (!component.getTemplate())
        {
            l3Parameter.setIsDraft(Boolean.TRUE);
        }
       
        l3ComponentParameterService.addParameter(l3Parameter);
        
        //track the change.
        trackChange(l3Parameter, user, OperationType.ADD);
        
		return new ModelMap("success", 1);
	}

	@RequestMapping(value = "/delete/parameter/{parameterid}", method = RequestMethod.POST)
	public void deleteComponentParameter(@PathVariable int parameterid)
	{
	    UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Users user = userService.findUserByUserName(userDetails.getUsername());
        trackChange(l3ComponentParameterService.getL3ComponentParamtersByID(parameterid), user, OperationType.DELETE);
        
		l3ComponentParameterService.deleteParameter(parameterid);
	}
	
	@RequestMapping(value = "/view/approve/parameter/{parameterId}", method = RequestMethod.POST)
    public @ResponseBody
    ModelMap approveComponentParameter(@PathVariable int parameterId, @RequestBody L3ComponentParameter parameter)
    {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Users user = userService.findUserByUserName(userDetails.getUsername());

        trackChange(parameter, user, OperationType.APPROVE);
        
        parameter = l3ComponentParameterService.getL3ComponentParamtersByID(parameterId);

        parameter.setIsDraft(Boolean.FALSE);
        parameter.setParameterValue(parameter.getDraftValue());
        parameter.setDraftValue(null);

        l3ComponentParameterService.updateParameter(parameter);
        return new ModelMap("success", 1);
    }

    @RequestMapping(value = "/view/decline/parameter/{parameterId}", method = RequestMethod.POST)
    public @ResponseBody
    ModelMap declineComponentParameter(@PathVariable int parameterId, @RequestBody L3ComponentParameter parameter)
    {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Users user = userService.findUserByUserName(userDetails.getUsername());

        trackChange(parameter, user, OperationType.DECLINE);
        
        parameter = l3ComponentParameterService.getL3ComponentParamtersByID(parameterId);

        parameter.setIsDraft(Boolean.FALSE);
        parameter.setDraftValue(null);

        l3ComponentParameterService.updateParameter(parameter);
        return new ModelMap("success", 1);
    }

    @RequestMapping(value = "/view/{l3id}/update/parameter", method = RequestMethod.POST)
    public @ResponseBody
    ModelMap updateComponentParameter(@PathVariable int l3id, @RequestBody L3ComponentParameter json)
    {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Users user = userService.findUserByUserName(userDetails.getUsername());

        L3Component component = l3ComponentService.getL3ComponentByID(l3id);
        json.setL3Component(component);
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

        l3ComponentParameterService.updateParameter(json);
        return new ModelMap("success", 1);
    }
}
