using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization.Json;
using System.IO;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;

using System.Reflection;
using System.Text.RegularExpressions;

/// <summary>
/// Public 的摘要说明
/// </summary>
public class Public
{
    public static List<T> getObjectByJson<T>(string jsonString)
    {
        // 实例化DataContractJsonSerializer对象，需要待序列化的对象类型  
        DataContractJsonSerializer serializer = new DataContractJsonSerializer(typeof(List<T>));
        //把Json传入内存流中保存  
        jsonString = "[" + jsonString + "]";
        MemoryStream stream = new MemoryStream(Encoding.UTF8.GetBytes(jsonString));
        // 使用ReadObject方法反序列化成对象  
        object ob = serializer.ReadObject(stream);
        List<T> ls = (List<T>)ob;
        return ls;
    }

    public static string ObjectToJson<T>(string jsonName, IList<T> IL, int pageNumber, int totalPage, int pageSize, int totalCount)
    {
        StringBuilder Json = new StringBuilder();
        Json.Append("{\"" + jsonName + "\":[");
        if (IL.Count > 0)
        {
            for (int i = 0; i < IL.Count; i++)
            {
                T obj = Activator.CreateInstance<T>();
                Type type = obj.GetType();
                PropertyInfo[] pis = type.GetProperties();
                Json.Append("{");
                for (int j = 0; j < pis.Length; j++)
                {
                    Json.Append("\"" + pis[j].Name.ToString() + "\":\"" + pis[j].GetValue(IL[i], null) + "\"");
                    if (j < pis.Length - 1)
                    {
                        Json.Append(",");
                    }
                }
                Json.Append("}");
                if (i < IL.Count - 1)
                {
                    Json.Append(",");
                }
            }
        }

        //Json.Append("]}");
        Json.Append("]");
        Json.Append(",\"" + "pageNumber" + "\":\"" + "" + pageNumber + "\"");

        Json.Append(",\"" + "totalPage" + "\":\"" + "" + totalPage + "\"");
        Json.Append(",\"" + "pageSize" + "\":\"" + "" + pageSize + "\"");
        Json.Append(",\"" + "totalCount" + "\":\"" + "" + totalCount + "\"");

        Json.Append("}");


        return Json.ToString();
    }

    public static string ObjectToJson<T>(string jsonName, IList<T> IL)
    {
        StringBuilder Json = new StringBuilder();
        Json.Append("{\"" + jsonName + "\":[");
        if (IL.Count > 0)
        {
            for (int i = 0; i < IL.Count; i++)
            {
                T obj = Activator.CreateInstance<T>();
                Type type = obj.GetType();
                PropertyInfo[] pis = type.GetProperties();
                Json.Append("{");
                for (int j = 0; j < pis.Length; j++)
                {
                    Json.Append("\"" + pis[j].Name.ToString() + "\":\"" + pis[j].GetValue(IL[i], null) + "\"");
                    if (j < pis.Length - 1)
                    {
                        Json.Append(",");
                    }
                }
                Json.Append("}");
                if (i < IL.Count - 1)
                {
                    Json.Append(",");
                }
            }
        }

        Json.Append("]}");



        return Json.ToString();
    }

    public static bool isNumberic(string message)
    {
        //判断是否为整数字符串
        //是的话则将其转换为数字并将其设为out类型的输出值、返回true, 否则为false
        //result = -1;   //result 定义为out 用来输出值
        try
        {
            //当数字字符串的为是少于4时，以下三种都可以转换，任选一种
            //如果位数超过4的话，请选用Convert.ToInt32() 和int.Parse()
            int res = int.Parse(message);
            //result = Convert.ToInt16(message);
            //result = Convert.ToInt32(message);
            return true;
        }
        catch
        {
            return false;
        }

    }

    //对特殊字符进行转义
    public static string Convert(string theString)
    {
        //theString = theString.Replace(">", "&gt;");
        //theString = theString.Replace("<", "&lt;");
        //theString = theString.Replace(" ", "&nbsp;");
     
        theString = theString.Replace("\"", "");
        theString = theString.Replace("\'", "&#39;");
        theString = theString.Replace("\\", "\\\\");//对斜线的转义
        theString = theString.Replace("\n", "\\n");
        theString = theString.Replace("\r", "\\r");

        theString = theString.Replace("“", "[");
        theString = theString.Replace("”", "]");
        return theString;

    }
}
