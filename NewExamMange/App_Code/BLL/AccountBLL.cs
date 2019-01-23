using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Account 的摘要说明
/// </summary>
public class AccountBLL
{

    DataClassesDataContext db = new DataClassesDataContext();
    //根据教师用户Id获取用户信息
    public Teacher GetTeacherById(string tId)
    {
        try
        {
            return db.Teacher.First(t => t.TId == tId);
        }
        catch (Exception e)
        {
            return null;
        }
    }
}