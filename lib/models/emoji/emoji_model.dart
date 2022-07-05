import 'package:freezed_annotation/freezed_annotation.dart';

part 'emoji_model.freezed.dart';
part 'emoji_model.g.dart';

@freezed
class EmojiModel with _$EmojiModel {
  const EmojiModel._();

  const factory EmojiModel(
    int id,
    String emoji,
  ) = _EmojiModel;

  factory EmojiModel.fromJson(Map<String, dynamic> json) =>
      _$EmojiModelFromJson(json);
}
