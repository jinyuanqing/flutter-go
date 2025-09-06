// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package do

import (
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
)

// WenZhang is the golang structure of table wen_zhang for DAO operations like Where/Data.
type WenZhang struct {
	g.Meta     `orm:"table:wen_zhang, do:true"`
	Id         interface{} //
	Biaoti     interface{} // 汉字长度25.标题
	Zuozhe     interface{} // 汉字长度25.作者
	Zhaiyao    interface{} // 汉字长度50.摘要
	Suoluetu   interface{} // 为字符串,长度30.缩略图
	Neirong    interface{} // 汉字长度65535/2.内容
	Yuedushu   interface{} // 阅读数
	Dianzanshu interface{} // 点赞数
	Fenleiid   interface{} // 分类id
	Zhiding    interface{} // 置顶0/1.字符的1和0
	Jinghua    interface{} // 精华0/1.字符的1和0
	Shanchu    interface{} // 是否删除.1和0,mysql的bool类型
	CreatedAt  *gtime.Time // 长度18,形如:2021-03-01 20:21:00  固定时间,gf会自动写入
	UpdatedAt  *gtime.Time // 固定时间,gf会自动写入
}
