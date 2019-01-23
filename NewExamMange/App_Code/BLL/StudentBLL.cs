using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// 考生
/// </summary>
public class StudentBLL
{
    DataClassesDataContext db = new DataClassesDataContext();
    public static int StudentPageSize = 50;  //考生列表分页大小

    public enum StudentState  //考生审核状态
    {
        WaitAudit = 1,  //待审核
        PassAudit = 2,  //通过审核
        FailAudit = 0   //未通过审核
    }

    public enum StudentExamState   //考生考试状态
    {

        AdmitExam = 1, //允许开始考试
        OnExam = 2,      //正在考试
        Default = 0     //完成考试或不能开始考试
    }


    //根据考生审核状态分页获取考生信息

    //分页获取所有考生信息
    public List<Student> GetStudentByPage(ref int pageNumber, ref int totalPage, ref int count, int state, string para)
    {

        var query = db.Student.Where(t => t.StudentName.Contains(para) ||
                t.Class.Contains(para)).Where(t => t.StudentState == state).OrderBy(t => t.Class).ThenBy(t =>  t.StudentId );
        count = query.Count();


        if (query.Count() == 0)
        {
            return null;
        }

        totalPage = query.Count() % StudentPageSize == 0 ? query.Count() / StudentPageSize :
            query.Count() / StudentPageSize + 1;

        //页码不合法
        if (pageNumber < 1)
        {
            pageNumber = 1;
            GetStudentByPage(ref pageNumber, ref totalPage, ref count, state, para);
        }
        if (pageNumber > totalPage)
        {
            pageNumber = totalPage;
            GetStudentByPage(ref pageNumber, ref totalPage,ref count, state, para);
        }
        if (totalPage == 0)  //查询无结果
        {
            return query.ToList();
        }
        else

            return query.Skip((pageNumber - 1) * StudentPageSize).Take(StudentPageSize).ToList();
    }

    //根据学号获取考生信息
    public Student GetStuBySid(string sId)
    {
        try
        {
            return db.Student.Where(t => t.StudentId == sId).First();
        }
        catch (Exception ex)
        {
            return null;
        }
    }

    //修改考生信息
    public int UpdateStu(Student stu)
    {
        try
        {
            Student theStu = db.Student.Where(t => t.StudentId == stu.StudentId).First();
            theStu.StudentName = stu.StudentName;
            theStu.StudentPhone = stu.StudentPhone;
            theStu.Class = stu.Class;

            db.SubmitChanges();
            return 1;
        }
        catch (Exception ex)
        {
            return 0;
        }
    }

    //修改考试状态
    public int UpdateStuExamState(Student stu)
    {
        try
        {
            Student theStu = db.Student.Where(t => t.StudentId == stu.StudentId).First();


            theStu.StudentState = stu.StudentState;

            db.SubmitChanges();
            return 1;
        }
        catch (Exception ex)
        {
            return 0;
        }
    }


    //修改考生审核状态
    public int UpdateStuState(Student stu)
    {
        try
        {
            Student theStu = db.Student.Where(t => t.StudentId == stu.StudentId).First();


            theStu.StudentState = stu.StudentState;

            db.SubmitChanges();
            return 1;
        }
        catch (Exception ex)
        {
            return 0;
        }
    }

    //监考老师添加学生


    //添加考生
    public int AddStudent(Student stu)
    {
        //去除空格
        stu.StudentName = stu.StudentName.Trim();
        stu.Class = stu.Class.Trim();
        stu.StudentId = stu.StudentId.Trim();

        try
        {
            stu.StudentState = (int)StudentBLL.StudentState.WaitAudit;   //考生状态
            if (IsHaveTheStu(stu) > 0)  //更新
                UpdateStu(stu);
            else
            {
                stu.StudentState = (int)StudentState.WaitAudit;
                stu.StuExamState = (int)StudentExamState.Default;  //考试资格
                stu.RegisterTime = DateTime.Now.ToLocalTime();  //导入时间
                db.Student.InsertOnSubmit(stu);
                db.SubmitChanges();
            }

            return 1;
        }
        catch (Exception ex)
        {
            return 0;

        }
    }

    //监考老师添加的学生不需要审核
    public int InvTeacherAddStudent(Student stu)
    {
        //去除空格
        stu.StudentName = stu.StudentName.Trim();
        stu.Class = stu.Class.Trim();
        stu.StudentId = stu.StudentId.Trim();

        try
        {
            stu.StudentState = (int)StudentBLL.StudentState.PassAudit;   //考生状态
            if (IsHaveTheStu(stu) > 0)  //更新
                UpdateStu(stu);
            else
            {
                stu.StudentState = (int)StudentState.PassAudit;
                stu.StuExamState = (int)StudentExamState.Default;  //考试资格
                stu.RegisterTime = DateTime.Now.ToLocalTime();  //导入时间
                db.Student.InsertOnSubmit(stu);
                db.SubmitChanges();
            }

            return 1;
        }
        catch (Exception ex)
        {
            return 0;

        }
    }

    //判断该考生是否已存在
    public int IsHaveTheStu(Student stu)
    {
        return db.Student.Count(t => t.StudentId == stu.StudentId);
    }

    //获取所有班级信息
    public List<string> GetAllClass()
    {
        return db.Student.OrderByDescending(t => t.RegisterTime).Select(t => t.Class).Distinct().ToList();
    }

    public List<Student> GetAllStudentByQuery(string para, int state)
    {
        var query = db.Student.Where(t => (t.StudentName.Contains(para) ||
                t.Class.Contains(para)) && t.StudentState == state).OrderByDescending(t => t.RegisterTime);

        return query.ToList();
    }

    //判断考生是否已存在
    public bool IsHaveThStu(string sId)
    {
        return db.Student.Count(t => t.StudentId == sId) > 0;
    }

    // 获取能参加考试的考生信息
    //public List<Student> GetExamStu(string examId, int examState,  string para)
    //{
    //    //List<Student>
    //}

    //判断某个考生在某次考试中是否已交卷
    //public bool StuIsHaveSubmitPaper(string sId, string, examId)
    //{

    //}

    //删除考生信息
    public int DeleteStu(string sId)
    {
        int res = 0;
        try
        {
            if (db.StuExam.Count(t => t.StudentId == sId) > 0)
            { // 该考生有考试记录
                res = -1;
                return res;
            }

            Student stu = db.Student.First(t => t.StudentId == sId);
            db.Student.DeleteOnSubmit(stu);
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
}

