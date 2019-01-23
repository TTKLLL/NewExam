using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// TeacherBLL 的摘要说明
/// </summary>
public class TeacherBLL
{
    DataClassesDataContext db = new DataClassesDataContext();
    AuthorityBLL authorityBll = new AuthorityBLL();

    public enum TeacherState   //教师在岗状态
    {
        OnWork = 1,  //在岗
        OffWork = 0  // 离岗
    }

    public enum IsAdmin  //教师职责
    {
        Admin = 1,  //管理员
        ExamTeacher = 2 //监考老师
    }

    public enum IsExamTeacher  //管理员是否为监考老师
    {
        Yes = 1, //是监考老师
        No = 0   //不是监考老师
    }

    public enum TeacherWork
    {
        Admin = 1,
        Teacher = 2
    }


    //获取教师信息
    public Teacher GetTeacherInfoById(string tId)
    {
        return db.Teacher.Where(t => t.TId == tId).First();
    }

    //修改教师在岗状态
    public int ChangeTeacherState(string tId)
    {
        try
        {
            Teacher teacher = GetTeacherInfoById(tId);
            if (teacher.TeacherState == 0)
                teacher.TeacherState = 1;
            else
                teacher.TeacherState = 0;

            db.SubmitChanges();
            return 1;
        }
        catch (Exception e)
        {
            return 0;
        }

    }

    //添加老师
    public int AddTeacher(Teacher teacher)
    {
        //  List<TeaAuthority> teaAuthority = new List<TeaAuthority>();
        try
        {
            teacher.TeacherState = 1;//在岗状态
            teacher.TeacherCreateDate = DateTime.Now.ToLocalTime();

            List<Authority> authority = authorityBll.GetAuthorityByUserType
            (int.Parse(teacher.IsAdmin.ToString()));

            //foreach (var item in authority)
            //{
            //    TeaAuthority teaAuthority = new TeaAuthority()
            //    {
            //        TId = teacher.TId,
            //        AuthorityId = item.AuthorityId
            //    };
            //    db.TeaAuthority.InsertOnSubmit(teaAuthority);
            //}


            db.Teacher.InsertOnSubmit(teacher);
            db.SubmitChanges();

            return 1;
        }
        catch (Exception e)
        {
            return -1;
        }

    }

    //判断教师时候有监考记录
    public bool TeacherIsInvigilate(string tId)
    {
        return db.Invigilate.Count(t => t.TId == tId) > 0;
    }

    ///删除教师
    public int DeleteTeacher(Teacher teacher)
    {
        try
        {
            List<Authority> authority = authorityBll.GetAuthorityByUserId(teacher.TId);
            foreach (var item in authority)
            {
                TeaAuthority teaAu = db.TeaAuthority.Where(t => t.TId == teacher.TId &&
                    t.AuthorityId == item.AuthorityId).First();
                db.TeaAuthority.DeleteOnSubmit(teaAu);
            }
            Teacher deleteTeacher = db.Teacher.Where(t => t.TId == teacher.TId).First();

            db.Teacher.DeleteOnSubmit(deleteTeacher);
            db.SubmitChanges();
            return 1;
        }
        catch (Exception ex)
        {
            return 0;
        }

    }


    //修改管理员是否为监考老师
    public int ChangeAdminExamTeacher(string tId)
    {
        int res = 0;
        try
        {
            Teacher teacher = db.Teacher.First(t => t.TId == tId);

            if (teacher.isExamTeacher == (int)IsExamTeacher.Yes)//取消该教师的监考老师资格
            {
                teacher.isExamTeacher = (int)IsExamTeacher.No;
                db.SubmitChanges();

                List<Authority> deleteAuthority = (from p in db.Authority
                                                   join q in db.TeaAuthority on p.AuthorityId equals q.AuthorityId
                                                   where q.TId == tId && p.AuthorityType == (int)AuthorityBLL.AuthorityType.ExamTeacher
                                                   select p).ToList();

                //从权限信息中删除监考老师权限
                foreach (var item in deleteAuthority)
                {
                    TeaAuthority teaAu = db.TeaAuthority.First(t => t.TId == tId && t.AuthorityId == item.AuthorityId);
                    db.TeaAuthority.DeleteOnSubmit(teaAu);
                    db.SubmitChanges();
                }
            }
            else  //设置管理员为该监考老师
            {
                teacher.isExamTeacher = (int)IsExamTeacher.Yes;

                //获取监考老师权限
                List<Authority> examTeacherAu = db.Authority.Where(t => t.AuthorityType == (int)AuthorityBLL.AuthorityType.ExamTeacher).ToList();

                //插入该管理员的权限信息中
                foreach (var item in examTeacherAu)
                {
                    TeaAuthority teaAu = new TeaAuthority()
                    {
                        AuthorityId = item.AuthorityId,
                        TId = tId
                    };

                    db.TeaAuthority.InsertOnSubmit(teaAu);
                    db.SubmitChanges();
                }

            }
            res = 1;

        }
        catch (Exception ex)
        {
            res = 0;
        }


        return res;
    }

    // 设置教师为管理员
    public int SetAdmin(string tId)
    {
        int res = 0;
        try
        {
            Teacher teacher = db.Teacher.First(t => t.TId == tId);
            if (teacher.IsAdmin == 0)
                teacher.IsAdmin = 1;
            else
                teacher.IsAdmin = 0;
            db.SubmitChanges();

            res = 1;
        }
        catch (Exception ex)
        {
            res = 0;
        }
        return res;
    }

    //当教师只有一种角色时 获取该角色
    public int GetTeacherRole(string tId)
    {
       try
       {
           Teacher teacher = db.Teacher.First(t => t.TId == tId);
           if (teacher.IsAdmin == 1)
               return (int)TeacherBLL.TeacherWork.Admin;
           if (teacher.isExamTeacher == 1)
               return (int)TeacherBLL.TeacherWork.Teacher;
       }
        catch(Exception e)
       {
           return 0;
       }
       return 0;
    }

}
