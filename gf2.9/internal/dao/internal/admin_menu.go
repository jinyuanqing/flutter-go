// ==========================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// ==========================================================================

package internal

import (
	"context"

	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/frame/g"
)

// AdminMenuDao is the data access object for table admin_menu.
type AdminMenuDao struct {
	table   string           // table is the underlying table name of the DAO.
	group   string           // group is the database configuration group name of current DAO.
	columns AdminMenuColumns // columns contains all the column names of Table for convenient usage.
}

// AdminMenuColumns defines and stores column names for table admin_menu.
type AdminMenuColumns struct {
	Id        string // 菜单id,为菜单的唯一识别.当前配置根据此项作为显示顺序了.sort字段未用
	MenuId    string // 废,可备用
	MenuUrl   string // 菜单所在的路由url.要在main.dart的getx路由设置
	MenuName  string // 菜单名称
	ParentId  string // 父节点id
	Icon      string // 图标
	Sort      string // 显示菜单的序号,默认0
	Isshow    string // 菜单是否显示.默认1显示
	CreatedAt string // 只需定义字段即可.gf自动填入
	UpdatedAt string // 只需定义字段即可.gf自动填入
	MenuClass string // 菜单的类名,如caidan1()
}

// adminMenuColumns holds the columns for table admin_menu.
var adminMenuColumns = AdminMenuColumns{
	Id:        "id",
	MenuId:    "menu_id",
	MenuUrl:   "menu_url",
	MenuName:  "menu_name",
	ParentId:  "parent_id",
	Icon:      "icon",
	Sort:      "sort",
	Isshow:    "isshow",
	CreatedAt: "created_at",
	UpdatedAt: "updated_at",
	MenuClass: "menu_class",
}

// NewAdminMenuDao creates and returns a new DAO object for table data access.
func NewAdminMenuDao() *AdminMenuDao {
	return &AdminMenuDao{
		group:   "default",
		table:   "admin_menu",
		columns: adminMenuColumns,
	}
}

// DB retrieves and returns the underlying raw database management object of current DAO.
func (dao *AdminMenuDao) DB() gdb.DB {
	return g.DB(dao.group)
}

// Table returns the table name of current dao.
func (dao *AdminMenuDao) Table() string {
	return dao.table
}

// Columns returns all column names of current dao.
func (dao *AdminMenuDao) Columns() AdminMenuColumns {
	return dao.columns
}

// Group returns the configuration group name of database of current dao.
func (dao *AdminMenuDao) Group() string {
	return dao.group
}

// Ctx creates and returns the Model for current DAO, It automatically sets the context for current operation.
func (dao *AdminMenuDao) Ctx(ctx context.Context) *gdb.Model {
	return dao.DB().Model(dao.table).Safe().Ctx(ctx)
}

// Transaction wraps the transaction logic using function f.
// It rollbacks the transaction and returns the error from function f if it returns non-nil error.
// It commits the transaction and returns nil if function f returns nil.
//
// Note that, you should not Commit or Rollback the transaction in function f
// as it is automatically handled by this function.
func (dao *AdminMenuDao) Transaction(ctx context.Context, f func(ctx context.Context, tx gdb.TX) error) (err error) {
	return dao.Ctx(ctx).Transaction(ctx, f)
}
