using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// 记录学生的考试信息
/// </summary>
public class MyStuExam
{
    public string StudentId { set; get; }

    public string StudentName { get; set; }
    public string StudentPhone { set; get; }
    public string Class { set; get; }

    public Nullable<int> StudentState { set; get; }
    public Nullable<int> StuExamState { set; get; }

    public Nullable<decimal> PaperId { get; set; }
    public string TId { set; get; }

    public string IPAddress { set; get; }
    public Nullable<int> Score { set; get; }

    public Nullable<DateTime> ReplyEndTime { set; get; }

    public Nullable<DateTime> BeginExamTIme { set; get; }

    public string ExamRoomPosition { set; get; }

    public string ExamStateDes { set; get; }

    public Nullable<int> ExamPeriod { set; get; }
}