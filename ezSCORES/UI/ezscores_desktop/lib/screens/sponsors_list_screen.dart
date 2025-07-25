import 'package:ezscores_desktop/dialogs/sponsor_dialog.dart';
import 'package:ezscores_desktop/dialogs/stadium_dialog.dart';
import 'package:ezscores_desktop/helpers/pagination/pagination_controller.dart';
import 'package:ezscores_desktop/helpers/pagination/pagination_controlls.dart';
import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/models/sponsors.dart';
import 'package:ezscores_desktop/providers/SponsorsProvider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SponsorsListScreen extends StatefulWidget {
  final int selectedIndex;
  const SponsorsListScreen({super.key, required this.selectedIndex});

  @override
  State<SponsorsListScreen> createState() => _SponsorsListScreenState();
}

class _SponsorsListScreenState extends State<SponsorsListScreen> {
  late SponsorProvider sponsorProvider;
  late PaginationController<Sponsors> _paginationController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    sponsorProvider = context.read<SponsorProvider>();
  }

  @override
  void initState() {
    super.initState();
    sponsorProvider = context.read<SponsorProvider>();
    _paginationController = PaginationController<Sponsors>(
      fetchPage: (page, pageSize){
        var filter = {
          "name": _ftsEditingController.text,
          "page": page,
          "pageSize": pageSize
        };
        return sponsorProvider.get(filter: filter);
      }
    );
    initForm();
  }

  Future initForm() async {
    await _paginationController.loadPage();

    setState(() {
    });
  }

  final TextEditingController _ftsEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Lista sponzora",
      selectedIndex: widget.selectedIndex,
      Container(
        child: Column(
          children: [
            _buildSearch(),
            AnimatedBuilder(
              animation: _paginationController,
              builder: (context, _) => _buildResultView(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _ftsEditingController,
              decoration: const InputDecoration(labelText: "Naziv"),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () async {
              await _paginationController.loadPage(0);
              setState(() {
              });
            },
            child: const Icon(Icons.search),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () async {
              final actionResult = await showDialog<bool>(
                context: context,
                builder: (context) => StadiumDialog());
              if (actionResult == true) {
                initForm();
              }
            },
            child: const Text("Dodaj"),
          ),
        ],
      ),
    );
  }

 Widget _buildResultView() {
  return Expanded(
    child: Column(
      children: [
        /// Main content area
        Expanded(
          child: _paginationController.isLoading
              ? const Center(child: CircularProgressIndicator())
              : _paginationController.items.isEmpty
                  ? const Center(child: Text('Nema podataka'))
                  : SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8.0),
                        child: DataTable(
                          columnSpacing: 16.0,
                          showCheckboxColumn: false,
                          columns: const [
                            DataColumn(
                              label: Text(
                                  "Slika",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                )
                            ),
                            DataColumn(
                              label: Text(
                                  "Naziv",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                            ),
                          ],
                          rows: _paginationController.items.map((e) => DataRow(
                            onSelectChanged: (_) => _handleRowTap(e),
                            cells: [
                              DataCell(
                                SizedBox(
                                  width: 30,
                                  child: e.picture != null
                                      ? imageFromString(e.picture!)
                                      : const Icon(Icons.handshake),
                                ),
                              ),
                              DataCell(
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(e.name ?? ""),
                                ),
                              ),
                            ],
                          )).toList(),
                        ),
                      ),
                    ),
        ),

        /// Pagination controls at bottom
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: PaginationControls(controller: _paginationController),
        ),
      ],
    ),
  );
}


  _handleRowTap(Sponsors selectedSponsor) async {
    final shouldReload = await showDialog<bool>(
      context: context,
      builder: (context) => SponsorDialog(sponsor: selectedSponsor),
    );

    if (shouldReload == true) {
      initForm();
    }
  }
}
