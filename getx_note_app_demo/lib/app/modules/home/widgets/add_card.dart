import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/extensions.dart';
import '../../../widgets/icons.dart';
import '../controller.dart';

class AddCard extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  AddCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squaredWidth = Get.width - 12.0.wp;

    return Container(
        width: squaredWidth / 2,
        height: squaredWidth / 2,
        margin: EdgeInsets.all(3.0.wp),
        child: InkWell(
          onTap: () {},
          child: DottedBorder(
            color: Colors.grey[400]!,
            dashPattern: const [8, 4],
            child: Center(
              child: Icon(
                Icons.add,
                size: 10.0.wp,
                color: Colors.grey[600],
              ),
            ),
          ),
        ));
  }
}
