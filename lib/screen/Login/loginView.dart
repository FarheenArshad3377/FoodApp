import 'package:flutter/material.dart';
import 'package:food/screen/Login/loginmodel.dart';
import 'package:food/screen/colors.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: ()=>Loginmodel(), 
      builder: (context,viewmodel,child){
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
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 35,),
                     Image.asset("assets/img/logoReal.png",
                        width: 230,height: 120,),
                        SizedBox(height: 1,),
                    Text("Welcome Back!",style: TextStyle(
                      color: AppColors.highlightColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      shadows: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.black,
                          offset: Offset(3, 3),
                        )
                      ]
                    ),),
                    SizedBox(height: 6,),
                    Container(
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
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                         TextField(
                        controller: viewmodel.email,
                        decoration: InputDecoration(
                          hintText: "Enter Email",
                          labelStyle: TextStyle(color: AppColors.inputFielsColor),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none
                          ),
                          focusColor: Colors.pinkAccent,
                          focusedBorder: OutlineInputBorder(),
                        ),
                                          
                                          ),
                                      
                                          SizedBox(height: 20,),
                                          TextField(
                        controller: viewmodel.password,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Enter Password",
                          labelStyle: TextStyle(color: AppColors.inputFielsColor),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none
                          ),
                          focusColor: Colors.pinkAccent,
                          focusedBorder: OutlineInputBorder(),
                        ),
                                          
                                          ),
                                         
                          ],
                        ),
                      ),
                    ),
                     SizedBox(height: 30,),
                    SizedBox(
                      width: 300,
                      height: 40,
                      child: ElevatedButton(onPressed: (){
                      viewmodel.loginUSer(context);
                      },
                       child: Text("Submit",style: TextStyle(color: AppColors.buttonTextColor),),
                       style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                       ),),
                    ),
                    SizedBox(height: 20,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset("assets/img/bannerGirl.jpg"),
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

