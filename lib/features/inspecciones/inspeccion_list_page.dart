import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

class InspeccionListPage extends StatefulWidget {
  const InspeccionListPage({super.key});

  @override
  State<InspeccionListPage> createState() => _InspeccionListPageState();
}

class _InspeccionListPageState extends State<InspeccionListPage> {
  late FloatingSearchBarController _searchBarController;

  @override
  void initState() {
    super.initState();
    _searchBarController = FloatingSearchBarController();
  }

  @override
  void dispose() {
    _searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Inspecciones',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.xmark),
          onPressed: () => context.go('/inspecciones'),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(12).copyWith(
              top: MediaQuery.viewPaddingOf(context).top + 24,
            ),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: RichText(
                            text: const TextSpan(
                              text: '10 Resultados',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    child: Row(
                      children: [
                        Container(
                          child: Text('Ordenar')
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          FloatingSearchBar(
            controller: _searchBarController,
            automaticallyImplyBackButton: false,
            hint: 'Búsqueda por No. Económico o Folio',
            clearQueryOnClose: false,
            scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
            transitionDuration: const Duration(milliseconds: 400),
            transitionCurve: Curves.easeInOut,
            accentColor: Theme.of(context).cardColor,
            physics: const BouncingScrollPhysics(),
            elevation: 2,
            debounceDelay: const Duration(milliseconds: 500),
            onQueryChanged: (query) {},
            onSubmitted: (query) async {},
            transition: CircularFloatingSearchBarTransition(),
            actions: [
              FloatingSearchBarAction(
                child: CircularButton(
                  icon:
                      const FaIcon(FontAwesomeIcons.magnifyingGlass, size: 16),
                  onPressed: () {
                    _searchBarController.open();
                  },
                ),
              ),
              FloatingSearchBarAction.icon(
                showIfClosed: false,
                showIfOpened: true,
                icon: const FaIcon(FontAwesomeIcons.xmark, size: 17.5),
                onTap: () {
                  _searchBarController.close();
                },
              ),
            ],
            builder: (context, transition) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Material(
                  elevation: 4,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: 25,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          _searchBarController.close();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: ListTile(
                            title: Text('Item $index'),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const Divider(thickness: 1, height: 0),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
