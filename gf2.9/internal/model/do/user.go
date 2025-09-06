// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package do

import (
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
)

// User is the golang structure of table user for DAO operations like Where/Data.
type User struct {
	g.Meta       `orm:"table:user, do:true"`
	Id           interface{} // User ID
	Username     interface{} // 通行证/用户名
	Password     interface{} // 密码
	Email        interface{} // 邮箱
	Address      interface{} // 地址
	Nickname     interface{} // 昵称
	Tel          interface{} // 电话
	Birthday     interface{} // 出生日期
	Beiyong1     interface{} // 备用.用户是否被禁用
	Sex          interface{} // 性别0/1.1男0女
	Qianming     interface{} // 签名
	Shenfenzheng interface{} // 身份证号
	Ip           interface{} // 最后登录ip
	Touxiang     interface{} // 头像
	Jifen        interface{} // 积分
	Isadmin      interface{} // 管理员.布尔.1管理,0普通
	Apinum       interface{} // 访问api的次数上限
	Isused       interface{} // 用户是否启用.0禁止1启用 bool
	Apiused      interface{} // 已经使用了多少次api.默认0
	CreateAt     *gtime.Time // 只需定义字段即可.gf自动填入
	UpdateAt     *gtime.Time // 只需定义字段即可.gf自动填入
}
