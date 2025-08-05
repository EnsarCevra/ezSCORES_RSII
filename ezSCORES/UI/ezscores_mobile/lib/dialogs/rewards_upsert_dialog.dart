import 'package:ezscores_mobile/models/rewards.dart';
import 'package:ezscores_mobile/providers/RewardsProvider.dart';
import 'package:ezscores_mobile/providers/base_provider.dart';
import 'package:ezscores_mobile/providers/utils.dart';
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
              FormBuilderTextField(
                name: 'name',
                initialValue: widget.reward?.name ?? '',
                decoration: const InputDecoration(labelText: 'Naziv'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Naziv je obavezan'),
                  FormBuilderValidators.minLength(2, errorText: 'Naziv mora imati barem 2 znaka'),
                ]),
              ),
              const SizedBox(height: 12),
              FormBuilderTextField(
                name: 'rankingPosition',
                initialValue: widget.reward?.rankingPosition?.toString() ?? '',
                decoration: const InputDecoration(labelText: 'Pozicija na ljestvici'),
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Pozicija je obavezna'),
                  FormBuilderValidators.integer(errorText: 'Unesite cijeli broj'),
                  FormBuilderValidators.min(1, errorText: 'Pozicija mora biti veća od 0'),
                ]),
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
                decoration: const InputDecoration(labelText: 'Opis'),
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
}
