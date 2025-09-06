// ==========================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// ==========================================================================

package internal

import (
	"context"

	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/frame/g"
)

// Admin1Dao is the data access object for table admin1无用.
type Admin1Dao struct {
	table   string        // table is the underlying table name of the DAO.
	group   string        // group is the database configuration group name of current DAO.
	columns Admin1Columns // columns contains all the column names of Table for convenient usage.
}

// Admin1Columns defines and stores column names for table admin1无用.
type Admin1Columns struct {
	Id        string //
	Username  string // 管理员用户名,长度10
	Password  string // 密码,长度10
	CreatedAt string // 只需定义字段即可.gf自动填入
	UpdatedAt string // 只需定义字段即可.gf自动填入
}

// admin1Columns holds the columns for table admin1无用.
var admin1Columns = Admin1Columns{
	Id:        "id",
	Username:  "username",
	Password:  "password",
	CreatedAt: "created_at",
	UpdatedAt: "updated_at",
}

// NewAdmin1Dao creates and returns a new DAO object for table data access.
func NewAdmin1Dao() *Admin1Dao {
	return &Admin1Dao{
		group:   "default",
		table:   "admin1无用",
		columns: admin1Columns,
	}
}

// DB retrieves and returns the underlying raw database management object of current DAO.
func (dao *Admin1Dao) DB() gdb.DB {
	return g.DB(dao.group)
}

// Table returns the table name of current dao.
func (dao *Admin1Dao) Table() string {
	return dao.table
}

// Columns returns all column names of current dao.
func (dao *Admin1Dao) Columns() Admin1Columns {
	return dao.columns
}

// Group returns the configuration group name of database of current dao.
func (dao *Admin1Dao) Group() string {
	return dao.group
}

// Ctx creates and returns the Model for current DAO, It automatically sets the context for current operation.
func (dao *Admin1Dao) Ctx(ctx context.Context) *gdb.Model {
	return dao.DB().Model(dao.table).Safe().Ctx(ctx)
}

// Transaction wraps the transaction logic using function f.
// It rollbacks the transaction and returns the error from function f if it returns non-nil error.
// It commits the transaction and returns nil if function f returns nil.
//
// Note that, you should not Commit or Rollback the transaction in function f
// as it is automatically handled by this function.
func (dao *Admin1Dao) Transaction(ctx context.Context, f func(ctx context.Context, tx gdb.TX) error) (err error) {
	return dao.Ctx(ctx).Transaction(ctx, f)
}
