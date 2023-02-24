import 'dart:io';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:originner/colors.dart';
import 'package:originner/common/utils/utils.dart';
import 'package:originner/features/auth/controller/auth_controller.dart';
import 'package:originner/features/landing/screens/landing_screen.dart';
import 'package:originner/features/select_contacts/screens/select_contacts_screen.dart';
import 'package:originner/features/chat/widgets/contacts_list.dart';
import 'package:originner/features/status/screens/confirm_status_screen.dart';
import 'package:originner/features/status/screens/status_contacts_screen.dart';

class MobileLayoutScreen extends ConsumerStatefulWidget {
  const MobileLayoutScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MobileLayoutScreen> createState() => _MobileLayoutScreenState();
}

class _MobileLayoutScreenState extends ConsumerState<MobileLayoutScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late TabController tabBarController;
  // ignore: prefer_final_fields
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        ref.read(authControllerProvider).setUserState(false);
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: blackColor,
          centerTitle: false,
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Originner app',
              style: TextStyle(
                fontSize: 25,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: CircleAvatar(
                  radius: 30,
                  backgroundColor: const Color.fromARGB(255, 81, 81, 81),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: IconButton(
                        icon: const Icon(BootstrapIcons.box_arrow_right,
                            size: 19, color: textColor),
                        onPressed: () async {
                          await _auth.signOut();
                          Navigator.pushNamed(context, LandingScreen.routeName);
                        }),
                  )),
            ),
            // IconButton(
            //   icon: const Icon(BootstrapIcons.search, color: Colors.grey),
            //   onPressed: () {},
            // ),
            // IconButton(
            //     icon: const Icon(BootstrapIcons.box_arrow_right,
            //         size: 25, color: Colors.grey),
            //     onPressed: () async {
            //       await _auth.signOut();
            //       Navigator.pushNamed(context, LandingScreen.routeName);
            //     })
          ],
          bottom: TabBar(
            controller: tabBarController,
            indicatorColor: buttonColor,
            indicatorWeight: 2,
            labelColor: iconColor,
            unselectedLabelColor: greyColor,
            labelStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(
                icon: Icon(
                  BootstrapIcons.chat_fill,
                  color: buttonColor,
                ),
              ),
              Tab(
                icon: Icon(BootstrapIcons.clock_fill),
              ),
              Tab(
                icon: Icon(BootstrapIcons.telephone_fill),
              ),
            ],
          ),
        ),
        body: TabBarView(controller: tabBarController, children: const [
          ContactsList(),
          StatusContactsScreen(),
          Icon(Iconsax.call),
        ]),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(5.0),
          child: FloatingActionButton(
            onPressed: () async {
              if (tabBarController.index == 0) {
                Navigator.pushNamed(context, SelectContactsScreen.routeName);
              } else {
                File? pickedImage = await pickImageFromGallery(context);
                if (pickedImage != null) {
                  Navigator.pushNamed(context, ConfirmStatusScreen.routeName,
                      arguments: pickedImage);
                }
              }
            },
            backgroundColor: const Color.fromARGB(255, 81, 81, 81),
            child: const Icon(
              BootstrapIcons.plus,
              color: iconColor,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
