import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class NewPhotoScreen extends StatefulWidget {
  static const nameRoute = '/newPhoto';

  @override
  _NewPhotoScreenState createState() => _NewPhotoScreenState();
}

class _NewPhotoScreenState extends State<NewPhotoScreen> {
  File _image;
  int _weight;
  String _imageName;
  String _imageExtension;
  DateTime _pickedDate;
  String _imagesPath;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery;
    mediaQuery = MediaQuery.of(context);

    Future<String> _createImagesDir() async {
      final Directory _appDocDir = await getApplicationDocumentsDirectory();
      final Directory _appDocDirImages =
          Directory('${_appDocDir.path}/Gallery/');
      if (await _appDocDirImages.exists()) {
        return _appDocDirImages.path;
      } else {
        final Directory _appDocDirNewImages =
            await _appDocDirImages.create(recursive: true);
        return _appDocDirNewImages.path;
      }
    }

    void _pickImage() async {
      final PickedFile pickedImage =
          await ImagePicker().getImage(source: ImageSource.gallery);
      if (pickedImage == null) return;
      _imageName = basename(pickedImage.path);
      _imageExtension = extension(pickedImage.path);
      setState(() {
        _image = File(pickedImage.path);
      });
    }

    void _saveImage() async {
      _imagesPath = await _createImagesDir();
      if (await File('$_imagesPath/$_imageName$_imageExtension').exists()) {
        print('File exists');
        return;
      } else {
        _image = await _image.copy('$_imagesPath/$_imageName$_imageExtension');
        print('$_imagesPath');
        Navigator.of(context).pop();
      }
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
                  child: Text(
                    'Enter your \ncurrent weight:',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Container(
                  height: mediaQuery.size.height * 0.08,
                  width: mediaQuery.size.width * 0.2,
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
              _pickImage();
            },
            child: Text(
              'Pick image',
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
            child: _image != null ? Image.file(_image) : Text(''),
          ),
          RaisedButton(
            onPressed: () {
              _saveImage();
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
