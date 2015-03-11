package org.longxin.web.controller;

import org.longxin.domains.Feature;
import org.longxin.domains.L1Component;
import org.longxin.domains.Module;
import org.longxin.domains.Product;
import org.longxin.service.FeatureService;
import org.longxin.service.ModuleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@RequestMapping("/feature")
@SessionAttributes("feature")
public class FeatureController
{

	@Autowired
	FeatureService featureService;

	@Autowired
	ModuleService moduleService;

	@RequestMapping(value = "/view/{featureId}", method = RequestMethod.GET)
	public String viewFeature(@PathVariable int featureId, Model model)
	{
		Feature feature = featureService.getFeatureByID(featureId);
		model.addAttribute("feature", feature);
		model.addAttribute("modules",
				moduleService.getModulesByFeature(feature));
		return "/feature/view";
	}
	
	@RequestMapping(value = "/update/{featureId}", method = RequestMethod.POST)
	public String updateFeature(@PathVariable int featureId, @ModelAttribute("feature") Feature feature ,Model model)
	{
		featureService.saveFeature(feature);
		model.addAttribute("feature", feature);
		return "redirect:/feature/view/"+featureId;
	}
	
	@RequestMapping(value = "/diagram/{featureId}", method = RequestMethod.GET)
	public String showFeatureDiagram(@PathVariable int featureId,Model model)
	{
		//product
		Feature feature = featureService.getFeatureByID(featureId);
		model.addAttribute("feature", feature);
		
		return "/feature/diagram";
	}

	@RequestMapping(value = "/functiondiagram/{featureId}", method = RequestMethod.GET)
	public String showFeatureFunctionDiagram(@PathVariable int featureId,Model model)
	{
		//product
		Feature feature = featureService.getFeatureByID(featureId);
		model.addAttribute("feature", feature);
		return "/feature/functiondiagram";
	}
	
	@RequestMapping(value = "/view/{featureId}/add/module", method = RequestMethod.POST)
	public String addModule(@PathVariable int featureId, Module module)
	{
		Feature feature = featureService.getFeatureByID(featureId);
		module.setFeature(feature);
		moduleService.updateModule(module);
		return "redirect:/feature/view/" + featureId;
	}

	@RequestMapping(value = "/delete/module/{id}", method = RequestMethod.POST)
	public void deleteModule(@PathVariable int id)
	{
		moduleService.deleteModule(id);
	}

	public FeatureService getFeatureService()
	{
		return featureService;
	}

	public void setFeatureService(FeatureService featureService)
	{
		this.featureService = featureService;
	}
}
