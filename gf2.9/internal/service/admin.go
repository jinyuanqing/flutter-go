// ================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// You can delete these comments if you wish manually maintain this interface file.
// ================================================================================

package service

import (
	"context"
	"database/sql"
	v1 "gf2/api/v1"
	"gf2/internal/model"

	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/frame/g"
)

type (
	IAdmin interface {
		Set_user_authority(ctx context.Context, rolename string, add_authority g.Array, del_authority g.Array) (result sql.Result, err error)
		Set_fen_lei_name(ctx context.Context, in model.Wenzhangfenlei) (result sql.Result, err error)
		SignIn(ctx context.Context, in model.UserSignInInput) (err error)
		// Create creates user account.
		Create(ctx context.Context, in model.AdminCreateInput) (err error)
		// SignIn creates session for given user account.
		Query(ctx context.Context, in model.AdminCreateInput) (err error)
		Query0wen0zhang0num(ctx context.Context, zuozhe string) (res int, err error)
		Update_user(ctx context.Context, user g.Map) (res sql.Result, err error)
		Get_userinfo(ctx context.Context, user g.Map) (res gdb.Result, err error)
		// 获取角色权限
		Get_user_authority(ctx context.Context, rolename string) (res gdb.Result, err error)
		Get_user(ctx context.Context, user g.Map) (res gdb.Record, err error)
		Query0wen0zhang(ctx context.Context, page int, fenleiid int) (res gdb.Result, err error)
		Query0tiao0jian0wen0zhang(ctx context.Context, map1 g.Map) (res gdb.Result, err error)
		Delete_user(ctx context.Context, req *v1.Admin_delete_user_Req) (res sql.Result, err error)
		Query0all0wen0zhang(ctx context.Context, page int) (res gdb.Result, err error)
		// IsNicknameAvailable checks and returns given nickname is available for signing up.
		IsNicknameAvailable(ctx context.Context, nickname string) (bool, error)
		// 根据菜单id获取菜单
		Get_menu_according_to_id(ctx context.Context, req *v1.Admin_get_menu_according_to_id_Req) (gdb.Result, error)
		// 删除菜单,根据id
		Delete_menu_according_to_id(ctx context.Context, req *v1.Admin_delete_menu_according_to_id_Req) (sql.Result, error)
		Modify_menu(ctx context.Context, req *v1.Admin_modify_menu_Req) (sql.Result, error)
		Insert_menu(ctx context.Context, req *v1.Admin_insert_menu_Req) (sql.Result, error)
		// 获取后台所有菜单,不分权限
		Get_allmenu(ctx context.Context) (interface{}, error)
		// 获取后台有权限的菜单
		Get_menu(ctx context.Context, username string) (interface{}, error)
		// 获取后台有权限的菜单
		Get_menu_according_to_role(ctx context.Context, role string) (interface{}, error)
		// 插入一个文章内容到数据库
		Insert_article(ctx context.Context, in model.Admin8wen8zhang) (result gdb.Result, err error)
		// 修改更新一个文章内容到数据库
		Update_article(ctx context.Context, in model.Admin8wen8zhang) (result sql.Result, err error)
		// 修改文章的阅读数
		Update_article_yuedushu(ctx context.Context, in model.Admin8wen8zhang) (yuedush2 uint64, result sql.Result, err error)
		// 修改文章的点赞数
		Update_article_dianzanshu(ctx context.Context, in model.Admin8wen8zhang) (dianzanshu1 uint64, result sql.Result, err error)
		// 修改文章的置顶和精华信息.同时更新2个字段
		Update_article_zhiding_jinghua(ctx context.Context, in model.Admin8wen8zhang) (result sql.Result, err error)
	}
)

var (
	localAdmin IAdmin
)

func Admin() IAdmin {
	if localAdmin == nil {
		panic("implement not found for interface IAdmin, forgot register?")
	}
	return localAdmin
}

func RegisterAdmin(i IAdmin) {
	localAdmin = i
}
