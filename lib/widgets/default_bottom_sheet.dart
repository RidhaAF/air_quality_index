import 'package:air_quality_index/cubits/city/city_cubit.dart';
import 'package:air_quality_index/cubits/country/country_cubit.dart';
import 'package:air_quality_index/cubits/state_province/state_province_cubit.dart';
import 'package:air_quality_index/models/city_model.dart';
import 'package:air_quality_index/models/country_model.dart';
import 'package:air_quality_index/models/state_model.dart';
import 'package:air_quality_index/utilities/constants.dart';
import 'package:air_quality_index/widgets/default_404.dart';
import 'package:air_quality_index/widgets/default_429.dart';
import 'package:air_quality_index/widgets/default_refresh_indicator.dart';
import 'package:air_quality_index/widgets/default_search_bar.dart';
import 'package:air_quality_index/widgets/default_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultBottomSheet extends StatefulWidget {
  final String? type;
  final Function? onTap;
  final Map? data;
  const DefaultBottomSheet({
    super.key,
    this.type,
    this.onTap,
    this.data,
  });

  @override
  State<DefaultBottomSheet> createState() => _DefaultBottomSheetState();
}

class _DefaultBottomSheetState extends State<DefaultBottomSheet> {
  final TextEditingController _searchCtrl = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  List _listDataSearched = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    if (context.mounted) {
      getData();
      setState(() {});
    }
  }

  getData() {
    switch (widget.type) {
      case 'country':
        context.read<CountryCubit>().getCountries();
        break;
      case 'state':
        context.read<StateProvinceCubit>().getStates(
              country: widget.data?['country'] ?? '',
            );
        break;
      case 'city':
        context.read<CityCubit>().getCities(
              country: widget.data?['country'] ?? '',
              state: widget.data?['state'] ?? '',
            );
        break;
      default:
    }
  }

  String _getTitle() {
    switch (widget.type) {
      case 'country':
        return 'Country';
      case 'state':
        return 'State';
      case 'city':
        return 'City';
      default:
        return '';
    }
  }

  void _searchData(String query) {
    setState(() {
      String queryLC = query.toLowerCase();

      switch (widget.type) {
        case 'country':
          List<Country>? data = context.read<CountryCubit>().getCountriesData();
          _listDataSearched = data!.where((e) {
            if (e.name!.toLowerCase().contains(queryLC)) {
              return true;
            }
            return false;
          }).toList();
          break;
        case 'state':
          List<StateData>? data =
              context.read<StateProvinceCubit>().getStatesData();
          _listDataSearched = data!.where((e) {
            if (e.name!.toLowerCase().contains(queryLC)) {
              return true;
            }
            return false;
          }).toList();
          break;
        case 'city':
          List<City>? data = context.read<CityCubit>().getCitiesData();
          _listDataSearched = data!.where((e) {
            if (e.name!.toLowerCase().contains(queryLC)) {
              return true;
            }
            return false;
          }).toList();
          break;
        default:
      }
    });
  }

  void _clearSearch() {
    setState(() {
      _searchCtrl.clear();
      _listDataSearched = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultRefreshIndicator(
      onRefresh: () => _onRefresh(),
      edgeOffset: 120,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title(),
          searchBar(),
          Expanded(
            child: bottomSheetContent(),
          ),
        ],
      ),
    );
  }

  Widget title() {
    return Container(
      padding:
          EdgeInsets.fromLTRB(defaultMargin, defaultMargin, defaultMargin, 0),
      child: Text(
        'Select ${_getTitle()}',
        style: GoogleFonts.dmSans(
          color: primaryColor,
          fontSize: 24,
          fontWeight: bold,
        ),
        textScaleFactor: 1.0,
      ),
    );
  }

  Widget searchBar() {
    return Container(
      padding: EdgeInsets.all(defaultMargin),
      child: DefaultSearchBar(
        controller: _searchCtrl,
        focusNode: _searchFocus,
        hintText: 'Search...',
        onChanged: (value) => _searchData(_searchCtrl.text),
        onPressed: _clearSearch,
      ),
    );
  }

  Widget bottomSheetContent({data}) {
    switch (widget.type) {
      case 'country':
        return BlocBuilder<CountryCubit, CountryState>(
          builder: (context, state) {
            if (state is CountryInitial) {
              return Container();
            } else if (state is CountryLoading) {
              return listTileShimmer();
            } else if (state is CountryLoaded) {
              List countries;
              countries = _searchCtrl.text.isNotEmpty
                  ? _listDataSearched
                  : state.countries.data ?? [];

              if (countries.isEmpty) {
                return const Default404();
              }
              return ListView.separated(
                itemCount: countries.length,
                separatorBuilder: (context, i) => const Divider(height: 0),
                itemBuilder: (context, i) {
                  Country? country = countries[i];

                  return ListTile(
                    title: Text(
                      country?.name ?? '',
                      textScaleFactor: 1.0,
                    ),
                    onTap: () {
                      if (widget.onTap != null) {
                        widget.onTap!();
                      } else {
                        context.pop(country);
                      }
                    },
                  );
                },
              );
            } else if (state is CountryError) {
              String err = state.message;

              if (err.contains('429')) {
                return const Default429();
              }
              return const Default404();
            }
            return const Default404();
          },
        );
      case 'state':
        return BlocBuilder<StateProvinceCubit, StateProvinceState>(
          builder: (context, state) {
            if (state is StateProvinceInitial) {
              return Container();
            } else if (state is StateProvinceLoading) {
              return listTileShimmer();
            } else if (state is StateProvinceLoaded) {
              List states;
              states = _searchCtrl.text.isNotEmpty
                  ? _listDataSearched
                  : state.states.data ?? [];

              if (states.isEmpty) {
                return const Default404();
              }
              return ListView.separated(
                itemCount: states.length,
                separatorBuilder: (context, i) => const Divider(height: 0),
                itemBuilder: (context, i) {
                  StateData? stateData = states[i];

                  return ListTile(
                    title: Text(
                      stateData?.name ?? '',
                      textScaleFactor: 1.0,
                    ),
                    onTap: () {
                      if (widget.onTap != null) {
                        widget.onTap!();
                      } else {
                        context.pop(stateData);
                      }
                    },
                  );
                },
              );
            } else if (state is StateProvinceError) {
              String err = state.message;

              if (err.contains('429')) {
                return const Default429();
              }
              return const Default404();
            }
            return const Default404();
          },
        );
      case 'city':
        return BlocBuilder<CityCubit, CityState>(
          builder: (context, state) {
            if (state is CityInitial) {
              return Container();
            } else if (state is CityLoading) {
              return listTileShimmer();
            } else if (state is CityLoaded) {
              List cities;
              cities = _searchCtrl.text.isNotEmpty
                  ? _listDataSearched
                  : state.cities.data ?? [];

              if (cities.isEmpty) {
                return const Default404();
              }
              return ListView.separated(
                itemCount: cities.length,
                separatorBuilder: (context, i) => const Divider(height: 0),
                itemBuilder: (context, i) {
                  City? city = cities[i];

                  return ListTile(
                    title: Text(
                      city?.name ?? '',
                      textScaleFactor: 1.0,
                    ),
                    onTap: () {
                      if (widget.onTap != null) {
                        widget.onTap!();
                      } else {
                        context.pop(city);
                      }
                    },
                  );
                },
              );
            } else if (state is CityError) {
              String err = state.message;

              if (err.contains('429')) {
                return const Default429();
              }
              return const Default404();
            }
            return const Default404();
          },
        );
      default:
        return const Default404();
    }
  }
}

Future showDefaultBottomSheet({
  required BuildContext context,
  required String type,
  Function? onTap,
  Map? data,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.65,
        child: DefaultBottomSheet(
          type: type,
          onTap: onTap,
          data: data,
        ),
      );
    },
    isScrollControlled: true,
    showDragHandle: true,
  );
}
