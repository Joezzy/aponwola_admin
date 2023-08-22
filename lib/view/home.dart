


import 'package:aponwola_admin/view/category/categoryList.view.dart';
import 'package:aponwola_admin/view/order/order.view.dart';
import 'package:aponwola_admin/view/product/productList/productList.view.dart';
import 'package:flutter/material.dart';

class MainHome extends StatelessWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FilledButton(

                onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      OrderView(),
                ),
              );
            }, child: const Text("Orders")),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FilledButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      CategoryListView(),
                ),
              );
            }, child: const Text("Categories")),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FilledButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      ProductListView(),
                ),
              );
            }, child: const Text("Products")),
          ),
        ],
      ),
    );
  }
}
