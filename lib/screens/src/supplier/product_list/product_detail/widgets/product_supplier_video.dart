import 'package:anth_package/anth_package.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/widgets/widgets.dart';
import 'package:video_player/video_player.dart';

class ProductSupplierVideo extends StatefulWidget {
  final ProductImage image;

  const ProductSupplierVideo(
    this.image, {
    Key? key,
  }) : super(key: key);

  @override
  _ProductSupplierVideoState createState() => _ProductSupplierVideoState();
}

class _ProductSupplierVideoState extends State<ProductSupplierVideo>
    with AutomaticKeepAliveClientMixin<ProductSupplierVideo> {
  late VideoPlayerController _controller;
  final _videoStreamController = BehaviorSubject<bool>()..value = false;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.image.value ?? '',
      videoPlayerOptions: VideoPlayerOptions(),
    )..initialize().then((_) {
        _videoStreamController.value = true;
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
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      width: context.screenSize.width,
      child: StreamBuilder<bool>(
        stream: _videoStreamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!) {
            return Chewie(
              controller: _chewieController,
            );
          }
          return const Center(child: KayleeLoadingIndicator());
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
