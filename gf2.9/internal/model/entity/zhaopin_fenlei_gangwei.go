// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package entity

import (
	"github.com/gogf/gf/v2/os/gtime"
)

// ZhaopinFenleiGangwei is the golang structure for table zhaopin_fenlei_gangwei.
type ZhaopinFenleiGangwei struct {
	Id        int         `json:"id"        description:""`
	FenLei    string      `json:"fenLei"    description:"招聘岗位分类.如销售分类"`
	GangWeiId string      `json:"gangWeiId" description:"分类下属的细分岗位.如销售分类的楼房销售"`
	CreatedAt *gtime.Time `json:"createdAt" description:"只需定义字段即可.gf自动填入"`
	UpdatedAt *gtime.Time `json:"updatedAt" description:"只需定义字段即可.gf自动填入"`
}
