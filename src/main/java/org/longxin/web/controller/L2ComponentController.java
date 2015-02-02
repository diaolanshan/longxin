package org.longxin.web.controller;

import org.longxin.domains.L2Component;
import org.longxin.domains.L2ComponentParameter;
import org.longxin.service.L2ComponentParameterService;
import org.longxin.service.L2ComponentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@RequestMapping("/l2component")
@SessionAttributes("l2component")
public class L2ComponentController
{

	@Autowired
	L2ComponentParameterService l2ComponentParameterService;
	
	@Autowired
	L2ComponentService l2ComponentService;

	@RequestMapping(value = "/view/{l2id}", method = RequestMethod.GET)
	public String viewModule(@PathVariable int l2id, Model model)
	{
		L2Component component = l2ComponentService.getL2ComponentByID(l2id);
		model.addAttribute("component", component);
		model.addAttribute("parameters", l2ComponentParameterService.getL2Paramters(component));
		model.addAttribute("parameter", new L2ComponentParameter());
		model.addAttribute("l3components", l2ComponentService.getL3ComponentsByL2(component));
		return "/l2/view";
	}
	
	@RequestMapping(value = "/diagram/{componentId}", method = RequestMethod.GET)
	public String showDiagram(@PathVariable int componentId, Model model)
	{
		L2Component component = l2ComponentService.getL2ComponentByID(componentId);
		model.addAttribute("component", component);
		return "/l2component/diagram";
	}
	
	@RequestMapping(value = "/view/{l2id}/add/parameter", method = RequestMethod.POST)
	public @ResponseBody ModelMap  addComponentParameter(@PathVariable int l2id, @RequestBody L2ComponentParameter json)
	{
		L2Component component = l2ComponentService.getL2ComponentByID(l2id);
		json.setL2Component(component);
		l2ComponentParameterService.addParameter(json);
		return new ModelMap("success", 1);
	}

}
