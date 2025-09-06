package v1

import (
	"github.com/gogf/gf/v2/encoding/gjson"
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
)

type Query0job0Req struct {
	g.Meta `path:"/query_job" method:"post" tags:"管理员" summary:"获取指定条件的招聘信息,用于搜索" `
	// Tiaojian   g.Map //map的条件 则发送时候的参数需要是Tiaojian[0]=x&Tiaojian[1]=x&Tiaojian[2]=x.如果直接发送多个参数,这里的参数可以不用写.直接代码里r.get().map()即可
	Gongsiming string // 公司名
	Gangwei    string // 岗位
	Riqi1      string // 汉字长度50
	Riqi2      string //  不用设置时间,gf自动设定
	Quanzhi    string // 全职
	Xueli      string //学历
	Dizhi      string //工作地点
	Page       int    //页数
	Id         int    //id根据id查询
	Zuozhe     string //`json:"zuozhe"            description:"发布者"` // 发布者
	Zhiding    string //`json:"zhiding"            description:"置顶"` // 置顶
	Jinghua    string //`json:"jinghua"            description:"精华"`
}
type Query0job0Res struct { //

}

// d为默认值 required必须值 max最大值 json接收参数转为的值名
type Fabu0Req struct {
	g.Meta          `path:"/fa_bu" method:"post" tags:"人才招聘模块" summary:"人才招聘发布信息" `
	Id              uint        `json:"id"            description:""`
	GongSiMing      string      `v:"required" json:"GongSiMing"    description:"招聘的公司名"`
	Gangwei         string      `json:"gangwei"       description:"岗位"`
	Renshu          int         `d:"1" v:"max:50#招聘人数最大50人"  description:"招聘人数"` //
	Xueli           string      `json:"xueli"         description:"学历"`
	Yaoqiu          string      `json:"yaoqiu"        description:"要求"`
	Baoxian         string      `json:"baoxian"       description:"保险"`
	Xinchou         string      `json:"xinchou"       description:"薪酬"`
	Lianxifangshi   string      `json:"lianxifangshi" description:"联系方式"`
	CreateAt        *gtime.Time `json:"createAt"      description:"只需定义字段即可.gf自动填入"`
	UpdateAt        *gtime.Time `json:"updateAt"      description:"只需定义字段即可.gf自动填入"`
	Liulanshu       int         `json:"Liulanshu"     description:"浏览数"`
	YingpinzheId    *gjson.Json `d:"{\"应聘者\": []}" json:"yingpinzheId"  description:"应聘者id字符串.使用逗号分隔.插入时需要加逗号"`
	Kaishishijian   *gtime.Time `json:"kaishishijian" description:"招聘的开始时间"`
	Jieshushijian   *gtime.Time `json:"jieshushijian" description:"招聘的结束时间"`
	Youxiang        string      `json:"youxiang"        description:"接收简历通知的邮箱"`
	TuPian          *gjson.Json `json:"tuPian"       description:"图片地址数组,逗号分隔"`
	Qita            string      `json:"qita"            description:"备用"`
	Quanzhi         string      `json:"quanzhi"         description:"全职兼职"`
	Dizhi           string      `json:"dizhi"           description:"招聘地址"`
	Gongzuonianxian string      `json:"gongzuonianxian" description:"工作年限"`
	Zuozhe          string      `json:"zuozhe"            description:"发布者"` // 发布者
	Zhiding         string      `json:"zhiding"            description:"置顶"` // 置顶
	Jinghua         string      `json:"jinghua"            description:"精华"`
}
type Fabu0Res struct{}

// json接收请求后,把参数转为得另一个变量名
type GetgangweiReq struct {
	g.Meta          `path:"/get_gangwei" method:"post" tags:"人才招聘模块" summary:"获取招聘岗位信息" `
	Id              uint        `json:"id"            description:""`
	GongSiMing      string      `json:"GongSiMing"    description:"招聘的公司名"`
	Gangwei         string      `json:"gangwei"       description:"岗位"`
	Renshu          int         `d:"1" v:"max:50#招聘人数最大50人"  description:"招聘人数"` //
	Xueli           string      `json:"xueli"         description:"学历"`
	Yaoqiu          string      `json:"yaoqiu"        description:"要求"`
	Baoxian         string      `json:"baoxian"       description:"保险"`
	Xinchou         string      `json:"xinchou"       description:"薪酬"`
	Lianxifangshi   string      `json:"lianxifangshi" description:"联系方式"`
	CreateAt        *gtime.Time `json:"createAt"      description:"只需定义字段即可.gf自动填入"`
	UpdateAt        *gtime.Time `json:"updateAt"      description:"只需定义字段即可.gf自动填入"`
	Liulanshu       int         `json:"Liulanshu"     description:"浏览数"`
	YingpinzheId    string      `json:"yingpinzheId"  description:"应聘者id字符串.使用逗号分隔.插入时需要加逗号"`
	Kaishishijian   *gtime.Time `json:"kaishishijian" description:"招聘的开始时间"`
	Jieshushijian   *gtime.Time `json:"jieshushijian" description:"招聘的结束时间"`
	Youxiang        string      `json:"youxiang"        description:"接收简历通知的邮箱"`
	TuPian          string      `json:"tuPian"       description:"图片地址数组,逗号分隔"`
	Quanzhi         string      `json:"quanzhi"         description:"全职兼职"`
	Dizhi           string      `json:"dizhi"           description:"招聘地址"`
	Gongzuonianxian string      `json:"gongzuonianxian" description:"工作年限"`
	Qita            string      `json:"qita"            description:"备用"`
	Page            int         //指定获取页数从1开始.
	Zuozhe          string      `json:"zuozhe"            description:"发布者"` // 发布者
	Zhiding         string      `json:"zhiding"            description:"置顶"` // 置顶
	Jinghua         string      `json:"jinghua"            description:"精华"`
}
type GetgangweiRes struct{}

type Fen_lei_Req struct {
	g.Meta  `path:"/get_fenlei_gangweixifen" method:"post" tags:"人才招聘模块" summary:"获取岗位的分类和岗位细分" `
	Id      int    `json:"id"      description:""`
	FenLei  string `json:"fenlei"  description:"招聘岗位分类.如销售分类"`
	GangWei string `json:"gangwei" description:"分类下属的细分岗位.如销售分类的楼房销售"`
	// Page int `json:"page" description:"//不能在传入page参数了,一次获取全部
}
type Fen_lei_Res struct{}

type Set_Fen_lei_Req struct { //虽然都是同样得字段,不能与 Fen_lei_Req共用一个.因为path不一样,要区分开
	g.Meta  `path:"/set_fenlei_gangweixifen" method:"post" tags:"人才招聘模块" summary:"设置岗位的分类和岗位细分" `
	Id      int    `json:"id"      description:""`
	FenLei  string `json:"fenlei"  description:"招聘岗位分类.如销售分类"`
	GangWei string `json:"gangwei" description:"分类下属的细分岗位.如销售分类的楼房销售"`
	// Page int `json:"page" description:"//不能在传入page参数了,一次获取全部
}
type Set_Fen_lei_Res struct{}

type Zhaopin_Update_Req struct {
	g.Meta          `path:"/zhaopin_update" method:"post" tags:"人才招聘模块" summary:"更新人才招聘信息" `
	Id              uint        `json:"id"            description:""`
	GongSiMing      string      `v:"required" json:"GongSiMing"    description:"招聘的公司名"`
	Gangwei         string      `json:"gangwei"       description:"岗位"`
	Renshu          int         `d:"1" v:"max:50#招聘人数最大50人"  description:"招聘人数"` //
	Xueli           string      `json:"xueli"         description:"学历"`
	Yaoqiu          string      `json:"yaoqiu"        description:"要求"`
	Baoxian         string      `json:"baoxian"       description:"保险"`
	Xinchou         string      `json:"xinchou"       description:"薪酬"`
	Lianxifangshi   string      `json:"lianxifangshi" description:"联系方式"`
	CreateAt        *gtime.Time `json:"createAt"      description:"只需定义字段即可.gf自动填入"`
	UpdateAt        *gtime.Time `json:"updateAt"      description:"只需定义字段即可.gf自动填入"`
	Liulanshu       int         `json:"Liulanshu"     description:"浏览数"`
	YingpinzheId    *gjson.Json `d:"{\"应聘者\": []}" json:"yingpinzheId"  description:"应聘者id字符串.使用逗号分隔.插入时需要加逗号"`
	Kaishishijian   *gtime.Time `json:"kaishishijian" description:"招聘的开始时间"`
	Jieshushijian   *gtime.Time `json:"jieshushijian" description:"招聘的结束时间"`
	Youxiang        string      `json:"youxiang"        description:"接收简历通知的邮箱"`
	TuPian          *gjson.Json `json:"tuPian"       description:"图片地址数组,逗号分隔"`
	Qita            string      `json:"qita"            description:"备用"`
	Quanzhi         string      `json:"quanzhi"         description:"全职兼职"`
	Dizhi           string      `json:"dizhi"           description:"招聘地址"`
	Gongzuonianxian string      `json:"gongzuonianxian" description:"工作年限"`
	Zuozhe          string      `json:"zuozhe"            description:"发布者"` // 发布者
	Zhiding         string      `json:"zhiding"            description:"置顶"` // 置顶
	Jinghua         string      `json:"jinghua"            description:"精华"`
}
type Zhaopin_Update_Res struct{}

type Get_Gongsi_Req struct {
	g.Meta `path:"/get_gongsi" method:"post" tags:"人才招聘模块" summary:"根据公司名,获取公司信息" `
	//Id      int    `json:"id"      description:""`

	Gongsiming string `json:"gongsiming" description:"公司名"`
	// Page int `json:"page" description:"//不能在传入page参数了,一次获取全部
}
type Get_Gongsi_Res struct {
	//Id                 interface{} //不返回id
	GongsiName  string `json:"gongsiname"`    // 公司名
	GongsiFaRen string `json:"gongsifaren"  ` // 法人
	//GongsiJianJie      string      `json:"gongsijianjie"`       // 简介
	GongsiYeWu string `json:"gongsiyewu"  ` // 业务范围
	//GongsiLingYu       string      `json:"gongsilingyu" `       // 所属领域
	//GongsiPic          string      `json:"gongsipic"  `         // json图片,如{"pics": [{"id": "1", "picurl": "thumbnail.png"}, {"id": "2", "picurl": "thumbnail.png"}, {"id": "3", "picurl": "thumbnail.png"}]}
	//GongsiXinyongdaima string      `json:"gongsixinyongdaima" ` // 统一社会信用代码18位
	//GongsiChengliriqi  *gtime.Time `json:"gongsichengliriqi"  ` // 成立日期
}
