import 'package:anth_package/anth_package.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/widgets/widgets.dart';
import 'package:video_player/video_player.dart';

class ProductSupplierVideo extends StatefulWidget {
  final ProductImage image;

  ProductSupplierVideo(this.image);

  @override
  _ProductSupplierVideoState createState() => _ProductSupplierVideoState();
}

class _ProductSupplierVideoState extends State<ProductSupplierVideo>
    with AutomaticKeepAliveClientMixin<ProductSupplierVideo> {
  VideoPlayerController _controller;
  final _videoStreamController = BehaviorSubject<bool>()..value = false;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.image.value ?? '',
      videoPlayerOptions: VideoPlayerOptions(),
    )..initialize().then((value) {
        _videoStreamController.value = _controller.value.initialized;
        _chewieController = ChewieController(
          videoPlayerController: _controller,
          autoPlay: true,
          deviceOrientationsOnEnterFullScreen: [DeviceOrientation.portraitUp],
          autoInitialize: true,
        );
      });
  }

  @override
  void dispose() {
    _videoStreamController.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      width: context.screenSize.width,
      child: StreamBuilder<bool>(
        stream: _videoStreamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data)
            return Chewie(
              controller: _chewieController,
            );
          return Center(child: KayleeLoadingIndicator());
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
