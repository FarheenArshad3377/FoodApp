import 'package:flutter/material.dart';
import 'package:food/screen/colors.dart';
import 'package:food/screen/detail%20Screen/detailview.dart';
import 'package:food/screen/home/homeModel.dart';
import 'package:stacked/stacked.dart';
// Replace with the correct path of your HomeModel

class PastaWidget extends StatelessWidget {
  const PastaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeModel(),
      onModelReady: (viewModel) {
        // Ensure that getApi is called and properly fetches data
        viewModel.getApiPasta(); // This should populate randomRec with chicken data
      },
      builder: (context, viewModel, child) {
        if(viewModel.randomPasta.isEmpty){
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
             body:  Center(
              child: CircularProgressIndicator(color: Colors.amberAccent,),
             ), 
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
          child: Container(
            width: double.infinity,
            child: SizedBox(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: viewModel.randomPasta.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: InkWell(
                      onTap: () {
                        print("Selected Meal ID: ${viewModel.randomPasta[index]["idMeal"]}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailView(id: viewModel.randomPasta[index]["idMeal"]);
                            },
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
                                // Circular image at the top
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                      viewModel.randomPasta[index]["strMealThumb"],
                                    ),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                                // Meal name
                                Text(
                                  viewModel.randomPasta[index]['strMeal'].toString(),
                                  style: const TextStyle(
                                    color: AppColors.primaryText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
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
            ),
          ),
        );
      },
    );
  }
}

