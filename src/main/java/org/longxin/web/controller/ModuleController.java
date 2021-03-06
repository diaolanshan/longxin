package org.longxin.web.controller;

import org.longxin.domains.L1Component;
import org.longxin.domains.Module;
import org.longxin.service.FunctionModuleService;
import org.longxin.service.L1ComponentService;
import org.longxin.service.ModuleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@RequestMapping("/module")
@SessionAttributes("module")
public class ModuleController
{
	@Autowired
	ModuleService moduleService;
	
	@Autowired
	FunctionModuleService functionModuleService;
	
	@Autowired
	L1ComponentService l1ComponentService;

	@RequestMapping(value = "/view/{moduleId}", method = RequestMethod.GET)
	public String viewModule(@PathVariable int moduleId, Model model)
	{
		Module module = moduleService.getModuleByID(moduleId);
		model.addAttribute("module", module);
		//The result should be ordered.
		model.addAttribute("l1components", l1ComponentService.getL1ComponentsByModule(module));
		return "/module/view";
	}

	@RequestMapping(value = "/diagram/{moduleId}", method = RequestMethod.GET)
	public String showModuleDiagram(@PathVariable int moduleId, Model model)
	{
		Module module = moduleService.getModuleByIDForDiagram(moduleId);
		model.addAttribute("module", module);
		return "/module/diagram";
	}

	@RequestMapping(value = "/functiondiagram/{moduleId}", method = RequestMethod.GET)
	public String showModuleFunctionDiagram(@PathVariable int moduleId, Model model)
	{
		Module module = moduleService.getModuleByIDForDiagram(moduleId);
		model.addAttribute("module", module);
		return "/module/functiondiagram";
	}

	@RequestMapping(value = "/update/{moduleId}", method = RequestMethod.POST)
	public String updateModuleDescription(
			@ModelAttribute("module") Module module, Model model)
	{
		moduleService.updateModule(module);
		model.addAttribute("module", module);
		return "redirect:/module/view/" + module.getId();
	}

	@RequestMapping(value = "/view/{moduleId}/add/component", method = RequestMethod.POST)
	public String addL1Componment(@PathVariable int moduleId,
			L1Component l1Component)
	{
		Module module = moduleService.getModuleByID(moduleId);
		l1Component.setModule(module);
		l1Component.setTemplate(module.getTemplate());
		l1Component.setIsDraft(!module.getTemplate());
		l1ComponentService.addL1Component(l1Component);
		return "redirect:/module/view/" + moduleId;
	}

	@RequestMapping(value = "/component/{l1Id}", method = RequestMethod.DELETE)
	public @ResponseBody String deleteL1Componment(@PathVariable int l1Id)
	{
		l1ComponentService.deleteL1Component(l1Id);
		
		return "SUCCESS";
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