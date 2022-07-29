import 'package:firebasesample/app/modules/auth/controllers/auth_controller.dart';
import 'package:firebasesample/app/modules/welcome_page/views/util/cutom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../show/views/show_view.dart';
import '../controllers/welcome_page_controller.dart';

class WelcomePageView extends GetView<WelcomePageController> {
  final String email;
  const WelcomePageView({Key? key, required this.email}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.black,
          drawer: Drawer(
            backgroundColor: Colors.transparent,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/default.jpg",
                          ),
                          fit: BoxFit.cover)),
                  child: Text(
                    email.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  title:
                      const Text('Home', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Get.back();
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.notes_outlined,
                    color: Colors.white,
                  ),
                  title:
                      const Text('Add', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    WelcomePageController.namecontroller.clear();
                    WelcomePageController.numbercontroller.clear();
                    WelcomePageController.dialog.value = true;
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                  ),
                  title: const Text('Logout',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    AuthController.instance.logout();
                    
                  },
                ),
              ],
            ),
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.transparent,
                floating: true,
                expandedHeight: height * 0.7,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text('Your Contacts'),
                  background: Container(
                    height: height * 0.1,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/contact.gif"),
                    )),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return ShowView();
                }, childCount: 1),
              )
            ],
          ),
        ),
        Obx(() => Visibility(
              visible: WelcomePageController.dialog.value,
              child: const CustomDialog(),
            ))
      ],
    );
  }
}
