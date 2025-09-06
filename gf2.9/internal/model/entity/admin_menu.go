// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package entity

import (
	"github.com/gogf/gf/v2/os/gtime"
)

// AdminMenu is the golang structure for table admin_menu.
type AdminMenu struct {
	Id        int         `json:"id"        description:"菜单id,为菜单的唯一识别.当前配置根据此项作为显示顺序了.sort字段未用"`
	MenuId    string      `json:"menuId"    description:"废,可备用"`
	MenuUrl   string      `json:"menuUrl"   description:"菜单所在的路由url.要在main.dart的getx路由设置"`
	MenuName  string      `json:"menuName"  description:"菜单名称"`
	ParentId  string      `json:"parentId"  description:"父节点id"`
	Icon      []byte      `json:"icon"      description:"图标"`
	Sort      uint        `json:"sort"      description:"显示菜单的序号,默认0"`
	Isshow    bool        `json:"isshow"    description:"菜单是否显示.默认1显示"`
	CreatedAt *gtime.Time `json:"createdAt" description:"只需定义字段即可.gf自动填入"`
	UpdatedAt *gtime.Time `json:"updatedAt" description:"只需定义字段即可.gf自动填入"`
	MenuClass string      `json:"menuClass" description:"菜单的类名,如caidan1()"`
}
