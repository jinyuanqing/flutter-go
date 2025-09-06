package model

import (
	"github.com/gogf/gf/v2/os/gtime"
)

// 在logic里调用,定义了输入输出数据结构.来自于model-entity-user.go
type UserCreateInput struct {
	Username string `json:"username"     description:"通行证/用户名"`
	Password string `json:"password"     description:"密码"`
	Email    string `json:"email"        description:"邮箱"`
	Address  string `json:"address"      description:"地址"`
	Nickname string `json:"nickname"     description:"昵称"`

	Tel          string `json:"tel"          description:"电话"`
	Birthday     string `json:"birthday"     description:"出生日期"`
	Beiyong1     string `json:"beiyong1"     description:"备用"`
	Sex          string `json:"sex"          description:"性别"`
	Qianming     string `json:"qianming"     description:"签名"`
	Shenfenzheng string `json:"shenfenzheng" description:"身份证号"`
	Ip           string `json:"ip"           description:"最后登录ip"`
	Touxiang     string `json:"touxiang"     description:"头像"`
	Jifen        uint   `json:"jifen"        description:"积分"`

	Isadmin int `json:"isadmin" description:"是否是管理员"`
}

type UserSignInInput struct {
	Username string
	Password string
	//Qianming string
}
type User struct { //查询服务中返回的用户表字段
	Id       uint        `json:"id"       ` // User ID
	Username string      `json:"username" ` // 通行证/用户名
	Password string      `json:"password" ` // 密码
	Email    string      `json:"email"    ` // 邮箱
	Address  string      `json:"address"  ` // 地址
	Nickname string      `json:"nickname" ` // 昵称
	CreateAt *gtime.Time `json:"createAt" ` // Created Time
	UpdateAt *gtime.Time `json:"updateAt" ` // Updated Time
	Tel      string      `json:"tel"      ` // 电话
	Birthday string      `json:"birthday" ` // 出生日期
	Beiyong1 string      `json:"beiyong1" ` // 备用
}
