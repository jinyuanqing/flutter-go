package model

// 在控制器和服务里调用,定义了输入输出数据结构.来自于model-entity-admin.go
// UserMenuRes UserMenu is the golang structure for table user_menu.
// 作为api:/user/get_user_menu的返回值,所以结构体要要加个Res
type UserMenuRes struct {
	UserMenuName     string        `json:"userMenuName"     description:""`
	UserMenuId       int           `json:"userMenuId"       description:""`
	UserMenuUrl      string        `json:"userMenuUrl"      description:""`
	UserMenuParentid int           `json:"userMenuParentid" description:""`
	Id               int           `json:"id"               description:""`
	Children         []UserMenuRes //新增递归字段

}
