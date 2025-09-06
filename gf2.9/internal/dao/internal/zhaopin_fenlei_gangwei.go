// ==========================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// ==========================================================================

package internal

import (
	"context"

	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/frame/g"
)

// ZhaopinFenleiGangweiDao is the data access object for table zhaopin_fenlei_gangwei.
type ZhaopinFenleiGangweiDao struct {
	table   string                      // table is the underlying table name of the DAO.
	group   string                      // group is the database configuration group name of current DAO.
	columns ZhaopinFenleiGangweiColumns // columns contains all the column names of Table for convenient usage.
}

// ZhaopinFenleiGangweiColumns defines and stores column names for table zhaopin_fenlei_gangwei.
type ZhaopinFenleiGangweiColumns struct {
	Id        string //
	FenLei    string // 招聘岗位分类.如销售分类
	GangWeiId string // 分类下属的细分岗位.如销售分类的楼房销售
	CreatedAt string // 只需定义字段即可.gf自动填入
	UpdatedAt string // 只需定义字段即可.gf自动填入
}

// zhaopinFenleiGangweiColumns holds the columns for table zhaopin_fenlei_gangwei.
var zhaopinFenleiGangweiColumns = ZhaopinFenleiGangweiColumns{
	Id:        "id",
	FenLei:    "fen_lei",
	GangWeiId: "gang_wei_id",
	CreatedAt: "created_at",
	UpdatedAt: "updated_at",
}

// NewZhaopinFenleiGangweiDao creates and returns a new DAO object for table data access.
func NewZhaopinFenleiGangweiDao() *ZhaopinFenleiGangweiDao {
	return &ZhaopinFenleiGangweiDao{
		group:   "default",
		table:   "zhaopin_fenlei_gangwei",
		columns: zhaopinFenleiGangweiColumns,
	}
}

// DB retrieves and returns the underlying raw database management object of current DAO.
func (dao *ZhaopinFenleiGangweiDao) DB() gdb.DB {
	return g.DB(dao.group)
}

// Table returns the table name of current dao.
func (dao *ZhaopinFenleiGangweiDao) Table() string {
	return dao.table
}

// Columns returns all column names of current dao.
func (dao *ZhaopinFenleiGangweiDao) Columns() ZhaopinFenleiGangweiColumns {
	return dao.columns
}

// Group returns the configuration group name of database of current dao.
func (dao *ZhaopinFenleiGangweiDao) Group() string {
	return dao.group
}

// Ctx creates and returns the Model for current DAO, It automatically sets the context for current operation.
func (dao *ZhaopinFenleiGangweiDao) Ctx(ctx context.Context) *gdb.Model {
	return dao.DB().Model(dao.table).Safe().Ctx(ctx)
}

// Transaction wraps the transaction logic using function f.
// It rollbacks the transaction and returns the error from function f if it returns non-nil error.
// It commits the transaction and returns nil if function f returns nil.
//
// Note that, you should not Commit or Rollback the transaction in function f
// as it is automatically handled by this function.
func (dao *ZhaopinFenleiGangweiDao) Transaction(ctx context.Context, f func(ctx context.Context, tx gdb.TX) error) (err error) {
	return dao.Ctx(ctx).Transaction(ctx, f)
}
