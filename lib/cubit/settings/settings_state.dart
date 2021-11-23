import 'package:flutter/material.dart';

class GeneralSettingsStates {
  final bool isDateTimeModification;
  final bool isBubbleAlignment;
  final bool isCenterDateBubble;
  final int textSize;
  final String? imagePath;

  final Orientation orientation;

  const GeneralSettingsStates({
    this.orientation = Orientation.portrait,
    this.imagePath,
    this.textSize = 15,
    this.isDateTimeModification = false,
    this.isBubbleAlignment = false,
    this.isCenterDateBubble = false,
  });

  GeneralSettingsStates copyWith({
    Orientation? orientation,
    String? imagePath,
    int? textSize,
    bool? isDateTimeModification,
    bool? isBubbleAlignment,
    bool? isCenterDateBubble,
  }) {
    return GeneralSettingsStates(
      orientation: orientation ?? this.orientation,
      imagePath: imagePath ?? this.imagePath,
      textSize: textSize ?? this.textSize,
      isDateTimeModification: isDateTimeModification ?? this.isDateTimeModification,
      isBubbleAlignment: isBubbleAlignment ?? this.isBubbleAlignment,
      isCenterDateBubble: isCenterDateBubble ?? this.isCenterDateBubble,
    );
  }
}