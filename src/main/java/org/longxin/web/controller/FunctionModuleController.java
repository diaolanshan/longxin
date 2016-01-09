package org.longxin.web.controller;

import org.longxin.domains.FunctionModule;
import org.longxin.service.FunctionModuleService;
import org.longxin.service.L1ComponentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@RequestMapping("/functionmodule")
@SessionAttributes("functionModule")
public class FunctionModuleController
{
	@Autowired
	FunctionModuleService functionModuleService;
	
	@Autowired
	L1ComponentService l1ComponentService;

	@RequestMapping(value = "/view/{moduleId}", method = RequestMethod.GET)
	public String viewFunctionModule(@PathVariable int moduleId, Model model)
	{
		FunctionModule functionModule = functionModuleService.getFunctionModuleById(moduleId);
		model.addAttribute("functionModule", functionModule);
		//The result should be ordered.
		model.addAttribute("l1components", l1ComponentService.getL1ComponentsByFunctionModule(functionModule));
		return "/functionmodule/view";
	}

//	@RequestMapping(value = "/diagram/{moduleId}", method = RequestMethod.GET)
//	public String showModuleDiagram(@PathVariable int moduleId, Model model)
//	{
//		Module module = moduleService.getModuleByIDForDiagram(moduleId);
//		model.addAttribute("module", module);
//		return "/module/diagram";
//	}
//
//	@RequestMapping(value = "/functiondiagram/{moduleId}", method = RequestMethod.GET)
//	public String showModuleFunctionDiagram(@PathVariable int moduleId, Model model)
//	{
//		Module module = moduleService.getModuleByIDForDiagram(moduleId);
//		model.addAttribute("module", module);
//		return "/module/functiondiagram";
//	}
//
	@RequestMapping(value = "/update/{functionModule}", method = RequestMethod.POST)
	public String updateFunctionModule(
			@ModelAttribute("functionModule") FunctionModule functionModule, Model model)
	{
		functionModuleService.saveFunctionModule(functionModule);
		model.addAttribute("functionModule", functionModule);
		return "redirect:/functionmodule/view/" + functionModule.getId();
	}
//
//	@RequestMapping(value = "/view/{moduleId}/add/component", method = RequestMethod.POST)
//	public String addL1Componment(@PathVariable int moduleId,
//			L1Component l1Component)
//	{
//		Module module = moduleService.getModuleByID(moduleId);
//		l1Component.setModule(module);
//		l1Component.setTemplate(module.getTemplate());
//		l1Component.setIsDraft(!module.getTemplate());
//		l1ComponentService.addL1Component(l1Component);
//		return "redirect:/module/view/" + moduleId;
//	}
//
//	@RequestMapping(value = "/delete/component/{l1Id}", method = RequestMethod.POST)
//	public void deleteL1Componment(@PathVariable int l1Id)
//	{
//		l1ComponentService.deleteL1Component(l1Id);
//	}
}