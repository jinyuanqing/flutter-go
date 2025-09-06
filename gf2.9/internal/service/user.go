// ================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// You can delete these comments if you wish manually maintain this interface file.
// ================================================================================

package service

import (
	"context"
	"gf2/internal/model"
	"gf2/internal/model/entity"

	"github.com/gogf/gf/v2/database/gdb"
)

type (
	IUser interface {
		S_get_alluser_num(ctx context.Context) (num int, err error)
		S_Get_user_accordto_page(ctx context.Context, page int) (res gdb.Result, err error)
		Get_menu_user(ctx context.Context, username string) (interface{}, error)
		Huo_qu_fen_lei(ctx context.Context) (res gdb.Result, err error)
		Query0wen0zhang(ctx context.Context, page int) (res gdb.Result, err error)
		// 注册用户.
		Create(ctx context.Context, in model.UserCreateInput) (err error)
		// IsSignedIn checks and returns whether current user is already signed-in.
		IsSignedIn(ctx context.Context) bool
		// SignIn creates session for given user account.
		SignIn(ctx context.Context, in model.UserSignInInput) (userinfo *entity.User, err error)
		// SignOut removes the session for current signed-in user.
		SignOut(ctx context.Context) error
		// IsPassportAvailable checks and returns given passport is available for signing up.
		IsPassportAvailable(ctx context.Context, Username string) (bool, error)
		// IsNicknameAvailable checks and returns given nickname is available for signing up.
		IsNicknameAvailable(ctx context.Context, nickname string) (bool, error)
		// GetProfile retrieves and returns current user info in session.
		GetProfile(ctx context.Context) *entity.User
	}
)

var (
	localUser IUser
)

func User() IUser {
	if localUser == nil {
		panic("implement not found for interface IUser, forgot register?")
	}
	return localUser
}

func RegisterUser(i IUser) {
	localUser = i
}
