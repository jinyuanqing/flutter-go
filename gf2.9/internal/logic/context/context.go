package context

//service中的上下文是对model的上下文变量进行了封装.此文件中的init函数在cmd.go调用的中间件中被调用
//Context中数据的初始化、读取、修改及其他公用接口/方法.在service-session.go中调用
import (
	"context"
	"gf2/internal/logic/user"
	"gf2/internal/service"

	// "fmt"
	"gf2/internal/consts"
	// "gf2/internal/logic/user"
	"gf2/internal/model"

	// "github.com/gogf/gf/v2/frame/g"
	// "github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/net/ghttp"
	// "github.com/casbin/casbin/v2"
)

type (
	// sContext is service struct of module Context.
	sContext struct{}
)

func init() {
	service.RegisterContext(New())
}

func New() *sContext {
	return &sContext{}
}

//var (
//	// insContext is the instance of service Context.
//	insContext = sContext{}
//)
//
//// Context returns the interface of Context service.
//func Context() *sContext {
//	return &insContext
//}

// Init initializes and injects custom business context object into request context.
func (s *sContext) Init(r *ghttp.Request, customCtx *model.Context) {
	r.SetCtxVar(consts.ContextKey, customCtx)
	user.R1 = r

}

// Get retrieves and returns the user object from context.
// It returns nil if nothing found in given context.
func (s *sContext) Get(ctx context.Context) *model.Context {
	// fmt.Println(ctx)

	value := ctx.Value(consts.ContextKey)
	if value == nil {
		return nil
	}
	if localCtx, ok := value.(*model.Context); ok {
		return localCtx
	}
	return nil
}

// SetUser injects business user object into context.
func (s *sContext) SetUser(ctx context.Context, ctxUser *model.ContextUser) {
	// fmt.Println(ctx)
	s.Get(ctx).User = ctxUser
	// s.Get(ctx).Data = g.Map{"a":1}//设置上下文
	//customCtx.Data=g.Map{"Casbin_Enforcer":e1 }//把rbac的实施者对象放入customCtx上下文中,这样在其他文件就可以使用上下文获取e1了,达到全局变量的作用

}
