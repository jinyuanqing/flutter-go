// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package entity

import (
	"github.com/gogf/gf/v2/os/gtime"
)

// JobGangwei is the golang structure for table job_gangwei.
type JobGangwei struct {
	Id        int         `json:"id"        description:""`
	Gangwei   string      `json:"gangwei"   description:""`
	CreatedAt *gtime.Time `json:"createdAt" description:"只需定义字段即可.gf自动填入"`
	UpdatedAt *gtime.Time `json:"updatedAt" description:"只需定义字段即可.gf自动填入"`
}
