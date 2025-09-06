// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package do

import (
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
)

// JobGangwei is the golang structure of table job_gangwei for DAO operations like Where/Data.
type JobGangwei struct {
	g.Meta    `orm:"table:job_gangwei, do:true"`
	Id        interface{} //
	Gangwei   interface{} //
	CreatedAt *gtime.Time // 只需定义字段即可.gf自动填入
	UpdatedAt *gtime.Time // 只需定义字段即可.gf自动填入
}
