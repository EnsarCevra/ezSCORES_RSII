import 'package:ezscores_desktop/models/rewards.dart';
import 'package:ezscores_desktop/providers/RewardsProvider.dart';
import 'package:ezscores_desktop/providers/base_provider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class RewardsDialog extends StatefulWidget {
  final Rewards? reward;
  final int competitionId;

  const RewardsDialog({super.key, this.reward, required this.competitionId});

  @override
  State<RewardsDialog> createState() => _RewardsDialogState();
}

class _RewardsDialogState extends State<RewardsDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  late RewardProvider rewardProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    rewardProvider = context.read<RewardProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.reward == null ? "Dodaj nagradu" : "Uredi nagradu"),
      content: SizedBox(
        width: 400,
        child: FormBuilder(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // FormBuilderTextField(
              //   name: 'name',
              //   initialValue: widget.reward?.name ?? '',
              //   decoration: const InputDecoration(labelText: 'Naziv'),
              //   autovalidateMode: AutovalidateMode.onUserInteraction,
              //   validator: FormBuilderValidators.compose([
              //     FormBuilderValidators.required(errorText: 'Naziv je obavezan'),
              //     FormBuilderValidators.minLength(2, errorText: 'Naziv mora imati barem 2 znaka'),
              //   ]),
              // ),
              //const SizedBox(height: 12),
              FormBuilderField<int>(
                name: 'rankingPosition',
                initialValue: widget.reward?.rankingPosition,
                validator: FormBuilderValidators.required(errorText: 'Pozicija je obavezna'),
                builder: (FormFieldState<int?> field) {
                  final selected = field.value;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Pozicija na ljestvici',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildPodiumBox(context, 2, selected, field.didChange, height: 80),
                          const SizedBox(width: 8),
                          _buildPodiumBox(context, 1, selected, field.didChange, height: 100),
                          const SizedBox(width: 8),
                          _buildPodiumBox(context, 3, selected, field.didChange, height: 70),
                          const SizedBox(width: 8),
                          _buildPodiumBox(context, 4, selected, field.didChange, height: 60),
                        ],
                      ),
                      if (field.hasError)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            field.errorText ?? '',
                            style: const TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 12),
              FormBuilderTextField(
                name: 'amount',
                initialValue: widget.reward?.amount?.toString() ?? '',
                decoration: const InputDecoration(labelText: 'Iznos'),
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Iznos je obavezan'),
                  FormBuilderValidators.integer(errorText: 'Unesite cijeli broj'),
                  FormBuilderValidators.min(0, errorText: 'Iznos ne može biti negativan'),
                ]),
              ),
              const SizedBox(height: 12),
              FormBuilderTextField(
                name: 'description',
                initialValue: widget.reward?.description ?? '',
                decoration: const InputDecoration(labelText: 'Opis (nije obavezno)'),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Otkaži"),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState?.saveAndValidate() ?? false) {
              final request = Map<String, dynamic>.from(_formKey.currentState!.value);
              request['competitionId'] = widget.competitionId;

              try {
                if (widget.reward == null) {
                  await rewardProvider.insert(request);
                } else {
                  await rewardProvider.update(widget.reward!.id!, request);
                }
              } on UserException catch (e) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Greška"),
                    content: Text(e.toString()),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))
                    ],
                  ),
                );
                return;
              }

              if (context.mounted) {
                showBottomRightNotification(
                  context,
                  widget.reward == null
                      ? 'Nagrada uspješno dodana.'
                      : 'Nagrada uspješno ažurirana.',
                );
                Navigator.pop(context, true);
              }
            }
          },
          child: const Text("Spremi"),
        ),
      ],
    );
  }
  Widget _buildPodiumBox(
    BuildContext context,
    int value,
    int? selected,
    ValueChanged<int> onSelected, {
    required double height,
  }) {
    final bool isSelected = selected == value;
    final Color baseColor = Colors.blue.shade400;

    return GestureDetector(
      onTap: () => onSelected(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 70,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? baseColor : baseColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.blue.shade900 : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(2, 3),
                    blurRadius: 6,
                  )
                ]
              : [],
        ),
        child: Text(
          value.toString(),
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.blue.shade900,
          ),
        ),
      ),
    );
  }
}
