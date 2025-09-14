package v1

// *api定义中写表中的所有字段,然后控制器中引入api的定义的结构体.logi中引入model中创建的模型表文件中的结构体字段
//对外提供服务的输入/输出数据结构定义.可以对页面输入字段进行取舍
import (
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
	//  "github.com/gogf/gf-demo-user/v2/internal/model/entity"
)

type Admin_delete_menu_according_to_id_Req struct { //在控制器中admin.go中对应,在postman中url中直接请求的url.get方法可在浏览器中渲染模板.post方法可作为api接口.仿佛是控制器调用了该结构的方法名作为访问url后调用的方法
	g.Meta  `path:"/admin_delete_menu_according_to_id" method:"post" tags:"管理员"  summary:"根据id删除菜单"`
	Id_menu int //菜单id
}

type Admin_delete_menu_according_to_id_Res struct {
}

type Admin_get_menu_according_to_id_Req struct { //在控制器中admin.go中对应,在postman中url中直接请求的url.get方法可在浏览器中渲染模板.post方法可作为api接口.仿佛是控制器调用了该结构的方法名作为访问url后调用的方法
	g.Meta  `path:"/admin_get_menu_according_to_id" method:"post" tags:"管理员"  summary:"根据id获取菜单"`
	Id_menu int //菜单id
}

type Admin_get_menu_according_to_id_Res struct {
}

type Admin_insert_menu_Req struct { //在控制器中admin.go中对应,在postman中url中直接请求的url.get方法可在浏览器中渲染模板.post方法可作为api接口.仿佛是控制器调用了该结构的方法名作为访问url后调用的方法
	g.Meta   `path:"/admin_insert_menu" method:"post" tags:"管理员"  summary:"插入一级,二级菜单"`
	Username string //`json:"username" ` // 用户名

	MenuUrl   string
	MenuName  string
	ParentId  int
	Icon      []byte // 图标
	Sort      uint
	Isshow    bool
	CreatedAt *gtime.Time
	UpdatedAt *gtime.Time
}

type Admin_insert_menu_Res struct {
}

type Admin_modify_menu_Req struct { //在控制器中admin.go中对应,在postman中url中直接请求的url.get方法可在浏览器中渲染模板.post方法可作为api接口.仿佛是控制器调用了该结构的方法名作为访问url后调用的方法
	g.Meta `path:"/admin_modify_menu" method:"post" tags:"管理员"  summary:"修改一级,二级菜单,根据菜单id"`
	//Username string //`json:"username" ` // 用户名
	Id        int //菜单id
	MenuUrl   string
	MenuName  string
	ParentId  int
	Icon      []byte // 图标
	Sort      uint
	Isshow    bool
	CreatedAt *gtime.Time
	UpdatedAt *gtime.Time
}

type Admin_modify_menu_Res struct {
}

type Admin_get_userinfo_Req struct { //在控制器中admin.go中对应,在postman中url中直接请求的url.get方法可在浏览器中渲染模板.post方法可作为api接口.仿佛是控制器调用了该结构的方法名作为访问url后调用的方法
	g.Meta   `path:"/admin_get_userinfo" method:"post" tags:"管理员"  summary:"根据用户名,用户id,昵称获取用户信息"`
	Username string //`json:"username" ` // 用户名
	Nickname string //`json:"nickname" ` // 用户昵称
	Userid   string //` json:"userid" `  // 用户id1

}

type Admin_get_userinfo_Res struct {
}

type Admin_update_user_Req struct { //在控制器中admin.go中对应,在postman中url中直接请求的url.get方法可在浏览器中渲染模板.post方法可作为api接口.仿佛是控制器调用了该结构的方法名作为访问url后调用的方法
	g.Meta   `path:"/admin_update_user" method:"post" tags:"管理员"  summary:"修改用户信息"`
	Id       int    //  `v:"required"`// 用户id
	Username string // `v:"required"` // 用户信息
	Address  string //`v:"required"` // 地址
	Tel      string //`v:"required"` //Tel

	Password string // `v:"required"` // 密码
	Email    string // `v:"required"` // 邮箱

	Nickname string // `v:"required"` // 昵称

	Birthday     string //`v:"required"` // 出生日期
	Beiyong1     string // `v:"required"` // 备用
	Sex          string // `v:"required"` // 性别
	Qianming     string // `v:"required"` // 签名
	Shenfenzheng string //`v:"required"` // 身份证号
	Ip           string // `v:"required"` // 最后登录ip
	Touxiang     string // `v:"required"` // 头像
	Jifen        string // `v:"required"` // 积分

}

type Admin_update_user_Res struct {
}
type Admin_set_user_authority_Req struct { //在控制器中admin.go中对应,在postman中url中直接请求的url.get方法可在浏览器中渲染模板.post方法可作为api接口.仿佛是控制器调用了该结构的方法名作为访问url后调用的方法
	g.Meta   `path:"/set_user_authority" method:"post" tags:"管理员"  summary:"设置角色user的权限"`
	Rolename string //`v:"required"` //  角色名称

	Add_authorrity g.Array //增加的权限列表
	Del_authorrity g.Array //删除的权限列表
}
type Admin_set_user_authority_Res struct {
}
type Admin_get_user_authority_Req struct { //在控制器中admin.go中对应,在postman中url中直接请求的url.get方法可在浏览器中渲染模板.post方法可作为api接口.仿佛是控制器调用了该结构的方法名作为访问url后调用的方法
	g.Meta   `path:"/get_user_authority" method:"post" tags:"管理员"  summary:" 获取角色user的权限"`
	Rolename string //`v:"required"` //  角色名称

}

type Admin_get_user_authority_Res struct {
}

type Admin_get_user_Req struct { //在控制器中admin.go中对应,在postman中url中直接请求的url.get方法可在浏览器中渲染模板.post方法可作为api接口.仿佛是控制器调用了该结构的方法名作为访问url后调用的方法
	g.Meta `path:"/admin_get_user" method:"post" tags:"管理员"  summary:"根据id获取用户信息"`
	Id     int `v:"required"` // 用户id

}

type Admin_get_user_Res struct {
}
type Admin_api_adminmenu_role_Req struct { //在控制器中admin.go中对应,在postman中url中直接请求的url.get方法可在浏览器中渲染模板.post方法可作为api接口.仿佛是控制器调用了该结构的方法名作为访问url后调用的方法
	g.Meta `path:"/admin_Get_menu_according_to_role" method:"post" tags:"管理员"  summary:"根据角色获取后台菜单"`
	Role   string `v:"required"`
}

type Admin_api_adminmenu_Req struct { //在控制器中admin.go中对应,在postman中url中直接请求的url.get方法可在浏览器中渲染模板.post方法可作为api接口.仿佛是控制器调用了该结构的方法名作为访问url后调用的方法
	g.Meta `path:"/admin_menu" method:"post" tags:"管理员"  summary:"获取后台有权限菜单"`
	//Username string `v:"required"`
	// Password string
	// Sub string
	// Obj string
	// Act string

}

type Admin_api_menu_Res struct { //决定了输出菜单的结构体.但是实际最终显示的是结构体切片

}

type Admin_allmenu_Req struct {
	g.Meta `path:"/admin_all_menu" method:"post" tags:"管理员"  summary:"获取后台所有菜单,不分权限"`
	//Username string `v:"required"`
	// Password string
	// Sub string
	// Obj string
	// Act string

}

type Admin_allmenu_Res struct {
}

type Admin_set_article_fenlei_Req struct {
	g.Meta     `path:"/admin_set_article_fenlei" method:"post" tags:"管理员" summary:"设置文章分类后,返回现有所有分类"`
	Fenleiname string `v:"required"` //分类名
}
type Admin_set_article_fenlei_Res struct {

	// Name    string
	// FileUrl string
}

type Admin8upload8article8Req struct {
	g.Meta `path:"/upload8article" method:"post" tags:"管理员" summary:"上传文章"`
	// gdb模块支持对数据记录的写入、更新、删除时间自动填充，提高开发维护效率。为了便于时间字段名称、类型的统一维护，如果使用该特性，我们约定：

	// 字段应当设置允许值为null。
	// 字段的类型必须为时间类型，如:date,  datetime,  timestamp。不支持数字类型字段，如int。
	// 字段的名称不支持自定义设置，并且固定名称约定为：
	// created_at用于记录创建时更新，仅会写入一次。
	// updated_at用于记录修改时更新，每次记录变更时更新。
	// deleted_at用于记录的软删除特性，只有当记录删除时会写入一次。
	Id         int         //
	Biaoti     string      // 汉字长度25
	Zuozhe     string      // 汉字长度25
	Zhaiyao    string      // 汉字长度50
	Created_at *gtime.Time //  不用设置时间,gf自动设定
	Updated_at *gtime.Time
	Suoluetu   string // 为字符串,长度30
	Neirong    string // 汉字长度65535/2
	Yuedushu   int    // 阅读数
	Fenleiid   int    // 分类id
}
type Admin8upload8article8Res struct { //返回文件名和路径

}

type Admin0get0all0article0Req struct {
	g.Meta `path:"/admin_get_all_article" method:"get" tags:"管理员" summary:"获取全部文章和数量" `

	Page int `json:"page" `
}
type Admin0get0all0article0Res struct {
}

type Admin0get0article0num0Req struct {
	g.Meta `path:"/admin_get_article_num" method:"get" tags:"管理员" summary:"获取全部文章数量" `
	Zuozhe string //`json:"zuozhe"`
}
type Admin0get0article0num0Res struct {
	Num int //返回文章数量
}

type Admin0get0article0Req struct {
	g.Meta   `path:"/admin_get_article" method:"get" tags:"管理员" summary:"获取指定数量的文章" `
	Page     int //指定获取文章的数量,page是页数从1开始.
	Fenleiid int `d:1 ` //参数默认1
}
type Admin0get0article0Res struct { //

}

type Admin0query0article0Req struct {
	g.Meta `path:"/admin_query_article" method:"post" tags:"管理员" summary:"获取指定条件的文章,用于搜索" `
	// Tiaojian   g.Map //map的条件 则发送时候的参数需要是Tiaojian[0]=x&Tiaojian[1]=x&Tiaojian[2]=x.如果直接发送多个参数,这里的参数可以不用写.直接代码里r.get().map()即可
	Biaoti   string //`json:"biaoti"  description:"标题"` // 汉字长度25
	Zuozhe   string // 汉字长度25
	Riqi1    string // 汉字长度50
	Riqi2    string //  不用设置时间,gf自动设定
	Fenleiid int    // 分类id
	Page     int    //页数
	Id       int    //id根据id查询
}
type Admin0query0article0Res struct { //

}

type AdminupdatearticleReq struct {
	g.Meta `path:"/update_article" method:"post" tags:"管理员" summary:"修改文章"`
	// gdb模块支持对数据记录的写入、更新、删除时间自动填充，提高开发维护效率。为了便于时间字段名称、类型的统一维护，如果使用该特性，我们约定：

	// 字段应当设置允许值为null。
	// 字段的类型必须为时间类型，如:date,  datetime,  timestamp。不支持数字类型字段，如int。
	// 字段的名称不支持自定义设置，并且固定名称约定为：
	// created_at用于记录创建时更新，仅会写入一次。
	// updated_at用于记录修改时更新，每次记录变更时更新。
	// deleted_at用于记录的软删除特性，只有当记录删除时会写入一次。
	Id      int    //
	Biaoti  string // 汉字长度25
	Zuozhe  string // 汉字长度25
	Zhaiyao string // 汉字长度50
	// Created_at *gtime.Time //  不用设置时间,gf自动设定
	// Updated_at *gtime.Time
	Suoluetu   string // 为字符串,长度30
	Neirong    string // 汉字长度65535/2
	Yuedushu   int    // 阅读数
	Fenleiid   int    // 分类id
	Zhiding    string
	Jinghua    string //
	Dianzanshu int
}
type AdminupdatearticleRes struct { //返回文件名和路径

}

type Adminupdate_article_zhiding_jinghuaReq struct {
	g.Meta `path:"/update_article_zhiding_jinghua" method:"post" tags:"管理员" summary:"修改文章置顶精华"`
	// gdb模块支持对数据记录的写入、更新、删除时间自动填充，提高开发维护效率。为了便于时间字段名称、类型的统一维护，如果使用该特性，我们约定：

	// 字段应当设置允许值为null。
	// 字段的类型必须为时间类型，如:date,  datetime,  timestamp。不支持数字类型字段，如int。
	// 字段的名称不支持自定义设置，并且固定名称约定为：
	// created_at用于记录创建时更新，仅会写入一次。
	// updated_at用于记录修改时更新，每次记录变更时更新。
	// deleted_at用于记录的软删除特性，只有当记录删除时会写入一次。
	Id int //

	Zhiding string
	Jinghua string //
}
type Adminupdate_article_zhiding_jinghuaRes struct { //返回文件名和路径

}

type Adminupdatearticle_yuedushu_Req struct {
	g.Meta `path:"/update_article_yuedushu" method:"post" tags:"管理员" summary:"修改文章阅读数"`

	Id int //

	//	Dianzanshu int `d:"0" json:"dianzanshu"  description:"点赞数"` //
	Yuedushu int `d:"0" json:"yuedushu"  description:"阅读数"` //
}
type Adminupdatearticle_yuedushu_Res struct { //返回文件名和路径

}

type Adminupdatearticle_dianzanshu_Req struct {
	g.Meta `path:"/update_article_dianzanshu" method:"post" tags:"管理员" summary:"修改文章点赞数"`

	Id int

	Dianzanshu int `d:"0" json:"dianzanshu"  description:"点赞数"` //

}
type Adminupdatearticle_dianzanshu_Res struct { //返回文件名和路径

}
type Admin_delete_user_Req struct { //在控制器中admin.go中对应,在postman中url中直接请求的url.get方法可在浏览器中渲染模板.post方法可作为api接口.仿佛是控制器调用了该结构的方法名作为访问url后调用的方法
	g.Meta   `path:"/admin_delete_user" method:"post" tags:"管理员"  summary:"根据用户id,用户名删除用户信息"`
	Username string //`json:"username" ` // 用户名
	//Nickname string //`json:"nickname" ` // 用户昵称
	Userid g.Array //` json:"userid" `  // 用户id有多个值

}

type Admin_delete_user_Res struct {
}
