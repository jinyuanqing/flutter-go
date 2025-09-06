package model

import (
	"github.com/gogf/gf/v2/os/gtime"
	//  "github.com/gogf/gf-demo-user/v2/internal/model/entity"
)

// 在控制器和服务里调用,定义了输入输出数据结构.来自于model-entity-admin.go
type AdminCreateInput struct {
	Id       uint
	Username string
	Password string
}

type AdminCreateInput1 struct {
	Id       uint
	Username string
	Password string
}

type Admin8wen8zhang struct {
	Id        int         `json:"id"       `      //
	Biaoti    string      `json:"biaoti"   `      // 汉字长度25
	Zuozhe    string      `json:"zuozhe"   `      // 汉字长度25
	Zhaiyao   string      `json:"zhaiyao"  `      // 汉字长度50
	CreatedAt *gtime.Time `json:"createdAt"     ` // 长度18,形如:2021-03-01 20:21:00

	UpdatedAt *gtime.Time `json:"updatedAt"     `
	Suoluetu  string      `json:"suoluetu" ` // 为字符串,长度30
	Neirong   string      `json:"neirong"  ` // 汉字长度65535/2
	Yuedushu  int         `json:"yuedushu" ` // 阅读数
	Fenleiid  int         `json:"fenleiid" ` // 分类id

	Zhiding    string `json:"zhiding"   description:"置顶"`
	Jinghua    string `json:"jinghua"   description:"精华"`
	Dianzanshu int    `json:"fenleiid" ` //
}
