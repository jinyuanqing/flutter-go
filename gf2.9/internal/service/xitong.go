// ================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// You can delete these comments if you wish manually maintain this interface file.
// ================================================================================

package service

import (
	"context"
	v1 "gf2/api/v1"
)

type (
	IXitong interface {
		STest_user_token(ctx context.Context, req *v1.Test_user_token_Req) (err error)
		Compare_time(ctx context.Context, time_str string, jihuochaoshi int) (err error)
	}
)

var (
	localXitong IXitong
)

func Xitong() IXitong {
	if localXitong == nil {
		panic("implement not found for interface IXitong, forgot register?")
	}
	return localXitong
}

func RegisterXitong(i IXitong) {
	localXitong = i
}
