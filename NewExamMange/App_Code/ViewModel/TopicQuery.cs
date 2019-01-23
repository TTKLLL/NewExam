using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// 题目信息查询条件
/// </summary>
public class TopicQuery
{
    public TopicQuery()
    {
        this.FirstPointId = 0;
        this.FirstPointName = "";
        this.SecondPointId = 0;
        this.SecondPointName = "";
        this.SortId = 0;
        this.SortName = "";
        this.SortName = "";
        this.TopicTitle = "";
        this.TopicType = "";
        this.TopicState = -1;
        this.TopicSourceId = 0;

    }
    public int FirstPointId { get; set; }
    public string FirstPointName { get; set; }
    public int SecondPointId { get; set; }
    public string SecondPointName { get; set; }
    public string SourceName { get; set; }
    public int SortId { get; set; }
    public string SortName { get; set; }

    public string TopicTitle { get; set; }

    public string TopicType { get; set; }

    public int TopicState { get; set; }

    public int TopicSourceId { get; set; }

}