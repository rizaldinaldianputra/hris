import 'package:flutter/widgets.dart';
import 'package:hris/models/leave_model.dart';
import 'package:hris/service/leave_service.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'leave.g.dart';

@Riverpod(keepAlive: false)
class LeaveList extends _$LeaveList {
  late PagingController<int, LeaveModel> pagingController;

  @override
  late BuildContext context;
  String searchQuery = ''; // Add searchQuery state

  @override
  PagingController<int, LeaveModel> build(BuildContext context) {
    this.context = context; // Store the context
    pagingController = PagingController<int, LeaveModel>(firstPageKey: 0);
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey: pageKey, pageSize: 10);
    });

    return pagingController;
  }

  Future<void> fetchPage({
    required int pageKey,
    required int pageSize,
  }) async {
    try {
      final data = {
        "pageNo": pageKey,
        "pageSize": pageSize,
        "filter": [],
        "sortType": "DESC",
        "sortByColumn": "waktu",
      };
      final leaveService = LeaveService(context);
      final newItems = await leaveService.findAllData(data);

      final isLastPage = newItems.length < pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error; // Make sure to handle errors here
      // You can log the error for debugging purposes
      print('Error fetching page: $error');
    }
  }
}
