import 'package:flutter/material.dart';
import 'package:food/screen/app/applocator.dart';
import 'package:food/screen/cart/cartmodel.dart';
import 'package:food/screen/colors.dart';
import 'package:stacked/stacked.dart';

class Cartview extends StatelessWidget {
  final String id;
  const Cartview({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder:()=>Cartmodel() ,
      onModelReady: (viewModel) {
        viewModel.getCartdata(id);
      },
       builder: (context,viewmodel,child){
        final cartLocator=locator<Cartmodel>();
        if(viewmodel.cartDetail.isEmpty){
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Center(child: Text("Cart Screen",style: TextStyle(color: Colors.white),)),
          ),
          
        body: Padding(
          padding: const EdgeInsets.only( top: 0.0),
          child: FutureBuilder(future: cartLocator.getCartdata(id),
           builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
                        backgroundColor: Colors.black,

            body: Center(child: CircularProgressIndicator()),
          );
        }

            return Scaffold(
                          backgroundColor: Colors.black,

              body: ListView.builder(
                itemCount: cartLocator.cartDetail.length,
                itemBuilder: (context, index) {
                  final item = cartLocator.cartDetail[index];
                  return ListTile(
                    leading: Image.network(item['strMealThumb']),
                    title: Text(item['strMeal'],style: TextStyle(color: Colors.white),),
                    subtitle: Text(item['strArea'],style: TextStyle(color: Colors.grey),),
                     trailing: IconButton(
                            icon: Icon(Icons.delete, color: const Color.fromARGB(255, 188, 161, 11)),
                            onPressed: () async {
                              await cartLocator.removeData(index); // Remove item from cart
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Item removed from cart")),
                              );
                              },
                    ),
                  );
                }
                        
              ),
            );
           }),
        ),
        );
       });
  }
}

