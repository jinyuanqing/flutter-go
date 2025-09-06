// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package entity

import (
	"github.com/gogf/gf/v2/os/gtime"
)

// UserMenu is the golang structure for table user_menu.
type UserMenu struct {
	UserMenuName     string      `json:"userMenuName"     description:""`
	UserMenuId       int         `json:"userMenuId"       description:"应该是随意设置"`
	UserMenuUrl      string      `json:"userMenuUrl"      description:""`
	UserMenuParentid int         `json:"userMenuParentid" description:""`
	Id               int         `json:"id"               description:""`
	CreatedAt        *gtime.Time `json:"createdAt"        description:"只需定义字段即可.gf自动填入"`
	UpdatedAt        *gtime.Time `json:"updatedAt"        description:"只需定义字段即可.gf自动填入"`
}
