// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package entity

import (
	"github.com/gogf/gf/v2/os/gtime"
)

// Admin1 is the golang structure for table admin1无用.
type Admin1 struct {
	Id        uint        `json:"id"        description:""`
	Username  string      `json:"username"  description:"管理员用户名,长度10"`
	Password  string      `json:"password"  description:"密码,长度10"`
	CreatedAt *gtime.Time `json:"createdAt" description:"只需定义字段即可.gf自动填入"`
	UpdatedAt *gtime.Time `json:"updatedAt" description:"只需定义字段即可.gf自动填入"`
}
