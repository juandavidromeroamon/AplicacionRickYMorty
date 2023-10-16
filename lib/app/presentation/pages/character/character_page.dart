import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/search_result_item.dart';
import '../../bloc/character/character_bloc.dart';
import '../../bloc/character/character_event.dart';
import '../../bloc/character/character_state.dart';

import '../../widgets/searchs_bar.dart';

class CharacterPage extends StatefulWidget {
  @override
  _CharacterPageState createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  ScrollController _scrollController = ScrollController();
  double opacity = 1.0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSearch(String query) {
    BlocProvider.of<CharacterBloc>(context).add(SearchCharactersEvent(query));
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
              child: BlocConsumer<CharacterBloc, CharacterState>(
                listener: (context, state) {
                  if (state is CharactersError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is CharactersLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is CharactersLoaded) {
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: state.characters.length,
                      itemBuilder: (context, index) {
                        final character = state.characters[index];
                        return SearchResultItem(
                          result: character,
                          subtitle: character
                              .status, // Asumiendo que quieres mostrar el estado o alguna otra propiedad del personaje
                          avatarUrl: character
                              .image, // Aquí se pasa la imagen del personaje
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
