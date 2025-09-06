package middleware

//中间件属于服务,无法再引用控制器了.
import (
	// "net/http"
	"fmt"
	"gf2/internal/model"
	"gf2/internal/service"
	"github.com/casbin/casbin/v2"
	"github.com/gogf/gf/v2/text/gstr"
	"strings"
	"sync"

	xormadapter "github.com/casbin/xorm-adapter/v3" //
	// _ "github.com/go-sql-driver/mysql"
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/net/ghttp"
)

type sMiddleware struct {
	//LoginUrl string // 登录路由地址
}

func init() {
	service.RegisterMiddleware(New())
}
func New() *sMiddleware {
	return &sMiddleware{
		//LoginUrl: "/login",
	}
}

//type (
//	// sMiddleware is service struct of module Middleware.
//	sMiddleware struct{}
//)

// 必有的中间件,且其中必须初始化service.Context().Init.否则涉及ctx的操作报错
func (s *sMiddleware) Ctx(r *ghttp.Request) {

	////连接casbin
	//a, err := xormadapter.NewAdapter("mysql", "root:root@tcp(127.0.0.1:3306)/gf2", true) //会自动创建一个casbin_csv策略表
	//if err != nil {
	//	r.Response.WriteJsonExit(g.Map{
	//		"code":    404,
	//		"message": "数据库连接出错",
	//		"data":    "",
	//	})
	//} else {
	//	//var f,err1=os.Open("./config/rbac/rbac.conf" )
	//	//if err1 != nil {
	//	//	fmt.Println("文件错误",f)
	//	//}
	//
	//	e1, err := casbin.NewEnforcer("./manifest/config/rbac/rbac_model.conf", a) //从本地文件夹加载rbac.conf配置文件
	//	if err != nil {
	//
	//		r.Response.WriteJsonExit(g.Map{
	//			"code":    404,
	//			"message": "中间件权限错误",
	//			"data":    "",
	//		})
	//	}
	//设置上下文变量,上下文变量包括session,User和自定义添加的变量.
	//用户登录时执行中间件ctx,在ctx里执行r.session是空的,所以上下文初始化中设置的变量session也都是空的.由于上下文session是空的,所以 user := service.Session().GetUser(r.Context())返回nil.
	//执行登录的控制器函数时候,会设置session和把用户信息下放入上下文变量中.下次请求执行中间件,就会判断session获取user信息,从而判断用户是否登录了.
	customCtx := &model.Context{
		//Session: r.Session, //获取sessionid
		//Data:    g.Map{"Casbin_Enforcer": e1}, //把casbin放入上下文中
	}

	//print(r.Session.Id())
	service.Context().Init(r, customCtx) //上下文初始化,主要是session.也可以是其他自定义变量
	//if user := service.Session().GetUser(r.Context()); user != nil { //根据r.Context()中的sessionid获取user信息.如果user为空,说明未登录.不为空就把信息放入session中.
	//	customCtx.User = &model.ContextUser{
	//		Id:       user.Id,
	//		Username: user.Username,
	//		Nickname: user.Nickname,
	//	}
	//}
	// Continue execution of next middleware.

	// s.Get(ctx).Data = g.Map{"a":1}
	//r.SetCtxVar("ContextKey",1)
	fmt.Println(r.GetCtxVar("ContextKey").Map())
	//测试设置session值
	//err1 := service.Session().Setvar(r.GetCtx(), "bian1", 5)
	//if err1 != nil {
	//	print("设置session值失败")
	//}

	// customCtx.Data=g.Map{ }//把rbac的实施者对象放入customCtx上下文中,这样在其他文件就可以使用上下文获取e1了,达到全局变量的作用

	// fmt.Println(customCtx )

	r.Middleware.Next()

}

// //检查用户是否登录的中间件,gtoken可以代替这个授权
func (s *sMiddleware) Auth(r *ghttp.Request) {
	if service.User().IsSignedIn(r.Context()) { //检查用户是否登录
		r.Middleware.Next()
	} else {

		// code:=	gcode.New(403,"未发现session","45")
		// err:=	gerror.NewCode(code)

		//r.Response.WriteStatus(http.StatusForbidden)
		r.Response.WriteJsonExit( //api方式返回一个json.
			g.Map{

				"Code":    "1",
				"Message": "未登录或者授权",
				"Data":    "",
			},
		)
	}
}

// CORS allows Cross-origin resource sharing.
func (s *sMiddleware) CORS(r *ghttp.Request) {
	r.Response.CORSDefault()
	r.Middleware.Next()
}

var once sync.Once

var Adapter *xormadapter.Adapter

// rbac认证中间件 .	//先执行gtoken,后执行gf的分组中间件.与书写顺序有关.先从token获取用户名或这用户id,然后用于在gf的中间件rbac中验证url是否有权限访问.
func (s *sMiddleware) Rbac(r *ghttp.Request) {
	//print("Adapter")
	//print(Adapter)
	once.Do(func() { //once.do只执行一次.

		var err error

		mysqluserpasswd, _ := g.Cfg().Get(r.Context(), "database.default.link")

		Adapter, err = xormadapter.NewAdapter("mysql", gstr.StrEx(mysqluserpasswd.String(), ":"), true) //会自动创建一个casbin_csv策略表
		//customCtx := &model.Context{
		//	Session: r.Session,
		//	Data:    g.Map{"adapter": Adapter},
		//}
		//service.Context().Init(r, customCtx)
		if err != nil {
			r.Response.WriteJsonExit(g.Map{
				"code":    404,
				"message": "数据库连接出错",
				"data":    "",
			})
		}
	})
	//print("Adapter")
	//print(Adapter)
	//var f,err1=os.Open("./config/rbac/rbac.conf" )
	//if err1 != nil {
	//	fmt.Println("文件错误",f)
	//}
	//fmt.Println(service.Context().Get(r.Context()).Data["adapter"])
	e1, err := casbin.NewEnforcer("./manifest/config/rbac/rbac_model.conf", Adapter)
	print("返回所有的角色列表list,e1.GetAllRoles()")
	//print(e1.GetAllRoles()[0])//若有角色则一次返回
	//print(e1.GetAllRoles()[1])
	//从本地文件夹加载rbac.conf配置文件
	if err != nil {

		r.Response.WriteJsonExit(g.Map{
			"code":    404,
			"message": "casbin错误",
			"data":    "",
		})
	}

	// s.Get(ctx).Data = g.Map{"a":1}
	//r.SetCtxVar("ContextKey",1)
	fmt.Println(r.GetCtxVar("ContextKey").Map())
	// 初始化，务必最开始执行.把session和Casbin_Enforcer放入上下文中
	customCtx := &model.Context{
		Session: r.Session,
		Data: g.Map{"Casbin_Enforcer": e1,
			"user_token": r.Context().Value("user_token"),
		},
	}
	service.Context().Init(r, customCtx) //fmt.Println(service.Context().Get(ctx).Data) //先获取上下文

	obj := strings.Split(r.Request.URL.RequestURI(), "?")[0] //将要被访问的资源.如/user/user_get_article?a=2,需要分割下?

	act := "post" //r.Request.Method// 用户对资源实施的操作

	sub := r.GetCtxVar("ctx_username").Val() // 想要访问资源的用户  val()获取gvar中的值

	//判断策略中是否存在
	if ok, _ := e1.Enforce(sub, obj, act); ok {
		fmt.Println("恭喜您,权限验证通过")

	} else {
		fmt.Println("很遗憾,权限验证没有通过")
		// r.Response.WriteStatus(http.StatusForbidden)

	}
	r.Middleware.Next()
}
