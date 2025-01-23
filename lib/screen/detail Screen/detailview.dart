import 'package:flutter/material.dart';
import 'package:food/screen/app/applocator.dart';
import 'package:food/screen/cart/cartmodel.dart';
import 'package:food/screen/cart/cartview.dart';
import 'package:food/screen/colors.dart';
import 'package:food/screen/detail%20Screen/detailmodel.dart';
import 'package:food/screen/favourite/favHome.dart';
import 'package:food/screen/favourite/favModel.dart';
import 'package:stacked/stacked.dart';

class DetailView extends StatelessWidget {
 final String id;
  const DetailView({super.key,required this.id});

  @override
  Widget build(BuildContext context) {
        final favLocator=locator<Favmodel>();
    return ViewModelBuilder.reactive(
      viewModelBuilder: ()=>DetailModel(),
      onModelReady: (viewModel) {
        viewModel.getDetailScreen(id);
      },
       builder: (context,viewmodel,child){
        if (viewmodel.detailScreen.isEmpty) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()), // Loading indicator
          );
        }
        final meal=viewmodel.detailScreen[0];
         final cartModel = locator<Cartmodel>();
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:[
                AppColors.gradientStart,
                AppColors.gradientEnd
              ],
              begin: Alignment.topLeft,
               end: Alignment.bottomRight
               ),

          ),
          child: Scaffold(
            backgroundColor:Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                    Image.network(
                      meal['strMealThumb'],
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      left: 15,
                      bottom: -50,
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child:Hero(
            tag: meal["idMeal"], // Same tag for Hero animation
            child: CircleAvatar(
              radius: 60, // Larger size for emphasis
              backgroundImage: NetworkImage(
                meal["strMealThumb"],
              ),
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
                        ),
                    ) ,
                    Positioned(
                      right: 10,
                      bottom: -30,
                      child: CircleAvatar(
                        radius: 22,
                                backgroundColor:AppColors.buttonColor,
                        child: Center(
                          child: IconButton(onPressed: (){
                            favLocator.getFav(meal['idMeal']);
                            final fav=viewmodel.detailScreen[0];
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Add on favourite"),
                              action: SnackBarAction(label: "View",
                               onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>FavHome(id: fav['idMeal'])));
                               }),
                              )
                            );
                                          }, icon: Icon(Icons.favorite,size: 25,
                                          color: AppColors.primaryText,),
                                        hoverColor: Colors.redAccent,highlightColor: const Color.fromARGB(255, 255, 7, 7),),
                        ),
                      ),)               
                    ],
                  ),
                  
                  SizedBox(height: 50,),
                  Padding(padding: EdgeInsets.all(7.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(meal['strMeal'],style: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign:TextAlign.left,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        ),
                      ),
            // Use ViewModelBuilder for Cartmodel
                        ElevatedButton(
                              onPressed: () {
                                // Add the item to the cart using cartModel
                              cartModel.getCartdata(meal['idMeal']);      
                              final cart=viewmodel.detailScreen[0];
                                // Show the SnackBar
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Added to cart"),
                                    action: SnackBarAction(
                                      label: "View",
                                      onPressed: () {
                                        // Optional undo functionality
                                        
                                      },
                                    ),
                                  ),
                                );
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Cartview(id:cart['idMeal'],),
                                  ),);
                              },
                              child: Text(
                                "Add to cart",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.primaryText
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:AppColors.buttonColor,
          
                              ),
                            ),
                          
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text("MAIN INGREDIENT",style: TextStyle(
                          color: AppColors.highlightColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 255, 255, 255)
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          
                           Container(
              decoration: BoxDecoration(
                border: Border.all(color:Colors.grey), // Border for each row
              ),
              child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(meal['strIngredient1'],style: TextStyle(color: Colors.white),)
                            ],
                          ),),
                           Container(
              decoration: BoxDecoration(
                border: Border.all(color:Colors.grey), // Border for each row
              ),
              child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(meal['strIngredient2'],style: TextStyle(color: Colors.white))
                            ],
                          ),),
                           Container(
              decoration: BoxDecoration(
                border: Border.all(color:Colors.grey), // Border for each row
              ),
              child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(meal['strIngredient3'],style: TextStyle(color: Colors.white))
                            ],
                          ),),
                           Container(
              decoration: BoxDecoration(
                border: Border.all(color:Colors.grey), // Border for each row
              ),
              child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(meal['strIngredient4'],style: TextStyle(color: Colors.white))
                                   ],
                          ),),
                           Container(
              decoration: BoxDecoration(
                border: Border.all(color:Colors.grey), // Border for each row
              ),
              child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(meal['strIngredient5'],style: TextStyle(color: Colors.white))
                            ],
                           ),),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Category: ${meal['strCategory']}',style: TextStyle(
                          color:AppColors.ratingStarColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Instruction',style: TextStyle(
                      color: AppColors.highlightColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                    child: Text(meal['strInstructions'],style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),),
                  ),
                  SizedBox(height: 30,),
                ],
              ),
            ),
          bottomNavigationBar: BottomAppBar(
                color: AppColors.gradientEnd,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.shopping_cart,
                            color: AppColors.iconColor),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.person, color: AppColors.iconColor),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.home, color: AppColors.iconColor),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search, color: AppColors.iconColor),
                      ),
                      Builder(
               builder: (context) {
                int index=0;
                 return IconButton(
                  onPressed: () {
                  // Ensure the list is not empty
            final meal = favLocator.favThing[index];  // Access the first item
             Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FavHome(id: meal["idMeal"]),
                          ),
                        );
                  
                  },
                  icon: Icon(Icons.favorite, color:AppColors.iconColor),
                 );
               }
             )
                    ],
                  ),
                ),
              ),  
          ),
        );
       });
  }
}

