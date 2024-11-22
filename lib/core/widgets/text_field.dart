import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:openbn/core/utils/constants/constants.dart';
import 'package:openbn/core/utils/snackbars/show_snackbar.dart';

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
  final bool isFilePicker;
  final String? dateFormat;
  final bool isDisabled;
  final bool isDebouncer; // Added new parameter
  final Duration debounceDuration; // Added debounce duration parameter

  const CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.suffixIcon = const SizedBox(),
    this.prefixIcon = const SizedBox(),
    this.onChanged,
    this.border,
    this.isDisabled = false,
    this.maxLength,
    this.maxLines,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.isDatePicker = false,
    this.isLocationPicker = false,
    this.isFilePicker = false,
    this.dateFormat,
    this.isDebouncer = false, // Default value
    this.debounceDuration =
        const Duration(milliseconds: 500), // Default duration
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  List<dynamic> _placesList = [];
  Timer? _debounce;
  Timer? _onChangedDebounce;
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
    _onChangedDebounce?.cancel();
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

  void _handleOnChanged(String value) {
    if (widget.onChanged == null) return;

    if (widget.isDebouncer) {
      if (_onChangedDebounce?.isActive ?? false) {
        _onChangedDebounce!.cancel();
      }
      _onChangedDebounce = Timer(widget.debounceDuration, () {
        widget.onChanged!(value);
      });
    } else {
      widget.onChanged!(value);
    }
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      final formatter = DateFormat(widget.dateFormat ?? 'yyyy-MM-dd');
      widget.controller.text = formatter.format(picked);
      _handleOnChanged(widget.controller.text);
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      int fileSize = await file.length();
      if (fileSize <= 750 * 1024) {
        widget.controller.text = file.path;
        _handleOnChanged(widget.controller.text);
      } else {
        showSimpleSnackBar(
            context: context,
            text: 'File size must be less than 750KB',
            position: SnackBarPosition.BOTTOM,
            isError: true);
      }
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

  void _fetchPlaceDetails(String placeId) async {
    String detailsURL =
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=${ApiKeys.places_api_key}';

    var response = await http.get(Uri.parse(detailsURL));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var result = data['result'];

      double latitude = result['geometry']['location']['lat'];
      double longitude = result['geometry']['location']['lng'];
      log("Latitude: $latitude, Longitude: $longitude");
    } else {
      log("Failed to fetch place details");
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
          enabled: !widget.isDisabled,
          readOnly:
              widget.isDisabled || widget.isDatePicker || widget.isFilePicker,
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
                  : widget.isFilePicker
                      ? _pickFile
                      : null,
          onChanged: _handleOnChanged,
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
                    _fetchPlaceDetails(_placesList[index]['place_id']);
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
