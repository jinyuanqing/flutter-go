package controller

//方法名首字母必须大写.控制器调用service
import (
	"context"
	"fmt"

	// "go/printer"

	v1 "gf2/api/v1"
	// "gf2/internal/model"
	"gf2/internal/service"
	// "github.com/gogf/gf/v2/os/gtime"

	// "github.com/gogf/guuid"
	// "github.com/google/uuid"

	// "github.com/gogf/gf/v2/util/gconv"
	// "gf2/internal/service/internal/dao"
	// "gf2/internal/service/internal/dao/internal"
	"github.com/gogf/gf/v2/frame/g"
	//	"github.com/gogf/gf/v2/errors/gerror"
	// "github.com/goflyfox/gtoken/gtoken"
	// "github.com/casbin/casbin/v2"                   //casbin
	// xormadapter "github.com/casbin/xorm-adapter/v3" //casbin
)

// var e1 *casbin.Enforcer
type cRbac struct{}

var Rbac = cRbac{}

func (c *cRbac) Rbac_add(ctx context.Context, req *v1.Rbac_add_Req) (res *v1.Rbac_add_Res, err error) {
	r := g.RequestFromCtx(ctx)

	sub := r.Get("sub").String()
	obj := r.Get("obj").String()
	act := r.Get("act").String()

	e := service.Rbac().Rbac_test(ctx, sub, obj, act)
	fmt.Println(e)
	//  fmt.Println(ctx.Value("ContextKey").String())

	fmt.Println(r.GetCtxVar("ContextKey").Map())
	fmt.Println(r.GetCtxVar("ContextKey").Map()["Data"])
	// r.GetCtxVar("ContextKey").Map()["Data"]=g.Map{"c":3}
	// r.SetCtxVar("ContextKey",g.Map{"c":2})
	fmt.Println(ctx.Value("ContextKey"))
	// 			 bool1 ,err := e1.AddPermissionForUser(sub, obj, act) ////为用户或角色添加多个权限
	// fmt.Println(bool1)
	// fmt.Println(err)
	// 			 r.Response.WriteJsonExit(g.Map{
	// 	"code":    0,
	// 	"message":"rbac_add请求成功123",
	// 	"data":    "ok",
	// })

	return
}
