// ================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// You can delete these comments if you wish manually maintain this interface file.
// ================================================================================

package service

import (
	"context"
	"database/sql"
	"gf2/internal/model"

	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/frame/g"
)

type (
	IRencaizhaopin interface {
		Fabu(ctx context.Context, in model.RenCaiZhaoPin) (err error, id int64)
		Query_job(ctx context.Context, map1 g.Map) (res gdb.Result, err error)
		Get_gongsi(ctx context.Context, map1 g.Map) (res gdb.Result, err error)
		Get_gangwei(ctx context.Context, map1 g.Map, page int) (res gdb.Result, err error)
		Get_fenlei_gangweixifen(ctx context.Context, map1 g.Map) (res gdb.Result, err error)
		Set_fenlei_gangwei(ctx context.Context, in model.ZhaopinFenleiGangwei) (err error)
		Update_zhaopin(ctx context.Context, in model.RenCaiZhaoPin) (res sql.Result, err error)
	}
)

var (
	localRencaizhaopin IRencaizhaopin
)

func Rencaizhaopin() IRencaizhaopin {
	if localRencaizhaopin == nil {
		panic("implement not found for interface IRencaizhaopin, forgot register?")
	}
	return localRencaizhaopin
}

func RegisterRencaizhaopin(i IRencaizhaopin) {
	localRencaizhaopin = i
}
