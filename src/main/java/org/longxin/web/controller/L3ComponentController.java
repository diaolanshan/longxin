package org.longxin.web.controller;

import org.longxin.domains.L3Component;
import org.longxin.domains.L3ComponentParameter;
import org.longxin.service.L3ComponentParameterService;
import org.longxin.service.L3ComponentService;
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
@RequestMapping("/l3component")
@SessionAttributes("l3component")
public class L3ComponentController
{

	@Autowired
	L3ComponentParameterService l3ComponentParameterService;
	
	@Autowired
	L3ComponentService l3ComponentService;

	@RequestMapping(value = "/view/{l3id}", method = RequestMethod.GET)
	public String viewModule(@PathVariable int l3id, Model model)
	{
		L3Component component = l3ComponentService.getL3ComponentByID(l3id);
		model.addAttribute("component", component);
		model.addAttribute("parameters", l3ComponentParameterService.getL3Paramters(component));
		model.addAttribute("parameter", new L3ComponentParameter());
		return "/l3/view";
	}
	
	@RequestMapping(value = "/diagram/{componentId}", method = RequestMethod.GET)
	public String showDiagram(@PathVariable int componentId, Model model)
	{
		L3Component component = l3ComponentService.getL3ComponentByID(componentId);
		model.addAttribute("component", component);
		return "/l3component/diagram";
	}
	
	@RequestMapping(value = "/view/{l3id}/add/parameter", method = RequestMethod.POST)
	public @ResponseBody ModelMap  addComponentParameter(@PathVariable int l3id, @RequestBody L3ComponentParameter json)
	{
		L3Component component = l3ComponentService.getL3ComponentByID(l3id);
		json.setL3Component(component);
		json.setValueScope(json.getMinValue()+","+json.getMaxValue());
		l3ComponentParameterService.addParameter(json);
		return new ModelMap("success", 1);
	}

}
