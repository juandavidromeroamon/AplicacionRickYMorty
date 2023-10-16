import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/search_result_item.dart';
import '../../bloc/location/location_bloc.dart';
import '../../bloc/location/location_event.dart';
import '../../bloc/location/location_state.dart';

import '../../widgets/searchs_bar.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  ScrollController _scrollController = ScrollController();
  double opacity = 1.0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSearch(String query) {
    BlocProvider.of<LocationBloc>(context).add(SearchLocationsEvent(query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2E8B57),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: SearchsBar(
              onChanged: _handleSearch,
              onCategorySelected: (category) {},
              selectedCategories: [],
            ),
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification is ScrollUpdateNotification &&
                    _scrollController.hasClients) {
                  final itemHeight = 150.0;
                  final delta = _scrollController.offset % itemHeight;
                  setState(() {
                    opacity = (1 - delta / itemHeight).clamp(0.0, 1.0);
                  });
                }
                return true;
              },
              child: BlocConsumer<LocationBloc, LocationState>(
                listener: (context, state) {
                  if (state is LocationsError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LocationsLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is LocationsLoaded) {
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: state.locations.length,
                      itemBuilder: (context, index) {
                        final location = state.locations[index];
                        return SearchResultItem(
                          result: location,
                          subtitle: location.type,
                          avatarUrl: 'url_to_location_avatar',
                          opacity: index ==
                                  (_scrollController.offset / 150.0).floor()
                              ? opacity
                              : 1.0,
                        );
                      },
                    );
                  } else {
                    return Offstage();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
