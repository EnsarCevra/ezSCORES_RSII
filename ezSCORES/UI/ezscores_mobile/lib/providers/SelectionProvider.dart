import 'package:ezscores_mobile/models/selections.dart';
import 'package:ezscores_mobile/providers/base_provider.dart';

class SelectionProvider extends BaseProvider<Selections>
{
  SelectionProvider(): super("Selections");

  @override
  Selections fromJson(data) {
    // TODO: implement fromJson
    return Selections.fromJson(data);
  }
}