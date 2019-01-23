using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// MyExam 的摘要说明  //用于传递Json数据的场考试实体
/// </summary>
public class MyExam
{
    public string ExamId { get; set; }
    public string TheExamId { get; set; }
    public string ExamBegTime { get; set; }
    public string ExamEndTime { get; set; }

    public int ExamPeriod { set; get; }

    public string NowPeriod { get; set; }

    public int PaperNumber { set; get; }
}