package org.longxin.domains;

import static javax.persistence.GenerationType.IDENTITY;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "user_feature_matrix", catalog = "longxin")
public class UserPermissionMatrix implements java.io.Serializable
{
    private static final long serialVersionUID = -4357902043717790420L;

    private Integer id;

    private Feature feature;

    private Users user;

    private Users createdBy;

    private Date createdat;

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "id", unique = true, nullable = false)
    public Integer getId()
    {
        return id;
    }

    public void setId(Integer id)
    {
        this.id = id;
    }

	@ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    @JoinColumn(name = "FEATURE", nullable = false)
    public Feature getFeature()
    {
        return feature;
    }

    public void setFeature(Feature feature)
    {
        this.feature = feature;
    }

	@ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    @JoinColumn(name = "USER", nullable = false)
    public Users getUser()
    {
        return user;
    }

    public void setUser(Users user)
    {
        this.user = user;
    }

    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    @JoinColumn(name = "CREATED_BY", nullable = false)
    public Users getCreatedBy()
    {
        return createdBy;
    }

    public void setCreatedBy(Users createdBy)
    {
        this.createdBy = createdBy;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "CREATED_AT", nullable = false, length = 19)
    public Date getCreatedat()
    {
        return createdat;
    }

    public void setCreatedat(Date createdat)
    {
        this.createdat = createdat;
    }
}
