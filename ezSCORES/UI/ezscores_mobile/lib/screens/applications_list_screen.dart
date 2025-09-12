import 'package:ezscores_mobile/helpers/app_loading_widget.dart';
import 'package:ezscores_mobile/helpers/pagination/pagination_controller.dart';
import 'package:ezscores_mobile/models/applications.dart';
import 'package:ezscores_mobile/providers/ApplicationsProvider.dart';
import 'package:ezscores_mobile/providers/utils.dart';
import 'package:ezscores_mobile/screens/application_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class ApplicationsListScreen extends StatefulWidget {
  const ApplicationsListScreen({super.key});

  @override
  State<ApplicationsListScreen> createState() => _ApplicationsListScreenState();
}

class _ApplicationsListScreenState extends State<ApplicationsListScreen> {
  bool? selectedStatus;
  late ApplicationProvider applicationProvider;
  final _formKey = GlobalKey<FormBuilderState>();

  late PaginationController<Applications> _paginationController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    
    applicationProvider = context.read<ApplicationProvider>();
    _paginationController = PaginationController<Applications>(
      fetchPage: (page, pageSize) {
        var filter = {
          "isAccepted" : selectedStatus,
          "page": page,
          "pageSize": pageSize,
        };
        return applicationProvider.get(filter: filter);
      },
    );
    _paginationController.addListener(() {
      setState(() {});
    });

    _paginationController.loadPage();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
        _paginationController.loadMore();
      }
    });
  }
  @override
  void dispose() {
    _paginationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prijave",
        style: TextStyle(fontSize: 15),),
        actions: const [
          LogoutButton()
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              _buildSearch(),
              const SizedBox(height: 12),
              Expanded(child: _buildApplicationsResultView())
            ]
          ),
        ),
      ),
    );
  }
  
  _buildSearch() {
    final textTheme = Theme.of(context).textTheme;
    return Row(
          children: [
            Expanded(
              child: FormBuilderDropdown<String>(
                name: "applicationStatus",
                decoration: InputDecoration(
                  labelText: "Status",
                  labelStyle: textTheme.bodySmall,
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  suffixIcon: selectedStatus != null
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              selectedStatus = null;
                              _formKey.currentState
                                  ?.fields['applicationStatus']
                                  ?.didChange(null);
                            });
                            _paginationController.loadPage();
                          },
                        )
                      : null,
                ),
                items: [
                  DropdownMenuItem(
                    value: "Prihvaćeno",
                    child: Text(
                      "Prihvaćeno",
                      style: textTheme.bodySmall,
                    ),
                  ),
                  DropdownMenuItem(
                    value: "Odbijeno",
                    child: Text(
                      "Odbijeno",
                      style: textTheme.bodySmall,
                    ),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value == null ? null : (value == 'Prihvaćeno');
                    _paginationController.loadPage();
                  });
                },
              ),
            ),
          ],
        );
  }
  
  _buildApplicationsResultView() {
    return AnimatedBuilder(
      animation: _paginationController,
      builder: (context, _) {
        if (_paginationController.isLoading && _paginationController.items.isEmpty) {
          return const Center(child: AppLoading());
        }

        if (_paginationController.items.isEmpty) {
          return const Center(child: Text("Nema podataka"));
        }

        return ListView.builder(
          controller: _scrollController,
          itemCount: _paginationController.items.length + (_paginationController.hasNext ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < _paginationController.items.length) {
              final application = _paginationController.items[index];
              return _buildApplicationCard(context, application);
            } else {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(child: AppLoading()),
              );
            }
          },
        );
      },
    );
  }
  Widget _buildApplicationCard(BuildContext context, Applications application) {
  final textTheme = Theme.of(context).textTheme;

  return InkWell(
    onTap:() async{
      final shouldReload = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => ApplicationDetailsScreen(application: application,)
                )
              )
            );
        if(shouldReload != null && shouldReload == true)
        {
          _paginationController.loadPage();
        }
    } ,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 60,
                height: 60,
                color: Colors.grey[300],
                child: application.team?.picture == null || application.team!.picture!.isEmpty
                    ? const Icon(Icons.groups, size: 30, color: Colors.grey)
                    : imageFromString(application.team!.picture!),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    application.team?.name ?? "Nepoznat tim",
                    style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    application.isAccepted == null ? 'Na obradi' : application.isAccepted == true ? "Prihvaćeno" : "Odbijeno",
                    style: textTheme.bodySmall?.copyWith(
                      color: application.isAccepted == null ? Colors.grey : application.isAccepted == true ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if(application.isAccepted == null)IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                await deleteEntity(
                  context: context,
                  deleteFunction: applicationProvider.delete,
                  entityId: application.id!,
                  onDeleted: _paginationController.loadPage);
              },
            ),
          ],
        ),
      ),
    ),
  );
}
}