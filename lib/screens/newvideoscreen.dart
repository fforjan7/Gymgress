import 'dart:io';

import 'package:Gymgress/models/bodyweightinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/DBBodyweightInfo.dart';

class NewVideoScreen extends StatefulWidget {
  static const nameRoute = '/newVideo';

  @override
  _NewVideoScreenState createState() => _NewVideoScreenState();
}

class _NewVideoScreenState extends State<NewVideoScreen> {
  int id;
  File _video;
  int _weight;
  String _videoName;
  DateTime _pickedDate;
  String videosPath;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery;
    mediaQuery = MediaQuery.of(context);

    Future<String> _getVideosDirPath() async {
      final Directory _appDocDir = await getApplicationDocumentsDirectory();
      final Directory _appDocDirVideos =
          Directory('${_appDocDir.path}/VideoGallery/');
      return _appDocDirVideos.path;
    }

    void _newVideoFile(PickedFile pickedVideo) {
      _videoName = 'video$id';
      setState(() {
        _video = File(pickedVideo.path);
      });
    }

    void _pickVideo() async {
      final PickedFile pickedVideo =
          await ImagePicker().getVideo(source: ImageSource.gallery);
      if (pickedVideo == null) return;
      if (_videoName == null) {
        _newVideoFile(pickedVideo);
      } else {
        videosPath = await _getVideosDirPath();
        //true ili false??
        Directory('$videosPath/$_videoName').delete(recursive: true);
        _newVideoFile(pickedVideo);
      }
    }

    void _saveVideo() async {
      videosPath = await _getVideosDirPath();
      if (_video == null) return;
      _video = await _video.copy('$videosPath/$_videoName');
      Navigator.of(context).pop();
    }

    void _pickDate() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
      ).then((pickedDate) {
        if (pickedDate == null) return;
        setState(() {
          _pickedDate = pickedDate;
        });
      });
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'Import New Data',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: mediaQuery.size.height * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: mediaQuery.size.height * 0.08,
                  width: mediaQuery.size.width * 0.4,
                  alignment: Alignment.center,
                  child: Text(
                    'Enter personal record:',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Container(
                  height: mediaQuery.size.height * 0.08,
                  width: mediaQuery.size.width * 0.25,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.all(mediaQuery.size.height * 0.006),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Weight',
                      ),
                      onChanged: (newWeight) {
                        _weight = int.parse(newWeight);
                        //Save it ...
                        print('$_weight');
                      },
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: mediaQuery.size.height * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  _pickedDate != null
                      ? 'Chosen date: ${DateFormat('dd/MM/yyyy').format(_pickedDate)}'
                      : 'No Chosen Date yet.',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 20.0,
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    _pickDate();
                  },
                  child: Text(
                    'Choose date',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  elevation: 17.0,
                  color: Theme.of(context).primaryColor,
                )
              ],
            ),
          ),
          RaisedButton(
            onPressed: () {
              _pickVideo();
            },
            child: Text(
              'Pick video',
              style: TextStyle(
                color: Theme.of(context).accentColor,
              ),
            ),
            elevation: 17.0,
            color: Theme.of(context).primaryColor,
          ),
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            height: mediaQuery.size.height * 0.4,
            width: mediaQuery.size.width * 1,
            margin: EdgeInsets.symmetric(
              horizontal: mediaQuery.size.height * 0.02,
              vertical: mediaQuery.size.height * 0.03,
            ),
            child: _video != null ? Image.file(_video) : Text(''),
          ),
          RaisedButton(
            onPressed: () {
              if (_video == null || _weight == null || _pickedDate == null)
                return;
              DBBodyweightInfo dbBodyweightInfo = DBBodyweightInfo();
              BodyweightInfo bodyweightInfo =
                  BodyweightInfo(id: 0, date: _pickedDate, weight: _weight);
              dbBodyweightInfo.save(bodyweightInfo);
              _saveVideo();
            },
            child: Text(
              'SAVE',
              style: TextStyle(
                  color: Theme.of(context).textSelectionColor, fontSize: 20.0),
            ),
            elevation: 17.0,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
