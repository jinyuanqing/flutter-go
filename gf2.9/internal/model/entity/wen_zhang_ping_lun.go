// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package entity

import (
	"github.com/gogf/gf/v2/os/gtime"
)

// WenZhangPingLun is the golang structure for table wen_zhang_ping_lun.
type WenZhangPingLun struct {
	Id             uint        `json:"id"             description:""`
	WenZhangId     string      `json:"wenZhangId"     description:"文章id"`
	PingLunRen     string      `json:"pingLunRen"     description:"评论人"`
	Pinglunneirong string      `json:"pinglunneirong" description:"评论内容"`
	CreateAt       *gtime.Time `json:"createAt"       description:""`
	UpdateAt       *gtime.Time `json:"updateAt"       description:""`
}
