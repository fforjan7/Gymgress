import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

import '../models/chartInfo.dart';
import '../models/exercisesinfo.dart';
import '../utils/dbhelper.dart';
import '../widgets/chart.dart';
import 'newvideoscreen.dart';

class ExerciseScreen extends StatefulWidget {
  static const routeName = '/exercises';

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  String name;
  int id;
  bool _loadedInitData = false;

  DBHelper dbExercisesInfo;
  List<ExerciseInfo> exerciseInfos;
  List<ChartInfo> exercisesChartInfos;
  int _weight;

  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  void dispose() {
    _chewieController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      id = routeArgs['id'];
      name = routeArgs['name'];
      _loadedInitData = true;
      _refreshInfos();
    }
    super.didChangeDependencies();
  }

  ChewieController _setChewieController(videoController) {
    VideoPlayerController controller = videoController;
    return ChewieController(
      videoPlayerController: controller,
      aspectRatio: controller.value.aspectRatio,
      autoPlay: false,
      looping: false,
      autoInitialize: true,
    );
  }

  @override
  void initState() {
    super.initState();
    dbExercisesInfo = DBHelper();
    exerciseInfos = [];
    exercisesChartInfos = [];
  }

  Future<String> _getVideosDirPath() async {
    final Directory _appDocDir = await getApplicationDocumentsDirectory();
    final Directory _appDocDirVideos =
        Directory('${_appDocDir.path}/VideoGallery/');
    return _appDocDirVideos.path;
  }

  void _refreshInfos() {
    dbExercisesInfo.getExerciseInfos(id).then((exerciseInfo) {
      setState(() {
        exerciseInfos.clear();
        exerciseInfos.addAll(exerciseInfo);
        if (exerciseInfos.length > 0) {
          exerciseInfos.sort((a, b) {
            return a.date.compareTo(b.date);
          });
          _weight = exerciseInfos.last.weight;
        }
      });
      dbExercisesInfo.getExerciseChartInfos(id).then((chartInfo) {
        setState(() {
          exercisesChartInfos.clear();
          exercisesChartInfos.addAll(chartInfo);
        });
      });
      if (exerciseInfos.length > 0) {
        _getVideosDirPath().then((path) {
          setState(() {
            _videoPlayerController =
                VideoPlayerController.file(File('$path/video$id'));
            _chewieController = _setChewieController(_videoPlayerController);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery;
    mediaQuery = MediaQuery.of(context);
    void _pauseChewie() {
      if (_chewieController != null) {
        _chewieController.pause();
        _chewieController.seekTo(Duration(seconds: 0));
      }
    }

    return WillPopScope(
      onWillPop: () async {
        _pauseChewie();
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            name,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: mediaQuery.size.height * 0.02),
              height: mediaQuery.size.height * 0.3,
              width: mediaQuery.size.width * 1,
              color: Theme.of(context).primaryColor,
              child: (exercisesChartInfos.length > 0)
                  ? Chart(
                      data: exercisesChartInfos,
                    )
                  : Center(
                      child: Text(
                        'No Data',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 25.0,
                        ),
                      ),
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Current PR:',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(width: mediaQuery.size.width * 0.04),
                Text(
                  _weight != null ? '$_weight' : '???',
                  style: TextStyle(
                    color: Theme.of(context).textSelectionColor,
                    fontSize: 40.0,
                  ),
                ),
                SizedBox(width: mediaQuery.size.width * 0.01),
                Container(
                  height: 30,
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'kg',
                    style: TextStyle(
                      color: Theme.of(context).textSelectionColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: mediaQuery.size.height * 0.01),
              height: mediaQuery.size.height * 0.4,
              width: mediaQuery.size.width * 1,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: (exerciseInfos.length > 0 && _chewieController != null)
                  ? FittedBox(
                      fit: BoxFit.contain,
                      child: Chewie(
                        controller: _chewieController,
                      ),
                    )
                  : Center(
                      child: Text(
                        'Video is not inserted',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 25.0,
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: mediaQuery.size.height * 0.02,
              ),
              child: RaisedButton(
                padding: EdgeInsets.symmetric(
                  vertical: mediaQuery.size.height * 0.01,
                  horizontal: mediaQuery.size.height * 0.04,
                ),
                child: Text(
                  'Add video',
                  style: TextStyle(fontSize: 25.0),
                ),
                onPressed: () {
                  _pauseChewie();
                  Navigator.of(context)
                      .pushNamed(NewVideoScreen.nameRoute, arguments: {
                    'id': id,
                  }).then((_) {
                    _refreshInfos();
                  });
                },
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textSelectionColor,
                elevation: 15.0,
                splashColor: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
