// ==========================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// ==========================================================================

package internal

import (
	"context"

	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/frame/g"
)

// UserApiLimitDao is the data access object for table user_api_limit.
type UserApiLimitDao struct {
	table   string              // table is the underlying table name of the DAO.
	group   string              // group is the database configuration group name of current DAO.
	columns UserApiLimitColumns // columns contains all the column names of Table for convenient usage.
}

// UserApiLimitColumns defines and stores column names for table user_api_limit.
type UserApiLimitColumns struct {
	Id         string //
	Uid        string //
	Url        string // 接口的路由   ,如{"urls": [{"id": "1", "url": "/hello"}, {"id": "2", "url": "/readdata"}, ]}
	Maxnum     string // 当前接口最大次数数量
	Currentnum string // 当前使用的接口次数数量
	Isopen     string // 0禁止1开启限制
	Ismax      string // 0未达到最大限制1达到了最大次数限制
	CreatedAt  string // 只需定义字段即可.gf自动填入
	UpdatedAt  string // 只需定义字段即可.gf自动填入
}

// userApiLimitColumns holds the columns for table user_api_limit.
var userApiLimitColumns = UserApiLimitColumns{
	Id:         "id",
	Uid:        "uid",
	Url:        "url",
	Maxnum:     "maxnum",
	Currentnum: "currentnum",
	Isopen:     "isopen",
	Ismax:      "ismax",
	CreatedAt:  "created_at",
	UpdatedAt:  "updated_at",
}

// NewUserApiLimitDao creates and returns a new DAO object for table data access.
func NewUserApiLimitDao() *UserApiLimitDao {
	return &UserApiLimitDao{
		group:   "default",
		table:   "user_api_limit",
		columns: userApiLimitColumns,
	}
}

// DB retrieves and returns the underlying raw database management object of current DAO.
func (dao *UserApiLimitDao) DB() gdb.DB {
	return g.DB(dao.group)
}

// Table returns the table name of current dao.
func (dao *UserApiLimitDao) Table() string {
	return dao.table
}

// Columns returns all column names of current dao.
func (dao *UserApiLimitDao) Columns() UserApiLimitColumns {
	return dao.columns
}

// Group returns the configuration group name of database of current dao.
func (dao *UserApiLimitDao) Group() string {
	return dao.group
}

// Ctx creates and returns the Model for current DAO, It automatically sets the context for current operation.
func (dao *UserApiLimitDao) Ctx(ctx context.Context) *gdb.Model {
	return dao.DB().Model(dao.table).Safe().Ctx(ctx)
}

// Transaction wraps the transaction logic using function f.
// It rollbacks the transaction and returns the error from function f if it returns non-nil error.
// It commits the transaction and returns nil if function f returns nil.
//
// Note that, you should not Commit or Rollback the transaction in function f
// as it is automatically handled by this function.
func (dao *UserApiLimitDao) Transaction(ctx context.Context, f func(ctx context.Context, tx gdb.TX) error) (err error) {
	return dao.Ctx(ctx).Transaction(ctx, f)
}
