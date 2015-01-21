package org.longxin.web.controller;

import org.longxin.domains.L1Component;
import org.longxin.domains.Module;
import org.longxin.service.L1ComponentParameterService;
import org.longxin.service.L1ComponentService;
import org.longxin.service.ModuleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@RequestMapping("/l1component")
@SessionAttributes("l1component")
public class L1ComponentController
{

	@Autowired
	L1ComponentParameterService l1ComponentParameterService;
	
	@Autowired
	L1ComponentService l1ComponentService;

	@RequestMapping(value = "/view/{l1id}", method = RequestMethod.GET)
	public String viewModule(@PathVariable int l1id, Model model)
	{
		L1Component component = l1ComponentService.getL1ComponentByID(l1id);
		model.addAttribute("component", component);
		model.addAttribute("parameters", l1ComponentParameterService.getL1Paramters(component));
		return "/module/view";
	}
	
	@RequestMapping(value = "/diagram/{componentId}", method = RequestMethod.GET)
	public String showDiagram(@PathVariable int componentId,Model model)
	{
		L1Component component = l1ComponentService.getL1ComponentByID(componentId);
		model.addAttribute("component", component);
		return "/l1component/diagram";
	}

}
