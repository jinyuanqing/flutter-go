// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package do

import (
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
)

// WenZhangPingLun is the golang structure of table wen_zhang_ping_lun for DAO operations like Where/Data.
type WenZhangPingLun struct {
	g.Meta         `orm:"table:wen_zhang_ping_lun, do:true"`
	Id             interface{} //
	WenZhangId     interface{} // 文章id
	PingLunRen     interface{} // 评论人
	Pinglunneirong interface{} // 评论内容
	CreateAt       *gtime.Time //
	UpdateAt       *gtime.Time //
}
