// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package do

import (
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
)

// RenCaiZhaoPin is the golang structure of table ren_cai_zhao_pin for DAO operations like Where/Data.
type RenCaiZhaoPin struct {
	g.Meta          `orm:"table:ren_cai_zhao_pin, do:true"`
	Id              interface{} //
	GongSiMing      interface{} // 招聘的公司名
	Gangwei         interface{} // 岗位
	Renshu          interface{} // 招聘人数
	Xueli           interface{} // 学历
	Yaoqiu          interface{} // 要求
	Baoxian         interface{} // 包括:五险一金,包吃, 加班补助 包住 饭补 交通补助 年底双薪 周末双休
	Xinchou         interface{} // 薪酬
	Lianxifangshi   interface{} // 联系方式
	CreatedAt       *gtime.Time // 只需定义字段即可.gf自动填入
	UpdatedAt       *gtime.Time // 只需定义字段即可.gf自动填入
	Liulanshu       interface{} // 浏览数
	YingpinzheId    interface{} // 应聘者id字符串.使用逗号分隔.插入时需要加逗号
	Kaishishijian   *gtime.Time // 招聘的开始时间
	Jieshushijian   *gtime.Time // 招聘的结束时间
	Youxiang        interface{} // 接收简历通知的邮箱
	Qita            interface{} // 其他,备用
	Quanzhi         interface{} // 全职兼职
	Dizhi           interface{} // 招聘地址
	Gongzuonianxian interface{} // 工作年限
	Tupian          interface{} // 图片json
	Zuozhe          interface{} // 发布者
	Zhiding         interface{} // 置顶,默认字符串0
	Jinghua         interface{} // 精华,默认字符串0
}
