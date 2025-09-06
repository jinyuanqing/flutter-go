// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package do

import (
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
)

// Admin1 is the golang structure of table admin1无用 for DAO operations like Where/Data.
type Admin1 struct {
	g.Meta    `orm:"table:admin1无用, do:true"`
	Id        interface{} //
	Username  interface{} // 管理员用户名,长度10
	Password  interface{} // 密码,长度10
	CreatedAt *gtime.Time // 只需定义字段即可.gf自动填入
	UpdatedAt *gtime.Time // 只需定义字段即可.gf自动填入
}
