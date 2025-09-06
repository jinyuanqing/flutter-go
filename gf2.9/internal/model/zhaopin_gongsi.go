package model

// 在控制器和服务里调用,定义了输入输出数据结构.来自于model-entity-admin.go
import (
	"github.com/gogf/gf/v2/os/gtime"
)

type ZhaoPinGongSiInput struct {
	GongsiName interface{} // 公司名

}

type ZhaoPinGongSiOutput struct {
	//Id                 interface{} //
	GongsiName         string      `json:"gongsiname"`          // 公司名
	GongsiFaRen        string      `json:"gongsifaren"  `       // 法人
	GongsiJianJie      string      `json:"gongsijianjie"`       // 简介
	GongsiYeWu         string      `json:"gongsiyewu"  `        // 业务范围
	GongsiLingYu       string      `json:"gongsilingyu" `       // 所属领域
	GongsiPic          string      `json:"gongsipic"  `         // json图片,如{"pics": [{"id": "1", "picurl": "thumbnail.png"}, {"id": "2", "picurl": "thumbnail.png"}, {"id": "3", "picurl": "thumbnail.png"}]}
	GongsiXinyongdaima string      `json:"gongsixinyongdaima" ` // 统一社会信用代码18位
	GongsiChengliriqi  *gtime.Time `json:"gongsichengliriqi"  ` // 成立日期
}
