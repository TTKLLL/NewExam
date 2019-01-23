using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// EnumHelper 的摘要说明
/// </summary>
/// <summary>
/// 自定义属性
/// </summary>
[AttributeUsage(AttributeTargets.Field, AllowMultiple = false)]
public sealed class EnumDescriptionAttribute : Attribute
{
    private string description;
    public string Description { get { return description; } }

    public EnumDescriptionAttribute(string description)
        : base()
    {
        this.description = description;
    }
}

/// <summary>
/// 获取枚举字符串
/// </summary>
public class EnumHelper
{
    public static  string GetDescription(Enum value)
    {
        if (value == null)
        {
            throw new ArgumentException("value");
        }
        string description = value.ToString();
        var fieldInfo = value.GetType().GetField(description);
        var attributes =
            (EnumDescriptionAttribute[])fieldInfo.GetCustomAttributes(typeof(EnumDescriptionAttribute), false);
        if (attributes != null && attributes.Length > 0)
        {
            description = attributes[0].Description;
        }
        return description;
    }
}