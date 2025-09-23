import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ui_providers.g.dart';

@riverpod
class FormModificationNotifier extends _$FormModificationNotifier {
  @override
  bool build() => false;

  void setModified(bool isModified) {
    state = isModified;
  }

  void reset() {
    state = false;
  }
}
