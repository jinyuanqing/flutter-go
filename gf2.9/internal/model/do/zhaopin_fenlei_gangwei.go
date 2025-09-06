// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package do

import (
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
)

// ZhaopinFenleiGangwei is the golang structure of table zhaopin_fenlei_gangwei for DAO operations like Where/Data.
type ZhaopinFenleiGangwei struct {
	g.Meta    `orm:"table:zhaopin_fenlei_gangwei, do:true"`
	Id        interface{} //
	FenLei    interface{} // 招聘岗位分类.如销售分类
	GangWeiId interface{} // 分类下属的细分岗位.如销售分类的楼房销售
	CreatedAt *gtime.Time // 只需定义字段即可.gf自动填入
	UpdatedAt *gtime.Time // 只需定义字段即可.gf自动填入
}
