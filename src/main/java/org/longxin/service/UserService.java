package org.longxin.service;

import org.longxin.domains.Users;

public interface UserService {

	public Users findUserByUserName(String userName);
}
