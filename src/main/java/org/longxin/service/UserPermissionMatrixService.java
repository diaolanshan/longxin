package org.longxin.service;

import java.util.List;

import org.longxin.domains.Feature;
import org.longxin.domains.Product;
import org.longxin.domains.UserPermissionMatrix;
import org.longxin.domains.Users;
import org.longxin.web.controller.bean.MatrixBean;

public interface UserPermissionMatrixService
{
    public List<UserPermissionMatrix> getAllPermissionMatrixs();

    public List<UserPermissionMatrix> getPermissionMatrixsByUserIDs(int[] userIds);

    public List<MatrixBean> constructMatrix(String [] selectedUsers, List<Product> products);
    
    public void updateMatrix(String userId, String featureId, boolean checked, Users user);
    
    public Boolean isUserAllowedForFeature(int userId, int featureId);
    
    public int componnentCountNeedToBeApproved(int userId);
    
    public List<Integer> draftFeatures(int userId);
    
    public List<Integer> draftModules(int featureId);
    
    public List<Integer> draftL1Component(int moduleId);
    
    public List<Integer> draftL2Component(int l1Id);
    
    public List<Integer> draftL3Component(int l2Id);
    
    public void deleteUserFeaturePermissionMatrixByFeature(Feature feature);
}
