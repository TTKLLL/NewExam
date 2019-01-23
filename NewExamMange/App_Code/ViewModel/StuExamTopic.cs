using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// StuExamTopic 的摘要说明
/// </summary>
public class StuExamTopic
{
    public Decimal TopicId { set; get; }
    public string StudentId { set; get; }
    public string StuAnswer { set; get; }
    public Decimal ExamId { set; get; }
    public Decimal SortId { set; get; }
    public string TopicTitle { set; get; }
    public string OptionA { set; get; }
    public string OptionB { set; get; }
    public string OptionC { set; get; }
    public string OptionD { set; get; }
    public string TitleAnswer { set; get; }
    public string TopicType { set; get; }

    public string SortName { set; get; }

    public int TopicSortScore { set; get; }
}