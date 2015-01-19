package org.longxin.web.controller;

import org.longxin.domains.Feature;
import org.longxin.domains.Module;
import org.longxin.domains.Product;
import org.longxin.service.FeatureService;
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

	@RequestMapping(value = "/view/{moduleId}", method = RequestMethod.GET)
	public String viewModule(@PathVariable int moduleId, Model model)
	{
		Module module = moduleService.getModuleByID(moduleId);
		model.addAttribute("module", module);
//		model.addAttribute("modules",
//				moduleService.getModulesByFeature(feature));
		return "/module/view";
	}
	
	@RequestMapping(value = "/diagram/{moduleId}", method = RequestMethod.GET)
	public String showModuleDiagram(@PathVariable int featureId,Model model)
	{
		Module module = moduleService.getModuleByID(featureId);
		model.addAttribute("module", module);
		return "/feature/diagram";
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
