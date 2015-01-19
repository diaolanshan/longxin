package org.longxin.web.controller;

import org.longxin.domains.Feature;
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
	
	@RequestMapping(value = "/diagram/{featureId}", method = RequestMethod.GET)
	public String showFeatureDiagram(@PathVariable int featureId,Model model)
	{
		//product
		Feature feature = featureService.getFeatureByID(featureId);
		model.addAttribute("feature", feature);
		
		return "/feature/diagram";
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
