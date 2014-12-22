package org.longxin.dao;

import org.longxin.domains.Users;

public interface UserDAO {

	public Users findUserByUserName(String userName);
}
