import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/common/common.dart';
import 'package:quran_app/common/widgets/spacing.dart';

/// A data type holding user feedback consisting of a feedback type, free from
/// feedback text, and a sentiment rating.
class CustomFeedback {
  CustomFeedback({
    this.feedbackType,
    this.feedbackText,
    this.rating,
  });

  FeedbackType? feedbackType;
  String? feedbackText;
  FeedbackRating? rating;

  @override
  String toString() {
    return {
      if (rating != null) 'rating': rating.toString(),
      'feedback_type': feedbackType.toString(),
      'feedback_text': feedbackText,
    }.toString();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (rating != null) 'rating': rating.toString(),
      'feedback_type': feedbackType.toString(),
      'feedback_text': feedbackText,
    };
  }
}

/// What type of feedback the user wants to provide.
enum FeedbackType {
  feedback,
  featureRequest,
}

/// A user-provided sentiment rating.
enum FeedbackRating {
  bad,
  neutral,
  good,
}

/// A form that prompts the user for the type of feedback they want to give,
/// free form text feedback, and a sentiment rating.
/// The submit button is disabled until the user provides the feedback type. All
/// other fields are optional.
class CustomFeedbackForm extends StatefulWidget {
  const CustomFeedbackForm({
    super.key,
    required this.onSubmit,
    required this.scrollController,
  });

  final OnSubmit onSubmit;
  final ScrollController? scrollController;

  @override
  State<CustomFeedbackForm> createState() => _CustomFeedbackFormState();
}

class _CustomFeedbackFormState extends State<CustomFeedbackForm> {
  final CustomFeedback _customFeedback = CustomFeedback();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              if (widget.scrollController != null) const FeedbackSheetDragHandle(),
              ListView(
                controller: widget.scrollController,
                // Pad the top by 20 to match the corner radius if drag enabled.
                padding: EdgeInsets.fromLTRB(
                  EemanSizes.s16,
                  widget.scrollController != null ? EemanSizes.s20 : EemanSizes.s16,
                  EemanSizes.s16,
                  0,
                ),
                children: [
                  const Text('Mau kasih feedback atau request fitur?'),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: EemanSizes.s8),
                        child: Text('*'),
                      ),
                      Flexible(
                        child: DropdownButton<FeedbackType>(
                          value: _customFeedback.feedbackType,
                          items: FeedbackType.values
                              .map(
                                (type) => DropdownMenuItem<FeedbackType>(
                                  value: type,
                                  child: Text(
                                    type == FeedbackType.feedback ? 'Feedback' : 'Request Fitur',
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (feedbackType) => setState(
                            () => _customFeedback.feedbackType = feedbackType,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const EemanSpacing.vertical16(),
                  const Text('Masukkan feedback kamu dibawah ya (Tarik keatas)'),
                  TextField(
                    onChanged: (newFeedback) => _customFeedback.feedbackText = newFeedback,
                  ),
                  const EemanSpacing.vertical16(),
                  const Text('Bagaimana pendapatmu tentang ini?'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: FeedbackRating.values.map(_ratingToIcon).toList(),
                  ),
                ],
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: _customFeedback.feedbackType != null
              ? () => widget.onSubmit(
                    _customFeedback.feedbackText ?? '',
                    extras: _customFeedback.toMap(),
                  )
              : null,
          child: const Text('KIRIM'),
        ),
        const EemanSpacing.vertical8(),
      ],
    );
  }

  Widget _ratingToIcon(FeedbackRating rating) {
    final isSelected = _customFeedback.rating == rating;
    late IconData icon;
    switch (rating) {
      case FeedbackRating.bad:
        icon = Icons.sentiment_dissatisfied;
        break;
      case FeedbackRating.neutral:
        icon = Icons.sentiment_neutral;
        break;
      case FeedbackRating.good:
        icon = Icons.sentiment_satisfied;
        break;
    }
    return IconButton(
      color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey,
      onPressed: () => setState(() => _customFeedback.rating = rating),
      icon: Icon(icon),
      iconSize: EemanSizes.s36,
    );
  }
}
