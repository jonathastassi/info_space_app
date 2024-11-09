import 'package:flutter/material.dart';
import 'package:info_space_app/feature/peoples_in_space/controller/peoples_in_space_controller.dart';
import 'package:info_space_app/feature/peoples_in_space/controller/peoples_in_space_state.dart';
import 'package:info_space_app/shared/widgets/error_warning_widget.dart';
import 'package:info_space_app/shared/widgets/loading_widget.dart';
import 'package:info_space_app/shared/widgets/sliver_app_bar_custom.dart';
import 'package:info_space_repository/info_space_repository.dart';

class PeoplesInSpaceTab extends StatelessWidget {
  const PeoplesInSpaceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return PeoplesInSpaceView(
      peoplesInSpaceController: PeoplesInSpaceController(
        infoSpaceRepository: InfoSpaceRepository(),
      ),
    );
  }
}

class PeoplesInSpaceView extends StatefulWidget {
  const PeoplesInSpaceView({
    super.key,
    required PeoplesInSpaceController peoplesInSpaceController,
  }) : _peoplesInSpaceController = peoplesInSpaceController;

  final PeoplesInSpaceController _peoplesInSpaceController;

  @override
  State<PeoplesInSpaceView> createState() => _PeoplesInSpaceViewState();
}

class _PeoplesInSpaceViewState extends State<PeoplesInSpaceView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => widget._peoplesInSpaceController.getPeoplesInSpace(),
    );

    super.initState();
  }

  @override
  void dispose() {
    widget._peoplesInSpaceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget._peoplesInSpaceController.getPeoplesInSpace,
      child: ValueListenableBuilder<PeoplesInSpaceState>(
        builder: (_, state, __) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(
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
                const SliverFillRemaining(
                  child: LoadingWidget(),
                )
              else if (state is FailurePeoplesInSpaceState)
                SliverFillRemaining(
                  child: ErrorWarningWidget(
                    onRetry: widget._peoplesInSpaceController.getPeoplesInSpace,
                  ),
                )
              else if (state is SuccessPeoplesInSpaceState)
                SliverToBoxAdapter(
                  child: DataTable(
                    columns: const [
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
        valueListenable: widget._peoplesInSpaceController,
      ),
    );
  }
}
