package session

import (
	"context"
	"gf2/internal/consts"
	"gf2/internal/model/entity"
	"gf2/internal/service"
	"github.com/gogf/gf/v2/container/gvar"
)

type (
	// sSession is service struct of module Session.
	sSession struct{}
)

//var (
//	// insSession is the instance of service Session.
//	insSession = sSession{}
//)

func init() {
	service.RegisterSession(New())
}

func New() *sSession {
	return &sSession{}
}

//// Session returns the interface of Session service.
//func Session() *sSession {
//	return &insSession
//}

// SetUser sets user into the session.
func (s *sSession) SetUser(ctx context.Context, user *entity.User) error {
	return service.Context().Get(ctx).Session.Set(consts.UserSessionKey, user)
}

// GetUser retrieves and returns the user from session.
// It returns nil if the user did not sign in.
func (s *sSession) GetUser(ctx context.Context) *entity.User {
	customCtx := service.Context().Get(ctx)
	if customCtx != nil {
		if v := customCtx.Session.MustGet(consts.UserSessionKey); !v.IsNil() {
			var user *entity.User
			_ = v.Struct(&user)
			return user
		}
	}
	return nil
}

// RemoveUser removes user rom session.
func (s *sSession) RemoveUser(ctx context.Context) error {
	customCtx := service.Context().Get(ctx)
	if customCtx != nil {
		return customCtx.Session.Remove(consts.UserSessionKey)
	}
	return nil
}

// 设置变量到session.传入变量名和变量值

func (s *sSession) Setvar(ctx context.Context, var_name string, value interface{}) error {
	//r.Session.Set("time", "1")重写
	customCtx := service.Context().Get(ctx)
	return customCtx.Session.Set(var_name, value)
}

// 获取session中的变量名对应的值
func (s *sSession) Getvar(ctx context.Context, var_name string) *gvar.Var {
	//data, _ := r.Session.Data()//重写
	//print(data)
	customCtx := service.Context().Get(ctx)
	if customCtx != nil {
		if v := customCtx.Session.MustGet(var_name); !v.IsNil() {
			//var user *entity.User
			//_ = v.Struct(&user)
			return v
		}
	}
	return nil
}
