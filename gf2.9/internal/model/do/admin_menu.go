// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package do

import (
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
)

// AdminMenu is the golang structure of table admin_menu for DAO operations like Where/Data.
type AdminMenu struct {
	g.Meta    `orm:"table:admin_menu, do:true"`
	Id        interface{} // 菜单id,为菜单的唯一识别.当前配置根据此项作为显示顺序了.sort字段未用
	MenuId    interface{} // 废,可备用
	MenuUrl   interface{} // 菜单所在的路由url.要在main.dart的getx路由设置
	MenuName  interface{} // 菜单名称
	ParentId  interface{} // 父节点id
	Icon      []byte      // 图标
	Sort      interface{} // 显示菜单的序号,默认0
	Isshow    interface{} // 菜单是否显示.默认1显示
	CreatedAt *gtime.Time // 只需定义字段即可.gf自动填入
	UpdatedAt *gtime.Time // 只需定义字段即可.gf自动填入
	MenuClass interface{} // 菜单的类名,如caidan1()
}
