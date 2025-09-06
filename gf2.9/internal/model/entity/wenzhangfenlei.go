// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package entity

import (
	"github.com/gogf/gf/v2/os/gtime"
)

// Wenzhangfenlei is the golang structure for table wenzhangfenlei.
type Wenzhangfenlei struct {
	Id         int         `json:"id"         description:"分类名称对应的id,也作为查询文章分类的表名.分类的表名命名规则wen_zhang_fenlei_id"`
	FenleiName string      `json:"fenleiName" description:"文章分类名称"`
	CreatedAt  *gtime.Time `json:"createdAt"  description:"只需定义字段即可.gf自动填入"`
	UpdatedAt  *gtime.Time `json:"updatedAt"  description:"只需定义字段即可.gf自动填入"`
}
