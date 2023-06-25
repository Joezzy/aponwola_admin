
import 'dart:typed_data';

import 'package:aponwola_admin/common/SizeConfig.dart';
import 'package:aponwola_admin/controllers/product.controller.dart';
import 'package:aponwola_admin/custom_widget/btn.dart';
import 'package:aponwola_admin/custom_widget/txt.dart';
import 'package:aponwola_admin/data/product.dart';
import 'package:aponwola_admin/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddProductView extends StatefulWidget {
  Product? product;
  AddProductView({Key? key,this.product}) : super(key: key);



  @override
  State<AddProductView> createState() => _AddProductViewState();
}


class _AddProductViewState extends State<AddProductView> {
  final productController=Get.put(ProductController());
  Uint8List?_image;

  selectIImage()async{
    Uint8List img=await pickImage(ImageSource.gallery);
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
 initMethod()async{
    if(widget.product !=null){
      id=widget.product!.id!;
      productController.nameController.value.text=widget.product!.name!;
      productController.descriptionController .value.text=widget.product!.description!;
      productController.priceController.value.text=widget.product!.price.toString();
      productController.category.value=widget.product!.category!;
    }

 }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
      ),

      body: Form(
        key: productController.key.value,
        child: Column(
          children: [
            SizedBox(height:MySize.size100),
              _image!=null?
              CircleAvatar(
                radius: 60,
                backgroundImage: MemoryImage(_image!),
              ):
            InkWell(
              onTap: ()=>selectIImage(),
              child: const  CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage("http://www.listercarterhomes.com/wp-content/uploads/2013/11/dummy-image-square.jpg"),
                ),
            ),

            MyText(
              hintText: "Name",
              controller: productController.nameController.value,
            ),
            MyText(
              hintText: "Price",
              controller: productController.priceController.value,
            ),
            MyText(
              hintText: "Description",
              controller: productController.descriptionController.value,
            ),
            MyText(
              hintText: "Category",
              controller: productController.descriptionController.value,
            ),

            MyButton(
                text: "Save",
                onPressed: (){
                  if(productController.key.value.currentState!.validate()){
                    if(id==null){
                      productController.addProducts(context,_image);
                    }else{
                      productController.updateProducts(context,id);
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

