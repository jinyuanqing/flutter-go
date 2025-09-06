package main

//功能:协程方式读取redis中的数据,协程方式写数据库.写完数据后,发送可以接收数据到通道,此时可以继续接收redis数据.
import (
	"context"
	"fmt"
	_ "github.com/gogf/gf/contrib/drivers/mysql/v2" //gf的数据库驱动
	"github.com/gogf/gf/v2/frame/g"
	"github.com/redis/go-redis/v9"
	"time"
)

//redis客户端下载 https://gitee.com/redis-windows/redis-windows/releases/tag/7.2.4

//登录 auth  123456

//根据流创建消费者组  XGROUP CREATE stream group 0 mkstream[这个参数必须有告诉 Redis 如果 mystream 这个键不存在，就先创建一个空的 Stream，然后再创建消费者组。]
//添加数据.  select 0   xadd  stream * name 1
//读去消费者组的未被ack数据  XREADGROUP GROUP group consumer STREAMS stream 0-0
//读取未被ack的数据 xpending stream group

//确认消息 xack stream[键,也就是消息队列名] group[组名]  1713165679703-0[消息id]
// 永久删除消息: xdel mystream(消息队列名) 1713067702346-0(消息id)

// 1查看消息队列的信息:XREVRANGE 队列名 最小id- 最大id+ [COUNT count]:
//xrevrange mystream + -

// 2查看消费者组中未处理的消息:XPENDING 消息队列名,消费者组名. 命令输出该消费者组的待处理消息总数，该数为1，随后是待处理消息中最小和最大的ID，然后列出消费者组中每个至少有一个待处理消息的消费者及其待处理消息的数量。

// 3.获取mystream 的所有消费者组未被ack的消息列表  xinfo groups mystream
//该命令返回存储在<key>mystream处的流的所有消费者组列表。
//默认情况下，每个组仅提供以下信息：
//name: 消费者组的名称
//consumers: 组中消费者的数量
//pending: 组的待处理条目列表（即已传递但尚未确认的消息）的长度（PEL）
//last-delivered-id: 传递给组的消费者的最后一条条目的ID
//entries-read: 传递给组的消费者的最后一条条目的逻辑“读取计数器”
//lag: 正在等待传递给组的消费者的流中的条目数，或者当无法确定该数目时为NULL。

// 4获取mystream 的流的信息 xinfo stream mystream
// 这个命令返回关于存储在<key>位置的流的信息。
// 此命令提供的详细信息为：
// length: 流中条目的数量（参见 XLEN）
// radix-tree-keys: 底层基数数据结构中的键数
// radix-tree-nodes: 底层基数数据结构中的节点数
// groups: 为该流定义的消费者组数
// last-generated-id: 添加到流中的最近一条条目的ID
// max-deleted-entry-id: 从流中删除的最大条目ID
// entries-added: 流的生命周期中添加的所有条目数
// first-entry: 流中第一条条目的ID和字段值元组
// last-entry: 流中最后一条条目的ID和字段值元组

//5 xlen mystream[队列名] 查看队列的消息数目

//6读取消费者组的消息:XREADGROUP GROUP group2[消费者组名] consumer[消费者名] STREAMS mystream[消息队列名] 0 解释:XReadGroup读取的是一组已经传递但尚未被确认的消息ID。被确认后在读取,消息就会减少
//XREADGROUP GROUP group consumer block 0 STREAMS stream 0-0
//如果我们在处理消息的中间发生崩溃，那么我们的消息将保留在待处理列表中，因此我们可以通过最初给 XREADGROUP 一个 ID 0，并执行相同的循环来访问我们的历史记录。一旦提供了 ID 0，回复为空的消息集，我们就知道我们已经处理和确认了所有待处理的消息：我们可以开始使用 > 作为 ID，以获取新消息并重新加入正在处理新事物的消费者。

// 7. 从第0个id开始读取消息队列mystream所有消息. XREAD STREAMS mystream[消息队列名] 0
var (
	ctx                  = context.Background()
	consumer             = "consumer"         //消费者名
	stream               = "stream"           //消息队列名,key
	group                = "group"            //消费者组名
	start                = ">"                // ">"读取最新的消息."0-0"从消息的开始开始读取
	count                = 10                 //XReadGroup返回的消息数
	whether_receive_chan = make(chan bool, 0) //是否可以接收的通道,写数据库完毕后,该通道为真.
)

func main_redis() {

	// 创建Redis客户端
	client := redis.NewClient(&redis.Options{
		MaxRetries: 5,
		Addr:       "localhost:6379",
		Password:   "123456",
		DB:         0,
	})
	// 创建消费者组,把流和消费者组绑定..XGROUP CREATE指令,0-0是从头开始消费
	err := client.XGroupCreateMkStream(ctx, stream, group, "0-0").Err()
	if err != nil {
		panic(err)
	}
	//var str int = 0
	var send_chan = make(chan []redis.XStream, 1)

	go read_redis(ctx, send_chan, stream, group, client)
	go writedatabase(ctx, send_chan, stream, group, client)
	time.Sleep(1 * time.Second)
	whether_receive_chan <- false
	for {

	}

}
func read_redis(ctx context.Context, send_chan chan []redis.XStream, stream string, group string, client *redis.Client) {

	for {
		select {
		case <-whether_receive_chan: //写数据库完成后,该通道返回值
			println("进入读取数据")
			//str = str + 1
			//time.Sleep(time.Second * 1)
			//添加数据库0
			//消息 .select 0
			//xadd  mystream * name youxue3
			//_, err = client.XAdd(ctx, &redis.XAddArgs{
			//	Stream: stream,
			//	ID:     "*",
			//	Values: map[string]interface{}{
			//		//"name": string(str) + "[{\"type\":1,\"title\":\"\\u4e60\\u8fd1\\u5e73\\u603b\\u4e66\\u8bb0\\u5728\\uff08\\uff09\\u8c03\\u7814\\u65f6\\uff0c\\u9996\\u6b21\\u660e\\u786e\\u63d0\\u51fa\\u201c\\u56db\\u4e2a\\u5168\\u9762\\u201d\",\"answer\":{\"nums\":\"4\",\"rs\":\"3\",\"ans\":[\"\\u3010\\u5e7f\\u4e1c\\u3011\",\"\\u3010\\u4e0a\\u6d77\\u3011\",\"\\u3010\\u6d59\\u6c5f\\u3011\",\"\\u3010\\u6c5f\\u82cf\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\u4ece\\uff08\\uff09\\u5230\\uff08\\uff09\\uff0c\\u662f\\u201c\\u4e24\\u4e2a\\u4e00\\u767e\\u5e74\\u201d\\u594b\\u6597\\u76ee\\u6807\\u7684\\u5386\\u53f2\\u4ea4\\u6c47\\u671f\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"1\",\"ans\":[\"\\u30102020\\u5e74 2035\\u5e74\\u3011\",\"\\u3010\\u5341\\u4e5d\\u5927 \\u4e8c\\u5341\\u5927\\u3011\",\"\\u3010\\u4e8c\\u5341\\u5927 \\u4e8c\\u5341\\u4e00\\u5927\\u3011\",\"\\u30102035\\u5e74 \\u672c\\u4e16\\u7eaa\\u4e2d\\u53f6\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\uff08\\uff09\\u662f\\u65b0\\u65f6\\u4ee3\\u575a\\u6301\\u548c\\u53d1\\u5c55\\u4e2d\\u56fd\\u7279\\u8272\\u793e\\u4f1a\\u4e3b\\u4e49\\u6839\\u672c\\u7acb\\u573a\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"1\",\"ans\":[\"\\u3010\\u4ee5\\u7ecf\\u6d4e\\u5efa\\u8bbe\\u4e3a\\u4e2d\\u5fc3\\u3011\",\"\\u3010\\u4ee5\\u4eba\\u6c11\\u4e3a\\u4e2d\\u5fc3\\u3011\",\"\\u3010\\u5baa\\u6cd5\\u81f3\\u4e0a\\u3011\",\"\\u3010\\u4e00\\u5207\\u6709\\u5229\\u4e8e\\u751f\\u4ea7\\u529b\\u53d1\\u5c55\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\u4e2d\\u56fd\\u68a6\\u662f\\u56fd\\u5bb6\\u7684\\u68a6\\u3001\\u6c11\\u65cf\\u7684\\u68a6\\uff0c\\u5f52\\u6839\\u5230\\u5e95\\u662f\\uff08\\uff09\",\"answer\":{\"nums\":\"4\",\"rs\":\"2\",\"ans\":[\"\\u3010\\u56fd\\u5bb6\\u7684\\u68a6\\u3011\",\"\\u3010\\u6c11\\u65cf\\u7684\\u68a6\\u3011\",\"\\u3010\\u4eba\\u6c11\\u7684\\u68a6\\u3011\",\"\\u3010\\u4e2a\\u4eba\\u7684\\u68a6\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\u6211\\u4eec\\u515a\\u7684\\u4e09\\u5927\\u5386\\u53f2\\u4efb\\u52a1\\u662f\\u63a8\\u8fdb\\u73b0\\u4ee3\\u5316\\u5efa\\u8bbe\\u3001\\uff08\\uff09\\u3001\\u7ef4\\u62a4\\u4e16\\u754c\\u548c\\u5e73\\u4e0e\\u4fc3\\u8fdb\\u5171\\u540c\\u53d1\\u5c55\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"2\",\"ans\":[\"\\u3010\\u5b9e\\u73b0\\u5171\\u4ea7\\u4e3b\\u4e49\\u3011\",\"\\u3010\\u5b9e\\u73b0\\u6c11\\u65cf\\u590d\\u5174\\u3011\",\"\\u3010\\u5b8c\\u6210\\u7956\\u56fd\\u7edf\\u4e00\\u3011\",\"\\u3010\\u5b9e\\u73b0\\u5168\\u4eba\\u7c7b\\u89e3\\u653e\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\u4e2d\\u56fd\\u7279\\u8272\\u793e\\u4f1a\\u4e3b\\u4e49\\u6700\\u672c\\u8d28\\u7684\\u7279\\u5f81\\u662f\\uff08\\uff09\",\"answer\":{\"nums\":\"4\",\"rs\":\"3\",\"ans\":[\"\\u3010\\u201c\\u4e94\\u4f4d\\u4e00\\u4f53\\u201d\\u603b\\u4f53\\u5e03\\u5c40\\u3011\",\"\\u3010\\u5efa\\u8bbe\\u4e2d\\u56fd\\u7279\\u8272\\u793e\\u4f1a\\u4e3b\\u4e49\\u6cd5\\u6cbb\\u4f53\\u7cfb\\u3011\",\"\\u3010\\u4eba\\u6c11\\u5229\\u76ca\\u4e3a\\u6839\\u672c\\u51fa\\u53d1\\u70b9\\u3011\",\"\\u3010\\u4e2d\\u56fd\\u5171\\u4ea7\\u515a\\u7684\\u9886\\u5bfc\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\u515a\\u7684\\u5341\\u4e5d\\u5927\\u62a5\\u544a\\u6307\\u51fa\\uff0c\\uff08\\uff09\\u662f\\u5b9e\\u73b0\\u793e\\u4f1a\\u4e3b\\u4e49\\u73b0\\u4ee3\\u5316\\u3001\\u521b\\u9020\\u4eba\\u6c11\\u7f8e\\u597d\\u751f\\u6d3b\\u7684\\u5fc5\\u7531\\u4e4b\\u8def\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"3\",\"ans\":[\"\\u3010\\u4ece\\u7ad9\\u8d77\\u6765\\u3001\\u5bcc\\u8d77\\u6765\\u5230\\u5f3a\\u8d77\\u6765\\u3011\",\"\\u3010\\u5b9e\\u884c\\u793e\\u4f1a\\u4e3b\\u4e49\\u6c11\\u4e3b\\u3011\",\"\\u3010\\u79d1\\u5b66\\u793e\\u4f1a\\u4e3b\\u4e49\\u9053\\u8def\\u3011\",\"\\u3010\\u4e2d\\u56fd\\u7279\\u8272\\u793e\\u4f1a\\u4e3b\\u4e49\\u9053\\u8def\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":0,\"title\":\"\\u6211\\u56fd\\u793e\\u4fdd\\u517b\\u8001\\u4fdd\\u9669\\u8986\\u76d6\\u4e8613.5\\u4ebf\\u4eba.\",\"answer\":{\"nums\":\"2\",\"rs\":\"0\",\"ans\":[],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":0,\"title\":\"\\u53ef\\u4ee5\\u8bf4,\\u4e2d\\u5171\\u5341\\u4e5d\\u5927\\u6700\\u5927\\u7684\\u6210\\u5c31\\u5c31\\u662f\\u5f62\\u6210\\u4e86\\u4e60\\u8fd1\\u5e73\\u65b0\\u65f6\\u4ee3\\u4e2d\\u56fd\\u7279\\u8272\\u793e\\u4f1a\\u4e3b\\u4e49\\u601d\\u60f3\\u3002\",\"answer\":{\"nums\":\"2\",\"rs\":\"1\",\"ans\":[],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":0,\"title\":\"\\u4e60\\u8fd1\\u5e73\\u65b0\\u65f6\\u4ee3\\u4e2d\\u56fd\\u7279\\u8272\\u793e\\u4f1a\\u4e3b\\u4e49\\u601d\\u60f3\\u7cfb\\u7edf\\u56de\\u7b54\\u4e86\\u5728\\u65b0\\u65f6\\u4ee3\\u5982\\u4f55\\u575a\\u6301\\u4e0e\\u53d1\\u5c55\\u4e2d\\u56fd\\u7279\\u8272\\u793e\\u4f1a\\u4e3b\\u4e49\\u3002\",\"answer\":{\"nums\":\"2\",\"rs\":\"1\",\"ans\":[],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":0,\"title\":\"\\u4e60\\u8fd1\\u5e73\\u65b0\\u65f6\\u4ee3\\u4e2d\\u56fd\\u7279\\u8272\\u793e\\u4f1a\\u4e3b\\u4e49\\u601d\\u60f3\\u96c6\\u4e2d\\u4f53\\u73b0\\u4e86\\u515a\\u3001\\u56fd\\u5bb6\\u548c\\u4eba\\u6c11\\u7684\\u610f\\u5fd7\\u3002\",\"answer\":{\"nums\":\"2\",\"rs\":\"1\",\"ans\":[],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\u5728\\u793e\\u4f1a\\u4e3b\\u4e49\\u521d\\u7ea7\\u9636\\u6bb5\\uff0c\\u5fc5\\u987b\\u575a\\u6301\\u548c\\u5b8c\\u5584\\u516c\\u6709\\u5236\\u4e3a\\u4e3b\\u4f53\\u3001\\u591a\\u79cd\\u6240\\u6709\\u5236\\u7ecf\\u6d4e\\uff08\\uff09\\u7684\\u57fa\\u672c\\u7ecf\\u6d4e\\u5236\\u5ea6.\",\"answer\":{\"nums\":\"4\",\"rs\":\"0\",\"ans\":[\"\\u3010\\u5171\\u540c\\u53d1\\u5c55\\u3011\",\"\\u3010\\u76f8\\u4e92\\u7ade\\u4e89\\u3011\",\"\\u3010\\u9f50\\u5934\\u5e76\\u8fdb\\u3011\",\"\\u3010\\u5747\\u8861\\u53d1\\u5c55\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\u4e60\\u8fd1\\u5e73\\u603b\\u4e66\\u8bb0\\u5f3a\\u8c03\\uff0c\\uff08\\uff09\\u662f\\u7b2c\\u662f\\u4e00\\u8981\\u52a1\\uff0c\\uff08\\uff09\\u662f\\u7b2c\\u4e00\\u8d44\\u6e90\\uff0c\\uff08\\uff09\\u662f\\u7b2c\\u4e00\\u52a8\\u529b\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"2\",\"ans\":[\"\\u3010\\u521b\\u65b0 \\u6539\\u9769 \\u4eba\\u624d\\u3011\",\"\\u3010\\u521b\\u65b0 \\u4eba\\u624d \\u6539\\u9769\\u3011\",\"\\u3010\\u53d1\\u5c55 \\u4eba\\u624d \\u521b\\u65b0\\u3011\",\"\\u3010\\u53d1\\u5c55 \\u521b\\u65b0 \\u6539\\u9769\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\u4e60\\u8fd1\\u5e73\\u603b\\u4e66\\u8bb0\\u6307\\u51fa\\uff0c\\u5168\\u9762\\u6df1\\u5316\\u6539\\u9769\\u603b\\u76ee\\u6807\\u662f\\uff08\\uff09.\",\"answer\":{\"nums\":\"4\",\"rs\":\"3\",\"ans\":[\"\\u3010\\u5b9e\\u73b0\\u793e\\u4f1a\\u4e3b\\u4e49\\u73b0\\u4ee3\\u5316\\u3011\",\"\\u3010\\u5b9e\\u73b0\\u4e2d\\u56fd\\u68a6\\u3011\",\"\\u3010\\u5168\\u9762\\u5efa\\u7acb\\u793e\\u4f1a\\u4e3b\\u4e49\\u5e02\\u573a\\u7ecf\\u6d4e\\u4f53\\u5236\\u3011\",\"\\u3010\\u5b8c\\u5584\\u548c\\u53d1\\u5c55\\u4e2d\\u56fd\\u7279\\u8272\\u793e\\u4f1a\\u4e3b\\u4e49\\u5236\\u5ea6\\u3001\\u63a8\\u8fdb\\u56fd\\u5bb6\\u6cbb\\u7406\\u4f53\\u7cfb\\u548c\\u6cbb\\u7406\\u80fd\\u529b\\u73b0\\u4ee3\\u5316\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":2,\"title\":\"\\u4e60\\u8fd1\\u5e73\\u603b\\u4e66\\u8bb0\\u5f3a\\u8c03\\uff0c\\u8981\\u53d1\\u626c\\u9489\\u9489\\u5b50\\u7cbe\\u795e\\uff0c\\uff08 \\uff09\\uff0c\\u5207\\u5b9e\\u628a\\u5de5\\u4f5c\\u843d\\u5728\\u5b9e\\u5904\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"0,1,2,3\",\"ans\":[\"\\u3010\\u575a\\u6301\\u4e00\\u5f20\\u84dd\\u56fe\\u7ed8\\u5230\\u5e95\\u3011\",\"\\u3010\\u575a\\u6301\\u201c\\u575a\\u6301\\u4e00\\u5206\\u90e8\\u7f72\\uff0c\\u4e5d\\u5206\\u843d\\u5b9e\\u201d\\u3011\",\"\\u3010\\u5efa\\u7acb\\u89c4\\u8303\\u7684\\u8003\\u8bc4\\u8bc4\\u4ef7\\u4f53\\u7cfb\\u3011\",\"\\u3010\\u5f62\\u6210\\u6fc0\\u52b1\\u6c42\\u771f\\u52a1\\u5b9e\\u7684\\u6709\\u6548\\u673a\\u5236\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":0,\"title\":\"\\u4ee5\\u4e60\\u8fd1\\u5e73\\u540c\\u5fd7\\u4e3a\\u6838\\u5fc3\\u7684\\u4e2d\\u592e\\u653f\\u6cbb\\u5c40\\u4e09\\u6b21\\u5bf9\\u9a6c\\u514b\\u601d\\u4e3b\\u4e49\\u54f2\\u5b66\\u8fdb\\u884c\\u4e86\\u96c6\\u4f53\\u5b66\\u4e60\\u3002\",\"answer\":{\"nums\":\"2\",\"rs\":\"0\",\"ans\":[],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":0,\"title\":\"\\u4e2d\\u56fd\\u7684\\u6539\\u9769\\u5f00\\u653e\\u7684\\u9636\\u6bb5\\u6027\\u53ef\\u4ee5\\u5206\\u4e3a\\u8fdb\\u884c\\u65f6\\u548c\\u5b8c\\u6210\\u65f6\\u3002\",\"answer\":{\"nums\":\"2\",\"rs\":\"0\",\"ans\":[],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":0,\"title\":\"\\u5f53\\u4eca\\u8fd9\\u4e2a\\u65b0\\u65f6\\u4ee3,\\u6211\\u4eec\\u6bd4\\u5386\\u53f2\\u4e0a\\u4efb\\u4f55\\u65f6\\u671f\\u90fd\\u66f4\\u63a5\\u8fd1\\u5b9e\\u73b0\\u4e2d\\u534e\\u6c11\\u65cf\\u4f1f\\u5927\\u590d\\u5174\\u7684\\u76ee\\u6807.\",\"answer\":{\"nums\":\"2\",\"rs\":\"1\",\"ans\":[],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":0,\"title\":\"\\u9093\\u5c0f\\u5e73\\u5f3a\\u8c03\\u5c06\\u6211\\u56fd\\u5efa\\u8bbe\\u4e3a\\u4e00\\u4e2a\\u53d1\\u8fbe\\u56fd\\u9645\\u3002\",\"answer\":{\"nums\":\"2\",\"rs\":\"0\",\"ans\":[],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":0,\"title\":\"\\u4e2d\\u56fd\\u793e\\u4f1a\\u4e3b\\u8981\\u77db\\u76fe\\u7684\\u6539\\u53d8,\\u4e5f\\u5bfc\\u81f4\\u4e86\\u4e2d\\u56fd\\u793e\\u4f1a\\u4e3b\\u4e49\\u6240\\u5904\\u5386\\u53f2\\u9636\\u6bb5\\u7684\\u5224\\u65ad\\u3002\",\"answer\":{\"nums\":\"2\",\"rs\":\"0\",\"ans\":[],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":0,\"title\":\"\\u4e2d\\u56fd\\u793e\\u4f1a\\u7684\\u4e3b\\u8981\\u77db\\u76fe\\u5df2\\u7ecf\\u8f6c\\u5316\\u4e3a\\u4eba\\u6c11\\u65e5\\u76ca\\u589e\\u957f\\u7684\\u7f8e\\u597d\\u751f\\u6d3b\\u9700\\u8981\\u548c\\u4e0d\\u5e73\\u8861\\u4e0d\\u5145\\u5206\\u7684\\u53d1\\u5c55\\u4e4b\\u95f4\\u7684\\u77db\\u76fe\\u3002\",\"answer\":{\"nums\":\"2\",\"rs\":\"1\",\"ans\":[],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":2,\"title\":\"(   )\\u5bf9\\u793e\\u4f1a\\u4e3b\\u4e49\\u793e\\u4f1a\\u7684\\u77db\\u76fe\\u95ee\\u9898\\u6ca1\\u6709\\u505a\\u8fc7\\u4e13\\u95e8\\u7684\\u8bba\\u8ff0\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"0,1,2\",\"ans\":[\"\\u3010\\u9a6c\\u514b\\u601d\\u3011\",\"\\u3010\\u6069\\u683c\\u65af\\u3011\",\"\\u3010\\u5217\\u5b81\\u3011\",\"\\u3010\\u6bdb\\u6cfd\\u4e1c\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":2,\"title\":\"\\u4e60\\u8fd1\\u5e73\\u5728\\u63a5\\u89c1\\u8fde\\u6218\\u65f6\\u5bf9\\u53d1\\u5c55\\u4e24\\u5cb8\\u5173\\u7cfb\\u63d0\\u51fa\\u4e86\\u51e0\\u70b9\\u610f\\u89c1,\\u5373(   )\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"0,1,2,3\",\"ans\":[\"\\u3010\\u4e24\\u5cb8\\u540c\\u80de\\u547d\\u8fd0\\u4e0e\\u5171\\u3011\",\"\\u3010\\u4e24\\u5cb8\\u540c\\u80de\\u8981\\u6301\\u7eed\\u63a8\\u52a8\\u4e24\\u5cb8\\u5173\\u7cfb\\u548c\\u5e73\\u53d1\\u5c55\\u3011\",\"\\u3010\\u4e24\\u5cb8\\u540c\\u80de\\u7684\\u8840\\u8109\\u662f\\u5272\\u4e0d\\u65ad\\u7684\\u3011\",\"\\u3010\\u4e24\\u5cb8\\u540c\\u80de\\u8981\\u5171\\u5706\\u4e2d\\u534e\\u6c11\\u65cf\\u4f1f\\u5927\\u590d\\u5174\\u7684\\u4e2d\\u56fd\\u68a6\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":2,\"title\":\"\\u4e60\\u8fd1\\u5e73\\u65b0\\u65f6\\u4ee3\\u4e2d\\u56fd\\u7279\\u8272\\u793e\\u4f1a\\u4e3b\\u4e49\\u601d\\u60f3\\u5f00\\u8f9f\\u4e86\\u54ea\\u4e9b\\u65b0\\u5883\\u754c?\",\"answer\":{\"nums\":\"4\",\"rs\":\"0,1,2,3\",\"ans\":[\"\\u3010\\u9a6c\\u514b\\u601d\\u4e3b\\u4e49\\u65b0\\u5883\\u754c\\u3011\",\"\\u3010\\u4e2d\\u56fd\\u7279\\u8272\\u793e\\u4f1a\\u4e3b\\u4e49\\u65b0\\u5883\\u754c\\u3011\",\"\\u3010\\u5f53\\u6cbb\\u56fd\\u7406\\u653f\\u65b0\\u5883\\u754c\\u3011\",\"\\u3010\\u7ba1\\u515a\\u6cbb\\u515a\\u7684\\u65b0\\u5883\\u754c\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":2,\"title\":\"\\u51e1\\u5c5e\\u91cd\\u5927\\u95ee\\u9898\\u90fd\\u8981\\u6309\\u7167\\uff08\\uff09\\u7684\\u539f\\u5219\\uff0c\\u7531\\u515a\\u7684\\u59d4\\u5458\\u4f1a\\u96c6\\u4f53\\u8ba8\\u8bba\\uff0c\\u4f5c\\u51fa\\u51b3\\u5b9a\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"0,1,2,3\",\"ans\":[\"\\u3010\\u96c6\\u4f53\\u9886\\u5bfc\\u3011\",\"\\u3010\\u6c11\\u4e3b\\u96c6\\u4e2d\\u3011\",\"\\u3010\\u4e2a\\u522b\\u915d\\u917f\\u3011\",\"\\u3010\\u4f1a\\u8bae\\u51b3\\u5b9a\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":2,\"title\":\"\\u4e2d\\u56fd\\u5171\\u4ea7\\u515a\\u6309\\u7167\\u5fb7\\u624d\\u517c\\u5907\\u3001\\u4ee5\\u5fb7\\u4e3a\\u5148\\u7684\\u539f\\u5219\\u9009\\u62d4\\u5e72\\u90e8\\uff0c\\u575a\\u6301\\u4e94\\u6e56\\u56db\\u6d77\\u3001\\u4efb\\u4eba\\u552f\\u8d24\\uff0c\\u575a\\u6301\\u4e8b\\u4e1a\\u4e3a\\u4e0a\\u3001\\u516c\\u9053\\u6b63\\u6d3e\\uff0c\\u53cd\\u5bf9\\u4efb\\u4eba\\u552f\\u4eb2\\uff0c\\u52aa\\u529b\\u5b9e\\u73b0\\u5e72\\u90e8\\u961f\\u4f0d\\u7684\\uff08\\uff09\",\"answer\":{\"nums\":\"4\",\"rs\":\"0,1,2,3\",\"ans\":[\"\\u3010\\u9769\\u547d\\u5316\\u3011\",\"\\u3010\\u5e74\\u8f7b\\u5316\\u3011\",\"\\u3010\\u77e5\\u8bc6\\u5316\\u3011\",\"\\u3010\\u4e13\\u4e1a\\u5316\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":2,\"title\":\"\\u515a\\u7684\\u7eaa\\u5f8b\\u4e3b\\u8981\\u5305\\u62ec\\u653f\\u6cbb\\u7eaa\\u5f8b\\u3001\\u7ec4\\u7ec7\\u7eaa\\u5f8b\\u3001\\uff08\\uff09\\u3001\\u5de5\\u4f5c\\u7eaa\\u5f8b\\u548c\\u751f\\u6d3b\\u7eaa\\u5f8b\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"0,3\",\"ans\":[\"\\u3010\\u5ec9\\u6d01\\u7eaa\\u5f8b\\u3011\",\"\\u3010\\u5e72\\u90e8\\u7eaa\\u5f8b\\u3011\",\"\\u3010\\u4f5c\\u98ce\\u7eaa\\u5f8b\\u3011\",\"\\u3010\\u7fa4\\u4f17\\u7eaa\\u5f8b\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":2,\"title\":\"\\u4e60\\u8fd1\\u5e73\\u603b\\u4e66\\u8bb0\\u5728\\u7eaa\\u5ff5\\u9a6c\\u514b\\u601d\\u8bde\\u8fb0200\\u5468\\u5e74\\u5927\\u4f1a\\u4e0a\\u7684\\u8bb2\\u8bdd\\u6df1\\u523b\\u6307\\u51fa\\uff0c\\u9a6c\\u514b\\u601d\\u4e3b\\u4e49\\u662f\\uff08\\uff09\",\"answer\":{\"nums\":\"4\",\"rs\":\"0,1,2,3\",\"ans\":[\"\\u3010\\u79d1\\u5b66\\u7684\\u7406\\u8bba\\u3011\",\"\\u3010\\u4eba\\u6c11\\u7684\\u7406\\u8bba\\u3011\",\"\\u3010\\u5b9e\\u8df5\\u7684\\u7406\\u8bba\\u3011\",\"\\u3010\\u5f00\\u653e\\u7684\\u7406\\u8bba\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\u5f00\\u542f\\u4e2d\\u56fd\\u653f\\u6cbb\\u4f53\\u5236\\u6539\\u9769\\u5148\\u58f0\\u7684\\u662f(   )\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"1\",\"ans\":[\"\\u3010\\u6bdb\\u6cfd\\u4e1c\\u3011\",\"\\u3010\\u9093\\u5c0f\\u5e73\\u3011\",\"\\u3010\\u80e1\\u9526\\u6d9b\\u3011\",\"\\u3010\\u4e60\\u8fd1\\u5e73\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\u201c\\u4e3b\\u4e49\\u8b6c\\u5982\\u4e00\\u9762\\u65d7\\u5b50,\\u65d7\\u5b50\\u7acb\\u8d77\\u6765\\u4e86,\\u5927\\u5bb6\\u624d\\u6709\\u6240\\u6307\\u671b,\\u624d\\u77e5\\u6240\\u8d8b\\u8d74\\u201d\\u3002\\u8fd9\\u53e5\\u8bdd\\u662f()\\u8bf4\\u7684\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"0\",\"ans\":[\"\\u3010\\u6bdb\\u6cfd\\u4e1c\\u3011\",\"\\u3010\\u9093\\u5c0f\\u5e73\\u3011\",\"\\u3010\\u5468\\u6069\\u6765\\u3011\",\"\\u3010\\u4e60\\u8fd1\\u5e73\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\u4e2d\\u5171\\u5341\\u4e5d\\u5927\\u7684\\u4e3b\\u9898\\u8981\\u56de\\u7b54\\u7684\\u7b2c\\u4e00\\u4e2a\\u95ee\\u9898\\u662f(  )\\u95ee\\u9898\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"2\",\"ans\":[\"\\u3010\\u5b9e\\u8df5\\u3011\",\"\\u3010\\u7ecf\\u6d4e\\u3011\",\"\\u3010\\u65d7\\u5e1c\\u3011\",\"\\u3010\\u6587\\u5316\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\u4e2d\\u5171\\u5341\\u4e5d\\u5927\\u7684\\u4e3b\\u9898\\u4e2d,\\u5bf9\\u5f85\\u5c0f\\u5eb7\\u793e\\u4f1a\\u7684\\u6001\\u5ea6\\u662f()\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"2\",\"ans\":[\"\\u3010\\u8ba1\\u5212\\u5efa\\u6210\\u3011\",\"\\u3010\\u52aa\\u529b\\u5efa\\u6210\\u3011\",\"\\u3010\\u5168\\u9762\\u5efa\\u6210\\u3011\",\"\\u3010\\u90e8\\u5206\\u5efa\\u6210\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\u515a\\u7684\\u5341\\u4e5d\\u5927\\u6307\\u51fa\\uff0c\\u53d1\\u6325\\u5e02\\u573a\\u5728\\u8d44\\u6e90\\u914d\\u7f6e\\u4e2d\\u7684\\uff08\\uff09\\u4f5c\\u7528\\uff0c\\u66f4\\u597d\\u53d1\\u6325\\u653f\\u5e9c\\u4f5c\\u7528\\uff0c\\u5efa\\u7acb\\u5b8c\\u5584\\u7684\\u5b8f\\u89c2\\u8c03\\u63a7\\u4f53\\u7cfb\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"2\",\"ans\":[\"\\u3010\\u57fa\\u7840\\u6027\\u3011\",\"\\u3010\\u5173\\u952e\\u6027\\u3011\",\"\\u3010\\u51b3\\u5b9a\\u6027\\u3011\",\"\\u3010\\u652f\\u67f1\\u6027\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":2,\"title\":\"\\u4e2d\\u56fd\\u7279\\u8272\\u793e\\u4f1a\\u4e3b\\u4e49\\u4e8b\\u4e1a\\u603b\\u4f53\\u5e03\\u5c40\\u662f(),\\u6218\\u7565\\u5e03\\u5c40\\u662f()\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"1,2\",\"ans\":[\"\\u3010\\u4e09\\u4f4d\\u4e00\\u4f53\\u3011\",\"\\u3010\\u4e94\\u4f4d\\u4e00\\u4f53\\u3011\",\"\\u3010\\u56db\\u4e2a\\u5168\\u9762\\u3011\",\"\\u3010\\u516d\\u4e2a\\u5168\\u9762\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":2,\"title\":\"\\u7531\\u4e8e\\u82cf\\u4e1c\\u5267\\u53d8,\\u4e0a\\u4e16\\u7eaa80\\u5e74\\u4ee3\\u672b90\\u5e74\\u4ee3\\u521d,\\u8d44\\u672c\\u4e3b\\u4e49\\u9f13\\u5439\\u7684\\u7406\\u8bba\\u6709(  )\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"0,1,2\",\"ans\":[\"\\u3010\\u793e\\u4f1a\\u4e3b\\u4e49\\u5931\\u8d25\\u8bba\\u3011\",\"\\u3010\\u5386\\u53f2\\u7ec8\\u7ed3\\u8bba\\u3011\",\"\\u3010\\u4e2d\\u56fd\\u5d29\\u6e83\\u8bba\\u3011\",\"\\u3010\\u4e2d\\u56fd\\u5a01\\u80c1\\u8bba\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\u4e2d\\u56fd\\u7279\\u8272\\u793e\\u4f1a\\u4e3b\\u4e49\\u8fdb\\u5165\\u4e86\\u65b0\\u65f6\\u4ee3,\\u8fd9\\u662f\\u4e2d\\u5171\\u5341\\u4e5d\\u5927\\u4f5c\\u51fa\\u7684\\u4e00\\u4e2a\\u91cd\\u5927()\\u5224\\u65ad\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"1\",\"ans\":[\"\\u3010\\u7ecf\\u6d4e\\u3011\",\"\\u3010\\u653f\\u6cbb\\u3011\",\"\\u3010\\u601d\\u60f3\\u3011\",\"\\u3010\\u7406\\u8bba\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\u4e0b\\u5217\\u5173\\u4e8e\\u4e60\\u8fd1\\u5e73\\u65b0\\u65f6\\u4ee3\\u4e2d\\u56fd\\u7279\\u8272\\u793e\\u4f1a\\u4e3b\\u4e49\\u601d\\u60f3\\u7684\\u8bf4\\u6cd5\\u4e2d,\\u4e0d\\u6b63\\u786e\\u7684\\u662f()\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"3\",\"ans\":[\"\\u3010\\u662f\\u9a6c\\u514b\\u601d\\u4e3b\\u4e49\\u4e2d\\u56fd\\u5316\\u7684\\u6700\\u65b0\\u7ed3\\u679c\\u3011\",\"\\u3010\\u662f\\u515a\\u548c\\u4eba\\u6c11\\u5b9e\\u8df5\\u7ecf\\u9a8c\\u548c\\u96c6\\u4f53\\u667a\\u6167\\u7684\\u7ed3\\u6676\\u3011\",\"\\u3010\\u662f\\u4e2d\\u56fd\\u7cbe\\u795e\\u7684\\u65f6\\u4ee3\\u7cbe\\u534e\\u3011\",\"\\u3010\\u662f\\u56fd\\u5bb6\\u7ecf\\u6d4e\\u751f\\u6d3b\\u548c\\u6587\\u5316\\u751f\\u6d3b\\u7684\\u6839\\u672c\\u6307\\u9488\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\u4e60\\u8fd1\\u5e73\\u65b0\\u65f6\\u4ee3\\u4e2d\\u56fd\\u7279\\u8272\\u793e\\u4f1a\\u4e3b\\u4e49\\u601d\\u60f3\\u88ab\\u660e\\u786e\\u5199\\u5165\\u515a\\u7ae0\\u7684\\u65e5\\u671f\\u662f( )\",\"answer\":{\"nums\":\"4\",\"rs\":\"2\",\"ans\":[\"\\u30102017-10-18\\u3011\",\"\\u30102017-10-19\\u3011\",\"\\u30102017-10-24\\u3011\",\"\\u30102017-10-25\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\u4e2d\\u56fd\\u68a6\\u5145\\u6ee1\\u4e86()\\u7684\\u7406\\u5ff5\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"1\",\"ans\":[\"\\u3010\\u987a\\u5176\\u81ea\\u7136\\u3011\",\"\\u3010\\u548c\\u8c10\\u5171\\u751f\\u3011\",\"\\u3010\\u5927\\u56fd\\u5d1b\\u8d77\\u3011\",\"\\u3010\\u901f\\u5ea6\\u4e3a\\u738b\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\u4e2d\\u56fd\\u68a6\\u7684\\u6838\\u5fc3\\u662f\\u5b9e\\u73b0()\\u6216\\u6574\\u4f53\\u7684\\u4ef7\\u503c\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"2\",\"ans\":[\"\\u3010\\u4e2a\\u4f53\\u3011\",\"\\u3010\\u90e8\\u5206\\u3011\",\"\\u3010\\u96c6\\u4f53\\u3011\",\"\\u3010\\u4ee5\\u4e0a\\u90fd\\u4e0d\\u5bf9\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\u4e60\\u8fd1\\u5e73\\u6307\\u51fa,\\u4e00\\u4e2a\\u56fd\\u5bb6\\u3001\\u4e00\\u4e2a\\u6c11\\u65cf\\u7684\\u5f3a\\u76db,\\u603b\\u662f\\u4ee5()\\u5174\\u76db\\u4e3a\\u652f\\u6491\\u7684\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"2\",\"ans\":[\"\\u3010\\u7ecf\\u6d4e\\u3011\",\"\\u3010\\u5236\\u5ea6\\u3011\",\"\\u3010\\u6587\\u5316\\u3011\",\"\\u3010\\u751f\\u6001\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\u4e2d\\u56fd\\u68a6\\u7684\\u7b2c\\u4e00\\u8981\\u4e49\\u662f\\u5b9e\\u73b0()\\u8fdb\\u4e00\\u6b65\\u8dc3\\u5347\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"3\",\"ans\":[\"\\u3010\\u6295\\u8d44\\u3011\",\"\\u3010\\u6d88\\u8d39\\u3011\",\"\\u3010\\u7a0e\\u6536\\u3011\",\"\\u3010\\u7efc\\u5408\\u56fd\\u529b\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\u201c\\u516b\\u4e2a\\u660e\\u786e\\u201d\\u504f\\u91cd\\u4e8e()\\u5c42\\u9762\\u7684\\u9ad8\\u5ea6\\u6982\\u62ec\\u548c\\u51dd\\u7ec3\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"3\",\"ans\":[\"\\u3010  \\u7ed3\\u6784  \\u3011\",\"\\u3010 \\u6280\\u672f \\u3011\",\"\\u3010  \\u5b9e\\u8df5  \\u3011\",\"\\u3010  \\u7406\\u8bba  \\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\u4e60\\u8fd1\\u5e73\\u6307\\u51fa,()\\u662f\\u638c\\u63e1\\u9a6c\\u514b\\u601d\\u4e3b\\u4e49\\u5b8c\\u6574\\u79d1\\u5b66\\u4f53\\u7cfb\\u7684\\u91cd\\u8981\\u524d\\u63d0\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"2\",\"ans\":[\"\\u3010\\u9a6c\\u514b\\u601d\\u4e3b\\u4e49\\u7ecf\\u6d4e\\u5b66\\u3011\",\"\\u3010\\u9a6c\\u514b\\u601d\\u4e3b\\u4e49\\u653f\\u6cbb\\u5b66\\u3011\",\"\\u3010\\u9a6c\\u514b\\u601d\\u4e3b\\u4e49\\u54f2\\u5b66\\u3011\",\"\\u3010\\u9a6c\\u514b\\u601d\\u4e3b\\u793e\\u4f1a\\u5b66\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\u4e60\\u8fd1\\u5e73\\u65b0\\u65f6\\u4ee3\\u4e2d\\u56fd\\u7279\\u8272\\u793e\\u4f1a\\u4e3b\\u4e49\\u601d\\u60f3\\u6700\\u6df1\\u539a\\u7684\\u7406\\u8bba\\u6839\\u6e90\\u662f()\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"0\",\"ans\":[\"\\u3010\\u9a6c\\u514b\\u601d\\u4e3b\\u4e49\\u3011\",\"\\u3010\\u4e09\\u4e2a\\u4ee3\\u8868\\u601d\\u60f3\\u3011\",\"\\u3010\\u6bdb\\u6cfd\\u4e1c\\u601d\\u60f3\\u3011\",\"\\u3010\\u9093\\u5c0f\\u5e73\\u7406\\u8bba\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\u4e2d\\u56fd\\u7684\\u53d1\\u5c55\\u5b9e\\u8df5\\u8bc1\\u660e()\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"3\",\"ans\":[\"\\u3010\\u897f\\u65b9\\u5236\\u5ea6\\u6a21\\u5f0f\\u662f\\u6781\\u5176\\u5931\\u8d25\\u7684\\u3011\",\"\\u3010\\u4e2d\\u56fd\\u7279\\u8272\\u793e\\u4f1a\\u4e3b\\u4e49\\u53ef\\u4ee5\\u7167\\u642c\\u3011\",\"\\u3010\\u53d1\\u5c55\\u6a21\\u5f0f\\u662f\\u56fa\\u5b9a\\u7684\\u3011\",\"\\u3010\\u4e16\\u754c\\u4e0a\\u6ca1\\u6709\\u4e00\\u79cd\\u666e\\u904d\\u4f7f\\u7528\\u7684\\u53d1\\u5c55\\u6a21\\u5f0f\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\u4e0b\\u5217\\u8bf4\\u6cd5\\u4e2d\\u9519\\u8bef\\u7684\\u662f()\",\"answer\":{\"nums\":\"4\",\"rs\":\"2\",\"ans\":[\"\\u3010\\u5b9e\\u73b0\\u4e2d\\u56fd\\u68a6\\u79bb\\u4e0d\\u5f00\\u548c\\u5e73\\u7684\\u56fd\\u9645\\u73af\\u5883\\u3011\",\"\\u3010\\u5b9e\\u73b0\\u4e2d\\u56fd\\u68a6\\u79bb\\u4e0d\\u5f00\\u7a33\\u5b9a\\u7684\\u56fd\\u9645\\u79e9\\u5e8f\\u3011\",\"\\u3010\\u5728\\u7ef4\\u62a4\\u4e16\\u754c\\u548c\\u5e73\\u4e0e\\u53d1\\u5c55\\u7684\\u65b9\\u9762\\u4e2d\\u56fd\\u7684\\u80fd\\u529b\\u4e00\\u65e5\\u6309\\u6709\\u6240\\u6b20\\u7f3a\\u3011\",\"\\u3010\\u4e2d\\u56fd\\u662f\\u4e16\\u754c\\u4e0a\\u6700\\u5927\\u7684\\u53d1\\u5c55\\u4e2d\\u56fd\\u5bb6\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\u53d1\\u5c55\\u4e0d\\u5e73\\u8861\\u4e3b\\u8981\\u5305\\u62ec()\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"3\",\"ans\":[\"\\u3010\\u57ce\\u4e61\\u4e0d\\u5e73\\u8861\\u3011\",\"\\u3010\\u5730\\u533a\\u4e0d\\u5e73\\u8861\\u3011\",\"\\u3010\\u4eba\\u7fa4\\u4e0d\\u5e73\\u8861\\u3011\",\"\\u3010\\u4ee5\\u4e0a\\u90fd\\u662f\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":1,\"title\":\"\\u7531\\u57fa\\u672c\\u77db\\u76fe\\u6d3e\\u751f\\u7684\\u4e3b\\u8981\\u77db\\u76fe\\u7684\\u7279\\u70b9\\u662f()\\u3002\",\"answer\":{\"nums\":\"4\",\"rs\":\"3\",\"ans\":[\"\\u3010\\u5c45\\u4e8e\\u4e3b\\u5bfc\\u5730\\u4f4d\\u3011\",\"\\u3010\\u8d77\\u6838\\u5fc3\\u4f5c\\u7528\\u3011\",\"\\u3010\\u80fd\\u652f\\u914d\\u5176\\u4ed6\\u77db\\u76fe\\u53d1\\u5c55\\u7684\\u77db\\u76fe\\u3011\",\"\\u3010\\u4ee5\\u4e0a\\u90fd\\u662f\\u3011\"],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"},{\"type\":0,\"title\":\"\\u9093\\u5c0f\\u5e73\\u5f3a\\u8c03\\u5c06\\u6211\\u56fd\\u5efa\\u8bbe\\u4e3a\\u4e00\\u4e2a\\u53d1\\u8fbe\\u56fd\\u9645\\u3002\",\"answer\":{\"nums\":\"2\",\"rs\":\"0\",\"ans\":[],\"img\":\"\",\"t_img\":\"\",\"t_audio\":\"\",\"t_video\":\"\",\"t_video_img\":\"\"},\"parsing\":\"\",\"score\":\"2.0\",\"score2\":\"0.0\"}]",
			//		"name": (str),
			//	},
			//}).Result()
			//if err != nil {
			//	panic(err)
			//}

			//读取消息 XReadGroup读取的是一组未被分配给消费者的,但尚未被确认的消息ID。被确认后在读取,消息就会减少.已经确认的消息不会出现在这里.
			////读取消息 ,需要前边有xadd添加消息.使用cli或者代码调用xadd.XReadGroup读取的是一组已经传递但尚未被确认的消息ID。被确认后在读取,消息就会减少

			//读组1,读消息的准备工作.把消费者添加到消费者组中,上一步是流跟消费者组绑定,间接的流与消费者绑定了.下一步XReadGroup 0-0指令就可以读取消息,否则为返回的是空
			messages, err := client.XReadGroup(ctx, &redis.XReadGroupArgs{
				Group:    group,
				Consumer: consumer,
				Streams:  []string{stream, start}, //获取当前分配给此消费者的未被ack的1个消息
				//Count:    int64(count),
				Block: 0,     //0无限等待,堵塞式消费者,就是无新消息时,执行此命令会一直在此等待,直到有新消息到达或超时为止.非堵塞式,就是block赋值大于0时候,无新消息则立即返回空结果,样，消费者可以快速检查是否有新消息，如果没有就去做其他事情.
				NoAck: false, //真,则xpendding读取为空,false时可以读到消息
			}).Result()
			if err != nil {
				defer func() {
					if r := recover(); r != nil {
						fmt.Println("Recovered from panic:", r)
					}
				}()
				panic(err)
				println(messages)
			}
			//读消息2.正是读取消息
			messages1, err := client.XReadGroup(ctx, &redis.XReadGroupArgs{
				Group:    group,
				Consumer: consumer,
				Streams:  []string{stream, "0-0"}, //获取所有分配给此消费者的未被ack的消息
				//Count:    int64(count),
				Block: 0,     //0无限等待,堵塞式消费者,就是无新消息时,执行此命令会一直在此等待,直到有新消息到达或超时为止.非堵塞式,就是block赋值大于0时候,无新消息则立即返回空结果,样，消费者可以快速检查是否有新消息，如果没有就去做其他事情.
				NoAck: false, //真,则xpendding读取为空,false时可以读到消息
			}).Result()
			if err != nil {
				panic(err)
			}
			println(messages1)

			// XInfoGroups , 获取消费者组未被确认的消息   xinfo groups mystream
			//groupinfo0, _ := client.XInfoGroups(ctx, stream).Result()
			//fmt.Println("XInfoGroups: ", groupinfo0)
			//fmt.Println("XInfoGroups[0].pending: ", groupinfo0[0].Pending)

			//// XInfoStream 获取所有流的消息,也就是所有产生的消息.
			info, err := client.XInfoStream(ctx, stream).Result()
			if err != nil {
				panic(err)
			}
			fmt.Println("XInfoStream: ", info)
			count2, err := client.XPendingExt(ctx, &redis.XPendingExtArgs{

				Stream: stream,
				Group:  group,
				Start:  "-",
				End:    "+",
				Count:  int64(count),
			}).Result()
			println(count2)
			if err != nil {
				panic(err)
			}
			//{"1":{"rs":0,"isok":"0","score":"0"},"2":{"rs":0,"isok":"0","score":"0"},}

			send_chan <- messages1
			//time.Sleep(10 * time.Second)

			// XInfoGroups , 获取消费者组消息   xinfo groups mystream
			//groupinfo, _ := client.XInfoGroups(ctx, stream).Result()
			//fmt.Println("XInfoGroups: ", groupinfo)
			//fmt.Println("XInfoGroups[0].pending: ", groupinfo[0].Pending)
			// XPending，获取待处理的消息,未被ack确认的消息
			//count1, err := client.XPending(ctx, stream, group).Result()
			//if err != nil {
			//	panic(err)
			//}
			//fmt.Println("XPending 未确认消息前的消息信息情况: ", count1) //待处理消息中最小和最大的ID，然后列出消费者组中每个至少有一个待处理消息的消费者及其待处理消息的数量。
			//fmt.Println("XPending Consumers: ", count1.Consumers)
			//fmt.Println("XPending count: ", count1.Count) //未确认消息的个数

			////// XInfoConsumer ，获取消费者组的成员信息 ,包括流和消费者组的相关信息；
			//consumerinfo, _ := client.XInfoConsumers(ctx, stream, group).Result()
			//fmt.Println("XInfoConsumers: ", consumerinfo)
		default:
			//println("默认")
		}

	}
}

// 在上述代码中，我们首先创建了一个Redis客户端并初始化了必要的参数。然后，我们使用`XClaim`方法并设置了`RETRYCOUNT`参数为`5`，这意味着消息在当前消费者处理失败后，还可以被重新分配给消费者最多5次。如果消息处理成功，`RETRYCOUNT`将被重置为`0`。如果在5次重试后消息仍然没有被成功处理，它可能会被发送到死信队列，或者根据消费者组的配置被丢弃。【1】

func writedatabase(ctx context.Context, send_chan chan []redis.XStream, stream string, group string, client *redis.Client) { //messages1 []redis.XStream
	println("进入协程写数据库")
	for {

		select {

		case messages1, ok := <-send_chan:

			println("开始写数据")
			println("messages1:", messages1)
			if !ok {
				// 这意味着通道已经空了，并且已被关闭
				fmt.Println("处理redis数据完毕")
				return
			}

			//fmt.Printf("Received message_values['name']: %v\n", message.Values["name"])
			//读取所有消息

			for i, message := range messages1[0].Messages {
				println(i)
				fmt.Printf("Received message_ID: %v\n", message.ID)
				fmt.Printf("Received message_values: %v\n", message.Values)

				var a1 int = 0
				//写入数据库.写3次,如果都失败,则停止
				done := false
				for !done {
					a1 = a1 + 1

					if a1 == 2 {
						done = true
						a1 = 0
					}
					// 执行一些操作，然后在某个时刻将done设置为true
					effect_row, err := g.Model("test_redis").Data(g.Map{"name": message}).Insert()
					print("db result", effect_row)
					//time.Sleep(10 * time.Second)
					if err == nil { //插入成功
						// XAck , 将消息的最高id,标记为已处理.标记后,则读取xpending则为0
						err = client.XAck(ctx, stream, group, message.ID).Err()
						done = true

						//if err != nil {
						//	fmt.Println("XAck err: ", err)
						//} else {
						//	fmt.Println("XAck ok: ", err)
						//}

					} else { //写库异常,可以把写入失败的消息转移给其他进程的消费者
						println("写库异常")
						//print(result)
						//// XPending，获取待处理的消息,未被ack确认的消息
						//count1, err := client.XPending(ctx, stream, group).Result()
						//if err != nil {
						//	panic(err)
						//}
						////fmt.Println("XPending 未确认消息前的消息信息情况: ", count1) //待处理消息中最小和最大的ID，然后列出消费者组中每个至少有一个待处理消息的消费者及其待处理消息的数量。
						////fmt.Println("XPending Consumers: ", count1.Consumers)
						//fmt.Println("XPending count: ", count1.Count) //未确认消息的个数
						////fmt.Println("XPending Higher: ", count1.Higher) //未确认消息的最高id
						////fmt.Println("XPending Lower: ", count1.Lower)   ////未确认消息的最小id
						//
						//if count1.Count > 0 { //待处理消息不为0,则执行消息转移,重新执行
						//
						//	// 获取消费者组信息,目的是获取未被ack的消息id,然后转移所有权重新加入消息这组中.已经确认的消息不会出现在这里.
						//	groupinfo, _ := client.XInfoGroups(ctx, stream).Result()
						//	if err != nil {
						//		panic(err)
						//	}
						//	for _, noack_message := range groupinfo {
						//		fmt.Printf("发现未被ack的消息,Received message_ID: %v\n", noack_message.LastDeliveredID)
						//		//fmt.Printf("Received message_values: %v\n", message2.Values)
						//		//fmt.Printf("Received message_values['name']: %v\n", message2.Values["name"])
						//		//写入数据库
						//
						//		// 执行XCLAIM命令// 使用XCLAIM命令转移消息的所有权给另外一个消费者
						//		claim, err := client.XClaim(ctx, &redis.XClaimArgs{
						//			Stream:   stream,
						//			Group:    group,
						//			Consumer: "consumer1",
						//			//MinIdle:  2000,
						//			//IDLE:        &idleTime,
						//			//Time:        &redisTime,
						//			//JustID:      true, // 只返回消息ID
						//			//Force:       true, // 强制覆盖消息的最后一次尝试时间
						//
						//			Messages: []string{noack_message.LastDeliveredID},
						//		}).Result()
						//		if err != nil {
						//			log.Fatalf("XCLAIM转移命令执行失败: %v", err)
						//		}
						//		// 输出结果claim结果
						//		for _, msg := range claim {
						//			fmt.Printf("xclaim转移后的消息ID: %s, 消息值: %s\n", msg.ID, msg.Values)
						//		}
						//}

						//}
					}
				}
			}
			println("写库完毕,发送可接收标记")
			whether_receive_chan <- true //写继续可接收通道真
		//case <-time.After(time.Second * 3):
		//	fmt.Println("超时")
		default:
			//fmt.Println("默认")

		}

	}
}
