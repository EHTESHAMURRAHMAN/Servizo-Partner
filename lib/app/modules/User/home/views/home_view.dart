import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/modules/User/home/controllers/home_controller.dart';
import 'package:servizo_vendor/app/modules/User/home/views/Widgets/AnimationUI.dart';
import 'package:servizo_vendor/app/modules/User/home/views/Widgets/app_heading_widget.dart';
import 'package:servizo_vendor/app/modules/User/home/views/Widgets/carousel_widget.dart';
import 'package:servizo_vendor/app/modules/User/home/views/Widgets/category_grid_widget.dart';
import 'package:servizo_vendor/app/modules/User/home/views/Widgets/govt_services_grid_widget.dart';
import 'package:servizo_vendor/app/modules/User/home/views/Widgets/head_widget.dart';
import 'package:servizo_vendor/app/modules/User/home/views/Widgets/khatabook_widget.dart';
import 'package:servizo_vendor/app/modules/User/home/views/Widgets/search_bar_widget.dart';
import 'package:servizo_vendor/app/modules/User/home/views/Widgets/section_title_widget.dart';
import 'package:servizo_vendor/app/modules/User/home/views/widgets/heding_section_title_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Get.theme.primaryColor,
          statusBarIconBrightness: Brightness.dark,
        ),
        toolbarHeight: 2,
        backgroundColor: Get.theme.primaryColor,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Get.theme.primaryColor,
              Get.theme.canvasColor,
              Get.theme.canvasColor,
              Get.theme.canvasColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Scrollbar(
            controller: scrollController,
            thickness: 6.0,
            radius: const Radius.circular(10),
            thumbVisibility: true,
            child: CustomScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(child: HeadWidget()),
                const _Spacer(20),
                SliverAppBar(
                  pinned: true,
                  elevation: 0,

                  backgroundColor: Colors.transparent,
                  toolbarHeight: 70,
                  automaticallyImplyLeading: false,
                  flexibleSpace: SearchBarWidget(),
                ),

                const SliverToBoxAdapter(child: AnimatedBanner()),

                const SliverToBoxAdapter(
                  child: HedingSectionTitleWidget(title: "Khatabook"),
                ),
                const _Spacer(10),
                const SliverToBoxAdapter(child: KhatabookWidget()),

                const _Spacer(20),

                const SliverToBoxAdapter(child: SectionTitleWidget()),
                const SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  sliver: CategoryGridWidget(),
                ),
                const _Spacer(20),
                const SliverToBoxAdapter(child: CarouselWidget()),
                const _Spacer(20),
                const SliverToBoxAdapter(
                  child: HedingSectionTitleWidget(title: "Government Services"),
                ),
                const _Spacer(10),
                const SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  sliver: GovtServicesGridWidget(),
                ),
                const _Spacer(20),

                const SliverToBoxAdapter(child: AppHeadingWidget()),
                const _Spacer(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Spacer extends StatelessWidget {
  final double height;
  const _Spacer(this.height);

  @override
  Widget build(BuildContext context) =>
      SliverToBoxAdapter(child: SizedBox(height: height));
}
