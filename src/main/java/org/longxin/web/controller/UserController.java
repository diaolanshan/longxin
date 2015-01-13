package org.longxin.web.controller;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.longxin.domains.Users;
import org.longxin.service.DepartmentService;
import org.longxin.service.UserService;
import org.longxin.web.controller.bean.UserSearchBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@RequestMapping("/user")
@SessionAttributes("user")
public class UserController
{
	@Autowired
	UserService userService;
	
	@Autowired
	DepartmentService departmentService;
	
	/**
	 * Json response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/list/all", method = RequestMethod.GET)
	public @ResponseBody List<Users> listUsers(Model model)
	{
		return  userService.getAllUsers();
	}
	
	@RequestMapping(value = "/check", method = RequestMethod.GET)
	public @ResponseBody boolean checkUserName(Model model)
	{
		return  true;
	}
	
	
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String searchUsers(Model model)
	{
		model.addAttribute("userSearchBean", new UserSearchBean());
		model.addAttribute("users", userService.getAllUsers());
		return "/user/usersearch";
	}
	
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public String doSearchUsers(Model model, UserSearchBean searchForm)
	{
		model.addAttribute("userSearchBean", searchForm);
		if (StringUtils.isEmpty(searchForm.getKeyword()))
		{
			model.addAttribute("users", userService.getAllUsers());
		} else
		{
			model.addAttribute("users",
					userService.searchUsers(searchForm.getKeyword()));
		}
		return "/user/usersearch";
	}
	
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String addUsers(Model model)
	{
		model.addAttribute(new Users());
		model.addAttribute("departments", departmentService.getAllDepartments());
		return "/user/adduser";
	}
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String updateUsers(Model model, Users user)
	{
		userService.addUser(user);
		model.addAttribute("userSearchBean", new UserSearchBean());
		model.addAttribute("departments", departmentService.getAllDepartments());
		return "redirect:/user/search";
	}
	
	@RequestMapping(value = "/edit/{userId}", method = RequestMethod.GET)
	public String editUsers(@PathVariable String userId, Model model)
	{
		Users user = userService.findUserByID(Integer.valueOf(userId));
		model.addAttribute("user",user);
		model.addAttribute("departments", departmentService.getAllDepartments());
		return "/user/edituser";
	}
	
	@RequestMapping(value = "/edit/{userId}", method = RequestMethod.POST)
	public String editUsers(Model model,@ModelAttribute("user") Users user)
	{
		userService.editUser(user);
		model.addAttribute("userSearchBean", new UserSearchBean());
		model.addAttribute(new Users());
		return "redirect:/user/search";
	}
	
	@RequestMapping(value = "/delete/{userId}", method = RequestMethod.POST)
	public void deleteUsers(@PathVariable String userId,Model model)
	{
		userService.deleteUser(Integer.valueOf(userId));
	}
	
	@RequestMapping(value = "/updateprofile", method = RequestMethod.GET)
	public String preUpdateProfile(Model model)
	{
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		if (!(auth instanceof AnonymousAuthenticationToken))
		{
			UserDetails userDetail = (UserDetails) auth.getPrincipal();
			
			Users user = userService.findUserByUserName(userDetail.getUsername());
			model.addAttribute("user", user);
		}
		
		return "/login/updateprofile";
	}
	
	@RequestMapping(value = "/updateprofile", method = RequestMethod.POST)
	public String updateProfile(Model model, @ModelAttribute("user")Users user)
	{
		userService.addUser(user);
		model.addAttribute("messages", "用户信息保存成功");
		return "/login/updateprofile";
	}
}
