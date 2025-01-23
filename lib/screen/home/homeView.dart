import 'package:flutter/material.dart';
import 'package:food/screen/app/app.dart';
import 'package:food/screen/app/applocator.dart';
import 'package:food/screen/cart/cartmodel.dart';
import 'package:food/screen/cart/cartview.dart';
import 'package:food/screen/colors.dart';
import 'package:food/screen/detail%20Screen/detailview.dart';
import 'package:food/screen/favourite/favHome.dart';
import 'package:food/screen/favourite/favModel.dart';
import 'package:food/screen/home/widget/homeAll.dart';
import 'package:food/screen/home/widget/homeDessert.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stacked/stacked.dart';
import 'homeModel.dart'; // Update the path for your HomeModel file
import 'widget/homeChicken.dart'; // Update the path for your ChickenWidget file
import 'widget/homePasta.dart'; // Update the path for your PastaWidget file

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String id;
    final cartLocator = locator<Cartmodel>();
    final favLocator = locator<Favmodel>();

    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeModel(),
      onModelReady: (viewModel) {
        viewModel.getApi();
        viewModel.filterData(viewModel.controllerSearch.text);
        viewModel.getUsername();
        viewModel.getApiAll();
      },
      builder: (context, viewModel, child) {
        if (viewModel.randomRec.isEmpty) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return DefaultTabController(
          length: 4,
          child: Container(
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
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 55.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "FOOD",
                                  style: TextStyle(
                                    color: AppColors.highlightColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  " ${viewModel.userData['name']}" ?? "Guest",
                                  style: TextStyle(
                                    color: AppColors.primaryText,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Cartview(
                                    id: cartLocator.cartDetail[0]['idMeal'],
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.shopping_cart,
                              color: AppColors.inactiveIconColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // Search Section
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 350,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: TextField(
                              controller: viewModel.controllerSearch,
                              decoration: InputDecoration(
                                hintText: "Search Here...",
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: AppColors.searchIconColor,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onChanged: viewModel.filterData,
                            ),
                          ),
                        ),
                      ),
                       // Search Results
                        if (viewModel.searchList.isNotEmpty)
                          Container(
                            height: 300,
                            color: Colors.white,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: viewModel.searchList.length,
                              itemBuilder: (context, index) {
                                final data = viewModel.searchList[index];
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(data['strMealThumb']),
                                  ),
                                  title: Text(data['strMeal']),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailView(id: data['idMeal']),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                      
             const SizedBox(height: 4),
                       Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15,top: 15),
                  child: Text(
                    "Enjoy Our",
                    style: TextStyle(
            color: AppColors.primaryText,
            fontSize: 35,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15, bottom: 15), // Added padding to the bottom of "ENJOY OUR"
                  child: Text(
                    "Delicious Foods",
                    style: TextStyle(
            color: AppColors.highlightColor,
            fontSize: 17,
            fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
             SizedBox(height: 2,),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
            color: Colors.grey, // Set the color of the top border
            width: 2.0, // Set the width of the top border
                    ),
                  ),
                ),),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Food Category",style: TextStyle(
                    color:AppColors.primaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),),
                ),
                      // Tabs Section
               Padding(
  padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12),
  child: Material(
        color: Colors.transparent, // Ensure no background color is added
    elevation: 0,
    child: TabBar(
      controller: _tabController,
      unselectedLabelColor: AppColors.backgroundColor,
      indicatorColor: AppColors.buttonColor.withOpacity(0.6),
      labelPadding: EdgeInsets.zero,
      tabs: [
        _buildTab("ALL", "assets/img/app (2).png", 0),
        _buildTab("Chicken", "assets/img/app (4).png", 1),
        _buildTab("Pasta", "assets/img/app (1).png", 2),
        _buildTab("Dessert", "assets/img/app (3).png", 3),
      ],
    ),
  ),
),

            //SizedBox(height: 10,),
            // Container(
            //   decoration: BoxDecoration(
            //     border:Border(
            //       top: BorderSide(
            //         color: AppColors.borderColor
            //       )
            //     )
            //   ),
            // ),
                      SizedBox(height: 12),
                      Center(child: Text("BEST FOOD",style: TextStyle(
                        fontSize: 20,
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.w700,
                      ),)),
                      SizedBox(height: 5),
                      // Tab Bar Content
                      SizedBox(
                        height: 400,
                        child: TabBarView(
                          controller: _tabController,
                          children: const [
                            RandomAllData(),
                            ChickenWidget(),
                            PastaWidget(),
                            DessertWidget(),
                          ],
                        ),
                      ),
                    ],
                  ),
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
          ),
        );
      },
    );
  }
Widget _buildTab(String label,String imgpath, int index) {
  return GestureDetector(
    onTap: () {
      setState(() {
        _tabController.index = index;
      });
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 15,),
       // Adjust horizontal padding
      child: Container(
        width: 100, // Keep fixed width for each tab
        height: 110,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.orange
          ),
          color: _tabController.index == index
              ? AppColors.buttonColor
              : AppColors.gradientStart,
          gradient: _tabController.index != index
              ? LinearGradient(
                  colors: [AppColors.gradientStart, AppColors.backgroundColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          borderRadius: BorderRadius.circular(12),
        
        ),
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imgpath,
              height: 60,
              width: 90,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

}

