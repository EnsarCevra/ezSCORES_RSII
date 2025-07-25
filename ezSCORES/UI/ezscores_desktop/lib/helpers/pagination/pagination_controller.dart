import 'package:ezscores_desktop/models/search_result.dart';
import 'package:flutter/material.dart';

typedef PaginatedFetch<T> = Future<SearchResult<T>> Function(int page, int pageSize);

class PaginationController<T> extends ChangeNotifier {
  final int pageSize;
  final PaginatedFetch<T> fetchPage;
  int currentPage = 0;
  int totalCount = 0;
  List<T> items = [];
  bool isLoading = false;

  PaginationController({required this.fetchPage, this.pageSize = 10});

  Future<void> loadPage([int page = 0]) async {
    isLoading = true;
    notifyListeners();

    currentPage = page;
    final result = await fetchPage(page, pageSize);
    items = result.result;
    totalCount = result.count;

    isLoading = false;
    notifyListeners();
  }

  int get totalPages {
    if (totalCount == 0) return 0;
    return (totalCount / pageSize).ceil();
  }
  int get displayPage => totalCount == 0 ? 0 : currentPage + 1;
  bool get hasNext => currentPage + 1 < totalPages;
  bool get hasPrevious => currentPage > 0;

  Future<void> nextPage() async {
    if (hasNext) await loadPage(currentPage + 1);
  }

  Future<void> previousPage() async {
    if (hasPrevious) await loadPage(currentPage - 1);
  }

  void reset() {
    currentPage = 0;
    totalCount = 0;
    items.clear();
    notifyListeners();
  }
}
