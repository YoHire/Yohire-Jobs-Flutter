import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:openbn/core/utils/constants/constants.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final Widget suffixIcon;
  final InputBorder? border;
  final int? maxLength;
  final int? maxLines;
  final Widget prefixIcon;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool isDatePicker;
  final bool isLocationPicker;
  final String? dateFormat;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.suffixIcon = const SizedBox(),
    this.prefixIcon = const SizedBox(),
    this.onChanged,
    this.border,
    this.maxLength,
    this.maxLines,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.isDatePicker = false,
    this.isLocationPicker = false,
    this.dateFormat,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  List<dynamic> _placesList = [];
  Timer? _debounce;
  bool _placeSelected = false;

  @override
  void initState() {
    super.initState();
    if (widget.isLocationPicker) {
      widget.controller.addListener(_onSearchChanged);
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    if (widget.isLocationPicker) {
      widget.controller.removeListener(_onSearchChanged);
    }
    super.dispose();
  }

  void _onSearchChanged() {
    if (_placeSelected) return;

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (widget.controller.text.isNotEmpty) {
        _getLocationResults(widget.controller.text);
      } else {
        setState(() {
          _placesList = [];
        });
      }
    });
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate:DateTime(2100),
    );

    if (picked != null) {
      final formatter = DateFormat(widget.dateFormat ?? 'yyyy-MM-dd');
      widget.controller.text = formatter.format(picked);
      widget.onChanged?.call(widget.controller.text);
    }
  }

  void _getLocationResults(String input) async {
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=${ApiKeys.places_api_key}';

    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      setState(() {
        _placesList = json.decode(response.body)['predictions'];
      });
    }
  }

  void _clearSelection() {
    widget.controller.clear();
    setState(() {
      _placesList = [];
      _placeSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          keyboardType: widget.keyboardType,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          
          controller: widget.controller,
          readOnly: widget.isDatePicker,
          style: textTheme.bodyMedium,
          decoration: InputDecoration(
            enabledBorder: widget.border ?? InputBorder.none,
            focusedBorder: widget.border ?? InputBorder.none,
            border: widget.border ?? InputBorder.none,
            label: Text(
              widget.hint,
              style: textTheme.labelMedium,
            ),
            suffixIcon:
                widget.controller.text.isNotEmpty && widget.isLocationPicker
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: _clearSelection,
                      )
                    : widget.suffixIcon,
            prefixIcon: widget.isDatePicker
                ? IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _showDatePicker(context),
                  )
                : widget.prefixIcon,
          ),
          onTap: widget.isDatePicker
              ? () => _showDatePicker(context)
              : widget.isLocationPicker
                  ? () {
                      if (_placeSelected) {
                        _clearSelection();
                      }
                    }
                  : null,
          onChanged: widget.onChanged,
          validator: widget.validator,
        ),
        if (_placesList.isNotEmpty &&
            widget.isLocationPicker &&
            !_placeSelected)
          SizedBox(
            height: 200,
            child: ListView.separated(
              itemCount: _placesList.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.location_on, color: Colors.red),
                  title: Text(_placesList[index]['description']),
                  onTap: () {
                    widget.controller.text = _placesList[index]['description'];
                    widget.controller.selection = TextSelection.fromPosition(
                      TextPosition(offset: widget.controller.text.length),
                    );
                    setState(() {
                      _placesList = [];
                      _placeSelected = true;
                    });
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
