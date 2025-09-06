package model

// 在控制器和服务里调用,定义了输入输出数据结构.来自于model-entity-admin.go
import (
	"github.com/gogf/gf/v2/encoding/gjson"
	"github.com/gogf/gf/v2/os/gtime"
)

type RenCaiZhaoPin struct {
	Id              uint        `json:"id"            description:""`
	GongSiMing      string      `json:"gong0Si0Ming"  description:"招聘的公司名"`
	Gangwei         string      `json:"gangwei"       description:"岗位"`
	Renshu          int         `json:"renshu"        description:"招聘人数"`
	Xueli           string      `json:"xueli"         description:"学历"`
	Yaoqiu          string      `json:"yaoqiu"        description:"要求"`
	Baoxian         string      `json:"baoxian"       description:"保险"`
	Xinchou         string      `json:"xinchou"       description:"薪酬"`
	Lianxifangshi   string      `json:"lianxifangshi" description:"联系方式"`
	CreatedAt       *gtime.Time `json:"createAt"      description:"只需定义字段即可.gf自动填入"`
	UpdatedAt       *gtime.Time `json:"updateAt"      description:"只需定义字段即可.gf自动填入"`
	Liulanshu       int         `json:"liulanshu"     description:"浏览数"`
	YingpinzheId    *gjson.Json `json:"yingpinzheId"  description:"应聘者id字符串.使用逗号分隔.插入时需要加逗号"`
	Kaishishijian   *gtime.Time `json:"kaishishijian" description:"招聘的开始时间"`
	Jieshushijian   *gtime.Time `json:"jieshushijian" description:"招聘的结束时间"`
	Youxiang        string      `json:"youxiang"        description:"接收简历通知的邮箱"`
	TuPian          *gjson.Json `json:"tupian"       description:"图片地址数组,逗号分隔"`
	Quanzhi         string      `json:"quanzhi"         description:"全职兼职"`
	Dizhi           string      `json:"dizhi"           description:"招聘地址"`
	Gongzuonianxian string      `json:"gongzuonianxian" description:"工作年限"`
	Qita            string      `json:"qita"            description:"备用"`

	Zuozhe  string `json:"zuozhe"            description:"发布者"` // 发布者
	Zhiding string `json:"zhiding"            description:"置顶"` // 置顶
	Jinghua string `json:"jinghua"            description:"精华"` // 精华

}
