using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// 导入的题目
/// </summary>
public class ImputTopic : Topic
{
    public string FirstPointName { get; set; }

    public string SecondPointName { get; set; }

    public string SortName { get; set; }

    public decimal FirstPointId { set; get; }

    public string ErrorInfo { set; get; }

    public string TopicSourceName { get; set; }

    public string FirstPointOrder { get; set; }

    public string SecondPointOrder { set; get; }

  
}