using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

/// <summary>
///管理知识点
/// </summary>
/// 


public class PointService
{

    DataClassesDataContext db = new DataClassesDataContext();
    public static int AllPointsSize = 15; //所有知识点页面大小


    //获取一级知识点
    public List<FirstPoint> GetFirstPointByPage(int pageNumber)
    {
        List<FirstPoint> FirstPoints = new List<FirstPoint>();


        FirstPoints = db.FirstPoint.OrderBy(t => t.FirstPointOrder)
           .ToList();
        return FirstPoints;
    }

    public List<FirstPoint> GetFirstPoint()
    {
        List<FirstPoint> FirstPoints = new List<FirstPoint>();


        FirstPoints = db.FirstPoint.OrderBy(t => t.FirstPointOrder)
           .ToList();
        return FirstPoints;
    }

    //判断某个一级知识点是否存在二级知识点
    public bool HasSecond(int FirstId)
    {
        bool res = false;
        int count = db.SecondPoint.Count(t => t.FIrstPointId == FirstId);
        if (count > 0)
            res = true;

        return res;
    }

    //删除一级知识点
    public int DeleteFirst(int id)
    {
        SqlParameter[] spa = { new SqlParameter("@id", id) };

        int res = db.ExecuteCommand("delete from FirstPoint where FirstPointId =" + id);
        return res;
    }

    //根据一级知识点Id获取知识点信息
    public FirstPoint GetFirstPoint(int id)
    {
        return db.FirstPoint.Where(t => t.FirstPointId == id).First();
    }

    public FirstPoint GetFirstPoint(string name)
    {
        var query = db.FirstPoint.Where(t => t.FirstPointName == name);
        int a = query.Count();
        return query.First();
    }

    //保存一级知识点
    public int SaveFirstPoint(FirstPoint point)
    {
        var count = db.FirstPoint.Count(t => t.FirstPointId == point.FirstPointId);
        int res = 0;
        //该知识点已存在
        if (count == 1)
        {
            string updateSql = "update FirstPoint set FirstPointName={0}, FirstPointOrder={1} where FirstPointId={2}";
            res = db.ExecuteCommand(updateSql, new Object[] { point.FirstPointName, point.FirstPointOrder, point.FirstPointId });

        }
        else //插入
        {
            string insertSql = "insert into FirstPoint values({0}, {1})";
            res = db.ExecuteCommand(insertSql, new Object[] { point.FirstPointName, point.FirstPointOrder });
        }
        return res;
    }

    //获取二级知识点
    public List<SecondPoint> GetSecondPoints(int firstId)
    {
        var res = db.SecondPoint.Where(t => t.FIrstPointId == firstId).OrderBy(t => t.SecondPointOrder).ToList();
        return res;
    }

    //获取考试用的二级知识点
    public List<secondPont> GetSecondPoint_Plus(int firstId)
    {
        var res = db.SecondPoint.Where(t => t.FIrstPointId == firstId).OrderBy(t => t.SecondPointOrder).ToList();
        List<secondPont> secondPoints = new List<secondPont>();

        foreach(var item in res)
        {
            //该二级知识点的可用数量
            int count = db.Topic.Count(t => t.SecondPointId == item.SecondPointId);

            secondPont point = new secondPont()
            {
                FIrstPointId = item.FIrstPointId,
                SecondPointId = item.SecondPointId,
                SecondPointName = item.SecondPointName,
                IsChose = item.IsChose,
                SecondPointOrder = item.SecondPointOrder,
                choseNumber = item.choseNumber,
                canChoseNumber = count
            };
            secondPoints.Add(point);
        }

        return secondPoints;
    }

    //保存二级知识点
    public int SaveSecondPoint(SecondPoint point)
    {
        var count = db.SecondPoint.Count(t => t.SecondPointId == point.SecondPointId);
        int res = 0;
        //该知识点已存在
        if (count == 1)
        {
            string updateSql = "update SecondPoint set FIrstPointId = {0}, SecondPointName={1}, " +
                "SecondPointOrder={2} where SecondPointId={3}";
            res = db.ExecuteCommand(updateSql, new Object[] { point.FIrstPointId, 
                point.SecondPointName, point.SecondPointOrder, point.SecondPointId });
        }
        else //插入
        {
            string insertSql = "insert into SecondPoint values({0}, {1},{2}, 0)";
            res = db.ExecuteCommand(insertSql, new Object[] { point.FIrstPointId, point.SecondPointName, point.SecondPointOrder });
        }
        return res;
    }

    //判断二级知识点是否有题目
    public bool SecondPointHasTopic(int secondId)
    {
        bool res = false;
        int count = db.Topic.Count(t => t.SecondPointId == secondId);
        if (count > 0)
            res = true;

        return res;
    }

    //删除二级知识点
    public int DeleteSecond(int secondId)
    {
        int res = 1;
        try
        {
            SecondPoint point = db.SecondPoint.Where(t => t.SecondPointId == secondId).First();
            db.SecondPoint.DeleteOnSubmit(point);
            db.SubmitChanges();

        }
        catch (Exception e)
        {
            res = 0;
        }
        return res;
    }

    //获取二级知识点by id
    public SecondPoint GetSecondPointById(int id)
    {
        return db.SecondPoint.Where(t => t.SecondPointId == id).First();
    }

    //分页获取所有知识点信息
    public List<Point> GetAllPoints(ref int pageNumber, ref long totalPage)
    {
        var query = (from p in db.FirstPoint
                     join d in db.SecondPoint on p.FirstPointId equals d.FIrstPointId
                     orderby p.FirstPointOrder, d.SecondPointOrder
                     select new Point
                     {
                         FirstPointName = p.FirstPointName,
                         FirstPointOrder = int.Parse(p.FirstPointOrder.ToString()),
                         SecondPointName = d.SecondPointName,
                         SecondPointOrder = int.Parse(d.SecondPointOrder.ToString())
                     });


        totalPage = query.Count() % AllPointsSize == 0 ? query.Count() / AllPointsSize : query.Count() / AllPointsSize + 1;
        if (pageNumber < 1)
            pageNumber = 1;
        if (pageNumber > totalPage)
            pageNumber = int.Parse(totalPage.ToString());


        List<Point> allPoints = query.Skip(AllPointsSize * (pageNumber - 1)).Take(AllPointsSize).ToList();
        return allPoints;
    }


    //获取所有知识点
    public List<Point> GetPoints()
    {
        return (from p in db.FirstPoint
                join d in db.SecondPoint on p.FirstPointId equals d.FIrstPointId
                select new Point
                {
                    FirstPointName = p.FirstPointName,
                    FirstPointOrder = int.Parse(p.FirstPointOrder.ToString()),
                    SecondPointName = d.SecondPointName,
                    SecondPointOrder = int.Parse(d.SecondPointOrder.ToString())
                }).ToList();
    }

    //判断该一级知识点是否存在
    public int IsHasFist(string firstPointName)
    {
        return db.FirstPoint.Count(t => t.FirstPointName == firstPointName);
    }

    //判断该二级知识点是否存在
    public int IsHasSecond(string secondPointName)
    {
        return db.SecondPoint.Count(t => t.SecondPointName == secondPointName);
    }

    //获取一级知识点最大排序号
    public int MaxFirstOrder()
    {
        if (db.FirstPoint.Count() == 0)
            return 1;
        else
        {
            int? order = db.FirstPoint.OrderByDescending(t => t.FirstPointOrder).First().FirstPointOrder;
            return int.Parse(order.ToString()) + 1;
        }

    }


    //获取二级知识点最大排序号
    public int MaxSecondOrder(string firstPointName)
    {
        string firstPointId = GetFirstPoint(firstPointName).FirstPointId.ToString();
        if (db.SecondPoint.Count(t => t.FIrstPointId.ToString() == firstPointName) == 0)
        {
            return 1;
        }
        else
        {
            int? order = db.SecondPoint.OrderByDescending(t => t.SecondPointOrder).First().SecondPointOrder;
            return int.Parse(order.ToString()) + 1;
        }
    }

    //添加知识点
    public int AddPoint(Point point)
    {
        int a = 0, b = 0;
        if (IsHasFist(point.FirstPointName) == 0)
        {
            FirstPoint firstPoint = new FirstPoint()
            {
                FirstPointName = point.FirstPointName,
                FirstPointOrder = MaxFirstOrder()
            };
            db.FirstPoint.InsertOnSubmit(firstPoint);
            db.SubmitChanges();
            if (firstPoint.FirstPointId > 0)
                a = 1;

        }

        if (IsHasSecond(point.SecondPointName) == 0)
        {
            decimal firstPointId = GetFirstPoint(point.FirstPointName).FirstPointId;
            SecondPoint secondPoint = new SecondPoint()
            {
                FIrstPointId = firstPointId,
                SecondPointName = point.SecondPointName,
                SecondPointOrder = MaxSecondOrder(point.FirstPointName)
            };
            db.SecondPoint.InsertOnSubmit(secondPoint);
            db.SubmitChanges();
            if (secondPoint.SecondPointId > 0)
            {
                b = 1;
            }

        }
        if (a == 1 && b == 1)
            return 1;
        else
            return 0;
    }

    //获取二级知识点id
    public int GetSeccondIdByName(string name)
    {
        decimal? id = db.SecondPoint.Where(t => t.SecondPointName == name).First().SecondPointId;
        return int.Parse(id.ToString());
    }

    //判断一级知识点是存在
    public bool isHaveFist(string firstName)
    {

        return db.FirstPoint.Count(t => t.FirstPointName == firstName) > 0;
    }

    //判断二级知识点是存在
    public bool isHaveSecond(int firstId, string secondName)
    {
        var query = from p in db.FirstPoint
                    join q in db.SecondPoint on p.FirstPointId equals q.FIrstPointId
                    where q.SecondPointName == secondName && p.FirstPointId == decimal.Parse(firstId.ToString())
                    select p;
        return query.ToList().Count() > 0;
    }

    //根据二级知识点修改二级知识点选中状态
    public int ChageSecondChoseBySecond(int secondId, int chose)
    {
        int res = 0;
        try
        {
            SecondPoint second = db.SecondPoint.First(t => t.SecondPointId == secondId);
            second.IsChose = chose;
            db.SubmitChanges();
            res = 1;
            if (chose == 0)
            {
                new TopicBLL().JudgeSorceTopicNumberValid();
            }

        }
        catch
        {
            res = 0;
        }
        return res;
    }

    //根据一级知识点修改二级知识点选中状态
    public int ChageSecondChoseByFirst(int firstId, int chose)
    {
        int res = 0;
        //var trans = db.Connection.BeginTransaction();
        // db.Transaction = trans;
        try
        {
            List<SecondPoint> seconds = db.SecondPoint.Where(t => t.FIrstPointId == firstId).ToList();
            foreach (var item in seconds)
            {
                SecondPoint secondPoint = db.SecondPoint.First(t => t.SecondPointId == item.SecondPointId);
                secondPoint.IsChose = chose;
                db.SubmitChanges();

            }
            db.SubmitChanges();
            res = 1;

            if (chose == 0)  //取消该知识点 即可用题目数量减少
            {
                new TopicBLL().JudgeSorceTopicNumberValid();
            }
        }
        catch
        {
            // trans.Rollback();
            res = 0;
        }
        return res;
    }

    //判断一级知识点下的二级知识点是否为全选
    public int SecondHaveAllChose(int firstId)
    {

        int secondCount = db.SecondPoint.Count(t => t.FIrstPointId == firstId);
        int choseCount = db.SecondPoint.Count(t => t.FIrstPointId == firstId && t.IsChose == 1);

        int res = 0;
        if (secondCount == choseCount)
            res = 1;
        return res;

    }
}



