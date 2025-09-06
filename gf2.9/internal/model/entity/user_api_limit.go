// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package entity

import (
	"github.com/gogf/gf/v2/os/gtime"
)

// UserApiLimit is the golang structure for table user_api_limit.
type UserApiLimit struct {
	Id         int         `json:"id"         description:""`
	Uid        int         `json:"uid"        description:""`
	Url        string      `json:"url"        description:"接口的路由   ,如{\"urls\": [{\"id\": \"1\", \"url\": \"/hello\"}, {\"id\": \"2\", \"url\": \"/readdata\"}, ]}"`
	Maxnum     int         `json:"maxnum"     description:"当前接口最大次数数量"`
	Currentnum int         `json:"currentnum" description:"当前使用的接口次数数量"`
	Isopen     bool        `json:"isopen"     description:"0禁止1开启限制"`
	Ismax      bool        `json:"ismax"      description:"0未达到最大限制1达到了最大次数限制"`
	CreatedAt  *gtime.Time `json:"createdAt"  description:"只需定义字段即可.gf自动填入"`
	UpdatedAt  *gtime.Time `json:"updatedAt"  description:"只需定义字段即可.gf自动填入"`
}
