// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package entity

import (
	"github.com/gogf/gf/v2/os/gtime"
)

// ZhaoPinGongSi is the golang structure for table zhao_pin_gong_si.
type ZhaoPinGongSi struct {
	Id                 int         `json:"id"                 description:""`
	GongsiName         string      `json:"gongsiName"         description:"公司名"`
	GongsiFaRen        string      `json:"gongsiFaRen"        description:"法人"`
	GongsiJianJie      string      `json:"gongsiJianJie"      description:"简介"`
	GongsiYeWu         string      `json:"gongsiYeWu"         description:"业务范围"`
	GongsiLingYu       string      `json:"gongsiLingYu"       description:"所属领域"`
	GongsiPic          string      `json:"gongsiPic"          description:"json图片,如{\"pics\": [{\"id\": \"1\", \"picurl\": \"thumbnail.png\"}, {\"id\": \"2\", \"picurl\": \"thumbnail.png\"}, {\"id\": \"3\", \"picurl\": \"thumbnail.png\"}]}"`
	GongsiXinyongdaima string      `json:"gongsiXinyongdaima" description:"统一社会信用代码18位"`
	GongsiChengliriqi  *gtime.Time `json:"gongsiChengliriqi"  description:"成立日期"`
	CreatedAt          *gtime.Time `json:"createdAt"          description:"只需定义字段即可.gf自动填入"`
	UpdatedAt          *gtime.Time `json:"updatedAt"          description:"只需定义字段即可.gf自动填入"`
}
