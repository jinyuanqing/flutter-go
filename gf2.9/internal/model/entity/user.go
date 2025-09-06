// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package entity

import (
	"github.com/gogf/gf/v2/os/gtime"
)

// User is the golang structure for table user.
type User struct {
	Id           uint        `json:"id"           description:"User ID"`
	Username     string      `json:"username"     description:"通行证/用户名"`
	Password     string      `json:"password"     description:"密码"`
	Email        string      `json:"email"        description:"邮箱"`
	Address      string      `json:"address"      description:"地址"`
	Nickname     string      `json:"nickname"     description:"昵称"`
	Tel          string      `json:"tel"          description:"电话"`
	Birthday     string      `json:"birthday"     description:"出生日期"`
	Beiyong1     string      `json:"beiyong1"     description:"备用.用户是否被禁用"`
	Sex          string      `json:"sex"          description:"性别0/1.1男0女"`
	Qianming     string      `json:"qianming"     description:"签名"`
	Shenfenzheng string      `json:"shenfenzheng" description:"身份证号"`
	Ip           string      `json:"ip"           description:"最后登录ip"`
	Touxiang     string      `json:"touxiang"     description:"头像"`
	Jifen        uint        `json:"jifen"        description:"积分"`
	Isadmin      bool        `json:"isadmin"      description:"管理员.布尔.1管理,0普通"`
	Apinum       uint        `json:"apinum"       description:"访问api的次数上限"`
	Isused       bool        `json:"isused"       description:"用户是否启用.0禁止1启用 bool"`
	Apiused      int         `json:"apiused"      description:"已经使用了多少次api.默认0"`
	CreateAt     *gtime.Time `json:"createAt"     description:"只需定义字段即可.gf自动填入"`
	UpdateAt     *gtime.Time `json:"updateAt"     description:"只需定义字段即可.gf自动填入"`
}
