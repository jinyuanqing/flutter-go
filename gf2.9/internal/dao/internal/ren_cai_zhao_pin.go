// ==========================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// ==========================================================================

package internal

import (
	"context"

	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/frame/g"
)

// RenCaiZhaoPinDao is the data access object for table ren_cai_zhao_pin.
type RenCaiZhaoPinDao struct {
	table   string               // table is the underlying table name of the DAO.
	group   string               // group is the database configuration group name of current DAO.
	columns RenCaiZhaoPinColumns // columns contains all the column names of Table for convenient usage.
}

// RenCaiZhaoPinColumns defines and stores column names for table ren_cai_zhao_pin.
type RenCaiZhaoPinColumns struct {
	Id              string //
	GongSiMing      string // 招聘的公司名
	Gangwei         string // 岗位
	Renshu          string // 招聘人数
	Xueli           string // 学历
	Yaoqiu          string // 要求
	Baoxian         string // 包括:五险一金,包吃, 加班补助 包住 饭补 交通补助 年底双薪 周末双休
	Xinchou         string // 薪酬
	Lianxifangshi   string // 联系方式
	CreatedAt       string // 只需定义字段即可.gf自动填入
	UpdatedAt       string // 只需定义字段即可.gf自动填入
	Liulanshu       string // 浏览数
	YingpinzheId    string // 应聘者id字符串.使用逗号分隔.插入时需要加逗号
	Kaishishijian   string // 招聘的开始时间
	Jieshushijian   string // 招聘的结束时间
	Youxiang        string // 接收简历通知的邮箱
	Qita            string // 其他,备用
	Quanzhi         string // 全职兼职
	Dizhi           string // 招聘地址
	Gongzuonianxian string // 工作年限
	Tupian          string // 图片json
	Zuozhe          string // 发布者
	Zhiding         string // 置顶,默认字符串0
	Jinghua         string // 精华,默认字符串0
}

// renCaiZhaoPinColumns holds the columns for table ren_cai_zhao_pin.
var renCaiZhaoPinColumns = RenCaiZhaoPinColumns{
	Id:              "id",
	GongSiMing:      "gong_si_ming",
	Gangwei:         "gangwei",
	Renshu:          "renshu",
	Xueli:           "xueli",
	Yaoqiu:          "yaoqiu",
	Baoxian:         "baoxian",
	Xinchou:         "xinchou",
	Lianxifangshi:   "lianxifangshi",
	CreatedAt:       "created_at",
	UpdatedAt:       "updated_at",
	Liulanshu:       "liulanshu",
	YingpinzheId:    "yingpinzhe_id",
	Kaishishijian:   "kaishishijian",
	Jieshushijian:   "jieshushijian",
	Youxiang:        "youxiang",
	Qita:            "qita",
	Quanzhi:         "quanzhi",
	Dizhi:           "dizhi",
	Gongzuonianxian: "gongzuonianxian",
	Tupian:          "tupian",
	Zuozhe:          "zuozhe",
	Zhiding:         "zhiding",
	Jinghua:         "jinghua",
}

// NewRenCaiZhaoPinDao creates and returns a new DAO object for table data access.
func NewRenCaiZhaoPinDao() *RenCaiZhaoPinDao {
	return &RenCaiZhaoPinDao{
		group:   "default",
		table:   "ren_cai_zhao_pin",
		columns: renCaiZhaoPinColumns,
	}
}

// DB retrieves and returns the underlying raw database management object of current DAO.
func (dao *RenCaiZhaoPinDao) DB() gdb.DB {
	return g.DB(dao.group)
}

// Table returns the table name of current dao.
func (dao *RenCaiZhaoPinDao) Table() string {
	return dao.table
}

// Columns returns all column names of current dao.
func (dao *RenCaiZhaoPinDao) Columns() RenCaiZhaoPinColumns {
	return dao.columns
}

// Group returns the configuration group name of database of current dao.
func (dao *RenCaiZhaoPinDao) Group() string {
	return dao.group
}

// Ctx creates and returns the Model for current DAO, It automatically sets the context for current operation.
func (dao *RenCaiZhaoPinDao) Ctx(ctx context.Context) *gdb.Model {
	return dao.DB().Model(dao.table).Safe().Ctx(ctx)
}

// Transaction wraps the transaction logic using function f.
// It rollbacks the transaction and returns the error from function f if it returns non-nil error.
// It commits the transaction and returns nil if function f returns nil.
//
// Note that, you should not Commit or Rollback the transaction in function f
// as it is automatically handled by this function.
func (dao *RenCaiZhaoPinDao) Transaction(ctx context.Context, f func(ctx context.Context, tx gdb.TX) error) (err error) {
	return dao.Ctx(ctx).Transaction(ctx, f)
}
