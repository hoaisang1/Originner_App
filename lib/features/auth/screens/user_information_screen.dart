import 'dart:io';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:originner/colors.dart';
import 'package:originner/common/utils/utils.dart';
import 'package:originner/features/auth/controller/auth_controller.dart';

class UserInformationScreen extends ConsumerStatefulWidget {
  static const String routeName = '/user-information';
  const UserInformationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserInformationScreen> createState() =>
      _UserInformationScreenState();
}

class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  File? image;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void storeUserData() async {
    String name = nameController.text.trim();

    if (image != null && name.isNotEmpty) {
      ref.read(authControllerProvider).saveUserDataToFirebase(
            context,
            name,
            image,
          );
    } else {
      showSnackBar(
          context: context, content: 'Bạn chưa điền tên hoặc thêm hình ảnh');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                const SizedBox(height: 60),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Nhập thông tin cá nhân',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: greyColor,
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/login.png',
                      height: 50,
                      width: 50,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Stack(
                  children: [
                    image == null
                        ? const CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png',
                            ),
                            radius: 64,
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(
                              image!,
                            ),
                            radius: 64,
                          ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(
                          BootstrapIcons.camera_fill,
                          color: buttonColor,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: nameController,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(width: 1, color: greyColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(width: 1, color: textColor),
                      ), //Create rounded outlined border

                      prefixIcon: const Icon(
                        BootstrapIcons.person,
                        color: greyColor,
                      ),

                      filled: true,
                      fillColor: const Color.fromARGB(255, 102, 102, 102),
                      hintText: "Nhập tên của bạn",
                      hintStyle: const TextStyle(
                        fontSize: 15,
                        // fontWeight: FontWeight.w300,
                        color: greyColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 183),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: ElevatedButton(
                          onPressed: storeUserData,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 15.0),
                            primary: buttonColor,
                          ),
                          child: const Text(
                            "Tiếp",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Row(
                //   children: [
                //     Container(
                //       width: size.width * 0.85,
                //       padding: const EdgeInsets.all(30),
                //       child: TextField(
                //         controller: nameController,
                //         decoration: const InputDecoration(
                //           hintText: 'Enter your name',
                //         ),
                //       ),
                //     ),
                //     IconButton(
                //       onPressed: storeUserData,
                //       icon: const Icon(
                //         Iconsax.tick_circle,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
