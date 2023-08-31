import 'package:air_quality_index/models/city_model.dart';
import 'package:air_quality_index/models/country_model.dart';
import 'package:air_quality_index/models/state_model.dart';
import 'package:air_quality_index/utilities/constants.dart';
import 'package:air_quality_index/widgets/default_app_bar.dart';
import 'package:air_quality_index/widgets/default_bottom_sheet.dart';
import 'package:air_quality_index/widgets/default_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final box = GetStorage();
  final TextEditingController _countryCtrl = TextEditingController();
  final FocusNode _countryFocus = FocusNode();
  final TextEditingController _stateCtrl = TextEditingController();
  final FocusNode _stateFocus = FocusNode();
  final TextEditingController _cityCtrl = TextEditingController();
  final FocusNode _cityFocus = FocusNode();
  Country? country;
  StateData? state;
  City? city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Search',
      ),
      body: ListView(
        children: [
          SizedBox(height: defaultMargin),
          countryTextField(),
          SizedBox(height: defaultMargin),
          stateTextField(),
          SizedBox(height: defaultMargin),
          cityTextField(),
          SizedBox(height: defaultMargin),
        ],
      ),
    );
  }

  Widget countryTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: DefaultTextField(
        controller: _countryCtrl,
        focusNode: _countryFocus,
        labelText: 'Country',
        hintText: 'Select country...',
        textInputAction: TextInputAction.next,
        suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
        readOnly: true,
        onTap: () => _showBottomSheet(type: 'country'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select country...';
          }
          return null;
        },
      ),
    );
  }

  Widget stateTextField() {
    if (_countryCtrl.text.isEmpty) {
      return Container();
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: DefaultTextField(
        controller: _stateCtrl,
        focusNode: _stateFocus,
        labelText: 'State',
        hintText: 'Select state...',
        textInputAction: TextInputAction.next,
        suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
        readOnly: true,
        onTap: () => _showBottomSheet(
          type: 'state',
          data: {
            'country': _countryCtrl.text,
          },
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select state...';
          }
          return null;
        },
      ),
    );
  }

  Widget cityTextField() {
    if (_stateCtrl.text.isEmpty) {
      return Container();
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: DefaultTextField(
        controller: _cityCtrl,
        focusNode: _cityFocus,
        labelText: 'City',
        hintText: 'Select city...',
        textInputAction: TextInputAction.next,
        suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
        readOnly: true,
        onTap: () => _showBottomSheet(
          type: 'city',
          data: {
            'country': _countryCtrl.text,
            'state': _stateCtrl.text,
          },
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select city...';
          }
          return null;
        },
      ),
    );
  }

  _showBottomSheet({required String type, Function? onTap, Map? data}) {
    showDefaultBottomSheet(
      context: context,
      type: type,
      onTap: onTap,
      data: data,
    ).then((value) {
      if (value != null) {
        setState(() {
          if (type == 'country') {
            country = value;
            _countryCtrl.text = country?.name ?? '';
            _stateCtrl.clear();
            _cityCtrl.clear();
          } else if (type == 'state') {
            state = value;
            _stateCtrl.text = state?.name ?? '';
            _cityCtrl.clear();
          } else if (type == 'city') {
            city = value;
            _cityCtrl.text = city?.name ?? '';
            box.write('locationType', 'specified');
            box.write('country', _countryCtrl.text);
            box.write('state', _stateCtrl.text);
            box.write('city', _cityCtrl.text);
            context.pop(value);
          }
        });
      }
    });
  }
}
