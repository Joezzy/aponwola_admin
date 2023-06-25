
import 'package:aponwola_admin/controllers/product.controller.dart';
import 'package:aponwola_admin/data/product.dart';
import 'package:aponwola_admin/view/product/addProduct.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProductListView extends StatefulWidget {
   ProductListView({Key? key}) : super(key: key);

  @override
  State<ProductListView> createState() => _ProductListViewState();
}


class _ProductListViewState extends State<ProductListView> {
  final productController=Get.put(ProductController());
  @override
  void initState() {
    super.initState();
    productController.getProducts();
  }
  @override
  Widget build(BuildContext context) {
    return  GetX<ProductController>(
      builder: (productController) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 8.0),
                child: InkWell(
                  onTap: ()=>  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) => AddProductView(
                          ))),
                    child: Icon(MdiIcons.plus,size: 20,)),
              )
            ],
          ),
          body: ListView.builder(
            itemCount: productController.productList.length,
            itemBuilder: (context,index){
              Product product=productController.productList[index];
              return Container(
                  child: ListTile(
                    title: Text(product.name!),
                    subtitle: Text(product.price.toString()),
                    trailing: InkWell(
                        onTap: (){
                          productController.deleteProduct(product.id!);
                        },

                        child: Icon(MdiIcons.trashCanOutline)),
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => AddProductView(
                              product: product,
                            )));

                    },
                  ));
            },

          ),
        );
      }
    );
  }
}

