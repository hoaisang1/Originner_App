import 'package:flutter/material.dart';
import 'package:originner/colors.dart';
import 'package:originner/features/auth/screens/login_screen.dart';

class LandingScreen extends StatelessWidget {
  static const String routeName = '/LandingScreen';

  const LandingScreen({Key? key}) : super(key: key);

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 0),
            Image.asset(
              'assets/landing.png',
              height: 350,
              width: 350,
            ),
            // const SizedBox(height: 20),
            // const Padding(
            //   padding: EdgeInsets.only(left: 30,
            //   right: 90),
            //   child: Text(
            //     'Chào mừng bạn đến với ứng dụng nhắn tin Originner',
            //     textAlign: TextAlign.start,
            //     style: TextStyle(
            //       fontSize: 25,
            //       fontWeight: FontWeight.w900,
            //       color: textColor,
                  
            //     ),
            //   ),
              
            // ),
            const SizedBox(height: 10),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   // ignore: prefer_const_literals_to_create_immutables
            //   children: [
            //     const Padding(
            //       padding: EdgeInsets.only(left: 30,
            //       right: 30),
            //       child: Text(
            //         'Chúc bạn có một trải nghiệm tuyệt vời',
            //         textAlign: TextAlign.start,
            //         style: TextStyle(
            //           // fontFamily,
            //           fontSize: 15,
            //           fontWeight: FontWeight.w300,
            //           // fontWeight: FontWeight.bold,
            //           color: greyColor,
                      
            //         ),
            //       ),
                  
            //     ),
            //   ],
            // ),
            

            const SizedBox(height: 160),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ElevatedButton(
                      onPressed: () => navigateToLoginScreen(context),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 90.0, vertical: 15.0),
                        primary: buttonColor,
                      ),
                      
                      child: const Text(
                        'Tiếp tục với số điện thoại',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(20),
                  //   child: ElevatedButton(
                  //     onPressed: () => navigateToLoginScreen(context),
                  //     style: ElevatedButton.styleFrom(
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: 25.0, vertical: 15.0),
                  //       primary: Color.fromARGB(255, 255, 255, 255),
                  //     ),
                  //     child: const Text(
                  //       'Đăng nhập',
                  //       style: TextStyle(
                  //         fontSize: 15,
                  //         fontWeight: FontWeight.bold,
                  //         color: greyColor,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 35,
                  right: 30),
                  child: Text(
                    'Bạn đã có tài một tài khoản? ',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: greyColor,
                      
                    ),
                  ),
                  
                ),
                
                 ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: ElevatedButton(
                      onPressed: () => navigateToLoginScreen(context),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical:20.0),
                        primary: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      child: const Text(
                        'Đăng nhập',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: iconColor,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            // FittedBox(
            //   child:
            //   // TextButton(
            //   //   onPressed: () => navigateToLoginScreen(context),
            //   //   child: Row(
            //   //     // ignore: prefer_const_literals_to_create_immutables
            //   //     children: [
            //   //       const Text(
            //   //         "Tiếp tục",
            //   //         style: TextStyle(
            //   //           fontSize: 18,
            //   //           fontWeight: FontWeight.w300,
            //   //           color: lColor,
            //   //         ),
            //   //       ),
            //   //       const Icon(
            //   //         Iconsax.arrow_right_3,
            //   //         color: lColor,
            //   //       ),
            //   //     ],
            //   //   ),
            //   //   // const
            //   // ),
            //   ElevatedButton.icon(
            //     style: ElevatedButton.styleFrom(
            //       primary: Color.fromARGB(255, 255, 255, 255),

            //       textStyle: const TextStyle(
            //         fontSize: 20,

            //       )
            //     ),
            //     onPressed: ()
            //     // {},
            //     => navigateToLoginScreen(context),
            //     label: const Text('Tiếp tục' ,style: TextStyle(color: Color.fromARGB(255, 189, 138, 49)),),
            //     icon: const Icon(Iconsax.arrow_right_4,color: Color.fromARGB(255, 189, 138, 49),),
            //   ),
            // ),
            //
          ],
        ),
      ),
    );
  }
}
