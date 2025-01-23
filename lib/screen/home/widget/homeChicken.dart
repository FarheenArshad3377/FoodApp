import 'package:flutter/material.dart';
import 'package:food/screen/colors.dart';
import 'package:food/screen/detail%20Screen/detailview.dart';
import 'package:food/screen/home/homeModel.dart';
import 'package:stacked/stacked.dart';

// ChickenWidget
class ChickenWidget extends StatelessWidget {
  const ChickenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeModel(),
      onModelReady: (viewModel) {
        // Ensure that getApi is called and properly fetches data
        viewModel.getApi(); // This should populate randomRec with chicken data
      },
      builder: (context, viewModel, child) {
        if (viewModel.randomRec.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.amberAccent,),
          );
        }
        // Use a GridView to display the chicken recipes
        return Padding(
          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: viewModel.randomRec.length,
            itemBuilder: (context, index) {
              final meal = viewModel.randomRec[index];
              return Card(
                child: InkWell(
                  onTap: () {
                    // Navigate to the detail page when tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailView(id: meal["idMeal"]),
                      ),
                    );
                  },
                  child:Padding(
                    padding: const EdgeInsets.all(5.0),
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
                            // Circular image at the top
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                meal["strMealThumb"],
                              ),
                              backgroundColor: Colors.transparent,
                            ),
                            const SizedBox(height: 8),
                            // Meal name
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
                            // Food type
                          
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

