import 'package:flutter/material.dart';
import 'package:info_space_app/app/domain/entities/people_in_space_entity.dart';
import 'package:info_space_app/app/presentation/pages/peoples_in_space/peoples_in_space_controller.dart';
import 'package:info_space_app/app/presentation/pages/peoples_in_space/peoples_in_space_state.dart';
import 'package:info_space_app/app/presentation/utils/show_snackbar.dart';
import 'package:info_space_app/app/presentation/widgets/datatable_custom.dart';
import 'package:info_space_app/app/presentation/widgets/header_page.dart';
import 'package:info_space_app/core/dependency_injection/dependency_injection_config.dart';

class PeoplesInSpacePage extends StatefulWidget {
  static String route = '/peoples-in-space';

  const PeoplesInSpacePage({
    Key? key,
  }) : super(key: key);

  @override
  _PeoplesInSpacePageState createState() => _PeoplesInSpacePageState();
}

class _PeoplesInSpacePageState extends State<PeoplesInSpacePage> {
  final PeoplesInSpaceController peoplesInSpaceController =
      locator<PeoplesInSpaceController>();

  Future<void> _getData() async {
    await peoplesInSpaceController.getPeoplesInSpace();

    if (peoplesInSpaceController.state.value.failure != null) {
      showErrorSnackbar(
        title: 'Error',
        error: peoplesInSpaceController.state.value.failure,
      );
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  void dispose() {
    peoplesInSpaceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderPage(
        context,
        title: 'People in Space Right Now',
        description:
            'The number of people in space at this moment. List of names when known.',
      ),
      body: ValueListenableBuilder<PeoplesInSpaceState>(
        builder: (_, state, __) {
          return DatatableCustom<PeopleInSpaceEntity>(
            data: state.peopleInSpaceList,
            loading: state.isLoading,
            onRefresh: _getData,
            itemHeader: [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Craft'))
            ],
            itemRow: (people) => [
              DataCell(Text(people.name)),
              DataCell(Text(people.craft), placeholder: true),
            ],
          );
        },
        valueListenable: peoplesInSpaceController.state,
      ),
    );
  }
}
