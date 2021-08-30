import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_space_app/app/domain/entities/people_in_space_entity.dart';
import 'package:info_space_app/app/presentation/pages/peoples_in_space/peoples_in_space_controller.dart';
import 'package:info_space_app/app/presentation/widgets/datatable_custom.dart';

class PeoplesInSpacePage extends GetView<PeoplesInSpaceController> {
  static String route = '/peoples-in-space';

  const PeoplesInSpacePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'People in Space Right Now',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'The number of people in space at this moment. List of names when known.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => DatatableCustom<PeopleInSpaceEntity>(
                  data: controller.peopleInSpaceList,
                  loading: controller.isLoading.value,
                  onRefresh: controller.getPeoplesInSpace,
                  itemHeader: [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Craft'))
                  ],
                  itemRow: (people) => [
                    DataCell(Text(people.name)),
                    DataCell(Text(people.craft), placeholder: true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
