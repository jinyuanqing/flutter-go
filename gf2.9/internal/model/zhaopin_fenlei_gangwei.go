package model

// 在控制器和服务里调用,定义了输入输出数据结构.来自于model-entity-admin.go
// ZhaopinFenleiGangwei is the golang structure for table zhaopin_fenlei_gangwei.
type ZhaopinFenleiGangwei struct {
	Id      int    `json:"id"    `
	FenLei  string `json:"fenLei" `
	GangWei string `json:"gangWei"`
}
