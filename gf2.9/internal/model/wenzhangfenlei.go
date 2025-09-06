package model

//在控制器和服务里调用,定义了输入输出数据结构.来自于model-entity-user.go

type Wenzhangfenlei struct {
	Id         interface{} // 分类名称对应的id,也作为查询文章分类的表名.分类的表名命名规则wen_zhang_fenlei_id
	FenleiName string      `json:"fenleiName" description:"文章分类名称"` // 文章分类名称
}
