import 'package:flutter/material.dart';
import 'package:food/screen/app/applocator.dart';
import 'package:food/screen/colors.dart';
import 'package:stacked/stacked.dart';
import 'favModel.dart';

class FavHome extends StatelessWidget {
  final String id;

  FavHome({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final favLocator = locator<Favmodel>();
    return ViewModelBuilder<Favmodel>.reactive(
      viewModelBuilder: () => locator<Favmodel>(),
      onModelReady: (viewModel) {
        viewModel.getFav(id);
      },
      disposeViewModel: false,
      builder: (context, viewModel, child) {
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
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Center(
                child: Text(
                  "FAVOURITES",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
                ),
              ),
              backgroundColor: AppColors.backgroundColor,
            ),
            body: viewModel.favThing.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.85, // Adjust item size
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: favLocator.favThing.length,
                    padding: const EdgeInsets.all(12),
                    itemBuilder: (context, index) {
                      var favMeal = favLocator.favThing[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 33, 33, 33),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 8,
                              spreadRadius: 1,
                              offset: const Offset(2, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Meal Image
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                  child: Image.network(
                                    favMeal['strMealThumb'],
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // Delete Icon Positioned
                                Positioned(
                                  top: 2,
                                  right: 1,
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.8),
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        favLocator.DeleteCart(index);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Meal Name
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                favMeal['strMeal'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Spacer(),
                            // Additional UI (if needed)
                            
                          ],
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}

