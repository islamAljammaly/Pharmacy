import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy/view/widgets/delete_alert_dialog.dart';
import 'package:pharmacy/view/widgets/details_alert_dialog.dart';
import '../../modle/request.dart';


class ListRequests extends StatelessWidget {
  final RxList<Request> sortedRequests;

  const ListRequests({super.key, required this.sortedRequests});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sortedRequests.length,
          itemBuilder: (context, index) {
        final request = sortedRequests[index];
        return ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(request.personName!),
              Row(
                children: [
                  Obx(() => Text('حالة طلبك : ${request.requestState.value}')),
                  const SizedBox(width: 5),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      print('Deleting request with ID: ${request.id}');
                      request.requestState.value == 'في الطريق اليك'
                          ? Get.snackbar('لا يمكن', 'لا يمكن حذف طلبك الان لأنه في الطريق اليك')
                          : showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DeleteAlertDialog(id: request.id!,type: 'req',);
                              },
                            );
                    },
                  ),
                ],
              ),
            ],
          ),
          subtitle: 
              Text(DateFormat('yyyy-MM-dd / HH:mm').format(request.addedTime!)),
            
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return DetailsRequestAlertDialog(request: request);
              },
            );
          },
        );
          },
        );
  }

}