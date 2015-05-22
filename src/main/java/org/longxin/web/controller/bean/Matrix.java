package org.longxin.web.controller.bean;

public class Matrix implements java.io.Serializable
{
    private static final long serialVersionUID = 1L;

    int rowId;

    int colId;

    Boolean isChecked;

    public Matrix(int rowId, int colId, Boolean isChecked)
    {
        this.rowId = rowId;
        this.colId = colId;
        this.isChecked = isChecked;
    }

    public int getRowId()
    {
        return rowId;
    }

    public void setRowId(int rowId)
    {
        this.rowId = rowId;
    }

    public int getColId()
    {
        return colId;
    }

    public void setColId(int colId)
    {
        this.colId = colId;
    }

    public Boolean getIsChecked()
    {
        return isChecked;
    }

    public void setIsChecked(Boolean isChecked)
    {
        this.isChecked = isChecked;
    }
}
