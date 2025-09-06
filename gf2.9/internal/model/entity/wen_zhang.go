// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package entity

import (
	"github.com/gogf/gf/v2/os/gtime"
)

// WenZhang is the golang structure for table wen_zhang.
type WenZhang struct {
	Id         int         `json:"id"         description:""`
	Biaoti     string      `json:"biaoti"     description:"汉字长度25.标题"`
	Zuozhe     string      `json:"zuozhe"     description:"汉字长度25.作者"`
	Zhaiyao    string      `json:"zhaiyao"    description:"汉字长度50.摘要"`
	Suoluetu   string      `json:"suoluetu"   description:"为字符串,长度30.缩略图"`
	Neirong    string      `json:"neirong"    description:"汉字长度65535/2.内容"`
	Yuedushu   int         `json:"yuedushu"   description:"阅读数"`
	Dianzanshu int         `json:"dianzanshu" description:"点赞数"`
	Fenleiid   int         `json:"fenleiid"   description:"分类id"`
	Zhiding    string      `json:"zhiding"    description:"置顶0/1.字符的1和0"`
	Jinghua    string      `json:"jinghua"    description:"精华0/1.字符的1和0"`
	Shanchu    bool        `json:"shanchu"    description:"是否删除.1和0,mysql的bool类型"`
	CreatedAt  *gtime.Time `json:"createdAt"  description:"长度18,形如:2021-03-01 20:21:00  固定时间,gf会自动写入"`
	UpdatedAt  *gtime.Time `json:"updatedAt"  description:"固定时间,gf会自动写入"`
}
