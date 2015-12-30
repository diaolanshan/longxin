package org.longxin.dao.impl;

import java.math.BigInteger;
import java.util.List;

import org.longxin.dao.UserPermissionMatrixDAO;
import org.longxin.domains.UserPermissionMatrix;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class UserPermissionMatrixDAOImpl extends HibernateDaoSupport implements UserPermissionMatrixDAO
{

    @SuppressWarnings("unchecked")
    @Override
    public List<UserPermissionMatrix> getAllPermissionMatrixs()
    {
        return this.getHibernateTemplate()
                .find("FROM UserPermissionMatrix");
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<UserPermissionMatrix> getPermissionMatrixsByUserIDs(int[] userIds)
    {
        StringBuilder queryStr = new StringBuilder("FROM UserPermissionMatrix matrix WHERE matrix.user.id IN (");
        for (int userId : userIds)
        {
            queryStr.append(userId).append(",");
        }
        queryStr.append(" 0 )");
        return this.getHibernateTemplate().find(queryStr.toString());
    }
    
    @SuppressWarnings("unchecked")
    @Override
    public List<UserPermissionMatrix> getPermissionMatrixsByUserAndFeature(String userId, int featureId)
    {
        StringBuilder queryStr = new StringBuilder("FROM UserPermissionMatrix matrix WHERE matrix.user.id =? AND matrix.feature.id =?");
        return this.getHibernateTemplate().find(queryStr.toString(), Integer.valueOf(userId), featureId);
    }

    @Override
    public List<UserPermissionMatrix> getPermissionMatrixByFeatures(int[] featureIds)
    {
        // TODO Auto-generated method stub
        return null;
    }
    
    public void saveOrUpdateUserPermissionMatrix(UserPermissionMatrix matrix)
    {
        this.getHibernateTemplate().saveOrUpdate(matrix);
    }
    
    public void removePermissionmatrix(UserPermissionMatrix matrix)
    {
        this.getHibernateTemplate().delete(matrix);
    }
    
    public int componnentCountNeedToBeApproved(int userId)
    {
        StringBuilder query = new StringBuilder();
        query.append("SELECT COUNT(DISTINCT(f.id)) ");
        query.append("FROM feature f ");
        query.append("LEFT JOIN module m ON m.feature = f.id ");
        query.append("LEFT JOIN l1_component l1 ON l1.module = m.id ");
        query.append("LEFT JOIN l2_component l2 ON l2.l1 = l1.id ");
        query.append("LEFT JOIN l3_component l3 ON l3.l2 = l2.id ");
        query.append("LEFT JOIN l1_component_parameter l1p ON l1p.L1_COMPONENT = l1.id ");
        query.append("LEFT JOIN l2_component_parameter l2p ON l2p.L2_COMPONENT = l2.id ");
        query.append("LEFT JOIN l3_component_parameter l3p ON l3p.L3_COMPONENT = l3.id  ");
        query.append("WHERE (l1.IS_DRAFT = 1 or l2.IS_DRAFT = 1 OR l3.IS_DRAFT = 1 OR l1p.IS_DRAFT = 1 OR l2p.IS_DRAFT = 1 OR l3p.IS_DRAFT = 1 ) AND f.id IN (SELECT feature from user_feature_matrix WHERE user =  ");
        query.append(userId).append(" ) ");
                
        BigInteger result = (BigInteger)this.getHibernateTemplate().getSessionFactory().getCurrentSession()
                .createSQLQuery(query.toString()).list().get(0);
        
        return result.intValue();
    }
    
    @SuppressWarnings("unchecked")
    public List<Integer> draftFeatures(int userId)
    {
        StringBuilder query = new StringBuilder();
        query.append("SELECT DISTINCT(f.id) ");
        query.append("FROM feature f ");
        query.append("LEFT JOIN module m ON m.feature = f.id ");
        query.append("LEFT JOIN l1_component l1 ON l1.module = m.id ");
        query.append("LEFT JOIN l2_component l2 ON l2.l1 = l1.id ");
        query.append("LEFT JOIN l3_component l3 ON l3.l2 = l2.id ");
        query.append("LEFT JOIN l1_component_parameter l1p ON l1p.L1_COMPONENT = l1.id ");
        query.append("LEFT JOIN l2_component_parameter l2p ON l2p.L2_COMPONENT = l2.id ");
        query.append("LEFT JOIN l3_component_parameter l3p ON l3p.L3_COMPONENT = l3.id  ");
        query.append("WHERE (l1.IS_DRAFT = 1 or l2.IS_DRAFT = 1 OR l3.IS_DRAFT = 1 OR l1p.IS_DRAFT = 1 OR l2p.IS_DRAFT = 1 OR l3p.IS_DRAFT = 1 ) AND f.id IN (SELECT feature from user_feature_matrix WHERE user =  ");
        query.append(userId).append(" ) ");
                
        return this.getHibernateTemplate().getSessionFactory().getCurrentSession()
                .createSQLQuery(query.toString()).list();
    }
    
    @SuppressWarnings("unchecked")
    public List<Integer> draftModules(int featureId)
    {
        StringBuilder query = new StringBuilder();
        query.append("SELECT DISTINCT(m.id) ");
        query.append("FROM feature f ");
        query.append("LEFT JOIN module m ON m.feature = f.id ");
        query.append("LEFT JOIN l1_component l1 ON l1.module = m.id ");
        query.append("LEFT JOIN l2_component l2 ON l2.l1 = l1.id ");
        query.append("LEFT JOIN l3_component l3 ON l3.l2 = l2.id ");
        query.append("LEFT JOIN l1_component_parameter l1p ON l1p.L1_COMPONENT = l1.id ");
        query.append("LEFT JOIN l2_component_parameter l2p ON l2p.L2_COMPONENT = l2.id ");
        query.append("LEFT JOIN l3_component_parameter l3p ON l3p.L3_COMPONENT = l3.id  ");
        query.append("WHERE (l1.IS_DRAFT = 1 or l2.IS_DRAFT = 1 OR l3.IS_DRAFT = 1 OR l1p.IS_DRAFT = 1 OR l2p.IS_DRAFT = 1 OR l3p.IS_DRAFT = 1 ) AND f.id  =  ");
        query.append(featureId);
                
        return this.getHibernateTemplate().getSessionFactory().getCurrentSession()
                .createSQLQuery(query.toString()).list();
    }
    
    @SuppressWarnings("unchecked")
    public List<Integer> draftL1Component(int moduleId)
    {
        StringBuilder query = new StringBuilder();
        query.append("SELECT DISTINCT(l1.id) ");
        query.append("FROM module m ");
        query.append("LEFT JOIN l1_component l1 ON l1.module = m.id ");
        query.append("LEFT JOIN l2_component l2 ON l2.l1 = l1.id ");
        query.append("LEFT JOIN l3_component l3 ON l3.l2 = l2.id ");
        query.append("LEFT JOIN l1_component_parameter l1p ON l1p.L1_COMPONENT = l1.id ");
        query.append("LEFT JOIN l2_component_parameter l2p ON l2p.L2_COMPONENT = l2.id ");
        query.append("LEFT JOIN l3_component_parameter l3p ON l3p.L3_COMPONENT = l3.id  ");
        query.append("WHERE (l1.IS_DRAFT = 1 or l2.IS_DRAFT = 1 OR l3.IS_DRAFT = 1 OR l1p.IS_DRAFT = 1 OR l2p.IS_DRAFT = 1 OR l3p.IS_DRAFT = 1 ) AND m.id  =  ");
        query.append(moduleId);
                
        return this.getHibernateTemplate().getSessionFactory().getCurrentSession()
                .createSQLQuery(query.toString()).list();
    }
    
    @SuppressWarnings("unchecked")
    public List<Integer> draftL2Component(int l1Id)
    {
        StringBuilder query = new StringBuilder();
        query.append("SELECT DISTINCT(l2.id) ");
        query.append("FROM l1_component l1 ");
        query.append("LEFT JOIN l2_component l2 ON l2.l1 = l1.id ");
        query.append("LEFT JOIN l3_component l3 ON l3.l2 = l2.id ");
        query.append("LEFT JOIN l1_component_parameter l1p ON l1p.L1_COMPONENT = l1.id ");
        query.append("LEFT JOIN l2_component_parameter l2p ON l2p.L2_COMPONENT = l2.id ");
        query.append("LEFT JOIN l3_component_parameter l3p ON l3p.L3_COMPONENT = l3.id  ");
        query.append("WHERE (l2.IS_DRAFT = 1 OR l3.IS_DRAFT = 1 OR l2p.IS_DRAFT = 1 OR l3p.IS_DRAFT = 1 ) AND l1.id  =  ");
        query.append(l1Id);
                
        return this.getHibernateTemplate().getSessionFactory().getCurrentSession()
                .createSQLQuery(query.toString()).list();
    }
    
    @SuppressWarnings("unchecked")
    public List<Integer> draftL3Component(int l2Id)
    {
        StringBuilder query = new StringBuilder();
        query.append("SELECT DISTINCT(l3.id) ");
        query.append("FROM l2_component l2 ");
        query.append("LEFT JOIN l3_component l3 ON l3.l2 = l2.id ");
        query.append("LEFT JOIN l2_component_parameter l2p ON l2p.L2_COMPONENT = l2.id ");
        query.append("LEFT JOIN l3_component_parameter l3p ON l3p.L3_COMPONENT = l3.id  ");
        query.append("WHERE (l3.IS_DRAFT = 1 OR l3p.IS_DRAFT = 1 ) AND l2.id  =  ");
        query.append(l2Id);
                
        return this.getHibernateTemplate().getSessionFactory().getCurrentSession()
                .createSQLQuery(query.toString()).list();
    }
}

