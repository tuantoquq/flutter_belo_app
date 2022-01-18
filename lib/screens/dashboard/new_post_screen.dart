import 'dart:ui';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewsPostScreen extends StatefulWidget {
  const NewsPostScreen({Key? key}) : super(key: key);

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewsPostScreen> {

  File? imageFile;
  final picker = ImagePicker() ;

  Widget build(BuildContext context){
   return Scaffold(
     appBar: AppBar(
       title: const Text('new post '),
       centerTitle: true,
     ),
     body: SingleChildScrollView(
      child: Column(
        children:[
          Container(
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.edit),
                  hintText: ('what are you thinking? '),
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white54,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  )
                ),
              ),

            ),
          ),
          Row(
              children:[
                const SizedBox(width: 8.0,),
                InkWell(
                  child: Container(
                    width: 170,
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      border: Border.all(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    alignment: Alignment.center,
                    child: TextButton.icon(
                      onPressed: ()=> getImageFromCamera(),
                      icon: const Icon(
                        Icons.add_a_photo,
                        size: 35,
                        color: Colors.blue,
                      ),
                      label: const Text('Camera'),

                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                    },
                  child: Container(
                    width: 170,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      border: Border.all(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    alignment: Alignment.center,
                    child: TextButton.icon(
                      onPressed: () => getImageFromGallery(),
                      icon: const Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 35,
                      ),
                      label: const Text('From gallery'),

                    ),
                  ),
                ),

              ]
          ),
          const SizedBox(height: 10,),
          Container(
            width: 380,
            height: 420,
            decoration: BoxDecoration(
              color: Colors.white70,
              border: Border.all(color: Colors.blue, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: imageFile != null ? Image.file(imageFile!, fit: BoxFit.fill,): Icon(Icons.photo, color: Colors.grey,),
          ),
          const SizedBox(height: 10,),
          Container(
            child: ElevatedButton(
                child: Text(
                    "POST".toUpperCase(),
                    style: const TextStyle(fontSize: 20)
                ),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15, horizontal: 40)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: const BorderSide(color: Colors.grey)
                        )
                    )
                ),
                onPressed: (){

                }
            )
          ),
        ]
     ),
    ),
    );
  }
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = File(pickedFile!.path);
    });
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

}