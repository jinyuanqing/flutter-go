// ==========================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// ==========================================================================

package internal

import (
	"context"

	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/frame/g"
)

// WenZhangPingLunDao is the data access object for table wen_zhang_ping_lun.
type WenZhangPingLunDao struct {
	table   string                 // table is the underlying table name of the DAO.
	group   string                 // group is the database configuration group name of current DAO.
	columns WenZhangPingLunColumns // columns contains all the column names of Table for convenient usage.
}

// WenZhangPingLunColumns defines and stores column names for table wen_zhang_ping_lun.
type WenZhangPingLunColumns struct {
	Id             string //
	WenZhangId     string // 文章id
	PingLunRen     string // 评论人
	Pinglunneirong string // 评论内容
	CreateAt       string //
	UpdateAt       string //
}

// wenZhangPingLunColumns holds the columns for table wen_zhang_ping_lun.
var wenZhangPingLunColumns = WenZhangPingLunColumns{
	Id:             "id",
	WenZhangId:     "wen_zhang_id",
	PingLunRen:     "ping_lun_ren",
	Pinglunneirong: "pinglunneirong",
	CreateAt:       "create_at",
	UpdateAt:       "update_at",
}

// NewWenZhangPingLunDao creates and returns a new DAO object for table data access.
func NewWenZhangPingLunDao() *WenZhangPingLunDao {
	return &WenZhangPingLunDao{
		group:   "default",
		table:   "wen_zhang_ping_lun",
		columns: wenZhangPingLunColumns,
	}
}

// DB retrieves and returns the underlying raw database management object of current DAO.
func (dao *WenZhangPingLunDao) DB() gdb.DB {
	return g.DB(dao.group)
}

// Table returns the table name of current dao.
func (dao *WenZhangPingLunDao) Table() string {
	return dao.table
}

// Columns returns all column names of current dao.
func (dao *WenZhangPingLunDao) Columns() WenZhangPingLunColumns {
	return dao.columns
}

// Group returns the configuration group name of database of current dao.
func (dao *WenZhangPingLunDao) Group() string {
	return dao.group
}

// Ctx creates and returns the Model for current DAO, It automatically sets the context for current operation.
func (dao *WenZhangPingLunDao) Ctx(ctx context.Context) *gdb.Model {
	return dao.DB().Model(dao.table).Safe().Ctx(ctx)
}

// Transaction wraps the transaction logic using function f.
// It rollbacks the transaction and returns the error from function f if it returns non-nil error.
// It commits the transaction and returns nil if function f returns nil.
//
// Note that, you should not Commit or Rollback the transaction in function f
// as it is automatically handled by this function.
func (dao *WenZhangPingLunDao) Transaction(ctx context.Context, f func(ctx context.Context, tx gdb.TX) error) (err error) {
	return dao.Ctx(ctx).Transaction(ctx, f)
}
