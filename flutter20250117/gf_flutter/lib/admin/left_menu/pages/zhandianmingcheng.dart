import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:universal_platform/universal_platform.dart';
// import 'dart:io'    if (dart.library.html) '/js.dart';
import 'dart:js' as js;

class zhandianmingcheng extends StatefulWidget {
  const zhandianmingcheng({Key? key}) : super(key: key);

  @override
  _zhandianmingchengState createState() => _zhandianmingchengState();
}

class _zhandianmingchengState extends State<zhandianmingcheng> {
  @override
  void initState() {
    super.initState();
    print("站点名称init");
  }
  @override
  void dispose() {
    super.dispose();
    print("站点名称dispose");
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child:
// Text('zhandianmingcheng'),
            App());
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        // Example08();
        DefaultTabController(
      length: 1,
      child: Scaffold(
        //  backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
        key: const ValueKey<String>('home_page'),
        appBar: AppBar(
          elevation: 0, //appbar的阴影
          // backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
          title: const Text('Video player example'),
          actions: <Widget>[
            IconButton(
              key: const ValueKey<String>('push_tab'),
              icon: const Icon(Icons.navigation),
              onPressed: () {
                Navigator.push<_PlayerVideoAndPopPage>(
                  context,
                  MaterialPageRoute<_PlayerVideoAndPopPage>(
                    builder: (BuildContext context) => _PlayerVideoAndPopPage(),
                  ),
                );
              },
            )
          ],
          bottom: const TabBar(
            isScrollable: true,
            tabs: <Widget>[
              // Tab(
              //   icon: Icon(Icons.cloud),
              //   text: "Remote",
              // ),
              Tab(icon: Icon(Icons.insert_drive_file), text: "Asset"),
              // Tab(icon: Icon(Icons.list), text: "List example"),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            // _BumbleBeeRemoteVideo(),
            _ButterFlyAssetVideo(),
            //  _ButterFlyAssetVideoInList(),
          ],
        ),
      ),
    );
  }
}

class _ButterFlyAssetVideoInList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _ExampleCard(title: "Item a"),
        _ExampleCard(title: "Item b"),
        _ExampleCard(title: "Item c"),
        _ExampleCard(title: "Item d"),
        _ExampleCard(title: "Item e"),
        _ExampleCard(title: "Item f"),
        _ExampleCard(title: "Item g"),
        Card(
            child: Column(children: <Widget>[
          Column(
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.cake),
                title: Text("Video video"),
              ),
              Stack(
                  alignment: FractionalOffset.bottomRight +
                      const FractionalOffset(-0.1, -0.1),
                  children: <Widget>[
                    _ButterFlyAssetVideo(),
                    Image.asset('assets/flutter-mark-square-64.png'),
                  ]),
            ],
          ),
        ])),
        _ExampleCard(title: "Item h"),
        _ExampleCard(title: "Item i"),
        _ExampleCard(title: "Item j"),
        _ExampleCard(title: "Item k"),
        _ExampleCard(title: "Item l"),
      ],
    );
  }
}

/// A filler card to show the video in a list of scrolling contents.
class _ExampleCard extends StatelessWidget {
  const _ExampleCard({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.airline_seat_flat_angled),
            title: Text(title),
          ),
          ButtonBar(
            children: <Widget>[
              TextButton(
                child: const Text('BUY TICKETS'),
                onPressed: () {
                  /* ... */
                },
              ),
              TextButton(
                child: const Text('SELL TICKETS'),
                onPressed: () {
                  /* ... */
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ButterFlyAssetVideo extends StatefulWidget {
  @override
  _ButterFlyAssetVideoState createState() => _ButterFlyAssetVideoState();
}

class _ButterFlyAssetVideoState extends State<_ButterFlyAssetVideo> {
  late VideoPlayerController _controller;
  String time = "00";

  String total_time = "00";

  Future<ClosedCaptionFile> _loadCaptions() async {
    //进度条拖动产生的效果
    final String fileContents = await DefaultAssetBundle.of(context)
        .loadString('bumble_bee_captions.srt');
    return SubRipCaptionFile(fileContents);
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      'a.mp4',
      closedCaptionFile: _loadCaptions(),
    );

    _controller.addListener(() {
      //实时处理的
      // print(_controller.value.toString());

//       返回 VideoPlayerValue(
//      duration: 0:03:42.468000, //视频总长度
//      size: Size(960.0, 540.0), //视频尺寸,(即宽和高)
//      position: 0:00:59.003000,  //当前已播放位置
//      caption: Instance of 'Caption',
//      buffered: [DurationRange(start: 0:00:00.000000, end: 0:01:45.674000)], //已缓冲的范围
//      isPlaying: true, //是否正在播放
//      isLooping: false, //是否为循环播放
//      isBuffering: falsevolume: 1.0,
//      errorDescription: null  //错误描述.如果不存在则返回为null
//volume: 1, playbackSpeed: 1,//音量
// )
      // print(_controller.value.position.toString().split(".")[0]);
      time = _controller.value.position.toString().split(".")[0];
      total_time = _controller.value.duration.toString().split(".")[0];
      // time_min = _controller.value.position.inMinutes.toString();
      // time_second = _controller.value.position.inSeconds.toString();

      // total_time_hour = _controller.value.duration.inHours.toString();
      // total_time_min = _controller.value.duration.inMinutes.toString();
      // total_time_second = _controller.value.duration.inSeconds.toString();
      setState(() {});
    });

    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
    _controller.setVolume(1.0); //设置音量0-1.0之间
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 20.0),
          ),
          const Text('With assets mp4'),
          Container(
            padding: const EdgeInsets.all(20),
            // width: double.infinity,
            // height: double.infinity,
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
                  //  ClosedCaption(text: _controller.value.caption.text),//字幕
                  _ControlsOverlay(controller: _controller), //控制暂停和播放
                  VideoProgressIndicator(
                    _controller,
                    allowScrubbing: true, //不允许拖动视频
                    padding: EdgeInsets.all(16.0),
                  ), //是否可以拖动的进度条
                  Row(
                    children: <Widget>[
                      Text('$time'),
                      Text('/'),
                      Text('$total_time'),
                      TextButton(
                          onPressed: () {
                            if (UniversalPlatform.isWeb) {
                              var result = js.context
                                  .callMethod("js_fullscreen", ["0"]); //调用的0为索引
                              print(result);
                            }

                            if (UniversalPlatform.isDesktop) {
                              print("isDesktop");
                            }
                          },
                          child: Text("调用js"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BumbleBeeRemoteVideo extends StatefulWidget {
  @override
  _BumbleBeeRemoteVideoState createState() => _BumbleBeeRemoteVideoState();
}

class _BumbleBeeRemoteVideoState extends State<_BumbleBeeRemoteVideo> {
  late VideoPlayerController _controller;

  Future<ClosedCaptionFile> _loadCaptions() async {
    final String fileContents = await DefaultAssetBundle.of(context)
        .loadString('bumble_bee_captions.srt');
    return SubRipCaptionFile(fileContents);
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://www.runoob.com/try/demo_source/mov_bbb.mp4',
      closedCaptionFile: _loadCaptions(),
      //videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),//此句不能加
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
      child: Column(
        children: <Widget>[
          Container(padding: const EdgeInsets.only(top: 20.0)),
          const Text('With remote mp4'),
          Container(
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
                  ClosedCaption(text: _controller.value.caption.text),
                  _ControlsOverlay(controller: _controller),
                  VideoProgressIndicator(_controller, allowScrubbing: true),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, required this.controller})
      : super(key: key);

  static const _examplePlaybackRates = [
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (context) {
              return [
                for (final speed in _examplePlaybackRates)
                  PopupMenuItem(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}

class _PlayerVideoAndPopPage extends StatefulWidget {
  @override
  _PlayerVideoAndPopPageState createState() => _PlayerVideoAndPopPageState();
}

class _PlayerVideoAndPopPageState extends State<_PlayerVideoAndPopPage> {
  late VideoPlayerController _videoPlayerController;
  bool startedPlaying = false;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.asset('big_buck_bunny.mp4');
    _videoPlayerController.addListener(() {
      if (startedPlaying && !_videoPlayerController.value.isPlaying) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  Future<bool> started() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.play();
    startedPlaying = true;
    return true;
    
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 0,
        child: OrientationBuilder(builder: (context, orientation) {
          return Flex(
            //  direction:Axis.horizontal,
            direction: orientation == Orientation.landscape
                ? Axis.vertical
                : Axis.horizontal, //横向-水平
            children: <Widget>[
              Center(
                child: FutureBuilder<bool>(
                  future: started(),
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.data == true) {
                      return AspectRatio(
                        aspectRatio: _videoPlayerController.value.aspectRatio,
                        child: VideoPlayer(_videoPlayerController),
                      );
                    } else {
                      return const Text('waiting for video to load');
                    }
                  },
                ),
              )
            ],
          );
        }));
  }
}

class HomeTile extends StatelessWidget {
  const HomeTile(this.title, this.backgroundColor, this.route);

  final String title;
  final String route;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: backgroundColor,
      child: new InkWell(
        onTap:
            route == null ? null : () => Navigator.of(context).pushNamed(route),
        child: new Center(
          child: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).primaryTextTheme.labelLarge!.copyWith(
                  color:
                      ThemeData.estimateBrightnessForColor(backgroundColor) ==
                              Brightness.dark
                          ? Colors.white
                          : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
