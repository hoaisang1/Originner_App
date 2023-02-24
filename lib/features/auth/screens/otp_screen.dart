import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:originner/colors.dart';
import 'package:originner/features/auth/controller/auth_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends ConsumerWidget {
  static const String routeName = '/otp-screen';
  final String verificationId;
  const OTPScreen({
    Key? key,
    required this.verificationId,
  }) : super(key: key);

  void verifyOTP(WidgetRef ref, BuildContext context, String userOTP) {
    ref.read(authControllerProvider).verifyOTP(
          context,
          verificationId,
          userOTP,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // backgroundColor: Constants.primaryColor,
      body: GestureDetector(
        onTap: () {},
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              // SizedBox(
              //   height: MediaQuery.of(context).size.height / 4,

              // ),
              const SizedBox(height: 90),
              Image.asset(
                'assets/login.png',
                height: 100,
                width: 100,
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Nhập mã otp',
                  style: TextStyle(
                      color: greyColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Mã otp đã được gửi đến số điện thoai của bạn',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: greyColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Form(
                // key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 30.0),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      obscureText: true,
                      obscuringCharacter: '*',
                      obscuringWidget: const FlutterLogo(
                        size: 24,
                      ),
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      
                      validator: (v) {
                        if (v!.length < 3) {
                          return "Nhập tại đây";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          inactiveColor: const Color.fromARGB(255, 0, 0, 0),
                          inactiveFillColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          selectedFillColor: textColor,
                          selectedColor: iconColor,
                          activeColor: iconColor),
                      cursorColor: const Color.fromARGB(255, 6, 6, 6),
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      keyboardType: TextInputType.number,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(5, 1),
                          color: Colors.black12,
                          blurRadius: 0,
                        )
                      ],
                      onChanged: (val) {
                        if (val.length == 6) {
                          verifyOTP(ref, context, val.trim());
                        }
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // final size = MediaQuery.of(context).size;
  // return Scaffold(
  //   appBar: AppBar(
  //     title: const Text('Xác nhận số điện thoại của bạn'),
  //     elevation: 0,
  //     backgroundColor: backgroundColor,
  //   ),
  //   body: Center(
  //     child: Column(
  //       children: [
  //         const SizedBox(height: 20),
  //         const Text(
  //           'Nhập mã otp.',
  //           style: TextStyle(
  //             fontSize: 20,
  //             fontWeight: FontWeight.bold,
  //             color: blackColor,
  //           ),
  //         ),
  //         SizedBox(
  //           width: size.width * 0.5,
  //           child:
  //           TextField(
  //             textAlign: TextAlign.center,
  //             decoration: const InputDecoration(
  //               hintText: '- - - - - -',
  //               hintStyle: TextStyle(
  //                 fontSize: 30,
  //               ),
  //             ),
  //             keyboardType: TextInputType.number,

  //           ),
  //         ),
  //       ],
  //     ),
  //   ),
  // );
}
