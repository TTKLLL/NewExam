using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// ExamPoint 用于设置考试信息时的知识点信息
/// </summary>
public class ExamPoint
{
    public ExamPoint()
    {
        secondPoints = new List<secondPont>();  //范型集合属性需要初始化
    }
    public FirstPoint firstPoint { set; get; }

    public int IsAllChose { set; get; }//该一级知识点下二级知识点是否为全选
    public List<secondPont> secondPoints { set; get; }

}

public class secondPont : SecondPoint
{
    public int canChoseNumber { set; get; } //可选题目数量
}