import 'package:flutter/material.dart';

class SliverAppBarCustom extends SliverAppBar {
  SliverAppBarCustom(
    BuildContext context, {
    required String titlePage,
    required String titleTab,
    required String descriptionTab,
  }) : super(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            titlePage,
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).secondaryHeaderColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          floating: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.light_mode,
                color: Theme.of(context).secondaryHeaderColor,
              ),
            )
          ],
          bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    titleTab,
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
                    descriptionTab,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            preferredSize: Size.fromHeight(130),
          ),
        );
}
