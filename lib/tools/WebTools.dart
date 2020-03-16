import 'dart:html' as html;
import 'dart:html';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';

class WebTools {
  static startWebFilePicker(OnFileUploadListenerWeb fileUploadListener) async {
    List<int> _selectedFile;
    Uint8List _bytesData;
    html.InputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files[0];
      final reader = new html.FileReader();

      reader.onLoadEnd.listen((e) {
        _bytesData =
            Base64Decoder().convert(reader.result.toString().split(",").last);
        _selectedFile = _bytesData;
        fileUploadListener.onFileUploadCompleteWeb(_selectedFile);
      });
      reader.readAsDataUrl(file);
    });
  }

  static Widget networkImageWeb(String url, {double width = 90, double height = 90}) {
    return FadeInImage.assetNetwork(
        width: width,
        height: height,
        placeholder: 'assets/web_img_load.gif',
        fit: BoxFit.fitHeight,
        image: url);
  }


  static bool copyToClipboardHack(String text) {
    final textarea = new TextAreaElement();
    document.body.append(textarea);
    textarea.style.border = '0';
    textarea.style.margin = '0';
    textarea.style.padding = '0';
    textarea.style.opacity = '0';
    textarea.style.position = 'absolute';
    textarea.readOnly = true;
    textarea.value = text;
    textarea.select();
    final result = document.execCommand('copy');
    textarea.remove();
    return result;
  }
}

abstract class OnFileUploadListenerWeb {
  void onFileUploadCompleteWeb(List<int> file);
}
