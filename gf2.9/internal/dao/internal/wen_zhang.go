// ==========================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// ==========================================================================

package internal

import (
	"context"

	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/frame/g"
)

// WenZhangDao is the data access object for table wen_zhang.
type WenZhangDao struct {
	table   string          // table is the underlying table name of the DAO.
	group   string          // group is the database configuration group name of current DAO.
	columns WenZhangColumns // columns contains all the column names of Table for convenient usage.
}

// WenZhangColumns defines and stores column names for table wen_zhang.
type WenZhangColumns struct {
	Id         string //
	Biaoti     string // 汉字长度25.标题
	Zuozhe     string // 汉字长度25.作者
	Zhaiyao    string // 汉字长度50.摘要
	Suoluetu   string // 为字符串,长度30.缩略图
	Neirong    string // 汉字长度65535/2.内容
	Yuedushu   string // 阅读数
	Dianzanshu string // 点赞数
	Fenleiid   string // 分类id
	Zhiding    string // 置顶0/1.字符的1和0
	Jinghua    string // 精华0/1.字符的1和0
	Shanchu    string // 是否删除.1和0,mysql的bool类型
	CreatedAt  string // 长度18,形如:2021-03-01 20:21:00  固定时间,gf会自动写入
	UpdatedAt  string // 固定时间,gf会自动写入
}

// wenZhangColumns holds the columns for table wen_zhang.
var wenZhangColumns = WenZhangColumns{
	Id:         "id",
	Biaoti:     "biaoti",
	Zuozhe:     "zuozhe",
	Zhaiyao:    "zhaiyao",
	Suoluetu:   "suoluetu",
	Neirong:    "neirong",
	Yuedushu:   "yuedushu",
	Dianzanshu: "dianzanshu",
	Fenleiid:   "fenleiid",
	Zhiding:    "zhiding",
	Jinghua:    "jinghua",
	Shanchu:    "shanchu",
	CreatedAt:  "created_at",
	UpdatedAt:  "updated_at",
}

// NewWenZhangDao creates and returns a new DAO object for table data access.
func NewWenZhangDao() *WenZhangDao {
	return &WenZhangDao{
		group:   "default",
		table:   "wen_zhang",
		columns: wenZhangColumns,
	}
}

// DB retrieves and returns the underlying raw database management object of current DAO.
func (dao *WenZhangDao) DB() gdb.DB {
	return g.DB(dao.group)
}

// Table returns the table name of current dao.
func (dao *WenZhangDao) Table() string {
	return dao.table
}

// Columns returns all column names of current dao.
func (dao *WenZhangDao) Columns() WenZhangColumns {
	return dao.columns
}

// Group returns the configuration group name of database of current dao.
func (dao *WenZhangDao) Group() string {
	return dao.group
}

// Ctx creates and returns the Model for current DAO, It automatically sets the context for current operation.
func (dao *WenZhangDao) Ctx(ctx context.Context) *gdb.Model {
	return dao.DB().Model(dao.table).Safe().Ctx(ctx)
}

// Transaction wraps the transaction logic using function f.
// It rollbacks the transaction and returns the error from function f if it returns non-nil error.
// It commits the transaction and returns nil if function f returns nil.
//
// Note that, you should not Commit or Rollback the transaction in function f
// as it is automatically handled by this function.
func (dao *WenZhangDao) Transaction(ctx context.Context, f func(ctx context.Context, tx gdb.TX) error) (err error) {
	return dao.Ctx(ctx).Transaction(ctx, f)
}
