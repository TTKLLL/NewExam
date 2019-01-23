using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Transactions;
using System.IO;

/// <summary>
/// StuExamBLL 的摘要说明
/// </summary>
public class StuExamBLL
{
    public DataClassesDataContext db = new DataClassesDataContext();
    ExamBLL examBll = new ExamBLL();

    //考生登陆
    //考生登陆
    public int StuLogIn(string sId, string stuName, string examId, ref string errorInfo)
    {
        int res = 0;




        //判断考生是否存在
        int count = db.Student.Count(t => t.StudentId == sId);
        if (count <= 0)
        {
            errorInfo = "该考生不存在！";
            return res;
        }

        //判断学号与姓名是否匹配
        int number = db.Student.Count(t => t.StudentId == sId && t.StudentName == stuName);
        if (number != 1)
        {
            errorInfo = "学号与姓名不匹配！";
            return res;
        }


        if (examBll.StueIsHaveSumbitPaper(sId, examId))
        {
            errorInfo = "该考生已交卷！";
            return res;
        }

        //判断考生是否通过审核
        int state = int.Parse(db.Student.First(t => t.StudentId == sId).StudentState.ToString());

        if (state != (int)(StudentBLL.StudentState.PassAudit))
        {
            if (state == (int)(StudentBLL.StudentState.WaitAudit))
                errorInfo = "该考生待审核！";
            else
                errorInfo = "该考生未通过审核！";

            return res;
        }

        if (GetStuExam(sId, examId) != null)
        {
            if (GetStuExam(sId, examId).Score < 0)
            {
                errorInfo = "该考生考试作弊，不能继续考试！";
                return res;
            }
        }



        //判断考生是否已经登记
        int examState = int.Parse(db.Student.First(t => t.StudentId == sId).StuExamState.ToString());

        //登记了 但还未开始考试过
        if (examState == 1)
        {
            ////判断Ip地址
            //if (!JudgeIp(sId, examId))
            //{
            //    errorInfo = "IP地址不合法";
            //    return res;
            //}
        }
        else if (examBll.GetStuExamByExamId(sId, examId) == null &&
            examState == 0)
        {
            errorInfo = "请先在该考场监考老师处登记！";
            return res;
        }

        else //未登记  正在考试  已交卷
        {
            //判断是否有相关考试记录 无则是未登记
            if (examBll.GetStuExamByExamId(sId, examId) == null)
            {
                errorInfo = "请先在该考场监考老师处登记！";
                return res;
            }
            else
            {
                //判断是否已交卷 
                if (examBll.StueIsHaveSumbitPaper(sId, examId))
                {
                    errorInfo = "该考生已交卷！";
                    return res;
                }
                else  //正在考试
                {
                    //判断Ip地址
                    if (!JudgeIp(sId, examId))
                    {
                        errorInfo = "IP地址不合法！";
                        return res;
                    }
                }
            }

        }
        res = 1;
        return res;
    }


    //获取考生当前电脑的Ip地址是否合法
    public bool JudgeIp(string sId, string examId)
    {
        bool res = false;
        try
        {
            string dataBaseIp = GetStuExam(sId, examId).IPAddress;
            if (dataBaseIp == null || dataBaseIp == "")  //没有登陆考试过或被重置考试
                res = true;
            else
            {
                string computerIp = GetComputerIp();
                if (computerIp == dataBaseIp)
                    res = true;
                else
                    res = false;
            }
        }
        catch (Exception e)
        {
            return res;
        }
        return res;
    }


    //根据考试Id获取某个考生的考试记录
    public StuExam GetStuExam(string sId, string examId)
    {
        try
        {
            string sql = "select * from StuExam where StudentId = {0} " +
            "and PaperId in (select PaperId from Paper where ExamId = {1} )";

            List<StuExam> stuExams = db.ExecuteQuery<StuExam>(sql, new Object[] { sId, examId }).ToList();

            if (stuExams.Count <= 0)
                return null;
            else
            {
                return stuExams.First();
            }
        }
        catch (Exception e)
        {
            return null;
        }


    }


    //获取当前电脑额IP
    public string GetComputerIp()
    {
        string ip = System.Web.HttpContext.Current.Request.UserHostAddress;

        return ip;
    }

    //获取考生的某次考试的考试记录
    public StuExam GetStuExamByExamId(string sId, string examId)
    {

        try
        {
            //获取去该次考试的Id
            string theExamId = db.Exam.First(t => t.ExamId == decimal.Parse(examId)).TheExamId.ToString();

            string sql = "   select * from StuExam where StudentId = {0} " +
            "and PaperId in (select PaperId from Paper where ExamId in " +
            "(select ExamId from Exam where TheExamId = {1}))";

            List<StuExam> stuExams = db.ExecuteQuery<StuExam>(sql, new Object[] { sId, theExamId }).ToList();
            StuExam stuExam = null;



            if (stuExams.Count() > 0)
                stuExam = stuExams.First();


            return stuExam;
        }
        catch (Exception e)
        {
            return null;
        }



    }

    //考生开始考试 返回考生的试卷编号
    public int StuBeginExam(string sId, string examId)
    {
        int res = 0;
        using (TransactionScope scope = new TransactionScope())
        {
            try
            {
                ExamBLL examBll = new ExamBLL();


                Student stu = db.Student.First(t => t.StudentId == sId);
                StuExam stuExam = GetStuExamByExamId(sId, examId);


                db.SubmitChanges();
                int paperId = int.Parse(stuExam.PaperId.ToString());

                //考生第一次登陆
                if (stu.StuExamState == (int)StudentBLL.StudentExamState.AdmitExam)
                {
                    stuExam.BeginExamTIme = DateTime.Now.ToLocalTime();//开始答题时间

                    //初始化考生答案
                    List<Decimal> topicIds = db.PaperDetail.Where(t => t.PaperId == paperId).Select(t => t.TopicId).ToList();
                    stuExam.Score = 0;

                    foreach (var item in topicIds)
                    {
                        StuPaper stuPaper = new StuPaper()
                        {
                            TopicId = item,
                            StudentId = sId,
                            StuAnswer = "",
                            ExamId = decimal.Parse(examId)
                        };
                        db.StuPaper.InsertOnSubmit(stuPaper);
                    }
                }



                //修改考生考试状态 开始时间 ip地址
                stu.StuExamState = (int)StudentBLL.StudentExamState.Default;

                stuExam.IPAddress = GetComputerIp();
                db.SubmitChanges();

                res = paperId;
                scope.Complete();
            }
            catch (Exception e)
            {
                res = 0;
            }
        }
        return res;
    }

    //获取考生信息
    public Student GetStuInfo(string sId)
    {
        try
        {
            return db.Student.First(t => t.StudentId == sId);
        }
        catch
        {
            return null;
        }
    }

    //获取题目类别
    public List<Sort> GetExamTopicBySort(string sId, string examId)
    {
        string sql = "	select SortId, SortName, TopicSortScore, TopicSortNumber from Sort " +
        "where SortId in ( select Sort.SortId from Topic, Sort " +
            " where Topic.SortId = Sort.SortId and TopicId in  " +
            " (select TopicId from StuPaper where StuPaper.StudentId = {0} and  ExamId = {1})) " +
            " and TopicSortNumber > 0  order by SortOrder ";
        List<Sort> sorts = db.ExecuteQuery<Sort>(sql, new Object[] { sId, examId }).ToList();
        if (sorts.Count() > 0)
            return sorts;
        else
            return null;
    }

    //获取某个考生在某次考试中某中题目类别下的题目
    public List<StuExamTopic> GetExamTopicBySortId(string sId, string examId, string sortId)
    {
        string sql = "select * from StuPaper, Topic, Sort  where Topic.SortId = Sort.SortId  " +
            "and StuPaper.TopicId = Topic.TopicId and " +
             "StudentId = {0} and  ExamId = {1} and Sort.SortId = {2} ";

        List<StuExamTopic> topics = db.ExecuteQuery<StuExamTopic>(sql, new Object[] { sId, examId, sortId }).ToList();

        if (topics.Count() > 0)
            return topics;
        else
            return null;
    }

    //修改考生答案
    public int UpdateStuAns(string sId, string examId, string topicId, string stuAns)
    {
        int res = 0;
        try
        {
            StuPaper stuPaper = db.StuPaper.First(t => t.StudentId == sId
               && t.ExamId == decimal.Parse(examId) && t.TopicId == decimal.Parse(topicId));

            stuPaper.StuAnswer = stuAns.Trim();
            db.SubmitChanges();

            res = 1;

        }
        catch (Exception e)
        {
            res = 0;
        }
        return res;

    }

    //考生交卷
    public int StuSubmitPaper(string sId, string examId)
    {
        int res = 0;
        using (TransactionScope scope = new TransactionScope())
        {
            try
            {
                string sql = " select * from StuPaper, Topic, Sort  where Topic.SortId = Sort.SortId  " +
                " and StuPaper.TopicId = Topic.TopicId and " +
               "  StudentId = {0} and  ExamId = {1} ";

                List<StuExamTopic> topics = db.ExecuteQuery<StuExamTopic>(sql, new Object[] { sId, examId }).ToList();
                int score = 0;
                int totalScore = 0;

                foreach (var item in topics)
                {
                    totalScore += item.TopicSortScore;
                    if (item.StuAnswer != null)
                    {
                        if (FormatAnswer(item.StuAnswer) == FormatAnswer(item.TitleAnswer))
                            score += item.TopicSortScore;
                    }

                }

                float floatScore = float.Parse(score.ToString());
                float temp = floatScore / totalScore * 100;
                score = (int)temp;



                StuExam stuExam = GetStuExamByExamId(sId, examId);
                stuExam.Score = score;

                stuExam.ReplyEndTime = DateTime.Now.ToLocalTime();
                db.SubmitChanges();

                scope.Complete();

                res = 1;
            }
            catch (Exception e)
            {
                res = 0;
            }
        }

        return res;
    }


    //格式化题目答案
    public string FormatAnswer(string oldAnswer)
    {
        oldAnswer.Replace(" ", "");
        char[] array = oldAnswer.ToArray();

        Array.Sort(array);
        return new string(array).ToUpper().Trim();
    }

    //根据学号和次考试id获取场考试id
    public Exam GetExamByThExamIdBySId(string theExamId, string sId)
    {
        string sql = "select * from Exam where TheExamId = {0} and ExamId = " +
       " (select top 1 ExamId from Paper where PaperId = " +
        "(select  PaperId " +
        "from  StuExam where StudentId = {1} and PaperId  in " +
        "(select PaperId from Paper where Paper.ExamId in (select ExamId from exam where TheExamId = {0})  )  ) )";

        List<Exam> exam = db.ExecuteQuery<Exam>(sql, new Object[] { theExamId, sId }).ToList();
        if (exam.Count() > 0)
            return exam.First();
        else
            return null;
    }

    //获取考生的实践题目
    public PracticalTopic GetStuPracTopicByExamId(string sId, string examId)
    {
        string getSql = "select * from practicalTopic where tId in " +
           "(select topicId from paperDetail where paperId in " +
           "(select paperId from stuexam where studentId = {0} and paperId in (select paperId from paper where examid = {1})))";

        PracticalTopic topic = db.ExecuteQuery<PracticalTopic>(getSql, new Object[] { sId, examId }).First();
        return topic;
    }


    //获取考生考试记录
    public StuExam GetStuExamBySidExamId(string sId, string examId)
    {
        string sql = "select paperId from stuexam where studentId = {0} and paperId in (select paperId from paper where examid = {1})";
        return db.ExecuteQuery<StuExam>(sql, new Object[] { sId, examId }).First();
    }

    //考生提交实践题答案
    public int StuPutPracAns(string sId, string examId, string path)
    {
        try
        {
            StuPaper stuPaper = db.StuPaper.First(t => t.StudentId == sId && t.ExamId == decimal.Parse(examId));
            if (stuPaper.stuAnsPath != null)
            {
                System.Web.HttpServerUtility server = System.Web.HttpContext.Current.Server;
                string phth = server.MapPath(@stuPaper.stuAnsPath);

                if (File.Exists(server.MapPath(@stuPaper.stuAnsPath)))
                    File.Delete(server.MapPath(stuPaper.stuAnsPath));
            }

            stuPaper.stuAnsPath = path;
            db.SubmitChanges();

            return 1;
        }
        catch
        {
            return -1;
        }
    }

    //更新实践考试成绩
    public string GetStuExamByTheExamId(string tId, string theExamId, int score)
    {
        int oldScore  =0;
        try
        {
            string sql = "select * from stuexam where studentId = {0} and paperId in (select paperId from paper" +
                " where examid in (select examId from exam where theExamId = {1}))";
            StuExam exam = db.ExecuteQuery<StuExam>(sql, new Object[] { tId, theExamId }).First();
            oldScore = int.Parse(exam.Score.ToString());
            exam.Score = score;
            db.SubmitChanges();

            return "success";

        }
        catch (Exception e)
        {
            return oldScore.ToString();
        }

    }

}