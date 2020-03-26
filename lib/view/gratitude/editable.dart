import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smile/config/constant.dart';
import 'package:smile/config/nets/api_service.dart';
import 'package:smile/generated/i18n.dart';
import 'package:smile/global/icon_font.dart';
import 'package:smile/global/toast.dart';
import 'package:smile/provider/gratitude_provider.dart';
import 'package:smile/utils/utils.dart';
import 'package:smile/widgets/dialog.dart';

import 'item_image.dart';

class EditablePage extends StatefulWidget {
  final String email;

  EditablePage({Key key, @required this.email}) : super(key: key);

  @override
  createState() => _EditablePageState();
}

class _EditablePageState extends State<EditablePage> {
  TextEditingController _notesController = TextEditingController();

  String newFileName = '';
  String imageUrl = '';

  List<String> images = [];
  List<String> imagesName = [];

  @override
  void initState() {
    super.initState();

    _notesController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _notesController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(children: [
              TextField(
                  maxLines: 8,
                  maxLength: 500,
                  controller: _notesController,
                  decoration: InputDecoration(
                      hintText: S.of(context).tipGratitude,
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.all(15.0),
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          height: 1.2, color: Colors.grey, fontSize: 15)),
                  style: TextStyle(
                      height: 1.2, color: Colors.black, fontSize: 15)),
              SizedBox(height: 10),
              GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 3.0,
                      mainAxisSpacing: 3.0),
                  itemBuilder: (_, index) {
                    return index == images.length &&
                            images.length < Constant.IMAGE_MAX_COUNT
                        ? Material(
                            color: Colors.white,
                            child: InkWell(
                                onTap: () {
                                  imageUrl = '';
                                  newFileName = '';
                                  showBottomView(context, (ImageSource source) {
                                    if (null != source) pickerImage(source);
                                  });
                                },
                                child: Container(
                                    child: Icon(IconFont.camera,
                                        size: 40, color: Colors.grey))))
                        : ItemImage(
                            images: images,
                            index: index,
                            deletePressed: () {
                              setState(() {
                                imagesName.removeAt(index);
                                images.removeAt(index);
                              });
                            },
                          );
                  },
                  itemCount: images.length < Constant.IMAGE_MAX_COUNT
                      ? images.length + 1
                      : images.length,
                  physics: new NeverScrollableScrollPhysics(),
                  shrinkWrap: true),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 45.0,
                  width: double.infinity,
                  child: FlatButton(
                      color: Theme.of(context).accentColor,
                      disabledColor: Colors.grey,
                      child: Text(S.of(context).post,
                          style:
                              TextStyle(color: Colors.white, fontSize: 20.0)),
                      onPressed: _notesController.text.isEmpty
                          ? null
                          : () {
                              Utils.hideKeyboard(context);
                              showLoadingDialog(context, S.of(context).saving);
                              postGratitudeData();
                            }))
            ])));
  }

  Future postGratitudeData() async {
    debugPrint(imagesName.join(','));

    String result = await ApiService().postGratitudeData(widget.email,
        imagesName.join(','), _notesController.text.toString().trim());

    if (result == 'ok') {
      Toast.show(context, S.of(context).saveSuccess);
      _notesController.text = '';
      Provider.of<GratitudeProvider>(context, listen: false).getGratitudeData();
    } else {
      Toast.show(context, S.of(context).saveFailed);
    }

    Navigator.pop(context);
  }

  Future pickerImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(
        source: source, maxWidth: 800, maxHeight: 800, imageQuality: 80);

    if (image != null) {
      showLoadingDialog(context, S.of(context).saving);

      ImageProperties properties =
          await FlutterNativeImage.getImageProperties(image.path);

      debugPrint(
          "width=> ${properties.width}\nheight=> ${properties.height}\norientation=> ${properties.orientation}");

      File compressedFile =
          await FlutterNativeImage.compressImage(image.path, quality: 80);

      String path = compressedFile.path;

      debugPrint(path);

      // 原图片名称
      String filename = path.substring(path.lastIndexOf("/") + 1, path.length);
      debugPrint(filename);

      // 图片后缀
      var suffix =
          filename.substring(filename.lastIndexOf(".") + 1, filename.length);
      debugPrint(suffix);

      // 时间戳
      int milliseconds = DateTime.now().millisecondsSinceEpoch;

      // 重新命名的图片名称
      newFileName = "$milliseconds.$suffix";

      Utils.image2Base64(image.path).then((value) {
        debugPrint(value);

        uploadFile(value, newFileName);
      });
    }
  }

  Future uploadFile(String base64String, String fileName) async {
    String result = await ApiService().uploadFile(base64String, fileName);

    Navigator.pop(context);

    if (Utils.isEmptyString(result)) {
      Toast.show(context, S.of(context).uploadFailed);
    } else {
      Toast.show(context, S.of(context).uploadSuccess);
      setState(() {
        imageUrl = '${Constant.IMAGE_PATH}$fileName';
        images.add("${Constant.IMAGE_BASE_URL}$imageUrl");
        imagesName.add(imageUrl);
      });
    }
  }
}
