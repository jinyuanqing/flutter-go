// ==========================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// ==========================================================================

package internal

import (
	"context"

	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/frame/g"
)

// UserDao is the data access object for table user.
type UserDao struct {
	table   string      // table is the underlying table name of the DAO.
	group   string      // group is the database configuration group name of current DAO.
	columns UserColumns // columns contains all the column names of Table for convenient usage.
}

// UserColumns defines and stores column names for table user.
type UserColumns struct {
	Id           string // User ID
	Username     string // 通行证/用户名
	Password     string // 密码
	Email        string // 邮箱
	Address      string // 地址
	Nickname     string // 昵称
	Tel          string // 电话
	Birthday     string // 出生日期
	Beiyong1     string // 备用.用户是否被禁用
	Sex          string // 性别0/1.1男0女
	Qianming     string // 签名
	Shenfenzheng string // 身份证号
	Ip           string // 最后登录ip
	Touxiang     string // 头像
	Jifen        string // 积分
	Isadmin      string // 管理员.布尔.1管理,0普通
	Apinum       string // 访问api的次数上限
	Isused       string // 用户是否启用.0禁止1启用 bool
	Apiused      string // 已经使用了多少次api.默认0
	CreateAt     string // 只需定义字段即可.gf自动填入
	UpdateAt     string // 只需定义字段即可.gf自动填入
}

// userColumns holds the columns for table user.
var userColumns = UserColumns{
	Id:           "id",
	Username:     "username",
	Password:     "password",
	Email:        "email",
	Address:      "address",
	Nickname:     "nickname",
	Tel:          "tel",
	Birthday:     "birthday",
	Beiyong1:     "beiyong1",
	Sex:          "sex",
	Qianming:     "qianming",
	Shenfenzheng: "shenfenzheng",
	Ip:           "ip",
	Touxiang:     "touxiang",
	Jifen:        "jifen",
	Isadmin:      "isadmin",
	Apinum:       "apinum",
	Isused:       "isused",
	Apiused:      "apiused",
	CreateAt:     "create_at",
	UpdateAt:     "update_at",
}

// NewUserDao creates and returns a new DAO object for table data access.
func NewUserDao() *UserDao {
	return &UserDao{
		group:   "default",
		table:   "user",
		columns: userColumns,
	}
}

// DB retrieves and returns the underlying raw database management object of current DAO.
func (dao *UserDao) DB() gdb.DB {
	return g.DB(dao.group)
}

// Table returns the table name of current dao.
func (dao *UserDao) Table() string {
	return dao.table
}

// Columns returns all column names of current dao.
func (dao *UserDao) Columns() UserColumns {
	return dao.columns
}

// Group returns the configuration group name of database of current dao.
func (dao *UserDao) Group() string {
	return dao.group
}

// Ctx creates and returns the Model for current DAO, It automatically sets the context for current operation.
func (dao *UserDao) Ctx(ctx context.Context) *gdb.Model {
	return dao.DB().Model(dao.table).Safe().Ctx(ctx)
}

// Transaction wraps the transaction logic using function f.
// It rollbacks the transaction and returns the error from function f if it returns non-nil error.
// It commits the transaction and returns nil if function f returns nil.
//
// Note that, you should not Commit or Rollback the transaction in function f
// as it is automatically handled by this function.
func (dao *UserDao) Transaction(ctx context.Context, f func(ctx context.Context, tx gdb.TX) error) (err error) {
	return dao.Ctx(ctx).Transaction(ctx, f)
}
