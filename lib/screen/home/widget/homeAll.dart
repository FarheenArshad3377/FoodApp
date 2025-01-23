import 'package:flutter/material.dart';
import 'package:food/screen/app/applocator.dart';
import 'package:food/screen/colors.dart';
import 'package:food/screen/detail%20Screen/detailview.dart';
import 'package:food/screen/favourite/favHome.dart';
import 'package:food/screen/favourite/favModel.dart';
import 'package:food/screen/home/homeModel.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

// ChickenWidget
class RandomAllData extends StatelessWidget {
  const RandomAllData({super.key});

  @override
  Widget build(BuildContext context) {
      final favLocator=locator<Favmodel>();
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeModel(),
      onModelReady: (viewModel) {
        viewModel.getApiAll();
      },
      builder: (context, viewModel, child) {
        if (viewModel.randomAll.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.amberAccent,
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: viewModel.randomAll.length,
            itemBuilder: (context, index) {
              final meal = viewModel.randomAll[index];
              final isFavorite = viewModel.favorites.contains(meal["idMeal"]);
          
              return Card(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailView(id: meal["idMeal"]),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: AppColors.borderColor
                        ),
                        boxShadow: [
                          BoxShadow(
                           color: AppColors.backgroundColor,
                            blurRadius: 5,
                            spreadRadius: 5,
                            offset: const Offset(5, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      child: Hero(
                        tag: meal["idMeal"], // Unique tag for Hero animation
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            meal["strMealThumb"],
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                    
                            const SizedBox(height: 8),
                            Text(
                              meal['strMeal'].toString(),
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

