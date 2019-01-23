using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;
using System.Text;

/// <summary>
/// TopicBLL 的摘要说明
/// </summary>
public class TopicBLL
{
    DataClassesDataContext db = new DataClassesDataContext();
    public static int TopicPageSize = 15;  //显示题目一页的大小

    public enum TopicState
    {
        FailAudit = 0,  //题目未通过审核
        WaitAudit = 1,  // 待审核
        PassAudit = 2   // 通过审核
    }

    //获取题目类别
    public List<Sort> GetTopiciSort()
    {
        List<Sort> srots = db.Sort.OrderBy(t => t.SortOrder).ToList();
        return srots;
    }

    //保存题目类别
    public int SaveSort(Sort sort)
    {
        int res = 0;
        //更新
        if (sort.SortId != 0)
        {
            string updateSql = "update Sort set SortOrder ={0}, SortName = {1} where SortId = {2}";
            res = db.ExecuteCommand(updateSql, new Object[] { sort.SortOrder, sort.SortName, sort.SortId });
        }
        else
        {
            Sort newSort = new Sort()
            {
                SortName = sort.SortName,
                SortOrder = sort.SortOrder
            };

            db.Sort.InsertOnSubmit(newSort);
            db.SubmitChanges();
            if (newSort.SortId > 0)
                res = 1;
        }

        return res;
    }

    //删除题目类别
    public int DeleteSort(int sortId)
    {
        string sql = "delete from Sort where SortId={0}";
        return db.ExecuteCommand(sql, new Object[] { sortId });
    }

    //判断该类别是否有题目
    public bool HasTopicInSort(int sortId)
    {
        return db.Topic.Count(t => t.SortId == sortId) > 0;
    }

    //获取所有题目信息
    public List<ImputTopic> GetAllTopics()
    {
        List<ImputTopic> topics = new List<ImputTopic>();
        topics = (from p in db.Topic
                  join m in db.Sort on p.SortId equals m.SortId
                  join d in db.SecondPoint on p.SecondPointId equals d.SecondPointId
                  join q in db.FirstPoint on d.FIrstPointId equals q.FirstPointId
                  select new ImputTopic
                  {
                      TopicTitle = p.TopicTitle,
                      SortName = m.SortName,
                      FirstPointName = q.FirstPointName,
                      SecondPointName = d.SecondPointName,
                      OptionA = p.OptionA,
                      OptionB = p.OptionB,
                      OptionC = p.OptionC,
                      OptionD = p.OptionD,
                      TitleAnswer = p.TitleAnswer,
                      TopicType = p.TopicType
                  }).ToList();

        return topics;


    }

    //获取最大sort排序号
    public int MaxSortOrder()
    {
        if (db.Sort.Count() == 0)
            return 1;
        else
        {
            int? sortOrder = db.Sort.OrderByDescending(t => t.SortOrder).First().SortOrder;
            return int.Parse(sortOrder.ToString()) + 1;
        }
    }

    //获取题目类别id
    public string GetSortId(string sortName)
    {
        if (db.Sort.Count(t => t.SortName == sortName) == 0)
        {
            Sort sort = new Sort()
            {
                SortName = sortName,
                SortOrder = MaxSortOrder()
            };
            db.Sort.InsertOnSubmit(sort);
            db.SubmitChanges();
            return sort.SortId.ToString();
        }
        else
        {
            decimal? sortId = db.Sort.Where(t => t.SortName == sortName).First().SortId;
            return sortId.ToString();
        }
    }

    //根据题库Id获取题目名称
    public int GetTopicSourceIdByName(string name)
    {
        return db.TopicSource.First(t => t.TopicSourceName == name.ToString()).TopicSourceId;
    }

    //添加题目
    public int AddTopic(ImputTopic topic)
    {
        int res = 0;
        try
        {
            DateTime time = DateTime.Now.ToLocalTime();
            int topicSourceId = GetTopicSourceIdByName(topic.TopicSourceName);

            Topic newTopic = new Topic()
            {
                SortId = decimal.Parse(GetSortId(topic.SortName)),
                SecondPointId = new PointService().GetSeccondIdByName(topic.SecondPointName),
                TopicTitle = Public.Convert(topic.TopicTitle),
                OptionA = Public.Convert(topic.OptionA.Trim()),
                OptionB = Public.Convert(topic.OptionB.Trim()),
                OptionC = Public.Convert(topic.OptionC.Trim()),
                OptionD = Public.Convert(topic.OptionD.Trim()),
                TitleAnswer = new StuExamBLL().FormatAnswer(topic.TitleAnswer.Trim()),
                TopicCreateDate = time,
                TopicType = topic.TopicType.Trim(),
                TopicState = (int)TopicBLL.TopicState.PassAudit,  //待审核
                TopicSourceId = topicSourceId
            };

            db.Topic.InsertOnSubmit(newTopic);
            db.SubmitChanges();

            res = 1;
        }
        catch (Exception e)
        {
            res = 0;
        }

        return res;


    }

    //分页获取题目信息
    public List<ImputTopic> GetTopicsByPage(ref int pageNumber, ref int totalPage, TopicQuery topicQuery, ref int totalCount)
    {
        var query = GetTopicsByQuery(topicQuery);
        int counts = query.Count();
        List<ImputTopic> topics = new List<ImputTopic>();
        if (counts == 0)
        {
            totalPage = 0;
            pageNumber = 0;

        }
        else
        {
            totalPage = counts % TopicPageSize == 0 ? counts / TopicPageSize : counts / TopicPageSize + 1;

            topics = (List<ImputTopic>)query.Skip((pageNumber - 1) * TopicPageSize).Take(TopicPageSize).ToList();
        }
        totalCount = counts; //题目总数
        return topics;
    }


    // 根据查询结果导出题目信息
    public List<ImputTopic> GetTopicsByQuery(TopicQuery topicQuery)
    {
        var query = (from p in db.Topic
                     join d in db.Sort on p.SortId equals d.SortId
                     join s in db.SecondPoint on p.SecondPointId equals s.SecondPointId
                     join f in db.FirstPoint on s.FIrstPointId equals f.FirstPointId
                     join q in db.TopicSource on p.TopicSourceId equals q.TopicSourceId
                     orderby f.FirstPointOrder, s.SecondPointOrder, p.TopicTitle
                     select new ImputTopic
                     {
                         TopicId = p.TopicId,
                         SortId = d.SortId,
                         SortName = d.SortName,
                         SecondPointId = p.SecondPointId,
                         FirstPointName = f.FirstPointName,
                         SecondPointName = s.SecondPointName,
                         TopicTitle = p.TopicTitle,
                         OptionA = p.OptionA,
                         OptionB = p.OptionB,
                         OptionC = p.OptionC,
                         OptionD = p.OptionD,
                         TitleAnswer = p.TitleAnswer,
                         TopicType = p.TopicType,
                         TopicCreateDate = p.TopicCreateDate,
                         FirstPointId = f.FirstPointId,
                         TopicSourceName = q.TopicSourceName,
                         TopicState = p.TopicState,
                         TopicSourceId = q.TopicSourceId

                     })
                     .Where(t => t.TopicTitle.Contains(topicQuery.TopicTitle)
                         || t.OptionA.Contains(topicQuery.TopicTitle)
                         || t.OptionB.Contains(topicQuery.TopicTitle)
                         || t.OptionC.Contains(topicQuery.TopicTitle)
                         || t.OptionD.Contains(topicQuery.TopicTitle));

        if (topicQuery.FirstPointId != 0)
            query = query.Where(t => t.FirstPointId == topicQuery.FirstPointId);
        if (topicQuery.SecondPointId != 0)
            query = query.Where(t => t.SecondPointId == topicQuery.SecondPointId);

        if (topicQuery.TopicSourceId != 0)  //根据题库查询
            query = query.Where(t => t.TopicSourceId == topicQuery.TopicSourceId);

        if (topicQuery.SortId != 0)
            query = query.Where(t => t.SortId == topicQuery.SortId);
        if (topicQuery.TopicType.Trim() != "")
            query = query.Where(t => t.TopicType == topicQuery.TopicType);

        if (topicQuery.TopicState != -1)  //题目审核状态
            query = query.Where(t => t.TopicState == topicQuery.TopicState);


        int counts = query.Count();
        List<ImputTopic> topics = query.ToList();

        return topics;
    }

    //获取所有题库名称
    public List<TopicSource> GetTopicSource()
    {

        return db.TopicSource.ToList();

    }

    //获取题目类型
    public List<string> GetTopicType()
    {
        List<string> array = db.Topic.Select(t => t.TopicType).Distinct().ToList();
        return array;
    }

    //获取所有题目类别
    public List<Sort> GetTpicSort()
    {
        List<Sort> array = db.Sort.OrderBy(t => t.SortOrder).ToList();
        return array;
    }

    //根据题目Id获取题目信息
    public Topic GetTopicByTid(int topicId)
    {
        var query = db.Topic.Where(t => t.TopicId == topicId);
        if (query.Count() <= 0)
            return null;
        else
            return query.First();
    }

    //根据题目Id获取题目信息
    public ImputTopic GetTopicByTid(string topicId)
    {
        List<ImputTopic> topics = (from p in db.Topic
                                   join d in db.Sort on p.SortId equals d.SortId
                                   join s in db.SecondPoint on p.SecondPointId equals s.SecondPointId
                                   join f in db.FirstPoint on s.FIrstPointId equals f.FirstPointId
                                   join q in db.TopicSource on p.TopicSourceId equals q.TopicSourceId
                                   where p.TopicId == decimal.Parse(topicId)

                                   select new ImputTopic
                                   {
                                       TopicId = p.TopicId,
                                       SortId = d.SortId,
                                       SortName = d.SortName,
                                       SecondPointId = p.SecondPointId,
                                       FirstPointName = f.FirstPointName,
                                       SecondPointName = s.SecondPointName,
                                       TopicTitle = p.TopicTitle,
                                       OptionA = p.OptionA,
                                       OptionB = p.OptionB,
                                       OptionC = p.OptionC,
                                       OptionD = p.OptionD,
                                       TitleAnswer = p.TitleAnswer,
                                       TopicType = p.TopicType,
                                       TopicCreateDate = p.TopicCreateDate,
                                       FirstPointId = f.FirstPointId,
                                       TopicSourceName = q.TopicSourceName,
                                       TopicState = p.TopicState,
                                       TopicSourceId = q.TopicSourceId

                                   }).ToList();


        if (topics.Count() <= 0)
            return null;
        else
            return topics.First();
    }

    //更新题目信息
    public int UpdateTopic(Topic topic)
    {
        try
        {
            Topic newTopic = db.Topic.Where(t => t.TopicId == topic.TopicId).First();
            newTopic.SortId = topic.SortId;
            newTopic.SecondPointId = topic.SecondPointId;
            newTopic.TopicTitle = topic.TopicTitle;
            newTopic.OptionA = topic.OptionA;
            newTopic.OptionB = topic.OptionB;
            newTopic.OptionC = topic.OptionC;
            newTopic.OptionD = topic.OptionD;
            newTopic.TitleAnswer = topic.TitleAnswer;
            newTopic.TopicType = topic.TopicType;
            newTopic.TopicState = topic.TopicState;
            newTopic.TopicSourceId = topic.TopicSourceId;

            db.SubmitChanges();

            return 1;
        }
        catch (Exception e)
        {
            return 0;
        }
    }

    public bool IsHaveTopicSource(string name)
    {
        return db.TopicSource.Count(t => t.TopicSourceName == name) == 1;
    }

    //保存题库
    public int SaveSource(TopicSource topicScouce)
    {
        int res = 0;
        try
        {
            //更新
            if (topicScouce.TopicSourceId != 0)
            {
                TopicSource newSource = db.TopicSource.First(t => t.TopicSourceId == topicScouce.TopicSourceId);
                newSource.TopicSourceName = topicScouce.TopicSourceName;
                db.SubmitChanges();
            }
            else  //添加
            {
                TopicSource newSource = new TopicSource();
                newSource.TopicSourceName = topicScouce.TopicSourceName;
                newSource.IsChose = 0;  //默认未被选中
                db.TopicSource.InsertOnSubmit(newSource);
                db.SubmitChanges();
            }
            res = 1;

        }
        catch (Exception ex)
        {
            res = 0;
        }
        return res;



    }

    //判断题库是否有题目
    public bool isHaveTopicOfSource(int id)
    {
        return db.Topic.Count(t => t.TopicSourceId == id) > 0;
    }

    //删除题库名称
    public int DeleteSource(int id)
    {
        int res = 0;
        try
        {
            TopicSource source = db.TopicSource.First(t => t.TopicSourceId == id);
            db.TopicSource.DeleteOnSubmit(source);
            db.SubmitChanges();
            res = 1;
        }
        catch (Exception ex)
        {
            res = 0;
        }
        return res;
    }

    //获取题库信息
    public List<TopicSource> GetAllSource()
    {
        return db.TopicSource.OrderByDescending(t => t.TopicSourceId).ToList();
    }

    //判断题库是否存在
    public bool IsHaveSource(string sourceName)
    {
        return db.TopicSource.Count(t => t.TopicSourceName == sourceName) > 0;
    }

    //判断题目类型是否存在
    public bool IsHaveSort(string sortName)
    {
        return db.Sort.Count(t => t.SortName == sortName) > 0;
    }


    //获取题目可用数量
    public int GetNumberOfTopicBySort(string sortId)
    {
        string sql = "select count(1) from Topic " +
            "where SecondPointId in " +
            "(select SecondPointId from SecondPoint where IsChose = 1)" +
            "and TopicSourceId in (select TopicSourceId from TopicSource where IsChose = 1)" +
            "and SortId = {0}";

        return db.ExecuteQuery<int>(sql, new object[] { int.Parse(sortId) }).First();
    }

    //判断各类型题目的数量是否超过最大值
    public void JudgeSorceTopicNumberValid()
    {
        List<Sort> sorts = db.Sort.ToList();

        foreach (var item in sorts)
        {
            int maxNumber = GetNumberOfTopicBySort(item.SortId.ToString());
            if (item.TopicSortNumber > maxNumber)
            {
                //当题目数量超过最大值时， 重置的当前的最大值
                item.TopicSortNumber = maxNumber;
            }
            db.SubmitChanges();
        }

    }

    //删除题目
    public int DeleTopic(string topicId)
    {
        int res = 0;
        try
        {
            int count = db.PaperDetail.Count(t => t.TopicId == decimal.Parse(topicId));
            if (count > 0)
            {
                res = -1; //该题目已被试卷选中
                return res;
            }

            Topic topic = db.Topic.First(t => t.TopicId == decimal.Parse(topicId));
            db.Topic.DeleteOnSubmit(topic);
            db.SubmitChanges();

            res = 1;
            return res;
        }
        catch (Exception e)
        {
            res = 0;
        }
        return res;
    }


    //  上传实践题目
    public int AddPracticalTopic(PracticalTopic topic)
    {
        try
        {
            PracticalTopic newTopic = new PracticalTopic()
            {
                TopicPath = topic.TopicPath,
                TopicDesc = topic.TopicDesc,
                TopicName = topic.TopicName,
                TopicUpTime = topic.TopicUpTime,
                Chose = 0
            };

            db.PracticalTopic.InsertOnSubmit(newTopic);
            db.SubmitChanges();
            return 1;
        }
        catch (Exception e)
        {
            return 0;
        }
    }

    //分页获取实践题目

    public List<PracticalTopic> GetPracticalTopicsByPage(ref int pageNumber, ref int totalPage, string topicQuery, ref int totalCount)
    {
        var query = db.PracticalTopic.Where(t => t.TopicDesc.Contains(topicQuery) || t.TopicName.Contains(topicQuery)).OrderByDescending(t => t.TopicUpTime).ToList();
        int counts = query.Count();
        List<PracticalTopic> topics = new List<PracticalTopic>();
        if (counts == 0)
        {
            totalPage = 0;
            pageNumber = 0;

        }
        else
        {
            totalPage = counts % TopicPageSize == 0 ? counts / TopicPageSize : counts / TopicPageSize + 1;
            query = query.OrderByDescending(t => t.TopicUpTime).ToList();
            topics = (List<PracticalTopic>)query.Skip((pageNumber - 1) * TopicPageSize).Take(TopicPageSize).ToList();

        }
        totalCount = counts; //题目总数
        return topics;
    }

    public List<PracticalTopic> GetPracticalTopicsByPage(ref int pageNumber, ref int totalPage, string topicQuery, ref int totalCount, int isChose)
    {
        var query = db.PracticalTopic.Where(t => t.TopicDesc.Contains(topicQuery) || t.TopicName.Contains(topicQuery)).OrderByDescending(t => t.TopicUpTime).Where(t => t.Chose == isChose).ToList();
        int counts = query.Count();
        List<PracticalTopic> topics = new List<PracticalTopic>();
        if (counts == 0)
        {
            totalPage = 0;
            pageNumber = 0;

        }
        else
        {
            totalPage = counts % TopicPageSize == 0 ? counts / TopicPageSize : counts / TopicPageSize + 1;
            query = query.OrderByDescending(t => t.TopicUpTime).ToList();
            topics = (List<PracticalTopic>)query.Skip((pageNumber - 1) * TopicPageSize).Take(TopicPageSize).ToList();

        }
        totalCount = counts; //题目总数
        return topics;
    }


    //根据id获取实践考试题目
    public PracticalTopic GetPracTopicById(string tId)
    {
        try
        {
            return db.PracticalTopic.First(t => t.Tid == int.Parse(tId));
        }
        catch
        {
            return null;
        }

    }

    ////修改实践题目选中状态
    public int ChangePracTopicChose(string tId)
    {
        int res = 0;
        try
        {
            PracticalTopic topic = db.PracticalTopic.First(t => t.Tid == int.Parse(tId));
            topic.Chose = topic.Chose == 1 ? 0 : 1;
            db.SubmitChanges();
            res = 1;
        }
        catch
        {
            res = -1;
        }
        return res;

    }


    //删除实践题目
    public string DeletePracTopic(string tId)
    {
        PracticalTopic topic = db.PracticalTopic.First(t => t.Tid == decimal.Parse(tId));
        
        List<PaperDetail> paperDetails = db.PaperDetail.Where(t => t.TopicId == decimal.Parse(tId)).ToList();
        if (paperDetails.Count() > 0)
        {
            StringBuilder res = new StringBuilder();
            res.Append("该题目已加入到以下考试中  ");
            string sql = "select * from theExam where theExamId in ( select theExamId from exam where examId in " +
                "( select examId from paper where paperId in ( select paperId from paperdetail where topicId = {0} ) ))";
            List<TheExam> theExams = db.ExecuteQuery<TheExam>(sql, new Object[] { tId }).ToList();
            if (theExams.Count() > 0)
            {
                foreach (var item in theExams)
                {
                    res.Append(item.TheExamName + " ");
                }
            }
            return res.ToString(); 
        }
        else
            return "success";
    }
}