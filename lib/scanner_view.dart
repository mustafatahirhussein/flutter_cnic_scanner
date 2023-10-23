import 'dart:io';

import 'package:cnic_scanner/cnic_scanner.dart';
import 'package:cnic_scanner/model/cnic_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({super.key});

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {

  CnicModel cnicModel = CnicModel();
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [

          if(image != null)
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: FileImage(image!),
                  fit: BoxFit.contain,
                ),
              ),
            ),

          ElevatedButton(onPressed: () async => await attachImage(), child: Text("Image")),
        ],
      ),
    );
  }

  attachImage() async {
    XFile? pf = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(pf != null) {
      setState(() {
        image = File(pf.path);
      });
      await scanCNIC();
    }
  }

  scanCNIC() async {
    CnicModel model = await CnicScanner().scanImage(imageSource: ImageSource.gallery);

      setState(() {
        cnicModel = model;
      });
  }
}
