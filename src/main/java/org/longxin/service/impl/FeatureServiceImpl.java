package org.longxin.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.longxin.dao.FeatureDAO;
import org.longxin.dao.L1ComponentDAO;
import org.longxin.domains.Feature;
import org.longxin.domains.FunctionModule;
import org.longxin.domains.L1Component;
import org.longxin.domains.Module;
import org.longxin.domains.Product;
import org.longxin.service.FeatureService;
import org.longxin.service.FunctionModuleService;
import org.longxin.service.ModuleService;
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

    public Feature getFeatureByID(Integer featureID)
    {
        return featureDAO.getFeatureByID(featureID);
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
                        if(l1Component.getFunctionModule()!=null&&l1Component.getFunctionModule().getId()==functiomModule.getId())
                        {
                            matrix = new Matrix(functiomModule.getId(), l1Component.getId(),true);
                        }else
                        {
                            matrix = new Matrix(functiomModule.getId(), l1Component.getId(),false);
                        }
                        matrixs.add(matrix);
                    }
                    bean.getMatrixs().addAll(matrixs);
                }
            }
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
}
