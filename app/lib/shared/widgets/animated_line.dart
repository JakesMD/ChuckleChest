// Leaves options open for future use.
// ignore_for_file: unused_element_parameter

import 'package:ccore/ccore.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:flutter/material.dart';

/// {@template CAnimatedLine}
///
/// A widget that displays a line.
///
/// {@endtemplate}
class CAnimatedLine extends StatelessWidget {
  /// {@macro CAnimatedLine}
  const CAnimatedLine({
    required this.line,
    required this.occurredAt,
    required this.people,
    this.onPressed,
    this.onDeletePressed,
    this.isDeleteEnabled = false,
    this.onAnimationCompleted,
    this.isAnimated = true,
    super.key,
  });

  /// The line to display.
  final CLine line;

  /// The people in the conversation.
  final List<CPerson> people;

  /// The date the line occurred.
  final DateTime occurredAt;

  /// Called when the line is pressed.
  final void Function()? onPressed;

  /// Called when the delete button is pressed.
  final void Function()? onDeletePressed;

  /// Whether the delete button is enabled.
  final bool isDeleteEnabled;

  /// The callback when the animation is completed.
  final void Function()? onAnimationCompleted;

  /// Whether the animation is enabled.
  final bool isAnimated;

  @override
  Widget build(BuildContext context) {
    CPerson? person;

    if (line.isQuote) {
      person = people.cFirstWhereOrNull((p) => p.id == line.personID!);
    }

    return CFadeIn(
      isAnimated: isAnimated,
      child: ListTile(
        minVerticalPadding: 16,
        onTap: onPressed,
        titleAlignment: line.isQuote ? ListTileTitleAlignment.top : null,
        leading: line.isQuote
            ? CAvatar.fromPerson(person: person, date: occurredAt)
            : null,
        title: line.isQuote
            ? Text(
                CAppL10n.of(context).quoteItem_person(
                  person!.nickname,
                  person.ageAtDate(occurredAt),
                ),
                style: context.cTextTheme.labelMedium,
              )
            : _CAnimatedSizedLine(
                isAnimated: isAnimated,
                text: line.text,
                onCompleted: onAnimationCompleted,
                textStyle: context.cTextTheme.bodyLarge!,
              ),
        subtitle: line.isQuote
            ? _CAnimatedSizedLine(
                isAnimated: isAnimated,
                text: line.text,
                onCompleted: onAnimationCompleted,
                textStyle: Theme.of(context).textTheme.bodyLarge!,
              )
            : null,
        trailing: isDeleteEnabled
            ? IconButton(
                onPressed: onDeletePressed,
                icon: const Icon(Icons.close_rounded),
              )
            : null,
      ),
    );
  }
}

class _CAnimatedSizedLine extends StatelessWidget {
  const _CAnimatedSizedLine({
    required this.text,
    required this.textStyle,
    this.onCompleted,
    this.speed = const Duration(milliseconds: 30),
    this.delay = const Duration(milliseconds: 1500),
    this.sizeAnimationDuration = const Duration(milliseconds: 250),
    this.sizeAnimationCurve = Curves.easeOut,
    this.isAnimated = true,
  });

  final String text;

  final Duration delay;

  final Duration speed;

  final Duration sizeAnimationDuration;

  final Curve sizeAnimationCurve;

  final void Function()? onCompleted;

  final bool isAnimated;

  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      alignment: Alignment.topLeft,
      clipBehavior: Clip.none,
      duration: sizeAnimationDuration,
      curve: sizeAnimationCurve,
      child: LayoutBuilder(
        builder: (context, constraints) => SizedBox(
          width: constraints.maxWidth,
          child: CAnimatedTypingText(
            text: text,
            textStyle: textStyle,
            onCompleted: onCompleted,
            speed: speed,
            delay: delay,
            isAnimated: isAnimated,
          ),
        ),
      ),
    );
  }
}
