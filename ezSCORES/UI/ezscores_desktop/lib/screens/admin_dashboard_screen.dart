import 'dart:io';

import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/models/DTOs/adminCardsDto.dart';
import 'package:ezscores_desktop/providers/auth_provider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ezscores_desktop/providers/CompetitionsProvider.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:file_selector/file_selector.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  late CompetitionProvider competitionProvider;
  AdminDashboardCardsDTO? stats;
  Map<String, int> competitionByStatus = {};
  Map<String, int> competitionByMonth = {};
  int selectedYear = DateTime.now().year;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    competitionProvider = context.read<CompetitionProvider>();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData([int? year]) async {
    try {
      final selected = year ?? selectedYear;
      final cardsInfo = await competitionProvider.getDashboardCardStats(selected);
      final byStatus = {
        'Priprema': cardsInfo.competitionsByStatus.preparationCount,
        'Otvorene prijave': cardsInfo.competitionsByStatus.applicationsOpenedCount,
        'Zatvorene prijave': cardsInfo.competitionsByStatus.applicationsClosedCount,
        'U toku': cardsInfo.competitionsByStatus.underwayCount,
        'Zavrseno': cardsInfo.competitionsByStatus.finishedCount,
      };
      final byMonth = cardsInfo.competitionsByMonth;
      setState(() {
        selectedYear = selected;
        stats = cardsInfo;
        competitionByStatus = byStatus;
        competitionByMonth = byMonth;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Dashboard",
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text(
                    "Dobrodošao ${AuthProvider.firstName} na admin panel",
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      MetricCard(title: "Takmičenja", value: "${stats?.competitions ?? 0}", icon: Icons.sports_soccer),
                      const SizedBox(width: 16),
                      MetricCard(title: "Timovi", value: "${stats?.teams ?? 0}", icon: Icons.groups),
                      const SizedBox(width: 16),
                      MetricCard(title: "Igrači", value: "${stats?.players ?? 0}", icon: Icons.person),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        ChartCard(
                          title: "Takmicenja po statusima",
                          child: CompetitionsPieChart(data: competitionByStatus),
                          onDownload: _generateStatusReportPdf,
                        ),
                        ChartCard(
                          title: "Takmicenja po mjesecima (datum pocetka)",
                          onDownload: (){
                            _generateMonthReportPdf();
                          },
                          child: Column(
                            children: [
                              YearDropdown(
                                selectedYear: selectedYear,
                                onChanged: (year) => _loadDashboardData(year),
                              ),
                              const SizedBox(height: 12),
                              competitionByMonth.values.every((v) => v == 0)
                                  ? const Padding(
                                      padding: EdgeInsets.only(top: 30),
                                      child: Text(
                                        "Nema takmicenja u ovoj godini",
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  : CompetitionsBarChart(data: competitionByMonth),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
      ),
      selectedIndex: 0,
    );
  }
  Future<void> _generateStatusReportPdf() async {
    final pdf = pw.Document();
    final total = competitionByStatus.values.fold(0, (a, b) => a + b);

    try {
      final logoBytes = await rootBundle.load('assets/images/ezLogo5.png'); 
      final logoImage = pw.MemoryImage(logoBytes.buffer.asUint8List());

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.SizedBox(),
                    pw.Image(logoImage, width: 80),
                  ],
                ),
                pw.SizedBox(height: 16),
                pw.Center(
                  child: pw.Text(
                    'Izvjestaj: Takmicenja po statusima',
                    style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.SizedBox(height: 24),
                pw.Text('Ukupan broj takmicenja: $total', style: const pw.TextStyle(fontSize: 16)),
                pw.SizedBox(height: 16),
                // ignore: deprecated_member_use
                pw.Table.fromTextArray(
                  headers: ['Status', 'Broj'],
                  headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
                  cellAlignment: pw.Alignment.center,
                  cellStyle: const pw.TextStyle(fontSize: 14),
                  data: competitionByStatus.entries
                      .map((e) => [e.key, e.value.toString()])
                      .toList(),
                ),
              ],
            );
          },
        ),
      );

      final timestamp = _formatDate(DateTime.now().toIso8601String());
      final saveFile = await getSaveLocation(
        suggestedName: 'TakmicenjaPoStatusima_$timestamp.pdf',
      );
      if (saveFile == null) return;

      final file = File(saveFile.path.endsWith('.pdf') ? saveFile.path : '${saveFile.path}.pdf');
      await file.writeAsBytes(await pdf.save());

      showBottomRightNotification(context, "Uspješno preuzet dokument");
    } catch (e) {
      print("PDF error: $e");
    }
  }
  Future<void> _generateMonthReportPdf() async {
    final pdf = pw.Document();
    final total = competitionByMonth.values.fold(0, (a, b) => a + b);

    try {
      final logoBytes = await rootBundle.load('assets/images/ezLogo5.png');
      final logoImage = pw.MemoryImage(logoBytes.buffer.asUint8List());

      final monthLabels = [
        "Januar", "Februar", "Mart", "April", "Maj", "Juni",
        "Juli", "August", "Septembar", "Oktobar", "Novembar", "Decembar"
      ];

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.SizedBox(),
                    pw.Image(logoImage, width: 80),
                  ],
                ),
                pw.SizedBox(height: 16),

                pw.Center(
                  child: pw.Text(
                    'Izvjestaj: Takmicenja po mjesecima',
                    style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.SizedBox(height: 24),

                pw.Text(
                  'Ukupan broj takmicenja: $total',
                  style: const pw.TextStyle(fontSize: 16),
                ),
                pw.SizedBox(height: 16),

                pw.Table.fromTextArray(
                  headers: ['Mjesec', 'Broj takmicenja'],
                  headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
                  cellAlignment: pw.Alignment.center,
                  cellStyle: const pw.TextStyle(fontSize: 14),
                  data: List.generate(12, (index) {
                    final month = index + 1;
                    final label = monthLabels[index];
                    final count = competitionByMonth["$month"] ?? 0;
                    return [label, count.toString()];
                  }),
                ),
              ],
            );
          },
        ),
      );

      final timestamp = _formatDate(DateTime.now().toIso8601String());
      final saveFile = await getSaveLocation(
        suggestedName: 'TakmicenjaPoMjesecima_$timestamp.pdf',
      );
      if (saveFile == null) return;

      final file = File(saveFile.path.endsWith('.pdf') ? saveFile.path : '${saveFile.path}.pdf');
      await file.writeAsBytes(await pdf.save());

      showBottomRightNotification(context, "Uspješno preuzet dokument");
    } catch (e) {
      print("PDF error: $e");
    }
  }

}
String _formatDate(String iso) {
    final dt = DateTime.parse(iso);
    return "${dt.day}-${dt.month}-${dt.year}_${dt.hour}-${dt.minute}";
  }
class YearDropdown extends StatelessWidget {
  final int selectedYear;
  final void Function(int) onChanged;

  const YearDropdown({
    super.key,
    required this.selectedYear,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;
    final years = List<int>.generate(currentYear - 2019 + 1, (i) => currentYear - i);

    return DropdownButton<int>(
      value: selectedYear,
      onChanged: (value) {

        if (value != null) onChanged(value);
      },
      items: years.map((year) {
        return DropdownMenuItem(
          value: year,
          child: Text(year.toString()),
        );
      }).toList(),
    );
  }
}


class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const MetricCard({super.key, required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Colors.blueAccent),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                  const SizedBox(height: 4),
                  Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartCard extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback? onDownload;

  const ChartCard({
    super.key,
    required this.title,
    required this.child,
    this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - 64) / 3;

    return SizedBox(
      width: cardWidth.clamp(300.0, 600.0),
      height: 500,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Expanded(child: child),
              const SizedBox(height: 12),
              if (onDownload != null)
                Center(
                  child: ElevatedButton.icon(
                    onPressed: onDownload,
                    icon: const Icon(Icons.download),
                    label: const Text("Preuzmi izvještaj"),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}





class CompetitionsPieChart extends StatelessWidget {
  final Map<String, int> data;

  const CompetitionsPieChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final total = data.values.fold(0, (sum, value) => sum + value);
    final List<Color> pieColors = [
      Colors.blue,
      Colors.orange,
      Colors.red,
      Colors.green,
      Colors.grey,
    ];

    return Column(
      children: [
        SizedBox(
          height: 250,
          child: PieChart(
            PieChartData(
              sections: List.generate(data.length, (i) {
                final key = data.keys.elementAt(i);
                final value = data[key]!;
                final label = '$value';

                return PieChartSectionData(
                  color: pieColors[i % pieColors.length],
                  value: value.toDouble(),
                  title: label,
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  radius: 60,
                );
              }),
              sectionsSpace: 2,
              centerSpaceRadius: 40,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: List.generate(data.length, (i) {
            final key = data.keys.elementAt(i);
            final value = data[key]!;
            final percentage = total == 0 ? 0 : (value / total * 100).toStringAsFixed(1);

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: pieColors[i % pieColors.length],
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  "$key ($value - $percentage%)",
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}

class CompetitionsBarChart extends StatelessWidget {
  final Map<String, int> data;

  const CompetitionsBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final barGroups = <BarChartGroupData>[];

    final monthLabels = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];

    for (int i = 0; i < 12; i++) {
      final count = data["${i + 1}"] ?? 0;
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: count.toDouble(),
              color: Colors.blueAccent,
              width: 16,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      height: 300,
      child: BarChart(
        BarChartData(
          barGroups: barGroups,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 28),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < monthLabels.length) {
                    return Text(monthLabels[index], style: const TextStyle(fontSize: 10));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}


