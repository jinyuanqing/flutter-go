// ==========================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// ==========================================================================

package internal

import (
	"context"

	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/frame/g"
)

// ZhaoPinGongSiDao is the data access object for table zhao_pin_gong_si.
type ZhaoPinGongSiDao struct {
	table   string               // table is the underlying table name of the DAO.
	group   string               // group is the database configuration group name of current DAO.
	columns ZhaoPinGongSiColumns // columns contains all the column names of Table for convenient usage.
}

// ZhaoPinGongSiColumns defines and stores column names for table zhao_pin_gong_si.
type ZhaoPinGongSiColumns struct {
	Id                 string //
	GongsiName         string // 公司名
	GongsiFaRen        string // 法人
	GongsiJianJie      string // 简介
	GongsiYeWu         string // 业务范围
	GongsiLingYu       string // 所属领域
	GongsiPic          string // json图片,如{"pics": [{"id": "1", "picurl": "thumbnail.png"}, {"id": "2", "picurl": "thumbnail.png"}, {"id": "3", "picurl": "thumbnail.png"}]}
	GongsiXinyongdaima string // 统一社会信用代码18位
	GongsiChengliriqi  string // 成立日期
	CreatedAt          string // 只需定义字段即可.gf自动填入
	UpdatedAt          string // 只需定义字段即可.gf自动填入
}

// zhaoPinGongSiColumns holds the columns for table zhao_pin_gong_si.
var zhaoPinGongSiColumns = ZhaoPinGongSiColumns{
	Id:                 "id",
	GongsiName:         "gongsi_name",
	GongsiFaRen:        "gongsi_fa_ren",
	GongsiJianJie:      "gongsi_jian_jie",
	GongsiYeWu:         "gongsi_ye_wu",
	GongsiLingYu:       "gongsi_ling_yu",
	GongsiPic:          "gongsi_pic",
	GongsiXinyongdaima: "gongsi_xinyongdaima",
	GongsiChengliriqi:  "gongsi_chengliriqi",
	CreatedAt:          "created_at",
	UpdatedAt:          "updated_at",
}

// NewZhaoPinGongSiDao creates and returns a new DAO object for table data access.
func NewZhaoPinGongSiDao() *ZhaoPinGongSiDao {
	return &ZhaoPinGongSiDao{
		group:   "default",
		table:   "zhao_pin_gong_si",
		columns: zhaoPinGongSiColumns,
	}
}

// DB retrieves and returns the underlying raw database management object of current DAO.
func (dao *ZhaoPinGongSiDao) DB() gdb.DB {
	return g.DB(dao.group)
}

// Table returns the table name of current dao.
func (dao *ZhaoPinGongSiDao) Table() string {
	return dao.table
}

// Columns returns all column names of current dao.
func (dao *ZhaoPinGongSiDao) Columns() ZhaoPinGongSiColumns {
	return dao.columns
}

// Group returns the configuration group name of database of current dao.
func (dao *ZhaoPinGongSiDao) Group() string {
	return dao.group
}

// Ctx creates and returns the Model for current DAO, It automatically sets the context for current operation.
func (dao *ZhaoPinGongSiDao) Ctx(ctx context.Context) *gdb.Model {
	return dao.DB().Model(dao.table).Safe().Ctx(ctx)
}

// Transaction wraps the transaction logic using function f.
// It rollbacks the transaction and returns the error from function f if it returns non-nil error.
// It commits the transaction and returns nil if function f returns nil.
//
// Note that, you should not Commit or Rollback the transaction in function f
// as it is automatically handled by this function.
func (dao *ZhaoPinGongSiDao) Transaction(ctx context.Context, f func(ctx context.Context, tx gdb.TX) error) (err error) {
	return dao.Ctx(ctx).Transaction(ctx, f)
}
