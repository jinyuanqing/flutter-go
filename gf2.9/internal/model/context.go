package model

// 在控制器和服务里调用,定义了输入输出数据结构.来自于model-entity-admin.go
//上下文在service中被封装修改,服务和控制器可以获取
// session一般存放每个链接私有的数据，如每个登录账户的个性设置、账户信息等等。

// context一般存放所有链接公有的数据，如本系统所有链接都要用到的各种公有数据。

// 应用场景不同，如果用session存放公有数据，那么会大量浪费内存；如果用context存放私有数据，那么会存在数据泄密风险
import (
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/net/ghttp"
	"github.com/gogf/gf/v2/os/gtime"
	// "github.com/casbin/casbin/v2"
)

const (
	// 上下文变量存储键名，前后端系统共享.上下文的值通过此键ContextKey进行获取和设置
	ContextKey = "ContextKey"
)

type Context struct {
	Session *ghttp.Session // Session in context.
	User    *ContextUser   // User in context.
	Data    g.Map          // 自定KV变量，业务模块根据需要设置，不固定
}

type ContextUser struct { //
	// 请求上下文中的用户信息
	Id       uint   // User ID.
	Username string // User passport.
	Nickname string // User nickname.
	Is_admin bool   //是否是管理员
	Qianming string //签名
	// Casbin_Enforcer *casbin.Enforcer
}

type Admin_api_adminmenu_Res struct { //决定了输出菜单的结构体.但是实际最终显示的是结构体切片
	Id        int
	MenuId    int
	MenuUrl   string
	MenuName  string
	MenuClass string
	ParentId  int
	Icon      []byte // 图标
	Sort      uint
	Isshow    bool
	CreatedAt *gtime.Time
	UpdatedAt *gtime.Time
	// Menupath string
	Children []Admin_api_adminmenu_Res
}
