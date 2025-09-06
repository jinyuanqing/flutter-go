package main

import (
	"gf2/internal/cmd"
	_ "gf2/internal/logic"
	_ "gf2/internal/packed"

	"github.com/gogf/gf/v2/os/gctx"
)

func main() {
	//test_queue()//测试队列
	cmd.Main.Run(gctx.New())
}
