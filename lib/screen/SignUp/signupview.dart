import 'package:flutter/material.dart';
import 'package:food/screen/Login/loginView.dart';
import 'package:food/screen/SignUp/signupModel.dart';
import 'package:food/screen/colors.dart';
import 'package:stacked/stacked.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => SignupModel(),
        builder: (context, viewModel, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.gradientStart,
                  AppColors.gradientEnd,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [                
                      // Logo Section
                      SizedBox(height: 100,),
                      Image.asset(
                        "assets/img/logoReal.png",
                        width: 150,
                        height: 120,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Restaurant",
                        style: TextStyle(
                          fontSize: 36,
                          color: AppColors.highlightColor,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Colors.white.withOpacity(0.7),
                              offset: const Offset(1, 1),
                            )
                          ],
                        ),
                      ),
                      Text(
                        "Enjoy Delicious Food",
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 25),
                
                      // Form Section
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: AppColors.cardColor,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(7, 6),
                              spreadRadius: 2
                            )
                          ],
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                // First Name Field
                                Expanded(
                                  child: TextField(
                                    controller: viewModel.name,
                                    decoration: InputDecoration(
                                      hintText: "First Name",
                                      labelStyle: TextStyle(color: AppColors.inputFielsColor),
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding:
                                          const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // Last Name Field
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Last Name",
                                      labelStyle: TextStyle(color: AppColors.inputFielsColor),
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding:
                                          const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                
                            // Email Field
                            TextField(
                              controller: viewModel.email,
                              decoration: InputDecoration(
                                hintText: "Enter Email",
                                labelStyle: TextStyle(color: AppColors.inputFielsColor),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                
                            // Password Field
                            TextField(
                              controller: viewModel.password,
                              obscureText: true,
                              decoration: InputDecoration(
                              hintText: "Enter Password",
                                labelStyle: TextStyle(color: AppColors.inputFielsColor),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                
                            // Sign Up Button
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  viewModel.storeData(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Successfully Sign UP"))
                                  );
                                },
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: AppColors.buttonTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.buttonColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                
                      const SizedBox(height: 20),
                
                      // Login Navigation
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const LoginView()));
                        },
                        child: Text(
                          "Already have an account? LOGIN IN",
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

