// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package do

import (
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
)

// Wenzhangfenlei is the golang structure of table wenzhangfenlei for DAO operations like Where/Data.
type Wenzhangfenlei struct {
	g.Meta     `orm:"table:wenzhangfenlei, do:true"`
	Id         interface{} // 分类名称对应的id,也作为查询文章分类的表名.分类的表名命名规则wen_zhang_fenlei_id
	FenleiName interface{} // 文章分类名称
	CreatedAt  *gtime.Time // 只需定义字段即可.gf自动填入
	UpdatedAt  *gtime.Time // 只需定义字段即可.gf自动填入
}
