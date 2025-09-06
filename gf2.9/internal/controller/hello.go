package controller

import (
	"context"
	"gf2/internal/model/entity"
	"github.com/gogf/gf/v2/util/gconv"

	"github.com/gogf/gf/v2/frame/g"

	"gf2/api/v1"
)

var (
	Hello = cHello{}
)

type cHello struct{}

func (c *cHello) Hello(ctx context.Context, req *v1.HelloReq) (res *v1.HelloRes, err error) {
	r := g.RequestFromCtx(ctx)
	var userInfo1 entity.User
	//var casbin3 casbin.Enforcer
	g.Dump(r.URL.Host)
	g.Dump(r.URL.Path)
	err1 := gconv.Struct(r.GetCtxVar("ctx_user"), &userInfo1) //获取上下文数据

	//err3 := r.GetCtxVar("ctx_casbin").Structs(&casbin3)
	g.Dump(userInfo1.Apiused)
	//获取apiused值,然后访问就+1.写入数据库
	if err1 != nil {
		print("发生了错误")
		r.ExitAll()
	}

	g.RequestFromCtx(ctx).Response.Writeln(userInfo1)
	return
}
