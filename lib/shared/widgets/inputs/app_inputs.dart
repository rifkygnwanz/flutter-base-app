import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../icons/app_icon.dart';
import '../text/app_text.dart';

/// A production-ready text input field styled according to Apple HIG.
class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final AutovalidateMode autovalidateMode;

  const AppTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.inputFormatters,
    this.focusNode,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final typography = AppTypography.of(context);

    return FormField<String>(
      initialValue: controller?.text ?? '',
      validator: validator,
      autovalidateMode: autovalidateMode,
      builder: (FormFieldState<String> fieldState) {
        final hasError = fieldState.hasError || errorText != null;
        final errorMsg = errorText ?? fieldState.errorText;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (labelText != null) ...[
              AppText.subheadline(
                labelText!,
                fontWeight: FontWeight.w600,
                color: colors.textPrimary,
              ),
              AppSpacing.gapSm,
            ],
            Container(
              decoration: BoxDecoration(
                color: enabled
                    ? colors.surface
                    : colors.border.withValues(alpha: 0.2),
                borderRadius: AppRadius.borderMd,
                border: Border.all(
                  color: hasError
                      ? colors.error
                      : (focusNode?.hasFocus ?? false
                            ? colors.primary
                            : colors.border),
                  width: 0.5,
                ),
              ),
              child: CupertinoTextField(
                controller: controller,
                obscureText: obscureText,
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                onChanged: (value) {
                  fieldState.didChange(value);
                  if (onChanged != null) onChanged!(value);
                },
                enabled: enabled,
                inputFormatters: inputFormatters,
                focusNode: focusNode,
                style: typography.body.copyWith(color: colors.textPrimary),
                placeholder: hintText,
                placeholderStyle: typography.body.copyWith(
                  color: colors.textSecondary.withValues(alpha: 0.6),
                ),
                prefix: prefixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.only(left: AppSpacing.md),
                        child: prefixIcon,
                      )
                    : null,
                suffix: suffixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.only(right: AppSpacing.md),
                        child: suffixIcon,
                      )
                    : null,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.mdSm,
                ),
                decoration: const BoxDecoration(
                  color: Color(0x00000000), // Transparent
                ),
              ),
            ),
            if (hasError && errorMsg != null) ...[
              AppSpacing.gapXs,
              Padding(
                padding: const EdgeInsets.only(left: AppSpacing.xs),
                child: AppText.caption(errorMsg, color: colors.error),
              ),
            ] else if (helperText != null) ...[
              AppSpacing.gapXs,
              Padding(
                padding: const EdgeInsets.only(left: AppSpacing.xs),
                child: AppText.caption(
                  helperText!,
                  color: colors.textSecondary,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

/// A specialized password input component with built-in visibility toggle.
class AppPasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;

  const AppPasswordField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText = 'Enter password',
    this.helperText,
    this.errorText,
    this.validator,
    this.textInputAction,
    this.focusNode,
  });

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return AppTextField(
      controller: widget.controller,
      labelText: widget.labelText,
      hintText: widget.hintText,
      helperText: widget.helperText,
      errorText: widget.errorText,
      obscureText: _obscureText,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      keyboardType: TextInputType.visiblePassword,
      prefixIcon: AppIcon(
        CupertinoIcons.lock,
        color: colors.textSecondary,
        size: 20,
      ),
      suffixIcon: GestureDetector(
        onTap: () => setState(() => _obscureText = !_obscureText),
        child: AppIcon(
          _obscureText ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
          color: colors.textSecondary,
          size: 20,
        ),
      ),
    );
  }
}

/// An iOS styled search text field with circular corners and built-in search/clear icons.
class AppSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final FocusNode? focusNode;

  const AppSearchField({
    super.key,
    this.controller,
    this.hintText = 'Search',
    this.onChanged,
    this.onClear,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final typography = AppTypography.of(context);

    return CupertinoSearchTextField(
      controller: controller,
      onChanged: onChanged,
      onSuffixTap: () {
        if (controller != null) {
          controller!.clear();
        }
        if (onClear != null) onClear!();
        if (onChanged != null) onChanged!('');
      },
      focusNode: focusNode,
      style: typography.body.copyWith(color: colors.textPrimary),
      placeholder: hintText,
      placeholderStyle: typography.body.copyWith(color: colors.textSecondary),
      backgroundColor: colors.border.withValues(
        alpha: 0.3,
      ), // HIG iOS search bar tint
      borderRadius: AppRadius.borderCircular,
      itemColor: colors.textSecondary,
    );
  }
}
