import 'package:flutter/material.dart';
import 'package:info_space_app/feature/peoples_in_space/controller/peoples_in_space_controller.dart';
import 'package:info_space_app/feature/peoples_in_space/controller/peoples_in_space_state.dart';
import 'package:info_space_app/feature/peoples_in_space/provider/peoples_in_space_provider.dart';
import 'package:info_space_app/shared/widgets/error_warning_widget.dart';
import 'package:info_space_app/shared/widgets/loading_widget.dart';
import 'package:info_space_app/shared/widgets/sliver_app_bar_custom.dart';
import 'package:info_space_repository/info_space_repository.dart';

class PeoplesInSpaceTab extends StatelessWidget {
  const PeoplesInSpaceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return PeoplesInSpaceProvider(
      notifier: PeoplesInSpaceController(
        infoSpaceRepository: InfoSpaceRepository(),
      ),
      child: const PeoplesInSpaceView(),
    );
  }
}

class PeoplesInSpaceView extends StatefulWidget {
  const PeoplesInSpaceView({
    Key? key,
  }) : super(key: key);

  @override
  _PeoplesInSpaceViewState createState() => _PeoplesInSpaceViewState();
}

class _PeoplesInSpaceViewState extends State<PeoplesInSpaceView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => PeoplesInSpaceProvider.of(context).getPeoplesInSpace());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final peoplesInSpaceController = PeoplesInSpaceProvider.of(context);

    return RefreshIndicator(
      onRefresh: PeoplesInSpaceProvider.of(context).getPeoplesInSpace,
      child: ValueListenableBuilder<PeoplesInSpaceState>(
        builder: (_, state, __) {
          return CustomScrollView(
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverAppBarCustom(
                context,
                titlePage: 'info SPACE',
                titleTab: 'People in Space Right Now',
                descriptionTab:
                    'The number of people in space at this moment. List of names when known.',
              ),
              if (state is LoadingPeoplesInSpaceState)
                SliverFillRemaining(
                  child: LoadingWidget(),
                )
              else if (state is FailurePeoplesInSpaceState)
                SliverFillRemaining(
                  child: ErrorWarningWidget(
                    onRetry:
                        PeoplesInSpaceProvider.of(context).getPeoplesInSpace,
                  ),
                )
              else if (state is SuccessPeoplesInSpaceState)
                SliverToBoxAdapter(
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Craft'))
                    ],
                    rows: state.data
                        .map(
                          (item) => DataRow(
                            cells: [
                              DataCell(Text(item.name)),
                              DataCell(
                                Text(item.craft),
                                placeholder: true,
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
            ],
          );
        },
        valueListenable: peoplesInSpaceController,
      ),
    );
  }
}
