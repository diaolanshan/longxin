package org.longxin.web.controller;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.longxin.domains.Users;
import org.longxin.service.DepartmentService;
import org.longxin.service.UserService;
import org.longxin.util.Roles;
import org.longxin.web.controller.bean.UserSearchBean;
import org.springframework.beans.factory.annotation.Autowired;
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
@SessionAttributes({ "user", "department" })
public class UserController {
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
	public @ResponseBody
	List<Users> listUsers(Model model) {
		return userService.getAllUsers();
	}

	@RequestMapping(value = "/check", method = RequestMethod.GET)
	public @ResponseBody
	boolean checkUserName(String username) {
		if (userService.findUserByUserName(username) == null) {
			return true;
		}
		return false;
	}

	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String searchUsers(Model model) {
		model.addAttribute("userSearchBean", new UserSearchBean());
		model.addAttribute("users", userService.getAllUsers());
		return "/user/usersearch";
	}

	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public String doSearchUsers(Model model, UserSearchBean searchForm) {
		model.addAttribute("userSearchBean", searchForm);
		if (StringUtils.isEmpty(searchForm.getKeyword())) {
			model.addAttribute("users", userService.getAllUsers());
		} else {
			model.addAttribute("users", userService.searchUsers(StringUtils
					.trim(searchForm.getKeyword())));
		}
		return "/user/usersearch";
	}

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String addUsers(Model model) {
		model.addAttribute(new Users());
		model.addAttribute("departments", departmentService.getAllDepartments());
		model.addAttribute("roles", Roles.values());
		return "/user/adduser";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String updateUsers(Model model, Users user) {
		user.setCreatedat(new Date());
		userService.editUser(user);
		model.addAttribute("userSearchBean", new UserSearchBean());
		model.addAttribute(new Users());
		return "redirect:/user/search";
	}

	@RequestMapping(value = "/edit/{userId}", method = RequestMethod.GET)
	public String editUsers(@PathVariable String userId, Model model) {
		Users user = userService.findUserByID(Integer.valueOf(userId));
		user.setPasswordAgain(user.getPassword());
		model.addAttribute("user", user);
		model.addAttribute("departments", departmentService.getAllDepartments());
		model.addAttribute("roles", Roles.values());
		return "/user/edituser";
	}

	@RequestMapping(value = "/edit/{userId}", method = RequestMethod.POST)
	public String editUsers(Model model, @ModelAttribute("user") Users user) {
		userService.editUser(user);
		model.addAttribute(new Users());
		return "redirect:/user/search";
	}

	@RequestMapping(value = "/profile/{userId}", method = RequestMethod.GET)
	public String editProfile(@PathVariable String userId, Model model) {
		Users user = userService.findUserByID(Integer.valueOf(userId));
		user.setPasswordAgain(user.getPassword());
		model.addAttribute("user", user);
		model.addAttribute("departments", departmentService.getAllDepartments());
		model.addAttribute("roles", Roles.values());
		return "/edit/profile";
	}

	@RequestMapping(value = "/profile/{userId}", method = RequestMethod.POST)
	public String editProfile(Model model, @ModelAttribute("user") Users user) {
		userService.editUser(user);
		model.addAttribute(
				"user",
				userService.getUsersByIds(
						new String[] { String.valueOf(user.getId()) }).get(0));
		return "/view/profile";
	}

	@RequestMapping(value = "/delete/{userId}", method = RequestMethod.DELETE)
	public String deleteUsers(@PathVariable String userId, Model model) {
		userService.deleteUser(Integer.valueOf(userId));
		model.addAttribute("userSearchBean", new UserSearchBean());
		return "/user/usersearch";
	}

	@RequestMapping(value = "/profile", method = RequestMethod.GET)
	public String editUser(Model model) {
		UserDetails userDetails = (UserDetails) SecurityContextHolder
				.getContext().getAuthentication().getPrincipal();
		Users user = userService.findUserByUserName(userDetails.getUsername());
		user.setPasswordAgain(user.getPassword());
		model.addAttribute("user", user);
		model.addAttribute("departments", departmentService.getAllDepartments());
		model.addAttribute("roles", Roles.values());
		return "/user/profile";
	}

	@RequestMapping(value = "/profile", method = RequestMethod.POST)
	public String editUser(@ModelAttribute("user") Users user, Model model) {
		userService.editUser(user);
		model.addAttribute(new Users());
		return "redirect:/user/profile";
	}
}
