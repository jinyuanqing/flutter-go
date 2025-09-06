// ==========================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// ==========================================================================

package internal

import (
	"context"

	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/frame/g"
)

// UserMenuDao is the data access object for table user_menu.
type UserMenuDao struct {
	table   string          // table is the underlying table name of the DAO.
	group   string          // group is the database configuration group name of current DAO.
	columns UserMenuColumns // columns contains all the column names of Table for convenient usage.
}

// UserMenuColumns defines and stores column names for table user_menu.
type UserMenuColumns struct {
	UserMenuName     string //
	UserMenuId       string // 应该是随意设置
	UserMenuUrl      string //
	UserMenuParentid string //
	Id               string //
	CreatedAt        string // 只需定义字段即可.gf自动填入
	UpdatedAt        string // 只需定义字段即可.gf自动填入
}

// userMenuColumns holds the columns for table user_menu.
var userMenuColumns = UserMenuColumns{
	UserMenuName:     "user_menu_name",
	UserMenuId:       "user_menu_id",
	UserMenuUrl:      "user_menu_url",
	UserMenuParentid: "user_menu_parentid",
	Id:               "id",
	CreatedAt:        "created_at",
	UpdatedAt:        "updated_at",
}

// NewUserMenuDao creates and returns a new DAO object for table data access.
func NewUserMenuDao() *UserMenuDao {
	return &UserMenuDao{
		group:   "default",
		table:   "user_menu",
		columns: userMenuColumns,
	}
}

// DB retrieves and returns the underlying raw database management object of current DAO.
func (dao *UserMenuDao) DB() gdb.DB {
	return g.DB(dao.group)
}

// Table returns the table name of current dao.
func (dao *UserMenuDao) Table() string {
	return dao.table
}

// Columns returns all column names of current dao.
func (dao *UserMenuDao) Columns() UserMenuColumns {
	return dao.columns
}

// Group returns the configuration group name of database of current dao.
func (dao *UserMenuDao) Group() string {
	return dao.group
}

// Ctx creates and returns the Model for current DAO, It automatically sets the context for current operation.
func (dao *UserMenuDao) Ctx(ctx context.Context) *gdb.Model {
	return dao.DB().Model(dao.table).Safe().Ctx(ctx)
}

// Transaction wraps the transaction logic using function f.
// It rollbacks the transaction and returns the error from function f if it returns non-nil error.
// It commits the transaction and returns nil if function f returns nil.
//
// Note that, you should not Commit or Rollback the transaction in function f
// as it is automatically handled by this function.
func (dao *UserMenuDao) Transaction(ctx context.Context, f func(ctx context.Context, tx gdb.TX) error) (err error) {
	return dao.Ctx(ctx).Transaction(ctx, f)
}
