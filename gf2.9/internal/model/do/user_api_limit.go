// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package do

import (
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
)

// UserApiLimit is the golang structure of table user_api_limit for DAO operations like Where/Data.
type UserApiLimit struct {
	g.Meta     `orm:"table:user_api_limit, do:true"`
	Id         interface{} //
	Uid        interface{} //
	Url        interface{} // 接口的路由   ,如{"urls": [{"id": "1", "url": "/hello"}, {"id": "2", "url": "/readdata"}, ]}
	Maxnum     interface{} // 当前接口最大次数数量
	Currentnum interface{} // 当前使用的接口次数数量
	Isopen     interface{} // 0禁止1开启限制
	Ismax      interface{} // 0未达到最大限制1达到了最大次数限制
	CreatedAt  *gtime.Time // 只需定义字段即可.gf自动填入
	UpdatedAt  *gtime.Time // 只需定义字段即可.gf自动填入
}
