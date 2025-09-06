// ================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// You can delete these comments if you wish manually maintain this interface file.
// ================================================================================

package service

import (
	"context"
	"gf2/internal/model/entity"

	"github.com/gogf/gf/v2/container/gvar"
)

type (
	ISession interface {
		// SetUser sets user into the session.
		SetUser(ctx context.Context, user *entity.User) error
		// GetUser retrieves and returns the user from session.
		// It returns nil if the user did not sign in.
		GetUser(ctx context.Context) *entity.User
		// RemoveUser removes user rom session.
		RemoveUser(ctx context.Context) error
		Setvar(ctx context.Context, var_name string, value interface{}) error
		// 获取session中的变量名对应的值
		Getvar(ctx context.Context, var_name string) *gvar.Var
	}
)

var (
	localSession ISession
)

func Session() ISession {
	if localSession == nil {
		panic("implement not found for interface ISession, forgot register?")
	}
	return localSession
}

func RegisterSession(i ISession) {
	localSession = i
}
