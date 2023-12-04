// ignore_for_file: non_constant_identifier_names

import 'package:cmp/Notes/db/notes_database.dart';
import 'package:cmp/Notes/edit_note_page.dart';
import 'package:cmp/Notes/model/note.dart';
import 'package:cmp/Notes/note_detail_page.dart';
import 'package:cmp/Notes/widget/note_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController? _textEditingController = TextEditingController();
  List countries = [];
  List filteredCountries = [];
  bool isSearching = false;
  late List<Note> searchnotes;
  late List<Note> notes;
  bool isLoading = false;
  late String Keyword;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // return Future.value(false);
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Alert"),
                content: const Text("Do you Want to Exit"),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("Yes"),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("No"),
                  ),
                ],
              );
            });
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(value);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: AnimatedCrossFade(
            duration: const Duration(milliseconds: 500),
            crossFadeState: isSearching ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            firstChild: const Text('Notes'),
            secondChild: TextField(
              autofocus: true,
              onChanged: (value) {
                setState(() {
                  notes = notes.where((note) => note.title.contains(value)).toList();
                });
              },
              controller: _textEditingController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                border: InputBorder.none,
                hintText: "Title and description",
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
          actions: <Widget>[
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              child: isSearching
                  ? IconButton(
                      key: const Key('clear_icon'),
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          isSearching = false;
                          // filteredCountries = countries;
                        });
                      },
                    )
                  : IconButton(
                      key: const Key('search_icon'),
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          isSearching = true;
                        });
                      },
                    ),
            ),
          ],
        ),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : notes.isEmpty
                  ? const Text(
                      'No Notes',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : buildNotes(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.add,
            color: CupertinoColors.darkBackgroundGray,
            size: 33,
          ),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddEditNotePage()),
            );

            refreshNotes();
          },
        ),
      ),
    );
  }

  Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailPage(noteId: note.id!),
              ));

              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      );
}
