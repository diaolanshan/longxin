package org.longxin.web.controller.bean;

import java.util.ArrayList;
import java.util.List;

public class MatrixBean implements java.io.Serializable
{
    private static final long serialVersionUID = -8391768280694316390L;

    int rowId;

    String rowName;

    List<Matrix> matrixs = new ArrayList<Matrix>();

    public MatrixBean(int rowId, String rowName)
    {
        this.rowId = rowId;
        this.rowName = rowName;
    }

    public int getRowId()
    {
        return rowId;
    }

    public void setRowId(int rowId)
    {
        this.rowId = rowId;
    }

    public String getRowName()
    {
        return rowName;
    }

    public void setRowName(String rowName)
    {
        this.rowName = rowName;
    }

    public List<Matrix> getMatrixs()
    {
        return matrixs;
    }

    public void setMatrixs(List<Matrix> matrixs)
    {
        this.matrixs = matrixs;
    }

}
