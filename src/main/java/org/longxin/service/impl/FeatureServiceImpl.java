package org.longxin.service.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.longxin.dao.FeatureDAO;
import org.longxin.dao.L1ComponentDAO;
import org.longxin.dao.UserPermissionMatrixDAO;
import org.longxin.domains.Feature;
import org.longxin.domains.FunctionModule;
import org.longxin.domains.L1Component;
import org.longxin.domains.L2Component;
import org.longxin.domains.L3Component;
import org.longxin.domains.Module;
import org.longxin.domains.Product;
import org.longxin.domains.UserPermissionMatrix;
import org.longxin.domains.Users;
import org.longxin.service.FeatureService;
import org.longxin.service.FunctionModuleService;
import org.longxin.service.ModuleService;
import org.longxin.util.Roles;
import org.longxin.web.controller.bean.Matrix;
import org.longxin.web.controller.bean.MatrixBean;
import org.longxin.web.controller.bean.Surounder;
import org.springframework.beans.factory.annotation.Autowired;

public class FeatureServiceImpl implements FeatureService
{
    @Autowired
    FeatureDAO featureDAO;
    
    @Autowired
    FunctionModuleService functionModuleService;
    
    @Autowired
    ModuleService moduleService;
    
    @Autowired
    L1ComponentDAO l1ComponentDAO;
    
    @Autowired
    UserPermissionMatrixDAO permissionMatrixDAO;
    
    public void saveFeatures(List<Feature> features)
    {
        for (Feature feature : features)
        {
            this.saveFeature(feature);
        }
    }

    public List<Feature> cloneFeatures(List<Feature> features)
    {
        return null;
    }

    public void saveFeature(Feature features)
    {
        featureDAO.saveFeature(features);
    }

    public void deleteFeatureById(Integer featureID)
    {
        featureDAO.deleteFeatureByID(featureID);
    }

    public List<Feature> getFeatureByProduct(Product product)
    {
        return featureDAO.getFeatureByProduct(product);
    }
    
    public List<Feature> getFeatureByProductAndPermission(Product product, Users user)
    {
        List<Feature> features = getFeatureByProduct(product);
        if (user.getRole() == Roles.ROLE_ADMIN)
        {
            //Admin, no need to check the permission.
            return features;
        }
        else
        {
            //normal user, need to check the permission.
            List<UserPermissionMatrix> matrixs = permissionMatrixDAO.getPermissionMatrixsByUserIDs(new int[] {user.getId()});

            Iterator<Feature> iterator = features.iterator();  
            while(iterator.hasNext())
            {
                boolean found = false;
                Feature feature = iterator.next(); 
                for (UserPermissionMatrix matrix : matrixs)
                {
                    if (feature.getId() == matrix.getFeature().getId())
                    {
                        found = true;
                    }
                }
                if(!found)
                {
                    iterator.remove();
                }
            }

            return features;
        }
    }

    public Feature getFeatureByID(Integer featureID)
    {
        return featureDAO.getFeatureByID(featureID);
    }
    
    public Feature getFeatureByIDForDiagram(Integer featureID)
    {
        Feature feature = featureDAO.getFeatureByID(featureID);

        if (feature.getModules() != null)
        {
            for (Module module : feature.getModules())
            {
                if (module.getL1Components() != null)
                {
                    for (L1Component l1Component : module.getL1Components())
                    {
                        if (l1Component.getL2Components() != null)
                        {
                            for (L2Component l2Component : l1Component.getL2Components())
                            {
                                if (l2Component.getL3Components() != null)
                                {
                                    for (L3Component l3Component : l2Component.getL3Components())
                                    {
                                        l3Component.getName();
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        return feature;
    }
    
    public Feature getFeatureByIDForFunctionDiagram(Integer featureID)
    {
        Feature feature = featureDAO.getFeatureByID(featureID);

        if (feature.getFunctionModules() != null)
        {
            for (FunctionModule module : feature.getFunctionModules())
            {
                if (module.getL1Components() != null)
                {
                    for (L1Component l1Component : module.getL1Components())
                    {
                        if (l1Component.getL2Components() != null)
                        {
                            for (L2Component l2Component : l1Component.getL2Components())
                            {
                                if (l2Component.getL3Components() != null)
                                {
                                    for (L3Component l3Component : l2Component.getL3Components())
                                    {
                                        l3Component.getName();
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        return feature;
    }
    
    public List<MatrixBean> generateFunctionMatrix(int featureId)
    {
        Feature feature = getFeatureByID(featureId);
        List<FunctionModule> functionModules = functionModuleService.getFunctionModulesByFeature(feature);
        List<Module> modules = moduleService.getModulesByFeature(feature);
        List<MatrixBean> beans = new ArrayList<MatrixBean>();
        for(FunctionModule functiomModule : functionModules)
        {
            MatrixBean bean = new MatrixBean(functiomModule.getId(), functiomModule.getName());
            List<Matrix> matrixs = new ArrayList<Matrix>();
            for (Module module : modules)
            {
                if (module.getL1Components() != null && module.getL1Components().size() > 0)
                {
                    for (L1Component l1Component : module.getL1Components())
                    {
                        Matrix matrix;
                        if (l1Component.getFunctionModule() != null
                                && l1Component.getFunctionModule().getId() == functiomModule.getId())
                        {
                            matrix = new Matrix(functiomModule.getId(), l1Component.getId(), true);
                        }
                        else
                        {
                            matrix = new Matrix(functiomModule.getId(), l1Component.getId(), false);
                        }
                        matrixs.add(matrix);
                    }
                }
            }
            bean.getMatrixs().addAll(matrixs);
            beans.add(bean);
        }
        return beans;
    }
    
    public void updateFunctionMatrix(Surounder rounder, int featureId)
    {
        l1ComponentDAO.resetL1ComponentMatrix(featureId);
        
        for(MatrixBean bean : rounder.getBean())
        {
            for(Matrix matrix:bean.getMatrixs())
            {
                if(matrix.getIsChecked())
                {
                    this.l1ComponentDAO.updateL1Component(matrix.getColId(), matrix.getRowId());
                }
            }
        }
    }

    @Override
    public List<Feature> searchByKeywords(String keywords)
    {
        return featureDAO.searchByKeywords(keywords);
    }
}
