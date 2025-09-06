// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package do

import (
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
)

// ZhaoPinGongSi is the golang structure of table zhao_pin_gong_si for DAO operations like Where/Data.
type ZhaoPinGongSi struct {
	g.Meta             `orm:"table:zhao_pin_gong_si, do:true"`
	Id                 interface{} //
	GongsiName         interface{} // 公司名
	GongsiFaRen        interface{} // 法人
	GongsiJianJie      interface{} // 简介
	GongsiYeWu         interface{} // 业务范围
	GongsiLingYu       interface{} // 所属领域
	GongsiPic          interface{} // json图片,如{"pics": [{"id": "1", "picurl": "thumbnail.png"}, {"id": "2", "picurl": "thumbnail.png"}, {"id": "3", "picurl": "thumbnail.png"}]}
	GongsiXinyongdaima interface{} // 统一社会信用代码18位
	GongsiChengliriqi  *gtime.Time // 成立日期
	CreatedAt          *gtime.Time // 只需定义字段即可.gf自动填入
	UpdatedAt          *gtime.Time // 只需定义字段即可.gf自动填入
}
