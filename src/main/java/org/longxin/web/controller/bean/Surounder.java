package org.longxin.web.controller.bean;

import java.util.ArrayList;
import java.util.List;

public class Surounder
{
    List<MatrixBean> bean = new ArrayList<MatrixBean>();
    
    public List<MatrixBean> getBean()
    {
        return bean;
    }

    public void setBean(List<MatrixBean> bean)
    {
        this.bean = bean;
    }
}

