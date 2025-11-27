import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servizo_vendor/app/Model/picked_scrap_resp.dart';
import 'package:servizo_vendor/app/Utils/Common_Widget.dart';
import 'package:servizo_vendor/app/modules/User/ScrapHome/views/ScrapDetail.dart';
import 'package:servizo_vendor/app/routes/app_pages.dart';
import '../controllers/scrap_home_controller.dart';

class ScrapHomeView extends GetView<ScrapHomeController> {
  const ScrapHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: heading('My Scrap Orders', ''),
          automaticallyImplyLeading: false,
          leading: backButton(),
          centerTitle: true,
          bottom: TabBar(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey.shade600,
            dividerColor: Colors.transparent,
            indicator: BoxDecoration(
              color: Get.theme.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(text: 'Pending'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Get.toNamed(Routes.SCRAP_BOOKING),
          backgroundColor: Get.theme.primaryColor,
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text(
            "Sell More Scrap",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        body: Obx(() {
          if (controller.isScrapLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return TabBarView(
            children: [
              _buildScrapList(context, 'Pending'),
              _buildScrapList(context, 'Completed'),
              _buildScrapList(context, 'Cancelled'),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildScrapList(BuildContext context, String status) {
    final filteredOrders =
        controller.pickedScrapData
            .where(
              (order) => order.status.toLowerCase() == status.toLowerCase(),
            )
            .toList();

    if (filteredOrders.isEmpty) return noData();

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        final order = filteredOrders[index];
        return _scrapOrderCard(order);
      },
    );
  }

  Widget _scrapOrderCard(PickedScrapData order) {
    Color statusColor;
    IconData statusIcon;
    switch (order.status.toLowerCase()) {
      case "completed":
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case "pending":
        statusColor = Colors.orange;
        statusIcon = Icons.hourglass_bottom;
        break;
      default:
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
    }

    return InkWell(
      onTap: () => Get.to(() => ScrapDetailView(order: order)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(10),
                itemCount: order.items.length,
                itemBuilder: (context, index) {
                  final item = order.items[index];
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              item.scrapImg,
                              width: 150,

                              fit: BoxFit.cover,
                              errorBuilder:
                                  (_, __, ___) => Container(
                                    width: 120,
                                    height: 100,
                                    color: Colors.grey.shade200,
                                    child: const Icon(
                                      Icons.broken_image,
                                      size: 30,
                                    ),
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.scrapType,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(statusIcon, size: 18, color: statusColor),
                      const SizedBox(width: 6),
                      Text(
                        order.status,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      order.isPaid
                          ? Chip(
                            label: const Text("Paid"),
                            backgroundColor: Colors.green.shade50,
                            labelStyle: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                          : Chip(
                            label: const Text("Unpaid"),
                            backgroundColor: Colors.red.shade50,
                            labelStyle: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                    ],
                  ),
                  const SizedBox(height: 5),

                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        order.pickupDate,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          order.pickupAddress,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone,
                        size: 14,
                        color: Colors.blueAccent,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        order.phoneNumber,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
