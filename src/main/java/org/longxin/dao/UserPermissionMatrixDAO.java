package org.longxin.dao;

import java.util.List;

import org.longxin.domains.UserPermissionMatrix;

public interface UserPermissionMatrixDAO
{
    public List<UserPermissionMatrix> getAllPermissionMatrixs();
    
    public List<UserPermissionMatrix> getPermissionMatrixsByUserIDs(int [] userIds);
    
    public List<UserPermissionMatrix> getPermissionMatrixByFeatures(int [] featureIds);
    
    public void saveOrUpdateUserPermissionMatrix(UserPermissionMatrix matrix);
    
    public void removePermissionmatrix(UserPermissionMatrix matrix);
    
    public List<UserPermissionMatrix> getPermissionMatrixsByUserAndFeature(String userId, int featureId);
    
    public int componnentCountNeedToBeApproved(int userId);
    
    public List<Integer> draftFeatures(int userId);
    
    public List<Integer> draftModules(int featureId);
    
    public List<Integer> draftL1Component(int moduleId);
    
    public List<Integer> draftL2Component(int l1Id);
    
    public List<Integer> draftL3Component(int l2Id);
}

