
import 'package:aponwola_admin/common/SizeConfig.dart';
import 'package:aponwola_admin/common/app_theme.dart';
import 'package:aponwola_admin/controllers/auth.controller.dart';
import 'package:aponwola_admin/custom_widget/btn.dart';
import 'package:aponwola_admin/custom_widget/txt.dart';
import 'package:aponwola_admin/routes/app.routes.dart';
import 'package:aponwola_admin/services/api.service.dart';
import 'package:aponwola_admin/util/imagePicker.dart';
import 'package:aponwola_admin/util/validator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final  authController=Get.put(AuthController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authController.loadProfile();
  }
  var avatar="http://www.listercarterhomes.com/wp-content/uploads/2013/11/dummy-image-square.jpg";
  Uint8List?_image;
  selectIImage()async{
    Uint8List img=await ImagePickerHandler.pickImage(ImageSource.gallery);
    setState(() {
      _image=img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppTheme.whiteBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black54),
        elevation: 0,
        centerTitle: true,
        title: const Text("Profile",style: TextStyle(color: Colors.black),),
      ),
      body: GetX<AuthController>(
          builder: (authController) {
            return regFormWidget(context,authController);
          }
      ),
    );
  }

  Form regFormWidget(BuildContext context,AuthController authController) {

    return
      Form(
        key: authController.registerKey.value,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height:MySize.size20),


              InkWell(
                onTap: ()=>selectIImage(),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child:
                    _image!=null?
                    Image.memory(_image!,
                      fit: BoxFit.cover,
                      width: MySize.size200,
                      height: MySize.size200,)
                        :  CachedNetworkImage(
                      imageUrl: authController.avatar.value!=""?
                      authController.avatar.value:
                      avatar,
                      fit: BoxFit.cover,
                      height: MySize.size200,
                      width: MySize.size200,
                    )
                  //   : Image.network(_image!,
                  // fit: BoxFit.cover,
                  // height: MySize.size300,)

                ),
              ),
              SizedBox(height:MySize.size10),

              Text(ApiService.me.email.toString(),style: TextStyle(fontSize: MySize.size18),),


              SizedBox(height:MySize.size10),
              MyText(
                hintText: "Full name",
                controller: authController.nameController.value,
                validator: Validator.requiredValidator,
              ),



              MyText(
                hintText: "Phone",
                controller: authController.phoneController.value,
                validator: Validator.requiredValidator,
              ),
              // SizedBox(height:MySize.size20),
              authController.isLoading.value?
              const Center(child:   CupertinoActivityIndicator()):
              MyButton(
                  text: "Update",
                  onPressed: (){
                    if(authController.registerKey.value.currentState!.validate()){
                      authController.updateProfile(context,_image);
                    }
                  }),



            ],
          ),
        ),
      );

  }
}
