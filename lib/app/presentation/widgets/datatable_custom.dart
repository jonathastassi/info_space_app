import 'package:flutter/material.dart';
import 'package:info_space_app/app/presentation/widgets/loading_widget.dart';

class DatatableCustom<ItemType> extends StatelessWidget {
  final List<ItemType> data;
  final bool loading;
  final List<DataColumn> itemHeader;
  final List<DataCell> Function(ItemType entity) itemRow;
  final Future<void> Function() onRefresh;
  const DatatableCustom({
    Key? key,
    required this.data,
    required this.itemHeader,
    required this.itemRow,
    required this.onRefresh,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: loading == true
          ? LoadingWidget()
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DataTable(
                        columns: itemHeader,
                        rows: data
                            .map(
                              (item) => DataRow(
                                cells: itemRow.call(item),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
