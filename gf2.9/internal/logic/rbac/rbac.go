package rbac

//在控制器目录文件中调用的方法
import (
	"context"
	"fmt"
	"github.com/gogf/gf/v2/util/gconv"

	// "reflect"

	// "github.com/gogf/gf/v2/container/gtree"
	// "github.com/gogf/gf/v2/util/gutil"
	// v1 "gf2/api/v1"
	"gf2/internal/service"
	// "gf2/internal/model/entity"
	// "gf2/internal/service/internal/dao"
	// "gf2/internal/service/internal/do"

	// "github.com/gogf/gf/v2/container/gmap"
	// "github.com/gogf/gf/v2/container/gvar"
	// "github.com/gogf/gf/v2/frame/g"

	"github.com/gogf/gf/v2/frame/g"
	// "github.com/gogf/gf/v2/util/gconv"
	"github.com/casbin/casbin/v2" //casbin
	// xormadapter "github.com/casbin/xorm-adapter/v3" //
	// "github.com/gogf/gf/v2/database/gdb"
	// "github.com/gogf/gf/v2/errors/gcode"
	// "github.com/gogf/gf/v2/errors/gerror"
)

type (
	// 作为本页函数的返回值指针
	sRbac struct{}
)

func init() {
	service.RegisterRbac(New())
}

func New() *sRbac {
	return &sRbac{}
}

//var (
//	// inadmin is the instance of service User.
//	insRbac = sRbac{}
//)
//
//// User returns the interface of User service.
//func Rbac() *sRbac { //Admin在service->admin.go中使用了
//	return &insRbac
//}

func (s *sRbac) Rbac_test(ctx context.Context, sub string, obj string, act string) (err int) {
	r := g.RequestFromCtx(ctx)
	fmt.Println(service.Context().Get(ctx).Data) //先获取上下文
	//g.Dump(service.Context().Get(ctx).Data["Casbin_Enforcer"])
	g.Dump(r.GetCtxVar("ctx_user"))
	var e1 casbin.Enforcer

	//err3 := r.GetCtxVar("ctx_casbin").Structs(&e1)
	//在中间件rbac中,写入了上下文Casbin_Enforcer
	err3 := gconv.Structs(service.Context().Get(ctx).Data["Casbin_Enforcer"], (&e1))
	if err3 != nil {
		print("发生了内部错误")
	}

	//e1 := service.Context().Get(ctx).Data["Casbin_Enforcer"].((*casbin.Enforcer))

	//判断策略中是否存在

	//obj = "/admin/yhgl"// r.Request.URL.RequestURI()// 将要被访问的资源
	act = "post" //r.Request.Method// 用户对资源实施的操作
	//sub = "youxue"// 想要访问资源的用户
	//println(e1.Enforce())
	// e1.Enforce()函数禁用执行器。 当它被禁用时， Enforcer.Enforce() 将总是返回 true。如果e1为空,则返回真,表示函授执行器被禁用了.
	bool1, err4 := e1.Enforce()
	if bool1 == true { //真,被禁用了.后续所有操作都是管理员操作.也就是权限管理不起作用了.因此退出
		r.Response.WriteJsonExit(
			g.Map{
				"code":    "1",
				"message": "casbin的函授执行器为空或者被禁用",
				"data":    err4,
			})
	}

	if ok, err3 := e1.Enforce(sub, obj, act); ok {
		g.Dump(err3)
		fmt.Println("恭喜您,权限验证通过", r)
		// r.Response.WriteJsonExit(g.Map{
		// 	"code":    0,
		// 	"message":"恭喜您,权限验证通过",
		// 	"data":    "ok",
		// })
		return 1
	} else {
		fmt.Println("很遗憾,权限验证没有通过")
		// r.Response.WriteStatus(http.StatusForbidden)
		// r.Response.WriteJsonExit(g.Map{
		// 		"code":    1,
		// 		"message":"很遗憾,权限验证没有通过",
		// 		"data":    "error",
		// 	})
		return 0
	}
	// Context().Get(ctx).Data= g.Map{"b":2,"a":Context().Get(ctx).Data["a"]}//设置上下文
	// return nil
}
