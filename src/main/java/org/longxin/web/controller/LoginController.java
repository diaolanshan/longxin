package org.longxin.web.controller;

import org.longxin.domains.Users;
import org.longxin.service.UserPermissionMatrixService;
import org.longxin.service.UserService;
import org.longxin.util.Roles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("login")
public class LoginController
{
    @Autowired
    UserService userService;
    
    @Autowired
    UserPermissionMatrixService userPermissionMatrixService;
    
    @RequestMapping(value = "/waiting/count", method = RequestMethod.GET)
    public @ResponseBody int countComponentNeedToBeApproved(Model model)
    {
        if(SecurityContextHolder.getContext().getAuthentication().getPrincipal() instanceof UserDetails)
        {
            UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            Users user = userService.findUserByUserName(userDetails.getUsername());
            
            if (user.getRole() == Roles.ROLE_USER || user.getRole() == Roles.ROLE_TECHNICALSUPPORT)
            {
                return 0;
            }
           
            return userPermissionMatrixService.componnentCountNeedToBeApproved(user.getId());
        }
       return 0;
    }
    
    @RequestMapping(value = "/waiting/list", method = RequestMethod.GET)
    public String listComponentNeedToBeApproved(Model model)
    {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Users user = userService.findUserByUserName(userDetails.getUsername());
        
        return "/feature/view";
    }

}

