// ==========================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// ==========================================================================

package internal

import (
	"context"

	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/frame/g"
)

// WenzhangfenleiDao is the data access object for table wenzhangfenlei.
type WenzhangfenleiDao struct {
	table   string                // table is the underlying table name of the DAO.
	group   string                // group is the database configuration group name of current DAO.
	columns WenzhangfenleiColumns // columns contains all the column names of Table for convenient usage.
}

// WenzhangfenleiColumns defines and stores column names for table wenzhangfenlei.
type WenzhangfenleiColumns struct {
	Id         string // 分类名称对应的id,也作为查询文章分类的表名.分类的表名命名规则wen_zhang_fenlei_id
	FenleiName string // 文章分类名称
	CreatedAt  string // 只需定义字段即可.gf自动填入
	UpdatedAt  string // 只需定义字段即可.gf自动填入
}

// wenzhangfenleiColumns holds the columns for table wenzhangfenlei.
var wenzhangfenleiColumns = WenzhangfenleiColumns{
	Id:         "id",
	FenleiName: "fenlei_name",
	CreatedAt:  "created_at",
	UpdatedAt:  "updated_at",
}

// NewWenzhangfenleiDao creates and returns a new DAO object for table data access.
func NewWenzhangfenleiDao() *WenzhangfenleiDao {
	return &WenzhangfenleiDao{
		group:   "default",
		table:   "wenzhangfenlei",
		columns: wenzhangfenleiColumns,
	}
}

// DB retrieves and returns the underlying raw database management object of current DAO.
func (dao *WenzhangfenleiDao) DB() gdb.DB {
	return g.DB(dao.group)
}

// Table returns the table name of current dao.
func (dao *WenzhangfenleiDao) Table() string {
	return dao.table
}

// Columns returns all column names of current dao.
func (dao *WenzhangfenleiDao) Columns() WenzhangfenleiColumns {
	return dao.columns
}

// Group returns the configuration group name of database of current dao.
func (dao *WenzhangfenleiDao) Group() string {
	return dao.group
}

// Ctx creates and returns the Model for current DAO, It automatically sets the context for current operation.
func (dao *WenzhangfenleiDao) Ctx(ctx context.Context) *gdb.Model {
	return dao.DB().Model(dao.table).Safe().Ctx(ctx)
}

// Transaction wraps the transaction logic using function f.
// It rollbacks the transaction and returns the error from function f if it returns non-nil error.
// It commits the transaction and returns nil if function f returns nil.
//
// Note that, you should not Commit or Rollback the transaction in function f
// as it is automatically handled by this function.
func (dao *WenzhangfenleiDao) Transaction(ctx context.Context, f func(ctx context.Context, tx gdb.TX) error) (err error) {
	return dao.Ctx(ctx).Transaction(ctx, f)
}
