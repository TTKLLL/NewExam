using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


/// <summary>
/// 用户权限
/// </summary>
public class AuthorityBLL
{
   public static DataClassesDataContext db = new DataClassesDataContext();

    public enum AuthorityType
    {
        Common = 1, //通用权限
        Admin = 1,  //管理员权限
        ExamTeacher = 2  //监考老师权限
    }

    public enum AuthorityExamType
    {
        Common = 0,  //通用权限
        Basic = 1,   //基础考试权限
        Practical = 2  //实践考试权限
    }

    //根据用户类别获取权限
    public List<Authority> GetAuthorityByUserType(int userType)
    {
        return db.Authority.Where(t => t.AuthorityType == userType).ToList();
    }

    //根据用户Id获取权限
    public List<Authority> GetAuthorityByUserId(string tId)
    {
        List<Authority> authority = (from p in db.Authority
                                     join d in db.TeaAuthority on p.AuthorityId equals d.AuthorityId
                                     where d.TId == tId
                                     select p).OrderBy(t => t.OrderNo).ToList();
        return authority;

    }

    public bool TeacherIsOnWord(string tId)
    {
        return db.Teacher.First(t => t.TId == tId).TeacherState == (int)TeacherBLL.TeacherState.OnWork;
    }

    //判断该用户是否有多种身份
    public int TwoUser(string tId)
    {
        int res = 0;
        Teacher teacher = db.Teacher.First(t => t.TId == tId);
        if (teacher.IsAdmin == (int)TeacherBLL.IsAdmin.Admin)  //判断是否为管理员
            res++;

        if (teacher.isExamTeacher == (int)TeacherBLL.IsExamTeacher.Yes)  //判断是否为监考老师
            res++;

        return res;
    }

    //根据教师要进入的模块获取权限
    public List<Authority> GetTeacherAu(string tId, int auType)
    {
        List<Authority> au = new List<Authority>();


        au = (from p in db.Authority
              join q in db.TeaAuthority on p.AuthorityId equals q.AuthorityId
              where q.TId == tId && ( p.AuthorityType == auType)
              select p).OrderBy(t => t.OrderNo).ToList();

        return au;
    }

    //根据当前的考试类别获取相关的权限
    public List<Authority> GetTeacherAu(string tId, int auType, int examType)
    {
        List<Authority> au = new List<Authority>();


        au = (from p in db.Authority
              join q in db.TeaAuthority on p.AuthorityId equals q.AuthorityId
              where q.TId == tId && (p.AuthorityType == auType) && ( p.AuthorityExamType == examType || p.AuthorityExamType == (int)AuthorityExamType.Common)
              select p).OrderBy(t => t.OrderNo).ToList();

        return au;
    }

}