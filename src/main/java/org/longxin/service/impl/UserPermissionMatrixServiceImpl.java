package org.longxin.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.longxin.dao.UserPermissionMatrixDAO;
import org.longxin.domains.Feature;
import org.longxin.domains.Product;
import org.longxin.domains.UserPermissionMatrix;
import org.longxin.domains.Users;
import org.longxin.service.FeatureService;
import org.longxin.service.ProductService;
import org.longxin.service.UserPermissionMatrixService;
import org.longxin.service.UserService;
import org.longxin.web.controller.bean.Matrix;
import org.longxin.web.controller.bean.MatrixBean;
import org.springframework.beans.factory.annotation.Autowired;

public class UserPermissionMatrixServiceImpl implements UserPermissionMatrixService
{
    @Autowired
    UserPermissionMatrixDAO userPermissionMatrixDAO;

    @Autowired
    FeatureService featureService;

    @Autowired
    ProductService productService;

    @Autowired
    UserService userService;

    @Override
    public List<UserPermissionMatrix> getAllPermissionMatrixs()
    {
        return userPermissionMatrixDAO.getAllPermissionMatrixs();
    }

    @Override
    public List<UserPermissionMatrix> getPermissionMatrixsByUserIDs(int[] userIds)
    {
        return userPermissionMatrixDAO.getPermissionMatrixsByUserIDs(userIds);
    }

    public List<MatrixBean> constructMatrix(String[] selectedUsers, List<Product> products)
    {
        List<Feature> features = new ArrayList<Feature>();
        for (Product product : products)
        {
            features.addAll(featureService.getFeatureByProduct(product));
        }

        List<MatrixBean> beans = new ArrayList<MatrixBean>();

        for (String userId : selectedUsers)
        {
            Users user = userService.findUserByID(Integer.valueOf(userId));
            MatrixBean matrixBean = new MatrixBean(Integer.valueOf(userId), user.getUsername());
            for (Feature feature : features)
            {
                List<UserPermissionMatrix> permissionMatrix = userPermissionMatrixDAO
                        .getPermissionMatrixsByUserAndFeature(userId, feature.getId());
                Matrix matrix = new Matrix(Integer.valueOf(userId), feature.getId(), false);
                if (permissionMatrix != null && permissionMatrix.size() > 0)
                {
                    matrix.setIsChecked(true);
                }
                matrixBean.getMatrixs().add(matrix);
            }
            beans.add(matrixBean);
        }

        return beans;
    }

    public void updateMatrix(String userId, String featureId, boolean checked, Users user)
    {
        List<UserPermissionMatrix> permissionMatrixs = userPermissionMatrixDAO.getPermissionMatrixsByUserAndFeature(
            userId,
            Integer.valueOf(featureId));

        if (checked)
        {
            // Need to have one item.
            if (permissionMatrixs == null || permissionMatrixs.size() == 0)
            {
                UserPermissionMatrix permissionMatrix = new UserPermissionMatrix();
                permissionMatrix.setCreatedBy(user);
                permissionMatrix.setCreatedat(new Date());
                permissionMatrix.setFeature(featureService.getFeatureByID(Integer.valueOf(featureId)));
                permissionMatrix.setUser(userService.findUserByID(Integer.valueOf(userId)));

                userPermissionMatrixDAO.saveOrUpdateUserPermissionMatrix(permissionMatrix);
            }
        }
        else
        {
            // Need to clean the item.
            if (permissionMatrixs != null && permissionMatrixs.size() > 0)
            {
                userPermissionMatrixDAO.removePermissionmatrix(permissionMatrixs.get(0));
            }
        }
    }
    
    public Boolean isUserAllowedForFeature(int userId, int featureId)
    {
        List<UserPermissionMatrix> matrixs = userPermissionMatrixDAO.getPermissionMatrixsByUserAndFeature(
            String.valueOf(userId),
            featureId);
        if (matrixs != null && matrixs.size() > 0)
        {
            return true;
        }
        return false;
    }

    @Override
    public int componnentCountNeedToBeApproved(int userId)
    {
        return userPermissionMatrixDAO.componnentCountNeedToBeApproved(userId);
    }

    @Override
    public List<Integer> draftFeatures(int userId)
    {
        return userPermissionMatrixDAO.draftFeatures(userId);
    }

    @Override
    public List<Integer> draftModules(int featureId)
    {
        return userPermissionMatrixDAO.draftModules(featureId);
    }

    @Override
    public List<Integer> draftL1Component(int moduleId)
    {
        return userPermissionMatrixDAO.draftL1Component(moduleId);
    }

    @Override
    public List<Integer> draftL2Component(int l1Id)
    {
        return userPermissionMatrixDAO.draftL2Component(l1Id);
    }

    @Override
    public List<Integer> draftL3Component(int l2Id)
    {
        return userPermissionMatrixDAO.draftL3Component(l2Id);
    }

	@Override
	public void deleteUserFeaturePermissionMatrixByFeature(Feature feature) 
	{
		userPermissionMatrixDAO.deleteUserFeaturePermissionMatrixByFeature(feature);
	}
}
