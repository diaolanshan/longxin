package org.longxin.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.log4j.Logger;
import org.longxin.domains.Users;
import org.longxin.service.UserService;
import org.longxin.util.Roles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.core.GrantedAuthority;

public class UserDetailsServiceImpl implements UserDetailsService {

	protected static Logger logger = Logger.getLogger(UserDetailsServiceImpl.class);
	
	@Autowired
	UserService userService;

	public UserDetails loadUserByUsername(String userName)
			throws UsernameNotFoundException {

		logger.info(String.format("User %s logged to the application", userName));
		Users localUser = userService.findUserByUserName(userName);
		User user = new User(localUser.getUsername(), localUser
				.getPassword(), true, true, true, true,
				getAuthorities(localUser.getRole()));
		return user;
	}

	public Collection<GrantedAuthority> getAuthorities(Roles role) {

		List<GrantedAuthority> authList = new ArrayList<GrantedAuthority>();

		authList.add(new GrantedAuthorityImpl(role.toString()));

		return authList;
	}
}
