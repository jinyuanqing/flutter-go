package main

import (
	"context"
	"fmt"
	"github.com/gogf/gf/v2/container/gqueue"
	"github.com/gogf/gf/v2/os/gctx"
	"github.com/gogf/gf/v2/os/gtime"
	"time"

	"github.com/gogf/gf/v2/os/gtimer"
)

func main1() {
	q := gqueue.New()
	ctx := gctx.New()
	// 数据生产者，每隔1秒往队列写数据
	gtimer.SetInterval(ctx, time.Second,
		func(ctx context.Context) {
			v := gtime.Now().String()
			q.Push(v)
			fmt.Println("Push:", v)
		})

	// 3秒后关闭队列
	gtimer.SetTimeout(ctx, 3*time.Second, func(ctx context.Context) {
		q.Close()
	})

	// 消费者，不停读取队列数据并输出到终端
	for {
		if v := q.Pop(); v != nil {
			fmt.Println(" Pop:", v)
		} else {
			break
		}
	}

	// 第3秒时关闭队列，这时程序立即退出，因此结果中只会打印2秒的数据。 执行后，输出结果为：
	// Output:
	// Push: 2021-09-07 14:03:00
	//  Pop: 2021-09-07 14:03:00
	// Push: 2021-09-07 14:03:01
	//  Pop: 2021-09-07 14:03:01
}
