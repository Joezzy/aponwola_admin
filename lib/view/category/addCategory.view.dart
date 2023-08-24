
import 'dart:typed_data';

import 'package:aponwola_admin/common/SizeConfig.dart';
import 'package:aponwola_admin/controllers/category.controller.dart';
import 'package:aponwola_admin/custom_widget/btn.dart';
import 'package:aponwola_admin/custom_widget/txt.dart';
import 'package:aponwola_admin/data/category.dart';
import 'package:aponwola_admin/util/imagePicker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddCategoryView extends StatefulWidget {
  Category? category;
  AddCategoryView({Key? key,this.category}) : super(key: key);



  @override
  State<AddCategoryView> createState() => _AddCategoryViewState();
}


class _AddCategoryViewState extends State<AddCategoryView> {
  final categoryController=Get.put(CategoryController());
  Uint8List?_image;

  selectIImage()async{
    Uint8List img=await ImagePickerHandler.pickImage(ImageSource.gallery);
    setState(() {
      _image=img;

    });
  }


  @override
  void initState() {
    initMethod();
    super.initState();
  }

  String? id;
  String avatar="";
  initMethod()async{
    if(widget.category !=null){
      id=widget.category!.id!;
      categoryController.nameController.value.text=widget.category!.name!;
      categoryController.descController.value.text=widget.category!.description!;
      avatar=widget.category!.image.toString()!;
    }

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
      ),

      body: Form(
        key: categoryController.key.value,
        child: Column(
          children: [
            SizedBox(height:MySize.size100),
            _image!=null?
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.memory(_image!),
            ):avatar!=""?
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: avatar,
                  height: 250,
                  width: 300,
                  fit: BoxFit.cover,
                )

            ):
            InkWell(
              onTap: ()=>selectIImage(),
              child:
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network("http://www.listercarterhomes.com/wp-content/uploads/2013/11/dummy-image-square.jpg"),
              ),


            ),
            SizedBox(height:MySize.size10),
            InkWell(
                onTap: ()=>selectIImage(),
                child: const Text("Upload")),

            MyText(
              hintText: "Name",
              controller: categoryController.nameController.value,
            ),

            MyText(
              hintText: "Description",
              controller: categoryController.descController.value,
            ),

            MyDropDown(
                hint: "Select category",
                width: MySize.screenWidth,
                drop_value: categoryController.categoryType.value,
                itemFunction: ["normal","daily"].map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child:  Text(toBeginningOfSentenceCase(item).toString()),
                  );
                }).toList(),
                onChanged: (newValue) async {
                  categoryController.categoryType.value = newValue.toString();
                }),

            MyButton(
                text: "Save",
                onPressed: (){
                  if(categoryController.key.value.currentState!.validate()){
                    if(id==null){
                      categoryController.addCategory(context,_image);
                    }else{
                      categoryController.updateCategory(context,_image,id);
                    }
                  }

                }),
            SizedBox(height:MySize.size100),
          ],
        ),
      ),
    );
  }
}

