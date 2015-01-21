package org.longxin.web.controller;

import org.longxin.domains.Module;
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
@RequestMapping("/module")
@SessionAttributes("module")
public class ModuleController
{

	@Autowired
	ModuleService moduleService;
	
	@Autowired
	L1ComponentService l1ComponentService;

	@RequestMapping(value = "/view/{moduleId}", method = RequestMethod.GET)
	public String viewModule(@PathVariable int moduleId, Model model)
	{
		Module module = moduleService.getModuleByID(moduleId);
		model.addAttribute("module", module);
		model.addAttribute("l1components", module.getL1Components());
		return "/module/view";
	}
	
	@RequestMapping(value = "/diagram/{moduleId}", method = RequestMethod.GET)
	public String showModuleDiagram(@PathVariable int moduleId,Model model)
	{
		Module module = moduleService.getModuleByID(moduleId);
		model.addAttribute("module", module);
		return "/module/diagram";
	}

	public ModuleService getModuleService()
	{
		return moduleService;
	}

	public void setModuleService(ModuleService moduleService)
	{
		this.moduleService = moduleService;
	}

}
