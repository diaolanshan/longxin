package org.longxin.web.controller;

import org.longxin.domains.L1Component;
import org.longxin.domains.L1ComponentParameter;
import org.longxin.domains.L2Component;
import org.longxin.service.L1ComponentParameterService;
import org.longxin.service.L1ComponentService;
import org.longxin.service.L2ComponentService;
import org.springframework.beans.factory.annotation.Autowired;
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
@SessionAttributes("l1component")
public class L1ComponentController
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
		model.addAttribute("parameters",
				l1ComponentParameterService.getL1Paramters(component));
		model.addAttribute("parameter", new L1ComponentParameter());
		model.addAttribute("l2components",
				l1ComponentService.getL2ComponentsByL1(component));
		return "/l1/view";
	}

	@RequestMapping(value = "/diagram/{componentId}", method = RequestMethod.GET)
	public String showDiagram(@PathVariable int componentId, Model model)
	{
		L1Component component = l1ComponentService
				.getL1ComponentByID(componentId);
		model.addAttribute("component", component);
		return "/l1component/diagram";
	}

	@RequestMapping(value = "/update/{l1id}", method = RequestMethod.POST)
	public String viewModule(@PathVariable int l1id,
			@ModelAttribute("l1Component") L1Component l1component)
	{
		l1ComponentService.updateL1Component(l1component);
		return "redirect:/l1component/view/" + l1id;
	}

	@RequestMapping(value = "/view/{l1id}/add/parameter", method = RequestMethod.POST)
	public @ResponseBody ModelMap addComponentParameter(@PathVariable int l1id,
			@RequestBody L1ComponentParameter json)
	{
		L1Component component = l1ComponentService.getL1ComponentByID(l1id);
		json.setL1Component(component);
		l1ComponentParameterService.addParameter(json);
		return new ModelMap("success", 1);
	}

	@RequestMapping(value = "/delete/parameter/{parameterid}", method = RequestMethod.POST)
	public void deleteComponentParameter(@PathVariable int parameterid)
	{
		l1ComponentParameterService.deleteParameter(parameterid);
	}

	@RequestMapping(value = "/view/{l1id}/update/parameter", method = RequestMethod.POST)
	public @ResponseBody ModelMap updateComponentParameter(
			@PathVariable int l1id, @RequestBody L1ComponentParameter json)
	{
		L1Component component = l1ComponentService.getL1ComponentByID(l1id);
		json.setL1Component(component);
		l1ComponentParameterService.updateParameter(json);
		return new ModelMap("success", 1);
	}

	@RequestMapping(value = "/view/{l1Id}/add/component", method = RequestMethod.POST)
	public String addL2Componment(@PathVariable int l1Id,
			L2Component l2Component)
	{
		l2Component.setL1Component(l1ComponentService.getL1ComponentByID(l1Id));
		l2ComponentService.addL2Component(l2Component);
		return "redirect:/l1component/view/" + l1Id;
	}

	@RequestMapping(value = "/delete/component/{l2Id}", method = RequestMethod.POST)
	public void deleteL2Componment(@PathVariable int l2Id)
	{
		l2ComponentService.deleteL2Component(l2Id);
	}
}