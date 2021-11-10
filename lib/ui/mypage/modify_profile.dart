import 'dart:io';

import 'package:duckie_app/components/Icons.dart';
import 'package:duckie_app/components/appBarWithBack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../styles/styles.dart';

class ModifyProfile extends StatefulWidget {
  @override
  _ModifyProfileState createState() => _ModifyProfileState();
}

class _ModifyProfileState extends State<ModifyProfile> {
  final storage = FlutterSecureStorage();

  String? _username;
  String? _picture;
  bool isEnabled = false;
  String? _inputName;
  String? _newPicture;

  @override
  initState() {
    super.initState();
    _loadProfile();
  }

  _loadProfile() async {
    String? username = await storage.read(key: 'username');
    String? picture = await storage.read(key: 'picture');
    setState(() =>
        {_username = username, _inputName = username, _picture = picture});
  }

  final ButtonStyle style = ElevatedButton.styleFrom(
    elevation: 0.0,
    textStyle: const TextStyle(fontSize: 20),
    shadowColor: Colors.transparent,
    primary: Colors.transparent,
  );

  final userIamge =
      "https://cdn.pixabay.com/photo/2021/09/09/12/27/child-6610447_1280.jpg";

  _loadPhotos() async {
    getImageFromGallery();
    // AlertDialog dialog = AlertDialog(content: Text("사진 폴더 불러오기"));
    // showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  Future getImageFromGallery() async {
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    print(image!.path);
    setState(() {
      _newPicture = image.path;
    });
  }

  _onSubmit() {
    if (isEnabled) {
      final snackBar = SnackBar(content: Text('프로필이 변경되었습니다.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      storage.write(key: 'username', value: _inputName);
    }
    Navigator.of(context).pop();
  }

  onChangeUsername(String? value) {
    if (value != null && value.length > 1 && value.length <= 20) {
      setState(() {
        _inputName = value;
        isEnabled = true;
      });
    } else {
      setState(() {
        isEnabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWithBack("프로필 설정"),
        body: _buildbody(),
        bottomNavigationBar: _bottomNavigationBar(isEnabled));
  }

  Widget _buildbody() {
    var profileImage;
    if (_newPicture != null) {
      profileImage = Image.file(File(_newPicture!)).image;
    } else if (_picture != null) {
      profileImage = Image.network(
        _picture!,
      ).image;
    } else {
      profileImage = AssetImage('assets/images/profile_default.png');
    }
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          color: white,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 36),
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.cover, image: profileImage)),
                          ),
                          SizedBox(
                            child: Container(
                              width: 120.0,
                              height: 120.0,
                              alignment: Alignment.bottomRight,
                              child: _loadPhotoButton(),
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
                    ],
                  ),
                ),
                onTap: _loadPhotos,
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 52),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "프로필 명",
                          style: caption,
                        ),
                      ),
                      TextField(
                          onChanged: onChangeUsername,
                          cursorColor: primaryColor,
                          decoration: InputDecoration(
                            fillColor: white,
                            focusColor: white,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: gray04),
                            ),
                            filled: true,
                            hintText: '닉네임을 입력해주세요',
                          )),
                    ],
                  ))
            ],
          )),
    ));
  }

  Container _loadPhotoButton() {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Color(0xffcccccc),
          width: 1.25,
        ),
        color: Colors.white,
      ),
      child: iconImageSmall("camera", 25.0),
    );
  }

  BottomAppBar _bottomNavigationBar(enabled) {
    return BottomAppBar(
        elevation: 0.0,
        child: ElevatedButton(
            onPressed: _onSubmit,
            style: style,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: enabled ? primaryColor : Colors.black45,
                ),
                width: 320,
                margin:
                    const EdgeInsets.symmetric(vertical: 56, horizontal: 24),
                padding: const EdgeInsets.all(20),
                child: Text('수정 완료',
                    textAlign: TextAlign.center, style: body1BoldWhite))));
  }
}
