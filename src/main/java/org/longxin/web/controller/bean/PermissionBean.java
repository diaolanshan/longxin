package org.longxin.web.controller.bean;

import java.util.ArrayList;
import java.util.List;

public class PermissionBean
{
    private List<Integer> selectedUsers;

    private List<Integer> selectedProducts;

    public PermissionBean()
    {
        this.selectedProducts = new ArrayList<Integer>();
        this.selectedUsers = new ArrayList<Integer>();
    }

    public List<Integer> getSelectedUsers()
    {
        return selectedUsers;
    }

    public void setSelectedUsers(List<Integer> selectedUsers)
    {
        this.selectedUsers = selectedUsers;
    }

    public List<Integer> getSelectedProducts()
    {
        return selectedProducts;
    }

    public void setSelectedProducts(List<Integer> selectedProducts)
    {
        this.selectedProducts = selectedProducts;
    }
}
