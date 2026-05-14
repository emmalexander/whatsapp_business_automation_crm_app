import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp_business_automation_crm_app/theme.dart';

class PhoneNumberField extends StatelessWidget {
  final Country selectedCountry;
  final TextEditingController controller;
  final VoidCallback onPickCountry;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;

  const PhoneNumberField({
    super.key,
    required this.selectedCountry,
    required this.controller,
    required this.onPickCountry,
    this.validator,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Country selector button ─────────────────────────────────────
        _CountryDialButton(country: selectedCountry, onTap: onPickCountry),
        const SizedBox(width: 10),

        // ── Number input ────────────────────────────────────────────────
        Expanded(
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.phone,
            style: Theme.of(context).textTheme.bodyLarge,
            validator: validator,
            textInputAction: textInputAction,
            maxLength: 15,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\d\s]')),
            ],
            decoration: InputDecoration(
              hintText: 'e.g. 8012345678',
              counterText: "",
              hintStyle: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppTheme.textLightGrey),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              filled: true,
              fillColor: AppTheme.background,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppTheme.primaryGreen,
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.redAccent),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.redAccent),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CountryDialButton extends StatelessWidget {
  final Country country;
  final VoidCallback onTap;

  const _CountryDialButton({required this.country, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Emoji flag
            Text(country.flagEmoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 6),
            Text(
              '+${country.phoneCode}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: AppTheme.textGrey,
            ),
          ],
        ),
      ),
    );
  }
}
