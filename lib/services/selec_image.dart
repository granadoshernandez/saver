import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

pickImage(ImageSource source) async{
final ImagePicker _imagePicker = ImagePicker();
XFile? file = await _imagePicker.pickImage(source: source);
var _file;
if(_file != null){
  var _file;
  return await _file.readAsBytes();
  }
}

