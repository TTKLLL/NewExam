using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// ExamSort用于考试的题目类别
/// </summary>
public class ExamSort : Sort
{
    //在当前选中知识点的前提下该类别下的题目数量
    public int CanUseNumber { set; get; } 
}