package org.longxin.web.controller;

import java.util.List;

import org.longxin.domains.Users;
import org.longxin.service.UserService;
import org.longxin.web.controller.bean.UserSearchBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/user")
public class UserController
{
	@Autowired
	UserService userService;
	
	UserSearchBean searchForm;

	@RequestMapping(value = "/list/all", method = RequestMethod.GET)
	public @ResponseBody List<Users> listUsers(Model model)
	{
		if (searchForm != null)
		{

		}
		return  userService.getAllUsers();
	}
	
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String searchUsers(Model model)
	{
		model.addAttribute("userSearchBean", new UserSearchBean());
		return "/user/usersearch";
	}
	
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public String doSearchUsers(Model model, UserSearchBean searchForm)
	{
		this.searchForm = searchForm;
		model.addAttribute("userSearchBean", searchForm);
		return "/user/usersearch";
	}
	
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String addUsers(Model model)
	{
		model.addAttribute(new Users());
		return "/user/adduser";
	}
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String updateUsers(Model model)
	{
		model.addAttribute(new Users());
		return "/user/listusers";
	}
	
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String editUsers(@PathVariable String userId, Model model)
	{
		Users user = userService.findUserByID(Integer.valueOf(userId));
		model.addAttribute(user);
		return "/user/edituser";
	}
}
