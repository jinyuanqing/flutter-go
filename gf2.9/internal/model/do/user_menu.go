// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package do

import (
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
)

// UserMenu is the golang structure of table user_menu for DAO operations like Where/Data.
type UserMenu struct {
	g.Meta           `orm:"table:user_menu, do:true"`
	UserMenuName     interface{} //
	UserMenuId       interface{} // 应该是随意设置
	UserMenuUrl      interface{} //
	UserMenuParentid interface{} //
	Id               interface{} //
	CreatedAt        *gtime.Time // 只需定义字段即可.gf自动填入
	UpdatedAt        *gtime.Time // 只需定义字段即可.gf自动填入
}
