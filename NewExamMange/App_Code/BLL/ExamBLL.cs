using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Transactions;


/// <summary>
/// 考试
/// </summary>
/// 


public class ExamBLL
{


    DataClassesDataContext db = new DataClassesDataContext();
    public static int theExamPageSize = 15; //考试管理页面大小
    public static int CheckStuPageSize = 15; // 登记考生页面大小
    public static int UnusualPageSize = 15;  //考试异常处理页面分页大小

    public static int TopicPageSize = 15;

    public enum StuExamDesc // 学生考试状态描述
    {
        [EnumDescription("待登记")]
        WaitCheck,

        [EnumDescription("未开始")]
        WaitBegin,

        [EnumDescription("正在考试")]
        NowExam,

        [EnumDescription("已交卷")]
        Submit,

        [EnumDescription("作弊")]
        Cheat
    }

    //修改题库选中状态
    public int ChangeSourceChose(string sourceId)
    {
        int res = 0;
        try
        {
            TopicSource source = db.TopicSource.First(t => t.TopicSourceId == int.Parse(sourceId));
            if (source.IsChose == null)
                source.IsChose = 1; //被选中

            if (source.IsChose == 1)
            {
                source.IsChose = 0;
                db.SubmitChanges();
                new TopicBLL().JudgeSorceTopicNumberValid();  //验证题目数量是否大于最大可选值
            }

            else
                source.IsChose = 1; //被选中

            db.SubmitChanges();
            res = 1;
        }
        catch
        {
            res = 0;
        }

        return res;

    }

    //修改考试的题型设置
    public int UpdateExamSort(Sort sort)
    {
        int res = 0;
        try
        {
            Sort newSort = db.Sort.First(t => t.SortId == sort.SortId);
            newSort.TopicSortNumber = sort.TopicSortNumber;
            newSort.TopicSortScore = sort.TopicSortScore;
            db.SubmitChanges();
        }
        catch (Exception e)
        {

        }

        return res;
    }

    //判断考试名称是否已存在
    public bool IshaveTheExam(string examName)
    {
        return db.TheExam.Count(t => t.TheExamName.Trim() == examName.Trim()) >= 1;
    }

    //添加一次考试
    public int AddTheExam(string name, string examType)
    {
        try
        {
            TheExam theExam = new TheExam()
            {
                TheExamName = name,
                ExamType = int.Parse(examType)
            };

            db.TheExam.InsertOnSubmit(theExam);
            db.SubmitChanges();
            return int.Parse(theExam.TheExamId.ToString());
        }
        catch (Exception e)
        {
            return 0;
        }

    }

    //根据次考试Id获取考试信息
    public TheExam GetTheExamBytheId(string theId)
    {
        return db.TheExam.First(t => t.TheExamId == int.Parse(theId));

    }

    //保存场考试
    public int SaveExam(Exam exam)
    {
        int res = 0;

        using (TransactionScope scope = new TransactionScope())
        {
            try
            {
                //添加
                if (exam.ExamId == 0)
                {
                    //判断该场次是否存在
                    Exam newExam = new Exam()
                    {
                        TheExamId = exam.TheExamId,
                        ExamBegTime = exam.ExamBegTime,
                        ExamEndTime = exam.ExamEndTime,
                        ExamPeriod = exam.ExamPeriod,
                        NowPeriod = exam.NowPeriod,
                        PaperNumber = exam.PaperNumber,

                    };
                    if (isHavePeriod(newExam.TheExamId.ToString(), newExam.ExamPeriod.ToString()))
                    {
                        return -1;
                    }

                    db.Exam.InsertOnSubmit(newExam);
                    db.SubmitChanges();

                    if (newExam.NowPeriod == 1)
                    {
                        var query = db.Exam.Where(t => t.TheExamId == newExam.TheExamId && t.ExamId != newExam.ExamId);
                        if (query.Count() > 0)
                        {
                            List<Exam> otherExams = query.ToList();
                            foreach (var item in otherExams)
                            {
                                item.NowPeriod = 0;
                            }
                            db.SubmitChanges();
                        }
                    }
                    //生成试卷
                    res = GenereatePaper(newExam);
                }

                //更新
                else
                {
                    Exam oldExam = db.Exam.First(t => t.ExamId == exam.ExamId);
                    oldExam.TheExamId = exam.TheExamId;
                    oldExam.ExamBegTime = exam.ExamBegTime;
                    oldExam.ExamEndTime = exam.ExamEndTime;
                    oldExam.ExamPeriod = exam.ExamPeriod;

                    //  oldExam.NowPeriod = exam.NowPeriod;


                    db.SubmitChanges();
                }
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


    //删除原来生成的试卷
    public int ReGenerate(Exam exam)
    {
        int res = 0;
        using (TransactionScope scope = new TransactionScope())
        {
            try
            {
                List<Paper> papers = db.Paper.Where(t => t.ExamId == exam.ExamId).ToList();
                db.Paper.DeleteAllOnSubmit(papers);
                db.SubmitChanges();


                Exam newExam = db.Exam.First(t => t.ExamId == decimal.Parse(exam.ExamId.ToString()));
                newExam.PaperNumber = exam.PaperNumber;
                db.SubmitChanges();

                GenereatePaper(exam);

                scope.Complete();
                res = 1;
            }
            catch (Exception e)
            {
                res = 0;
            }
            return res;
        }
    }

    //判断该场次是否已存在
    public bool isHavePeriod(string theExamId, string period)
    {
        return db.Exam.Count(t => t.ExamPeriod == int.Parse(period) && t.TheExamId == decimal.Parse(theExamId)) > 0;
    }

    //添加一套试卷
    public int AddPaper(Paper paper)
    {
        try
        {
            db.Paper.InsertOnSubmit(paper);
            db.SubmitChanges();
            return int.Parse(paper.PaperId.ToString());
        }
        catch (Exception e)
        {
            return 0;
        }
    }

    //生成试卷  包括理论考试和实践考试
    public int GenereatePaper(Exam exam)
    {
        int res = 0;

        using (TransactionScope scope = new TransactionScope(TransactionScopeOption.Required, new TimeSpan(6000000000)))
        {
            try
            {
                int examFlag = GetChoseExamType(); //获取当前考试类型

                ///获取试卷的基本信息
                for (int i = 0; i < exam.PaperNumber; i++)
                {

                    //产生试卷
                    Paper paper = new Paper()
                    {
                        ExamId = exam.ExamId
                    };
                    int paperId = AddPaper(paper);
                    if (paperId == 0)
                        return res;



                    //理论考试
                    if (examFlag == (int)AuthorityBLL.AuthorityExamType.Basic)
                    {
                        //获取题目数量不为0的题目类型
                        //根据题目类型获取相关数量的题目 并给生成的试卷添加题目
                        List<Sort> sorts = db.Sort.Where(t => t.TopicSortNumber != 0).ToList();
                        foreach (var item in sorts)
                        {
                            string getTopicSql = "select  top " + item.TopicSortNumber + "  *  from Topic " +
                                "where SecondPointId in " +
                                " (select SecondPointId from SecondPoint where IsChose = 1)" +
                                "  and   TopicSourceId in (select TopicSourceId from TopicSource where IsChose = 1)" +
                                "  and    SortId = {0} " +
                                "order by newID()";


                            List<Topic> topics = db.ExecuteQuery<Topic>(getTopicSql, new Object[] { item.SortId }).ToList();

                            //将题目添加到试卷中
                            foreach (var topic in topics)
                            {
                                PaperDetail paperDetail = new PaperDetail()
                                {
                                    TopicId = topic.TopicId,
                                    PaperId = paperId,
                                    TopicScore = item.TopicSortScore
                                };

                                db.PaperDetail.InsertOnSubmit(paperDetail);
                                db.SubmitChanges();
                            }
                        }
                    }
                    else //实践考试
                    {
                        string getPracTopic = "   select  top 1 *  from PracticalTopic where chose = 1 order by newID()";
                        PracticalTopic topic = db.ExecuteQuery<PracticalTopic>(getPracTopic, new object[] { }).First();
                        PaperDetail paperDetail = new PaperDetail()
                        {
                            TopicId = topic.Tid,
                            PaperId = paperId,
                            TopicScore = 0
                        };
                        db.PaperDetail.InsertOnSubmit(paperDetail);
                        db.SubmitChanges();
                    }



                }

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

    //生成指定数量的试卷
    public int GenereatePaper(Exam exam, int paperNumber)
    {
        int res = 0;

        using (TransactionScope scope = new TransactionScope())
        {
            try
            {
                ///获取试卷的基本信息
                for (int i = 0; i < paperNumber; i++)
                {
                    //if (i == 3)
                    //    return res;
                    //产生试卷
                    Paper paper = new Paper()
                    {
                        ExamId = exam.ExamId
                    };
                    int paperId = AddPaper(paper);
                    if (paperId == 0)
                        return res;

                    //获取题目数量不为0的题目类型
                    //根据题目类型获取相关数量的题目 并给生成的试卷添加题目
                    List<Sort> sorts = db.Sort.Where(t => t.TopicSortNumber != 0).ToList();

                    foreach (var item in sorts)
                    {
                        string getTopicSql = "select  top " + item.TopicSortNumber + "  *  from Topic " +
                            "where SecondPointId in " +
                            " (select SecondPointId from SecondPoint where IsChose = 1)" +
                            "  and   TopicSourceId in (select TopicSourceId from TopicSource where IsChose = 1)" +
                            "  and    SortId = {0} " +
                            "order by newID()";



                        List<Topic> topics = db.ExecuteQuery<Topic>(getTopicSql, new Object[] { item.SortId }).ToList();

                        //将题目添加到试卷中
                        foreach (var topic in topics)
                        {
                            PaperDetail paperDetail = new PaperDetail()
                            {
                                TopicId = topic.TopicId,
                                PaperId = paperId,
                                TopicScore = item.TopicSortScore
                            };

                            db.PaperDetail.InsertOnSubmit(paperDetail);
                            db.SubmitChanges();
                        }


                    }

                }

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

    //分页获取次考试信息
    public List<TheExam> GetTheExamByPage(ref int pageNumber, ref int totalPage, ref int count, string examType)
    {
        var query = db.TheExam.Where(t => t.ExamType == int.Parse(examType)).OrderByDescending(t => t.TheExamId);
        count = query.Count();

        if (count == 0)
            return null;
        if (pageNumber < 1)
        {
            pageNumber = 1;
            GetTheExamByPage(ref  pageNumber, ref  totalPage, ref  count, examType);
        }
        if (pageNumber > count)
        {
            pageNumber = count;
            GetTheExamByPage(ref  pageNumber, ref  totalPage, ref  count, examType);
        }

        List<TheExam> theExams = query.Skip((pageNumber - 1) * theExamPageSize).Take(theExamPageSize).ToList();

        totalPage = count % theExamPageSize == 0 ? count / theExamPageSize : count / theExamPageSize + 1;

        return theExams;
    }

    //获取次考试开始时间
    public String GetTheExamBeginTime(string theExamId)
    {
        var query = db.Exam.Where(t => t.TheExamId == int.Parse(theExamId)).OrderBy(t => t.ExamBegTime);

        int count = query.Count();
        if (count == 0)
            return "该考试暂无场次";
        else
        {
            List<Exam> exams = query.ToList();

            DateTime? minTime = exams[0].ExamBegTime;
            foreach (var item in exams)
            {
                if (item.ExamBegTime < minTime)
                    minTime = item.ExamBegTime;
            }

            return minTime.ToString();
        }
    }

    //获取次考试结束时间
    public String GetTheExamEndTime(string theExamId)
    {
        var query = db.Exam.Where(t => t.TheExamId == int.Parse(theExamId)).OrderBy(t => t.ExamBegTime);

        int count = query.Count();
        if (count == 0)
            return "该考试暂无场次";
        else
        {
            List<Exam> exams = query.ToList();
            DateTime? maxTime = exams[0].ExamBegTime;
            foreach (var item in exams)
            {
                if (item.ExamEndTime > maxTime)
                    maxTime = item.ExamEndTime;
            }
            return maxTime.ToString();
        }
    }

    //获取一次考试中的所有场次
    public List<Exam> GetExamByTheExamId(string theExamId)
    {
        return db.Exam.Where(t => t.TheExamId == decimal.Parse(theExamId)).OrderBy(t => t.ExamPeriod).ToList();
    }

    /// <summary>
    /// 判断当前场考试是否已结束
    /// </summary>
    public bool JudeNowExamIsEnd()
    {
        if (GetNowExam() == null) //没有设置当前场次
            return true;
        else
            return DateTime.Now > GetNowExam().ExamEndTime;
    }

    //修改当前场次
    public int ChangeNowPeriod(string examId)
    {
        int res = 0;
        using (TransactionScope scop = new TransactionScope())
        {
            try
            {     
                Exam exam = db.Exam.First(t => t.ExamId == decimal.Parse(examId));
                exam.NowPeriod = 1;
                db.SubmitChanges();

                var query = db.Exam.Where(t => t.ExamId != exam.ExamId);
                if (query.Count() > 0)
                {
                    List<Exam> otherExams = query.ToList();
                    foreach (var item in otherExams)
                    {
                        item.NowPeriod = 0;
                    }
                    db.SubmitChanges();
                }

                //同时修改次当前考试
                TheExam theExam = db.TheExam.First(t => t.TheExamId == exam.TheExamId);
                theExam.IsNowTheExam = 1;

                List<TheExam> theExams = db.TheExam.ToList();
                foreach (var item in theExams)
                {
                    if (item.TheExamId != theExam.TheExamId)
                        item.IsNowTheExam = 0;
                }

                db.SubmitChanges();


                res = 1;
                // }
                scop.Complete();
            }
            catch (Exception e)
            {
                res = 0;
            }
        }
        return res;
    }

    ///获取最新一次考试的当前考试
    public Exam GetNowExam()
    {
        try
        {
            //先判断有无次考试
            var getTheExamQuery = db.TheExam.OrderByDescending(t => t.TheExamId);
            if (getTheExamQuery.Count() <= 0)  //没有任何考试
                return null;

            //TheExam theExam = getTheExamQuery.First();
            TheExam theExam = GetNowTheExam();
            var query = db.Exam.Where(t => t.TheExamId == theExam.TheExamId);
            if (query.Count() <= 0) //最新的次考试还没有场次信息
                return null;
            else
            {
                var getLaseExamQuery = query.Where(t => t.NowPeriod == 1).ToList();
                if (getLaseExamQuery.Count() <= 0)
                    return null;  //有次考试信息和场考试信息 但未设置当前场
                Exam lastExam = getLaseExamQuery.First();

                if (lastExam.ExamEndTime < DateTime.Now)
                {
                    return null;  //最新的考试已结束
                }
                else
                    return lastExam;
            }
        }
        catch (Exception e)
        {
            return null;
        }

    }

    //获取场考试名称
    public String GetExamName(Exam exam)
    {
        string res = "";
        try
        {
            TheExam theExam = db.TheExam.First(t => t.TheExamId == exam.TheExamId);
            return theExam.TheExamName + "第" + exam.ExamPeriod.ToString() + "场";
        }
        catch (Exception)
        {
            res = "";
        }
        return res;
    }

    //根据教师和考试信息获取监考信息
    public Invigilate GetInvigilateByTidExamId(string tId, string examId)
    {
        try
        {
            return db.Invigilate.First(t => t.TId == tId && t.ExamId == decimal.Parse(examId));
        }
        catch (Exception e)
        {
            return null;
        }
    }

    //判断某次考试是否已被登记过
    public bool IsExamHasInvigilate(string examId, string tId)
    {
        return db.Invigilate.Count(t => t.ExamId == decimal.Parse(examId) && t.TId == tId) > 0;
    }

    //判断考场名称是否可用
    public bool JudeExamRoomName(string examId, string name, string tId)
    {
        return db.Invigilate.Count(t => t.ExamId == decimal.Parse(examId) && t.ExamRoomName == name && t.TId != tId) > 0;
    }

    //判断考场地址是否可用
    public bool JudeExamPosition(string examId, string position, string tId)
    {
        return db.Invigilate.Count(t => t.ExamId == decimal.Parse(examId) && t.ExamRoomPosition == position && t.TId != tId) > 0;
    }

    //保存监考信息
    public int SaveInvigilate(Invigilate invigilate)
    {
        int res = 0;
        try
        {
            if (IsExamHasInvigilate(invigilate.ExamId.ToString(), invigilate.TId))
            {
                //更新
                Invigilate newInvigilate = db.Invigilate.First(t => t.ExamId == invigilate.ExamId && t.TId == invigilate.TId);
                newInvigilate.ExamRoomPosition = invigilate.ExamRoomPosition;
                newInvigilate.ExamRoomName = invigilate.ExamRoomName;
                newInvigilate.OtherTeacher = invigilate.OtherTeacher;
                db.SubmitChanges();
            }
            else //添加
            {
                Invigilate newInvigilate = new Invigilate()
                {
                    ExamId = invigilate.ExamId,
                    TId = invigilate.TId,
                    ExamRoomName = invigilate.ExamRoomName,
                    ExamRoomPosition = invigilate.ExamRoomPosition,
                    OtherTeacher = invigilate.OtherTeacher
                };
                db.Invigilate.InsertOnSubmit(newInvigilate);
                db.SubmitChanges();
            }
            res = 1;
        }
        catch (Exception e)
        {
            res = 0;
        }
        return res;
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

    //判断某个考生在某次考试中是否已交卷 
    public bool StueIsHaveSumbitPaper(string sId, string examId)
    {
        StuExam stuExam = GetStuExamByExamId(sId, examId);

        bool res = false;
        if (stuExam == null)
            return res;


        if (stuExam.ReplyEndTime != null)
            res = true;

        return res;
    }

    //判断考生在某次考试中是否已开始考试
    public bool StuIsHaveBeginExam(string sId, string examId)
    {
        StuExam stuExam = GetStuExamByExamId(sId, examId);

        bool res = false;
        if (stuExam == null)
            return res;

        if (stuExam.BeginExamTIme != null)
        {
            res = true;
        }

        return res;
    }

    //获取通过审核的考生  即可以参加考试的学生
    public List<Student> GetPassAuditStu(string para)
    {
        List<Student> stus = db.Student.Where(t => t.StudentState == (int)StudentBLL.StudentState.PassAudit)
            .Where(t => t.StudentName.Contains(para.Trim()) || t.Class.Contains(para.Trim()))  //对姓名和班级模糊查询
            .OrderBy(t => t.Class).ThenBy(t => t.StudentId).ToList();
        return stus;
    }

    // 获取待登记的考生
    public List<Student> GetWaitCheckStu(string examId, ref int pageNumber, ref int totalPage, ref int count, string para)
    {
        List<Student> waitCheckStu = new List<Student>();


        foreach (var item in GetPassAuditStu(para))
        {
            //排除已参加过该次考试的学生  
            //if (GetStuExamByExamId(item.StudentId, examId) != null)
            //    continue;
            //if (item.StuExamState == (int)StudentBLL.StudentExamState.Default)
            //    waitCheckStu.Add(item);

            //没有该次考试记录的学生
            if (GetStuExamByExamId(item.StudentId, examId) == null)
                waitCheckStu.Add(item);
        }

        if (waitCheckStu.Count != 0)
        {
            count = waitCheckStu.Count;
            totalPage = count % CheckStuPageSize == 0 ? count / CheckStuPageSize : count / CheckStuPageSize + 1;

            int flag = 1;
            if (pageNumber < 1)
            {
                pageNumber = 1;
                flag = 0;
            }

            if (pageNumber > totalPage)
            {
                pageNumber = totalPage;
                flag = 0;
            }

            if (flag == 0)  //重新查询
                return GetWaitCheckStu(examId, ref  pageNumber, ref  totalPage, ref  count, para);

            return waitCheckStu.Skip((pageNumber - 1) * CheckStuPageSize).Take(CheckStuPageSize).ToList();
        }

        else
        {
            count = 0;
            totalPage = 0;
            return null;
        }

    }

    //获取已登记的考生  有本次考试的考试记录 并且是在本场考试中在这个考场中被这个老师登记的学生
    public List<Student> GetPassCheckStu(string examId, string tId, ref int pageNumber, ref int totalPage, ref int count, string para)
    {
        List<Student> passCheckStu = new List<Student>();
        foreach (var item in GetPassAuditStu(para))
        {
            int flag = 0;

            StuExam stuExam = GetStuExamByExamId(item.StudentId, examId);
            //有这次考试的考试记录的考生
            if (stuExam != null)
            {
                bool res1 = stuExam.TId == tId;
                bool res2 = db.Paper.Where(t => t.ExamId == decimal.Parse(examId))
                    .Select(t => t.PaperId).ToList().Contains(stuExam.PaperId);

                if (res1 == true && res2 == true)
                {
                    passCheckStu.Add(item);
                }

            }
        }

        if (passCheckStu.Count != 0)
        {
            count = passCheckStu.Count;
            totalPage = count % CheckStuPageSize == 0 ? count / CheckStuPageSize : count / CheckStuPageSize + 1;

            int flag = 1;
            if (pageNumber < 1)
            {
                pageNumber = 1;
                flag = 0;
            }

            if (pageNumber > totalPage)
            {
                pageNumber = totalPage;
                flag = 0;
            }

            if (flag == 0)  //重新查询
                return GetPassCheckStu(examId, tId, ref  pageNumber, ref  totalPage, ref  count, para);

            return passCheckStu.Skip((pageNumber - 1) * CheckStuPageSize).Take(CheckStuPageSize).ToList();
        }
        else
        {
            count = 0;
            totalPage = 0;
            return null;
        }


    }

    //获取某个教师登记的学生
    //public List<Student> GetPassCheckStu(string examId, string tId, ref int pageNumber, ref int totalPage, ref int count, string para)
    //{
    //    List<Student> passCheckStu = new List<Student>();
    //    foreach (var item in GetPassAuditStu(para))
    //    {
    //        int flag = 0;
    //        ////状态为1的学生
    //        //if (item.StuExamState == (int)StudentBLL.StudentExamState.AdmitExam)
    //        //{
    //        //    passCheckStu.Add(item);
    //        //    continue;
    //        //}

    //        //有这次考试的考试记录的考生
    //        StuExam stuExam = GetStuExamByExamId(item.StudentId, examId);
    //        if (stuExam != null)
    //        {
    //            if (stuExam.TId == tId)
    //                passCheckStu.Add(item);
    //        }
    //    }

    //    if (passCheckStu.Count != 0)
    //    {
    //        count = passCheckStu.Count;
    //        totalPage = count % CheckStuPageSize == 0 ? count / CheckStuPageSize : count / CheckStuPageSize + 1;

    //        int flag = 1;
    //        if (pageNumber < 1)
    //        {
    //            pageNumber = 1;
    //            flag = 0;
    //        }

    //        if (pageNumber > totalPage)
    //        {
    //            pageNumber = totalPage;
    //            flag = 0;
    //        }

    //        if (flag == 0)  //重新查询
    //            return GetPassCheckStu(examId, ref  pageNumber, ref  totalPage, ref  count, para);

    //        return passCheckStu.Skip((pageNumber - 1) * CheckStuPageSize).Take(CheckStuPageSize).ToList();
    //    }
    //    else
    //    {
    //        count = 0;
    //        totalPage = 0;
    //        return null;
    //    }


    //}

    //修改考生的考试状态
    public int ChangeStuExamState(string sId, string tId, string examId, int state)
    {
        int res = 0;
        using (TransactionScope scope = new TransactionScope())
        {
            try
            {
                Student stu = db.Student.First(t => t.StudentId == sId);
                stu.StuExamState = state;

                db.SubmitChanges();

                //分配试卷
                if (state == (int)StudentBLL.StudentExamState.AdmitExam)
                {
                    if (DistributePaper(sId, tId, examId) <= 0)
                        return res;
                }

                //取消登记
                if (state == (int)StudentBLL.StudentExamState.Default)
                {
                    Exam nowExam = GetNowExam();
                    if (CancleStuExame(sId, nowExam.ExamId.ToString()) <= 0)
                        return res;
                }

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

    //为考生分配试卷
    public int DistributePaper(string sId, string tId, string examId)
    {
        int res = 0;

        using (TransactionScope scope = new TransactionScope())
        {
            try
            {
                //获取一份试卷
                Paper paper = SelecetPaperForStu(tId, examId);
                if (paper != null)
                {
                    StuExam stuExam = new StuExam()
                    {
                        StudentId = sId,
                        TId = tId,
                        PaperId = paper.PaperId,
                        Score = 0  //初始化成绩
                    };
                    db.StuExam.InsertOnSubmit(stuExam);
                    db.SubmitChanges();
                }
                else
                {
                    res = 0;
                    return res;
                }
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

    //为一位考生取一份试卷
    public Paper SelecetPaperForStu(string tId, string examId)
    {
        Paper paper = new Paper();
        try
        {
            //获取试卷份数
            int totalCount = db.Paper.Count(t => t.ExamId == decimal.Parse(examId));
            string getPaperSql = "select top 1 * from  paper where ExamId = {0} order by NEWID()";
            paper = db.ExecuteQuery<Paper>(getPaperSql, new object[] { examId }).First();

            //判断同考场人数是否等于试卷分数
            string getStuCountSql = "select count(1) from StuExam where TId = {0} and PaperId in " +
                    " (select PaperId from Paper where ExamId = {1})";
            int studentCount = db.ExecuteQuery<int>(getStuCountSql, new object[] { tId, examId }).First();

            //只有一份试卷或者同一个考场内试卷已分发完了 即试卷份数不够
            if (totalCount == 1 || totalCount == studentCount)
            {
                SelecetPaperForStu(tId, examId);
            }
            else
            {
                //判断该试卷是否已被该考场的其他考试使用
                string judgeSql = "	select count(1) from StuExam where TId = {0} and PaperId = {1}";
                int count = db.ExecuteQuery<int>(judgeSql, new object[] { tId, paper.PaperId }).First();
                if (count > 0)
                    SelecetPaperForStu(tId, examId);
                else
                    return paper;
            }


        }
        catch (Exception e)
        {
            paper = null;
        }
        return paper;
    }

    //取消登记 即删除学生的考试记录 
    public int CancleStuExame(string sId, string examId)
    {
        int res = 0;
        using (TransactionScope scope = new TransactionScope())
        {
            try
            {
                //获取考试记录
                string getStuExamQuery = "select * from StuExam where StudentId = {0} and PaperId in" +
                    "(select PaperId from Paper where ExamId = {1})";

                var query = db.ExecuteQuery<StuExam>(getStuExamQuery, new object[] { sId, examId }).ToList();
                int count = query.Count();
                var getStuPaperQuery = db.StuPaper.Where(t => t.StudentId == sId && t.ExamId == decimal.Parse(examId));
                if (count == 0) //考生没有当场考试的记录
                {
                    res = 0;
                    //获取答题记录

                    //无考试记录 担忧相关的答题记录
                    if (getStuPaperQuery.Count() != 0)
                    {
                        //删除答题记录
                        db.StuPaper.DeleteAllOnSubmit(getStuPaperQuery.ToList());
                        db.SubmitChanges();
                    }
                }
                else
                {
                    StuExam stuExam = query.First();
                    //有答题记录
                    if (getStuPaperQuery.Count() != 0)
                    {
                        //删除答题记录
                        db.StuPaper.DeleteAllOnSubmit(getStuPaperQuery.ToList());
                        db.SubmitChanges();
                    }

                    //删除考试记录
                    db.StuExam.DeleteOnSubmit(stuExam);
                    db.SubmitChanges();
                }

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


    /// <summary>
    /// 获取最新发布的次考试
    /// </summary>
    /// <returns></returns>
    public TheExam GetLastTheExam()
    {
        try
        {
            return db.TheExam.OrderByDescending(t => t.TheExamId).First();
        }
        catch
        {
            return null;
        }
    }

    //判断当前次考试是否结束
    public bool TheExamIsEnd()
    {
        try
        {
            DateTime nowTiem = DateTime.Now;
            //获取最新的次考试
            TheExam theExam = GetLastTheExam();

            DateTime endTIme = DateTime.Parse(GetTheExamEndTime(theExam.TheExamId.ToString()));
            return nowTiem > endTIme;

        }
        catch (Exception e)
        {
            return true;
        }

    }

    //获取正在进行的一场考试中有的学生信息
    public List<MyStuExam> GetExamStuByExamId(ref int pageNumber, ref int totalPage, ref int count, string examId, string para)
    {
        try
        {
            List<MyStuExam> examStus = new List<MyStuExam>();
            //string sql = "select * from Student, StuExam, Invigilate where Student.StudentId = StuExam.StudentId" +
            //    " and StuExam.TId = Invigilate.TId and Invigilate.ExamId = {0} " +
            //    " and PaperId in (select paperId from Paper where ExamId = {0} )" +
            //    " and (studentName like '%" + para.Trim() + "%' or Class like '%" + para.Trim() + "%')" +
            //    " order by ExamRoomName, ReplyEndTime desc, Student.StudentId ";

            string sql = "  select Student.StudentId, StudentName, StudentPhone, Class, ExamRoomPosition, IPAddress, StuExamState, " +
  "StudentState, StuExam.PaperId, Invigilate.TId,  StuExam.Score,  StuExam.ReplyEndTime, StuExam.BeginExamTIme " +
  "from Student  " +
  " left join StuExam on  Student.StudentId = StuExam.StudentId  " +
  " and PaperId in (select paperId from Paper where ExamId = {0}) " +
  " left join Invigilate on  StuExam.TId = Invigilate.TId and Invigilate.ExamId ={0} " +
  "where StudentState = 2" +
  " order by ExamRoomPosition ,  ReplyEndTime desc, Student.StudentId  ";




            List<MyStuExam> query = db.ExecuteQuery<MyStuExam>(sql, new Object[] { examId, para })
                .Where(t => t.StudentId.Contains(para.Trim()) || t.StudentName.Contains(para.Trim()) || t.Class.Contains(para.Trim())).ToList();

            count = query.Count();

            if (count == 0)
                return null;

            totalPage = count % UnusualPageSize == 0 ? count / UnusualPageSize : count / UnusualPageSize + 1;

            int flag = 1;
            if (pageNumber < 1)
            {
                pageNumber = 1;
                flag = 0;
            }
            if (pageNumber > totalPage)
            {
                pageNumber = totalPage;
                flag = 0;
            }
            if (flag == 0)  //页码非法 重新获取数据
                GetExamStuByExamId(ref pageNumber, ref totalPage, ref count, examId, para);

            examStus = query.Skip((pageNumber - 1) * UnusualPageSize).Take(UnusualPageSize).ToList();

            //设置考试状态描述

            AddStuExamStateDesc(examStus, examId);
            return examStus;
        }
        catch (Exception e)
        {
            return null;
        }

    }

    //添加考生考试状态的描述
    public List<MyStuExam> AddStuExamStateDesc(List<MyStuExam> stuExams, string examId)
    {
        if (stuExams == null)
            return null;

        //设置考试状态描述
        foreach (var item in stuExams)
        {
            //判断有无本次考试的考试记录
            if (GetStuExamByExamId(item.StudentId, examId) == null)
            {
                item.ExamStateDes = EnumHelper.GetDescription(StuExamDesc.WaitCheck);
                continue;
            }

            if (item.Score == -1)  //作弊
            {
                item.ExamStateDes = EnumHelper.GetDescription(StuExamDesc.Cheat);
                continue;
            }

            if (item.ReplyEndTime != null)
            {
                item.ExamStateDes = EnumHelper.GetDescription(StuExamDesc.Submit);  //已交卷
            }
            else //待登记 正在考试  (0)      未开始  (1)   
            {
                if (item.BeginExamTIme != null)
                {
                    item.ExamStateDes = EnumHelper.GetDescription(StuExamDesc.NowExam); //正在考试
                    continue;
                }
                else
                {
                    if (item.StuExamState == (int)StudentBLL.StudentExamState.AdmitExam)
                        item.ExamStateDes = EnumHelper.GetDescription(StuExamDesc.WaitBegin); //未开始
                    else
                        item.ExamStateDes = EnumHelper.GetDescription(StuExamDesc.WaitCheck); //未登记
                }
            }
        }

        return stuExams;
    }

    //管理员获取正在进行的次考试中学生的考试相关信息
    public List<MyStuExam> AdminGetStuExamByTheExamId(ref int pageNumber, ref int totalPage, ref int count, string examId, string para)
    {
        try
        {
            string theExamId = db.Exam.First(t => t.ExamId == decimal.Parse(examId)).TheExamId.ToString();

            List<MyStuExam> examStus = new List<MyStuExam>();

            string sql = "select * from Student " +
    " left join StuExam on Student.StudentId = StuExam.StudentId   " +
    " left join  Invigilate on StuExam.TId  = Invigilate.TId and StuExam.PaperId  " +
    " in (select PaperId from Paper where ExamId = Invigilate.ExamId) " +
    " left join  Exam on StuExam.PaperId in (select PaperId from Paper where ExamId = Exam.ExamId) " +
    " where   PaperId in (select PaperId from Paper where ExamId  " +
    "	 in (select ExamId from Exam where TheExamId = {0}))  " +
    " order by ExamPeriod , ReplyEndTime  ";

            List<MyStuExam> query = db.ExecuteQuery<MyStuExam>(sql, new Object[] { theExamId })
                .Where(t => t.StudentId.Contains(para.Trim()) || t.StudentName.Contains(para.Trim()) || t.Class.Contains(para.Trim())).ToList();

            count = query.Count();

            if (count == 0)
                return null;

            totalPage = count % UnusualPageSize == 0 ? count / UnusualPageSize : count / UnusualPageSize + 1;

            int flag = 1;
            if (pageNumber < 1)
            {
                pageNumber = 1;
                flag = 0;
            }
            if (pageNumber > totalPage)
            {
                pageNumber = totalPage;
                flag = 0;
            }
            if (flag == 0)  //页码非法 重新获取数据
                AdminGetStuExamByTheExamId(ref pageNumber, ref totalPage, ref count, examId, para);

            //examStus = query.Skip((pageNumber - 1) * UnusualPageSize).Take(UnusualPageSize).ToList();

            //examStus = AddStuExamStateDesc(examStus, examId);
            examStus = AddStuExamStateDesc(query, examId);
            examStus = examStus.OrderBy(t => t.StuExamState).ToList();
            examStus = examStus.Skip((pageNumber - 1) * UnusualPageSize).Take(UnusualPageSize).ToList();

            return examStus;
        }
        catch (Exception e)
        {
            return null;
        }
    }

    public List<MyStuExam> ExamTeacherGetStuExamByTheExamId(string tId, ref int pageNumber, ref int totalPage, ref int count, string examId, string para)
    {
        try
        {
            string theExamId = db.Exam.First(t => t.ExamId == decimal.Parse(examId)).TheExamId.ToString();

            List<MyStuExam> examStus = new List<MyStuExam>();

            string sql = "		 select * from Student " +
                "left join StuExam on Student.StudentId = StuExam.StudentId  " +
                "left join  Invigilate on StuExam.TId  = Invigilate.TId and StuExam.PaperId  " +
                " in (select PaperId from Paper where ExamId = Invigilate.ExamId) " +
                " left join  Exam on StuExam.PaperId in (select PaperId from Paper where ExamId = Exam.ExamId) " +
                " where   PaperId in (select PaperId from Paper where ExamId " +
                "	 in (select ExamId from Exam where TheExamId = {0})) " +
                " and StuExam.TId = {1} and StuExam.PaperId in (select PaperId from Paper where ExamId = {2}) " +
                " order by ExamPeriod , ReplyEndTime ";

            List<MyStuExam> query = db.ExecuteQuery<MyStuExam>(sql, new Object[] { theExamId, tId, examId })
                .Where(t => t.StudentId.Contains(para.Trim()) || t.StudentName.Contains(para.Trim()) || t.Class.Contains(para.Trim())).ToList();

            count = query.Count();

            if (count == 0)
                return null;

            totalPage = count % UnusualPageSize == 0 ? count / UnusualPageSize : count / UnusualPageSize + 1;

            int flag = 1;
            if (pageNumber < 1)
            {
                pageNumber = 1;
                flag = 0;
            }
            if (pageNumber > totalPage)
            {
                pageNumber = totalPage;
                flag = 0;
            }
            if (flag == 0)  //页码非法 重新获取数据
                ExamTeacherGetStuExamByTheExamId(tId, ref pageNumber, ref totalPage, ref count, examId, para);


            examStus = AddStuExamStateDesc(query, examId).OrderBy(t => t.StuExamState).ToList();

            examStus = examStus.Skip((pageNumber - 1) * UnusualPageSize).Take(UnusualPageSize).ToList();

            // examStus = AddStuExamStateDesc(examStus, examId);

            return examStus;
        }
        catch (Exception e)
        {
            return null;
        }
    }

    //重置考生考试记录
    public int RestStuExam(string sId)
    {
        int res = 0;
        try
        {
            string theExamId = GetNowTheExam().TheExamId.ToString();

            string getStuExamSql = "select * from StuExam where StudentId = {0}" +
                " and PaperId in (select  PaperId from Paper where ExamId in (select ExamId from exam where theExamId = '" + theExamId + "')  )";

            StuExam stuExam = db.ExecuteQuery<StuExam>(getStuExamSql, new Object[] { sId }).First();


            stuExam.ReplyEndTime = null;
            stuExam.IPAddress = "";
            stuExam.Score = 0;
            db.SubmitChanges();
            res = 1;
        }
        catch (Exception e)
        {
            res = 0;
        }

        return res;
    }

    //考生作弊
    public int StuCheat(string sId, string examId)
    {
        int res = 0;
        try
        {
            string getStuExamSql = "select * from StuExam where StudentId = {0}" +
                " and PaperId in (select  PaperId from Paper where ExamId = {1})";

            StuExam stuExam = db.ExecuteQuery<StuExam>(getStuExamSql, new Object[] { sId, examId }).First();

            stuExam.Score = -1;
            db.SubmitChanges();
            res = 1;
        }
        catch (Exception e)
        {
            res = 0;
        }

        return res;
    }

    //删除某场考试的试卷
    public int DeletePaperByExamId(Exam exam)
    {
        int res = 0;
        using (TransactionScope scope = new TransactionScope())
        {
            try
            {
                List<Paper> papers = db.Paper.Where(t => t.ExamId == exam.ExamId).ToList();
                db.Paper.DeleteAllOnSubmit(papers);
                db.SubmitChanges();

                //修改其它场次的场次号
                List<Exam> otherExam = db.Exam.Where(t => t.TheExamId == exam.TheExamId).ToList();
                foreach (var item in otherExam)
                {
                    if (item.ExamPeriod > exam.ExamPeriod)
                    {
                        item.ExamPeriod = item.ExamPeriod - 1;
                    }
                    db.SubmitChanges();
                }
                Exam deleteExam = db.Exam.First(t => t.ExamId == exam.ExamId);
                db.Exam.DeleteOnSubmit(deleteExam);
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

    //获取当前的次考试
    public TheExam GetNowTheExam()
    {
        try
        {
            return db.TheExam.First(t => t.IsNowTheExam == 1);

        }
        catch
        {
            return null;
        }
    }

    //修改当前次考试
    public int ChangeNowTheExam(string theExamId)
    {
        int res = 0;
        using (TransactionScope scope = new TransactionScope())
        {
            try
            {
                TheExam oldNowTheExam = GetNowTheExam();
                if (oldNowTheExam != null)  //修改原来的当前次考试
                {
                    oldNowTheExam.IsNowTheExam = 0;
                    db.SubmitChanges();
                }


                TheExam newNowExam = db.TheExam.First(t => t.TheExamId == decimal.Parse(theExamId));
                newNowExam.IsNowTheExam = 1;
                db.SubmitChanges();

                scope.Complete();


                //同时修改当前场考试

                res = 1;
            }
            catch (Exception e)
            {
                res = 0;
            }

        }
        return res;
    }


    //分页获取某次考试中的试卷
    public Paper GetPaperByExamIdByPage(string examId, ref int pageNumber, ref int totalPage)
    {
        try
        {
            var query = db.Paper.Where(t => t.ExamId == decimal.Parse(examId));

            totalPage = query.Count();
            int flag = 1;
            if (pageNumber < 1)
            {
                flag = 0;
                pageNumber = 1;
            }
            if (pageNumber > totalPage)
            {
                flag = 0;
                pageNumber = totalPage;
            }
            if (flag == 0)
                GetPaperByExamIdByPage(examId, ref pageNumber, ref totalPage);

            Paper paper = query.Skip(pageNumber - 1).Take(1).First();
            return paper;
        }
        catch (Exception e)
        {
            string a = e.Message;
            return null;
        }
    }

    //获取一套试卷中的题目类别
    public List<Sort> GetPaperSorts(string papertId)
    {
        string sql = "		select * from sort where SortId in ( " +
            " select distinct Sort.SortId from  Topic, Sort, PaperDetail  " +
            " where  Topic.TopicId = PaperDetail.TopicId and Sort.SortId = Topic.SortId and PaperId = {0}   " +
            " )order by SortOrder";

        List<Sort> sorts = db.ExecuteQuery<Sort>(sql, new Object[] { papertId }).ToList();
        if (sorts.Count > 0)
            return sorts;
        else
            return null;
    }

    //获取一套试卷中某种类别的题目
    public List<Topic> GetTopicByPaperIdBySortId(string paperId, string sortId)
    {
        //string sql = " select * from Paper, PaperDetail, Topic, Sort, FirstPoint, SecondPoint, TopicSource  "+
        //    " where FirstPoint.FirstPointId = SecondPoint.FIrstPointId and SecondPoint.SecondPointId = Topic.SecondPointId  "+
        //    " and Topic.TopicSourceId = TopicSource.TopicSourceId and Topic.SortId = Sort.SortId and Paper.PaperId = PaperDetail.PaperId  "+
        //    " and  PaperDetail.TopicId = Topic.TopicId   and Paper.PaperId = {0} and Sort.SortId = {1} ";

        string sql = "select * from Topic " +
            "where Topic.TopicId in (select TopicId from PaperDetail where PaperId = {0} ) and SortId = {1}";

        List<Topic> topics = db.ExecuteQuery<Topic>(sql, new Object[] { paperId, sortId }).ToList();

        if (topics.Count() > 0)
            return topics;
        else
            return null;

    }

    //根据次考试id获取名称
    public TheExam GetThExamInfoByTheId(string theExamId)
    {
        var query = db.TheExam.Where(t => t.TheExamId == decimal.Parse(theExamId));

        TheExam theExam = null;
        if (query.Count() > 0)
            theExam = query.First();

        return theExam;
    }

    //获取学生成绩
    public string GetStuScore(string sId, string examId)
    {
        string sql = "select  * from StuExam where StudentId = {0} " +
            "and PaperId in (select PaperId from Paper where ExamId = {1})";

        List<StuExam> stuExam = db.ExecuteQuery<StuExam>(sql, new Object[] { sId, examId }).ToList();
        if (stuExam.Count() >= 1)
            return stuExam.First().Score.ToString();
        else
            return "无成绩";
    }

    //获取当前考试类型
    public int GetChoseExamType()
    {
        return int.Parse(db.ExamType.Where(t => t.IsChose == 1).First().ExamTypeFlag.ToString());
    }


    //获取一场考试中的实践题目
    public List<PracticalTopic> GetPracTopicByExamId(ref int pageNumber, ref int totalPage, ref int totalCount, string examId)
    {
        string getTopic = "select * from PracticalTopic where tId in " +
           "(select topicId from paperDetail where paperid in (select paperId from paper where examid = {0})) order by topicUpTime desc";
        List<PracticalTopic> topics = db.ExecuteQuery<PracticalTopic>(getTopic, new Object[] { examId }).ToList();

        int counts = topics.Count();

        if (counts == 0)
        {
            totalPage = 0;
            pageNumber = 0;

        }
        else
        {
            totalPage = counts % TopicPageSize == 0 ? counts / TopicPageSize : counts / TopicPageSize + 1;

            topics = (List<PracticalTopic>)topics.Skip((pageNumber - 1) * TopicPageSize).Take(TopicPageSize).ToList();

        }
        totalCount = counts; //题目总数
        return topics;

    }


    //获取考生提交的文档
    public string GetStuPracAnsById(string sId, string theExamId)
    {
        try
        {
            string sql = "select * from stuPaper where studentId = {0} and examId in (select examId from exam where TheExamId = {1})";
            DataClassesDataContext db = new DataClassesDataContext();
            return db.ExecuteQuery<StuPaper>(sql, new Object[] { sId, theExamId }).First().stuAnsPath;
        }
        catch
        {
            return "";
        }

    }


   
}