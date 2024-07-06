import 'dart:convert';

import 'package:eos_mobile/features/inspecciones/presentation/pages/configuracion/inspeccion_tipo/inspeccion_tipo_page.dart';

import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:http/http.dart' as http;

class InspeccionIndexPage extends StatefulWidget {
  const InspeccionIndexPage({Key? key}) : super(key: key);

  @override
  State<InspeccionIndexPage> createState() => _InspeccionIndexPageState();
}

class _InspeccionIndexPageState extends State<InspeccionIndexPage> {
  // CONTROLLERS
  late TextEditingController _searchTextController;
  final ScrollController _scrollController = ScrollController();

  // LIST
  List<String> items = [];
  bool hasMore = true;
  bool isLoading = false;
  int page = 1;

  // STATE
  @override
  void initState() {
    super.initState();
    fetch();

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent == _scrollController.offset) {
        fetch();
      }
    });

    _searchTextController = TextEditingController();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // EVENTS
  void _handleSelectMenuItem(int item) {
    switch (item) {
      case 0:
        Navigator.push<void>(
          context,
          MaterialPageRoute(builder: (context) => const InspeccionConfiguracionInspeccionTipoPage()),
        );
    }
  }

  void _handleSearchSubmitted(String query) {
    _searchTextController.text = query;
  }

  // METHODS
  Future<void> fetch() async {
    if (isLoading) return;
    isLoading = true;

    const limit = 25;

    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=$limit&_page=$page');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> newItems = json.decode(response.body) as List<dynamic>;
      setState(() {
        page++;
        isLoading = false;

        if (newItems.length < limit) {
          hasMore = false;
        }

        items.addAll(newItems.map<String>((item) {
          final number = item['id'];
          return 'Item $number';
        }).toList());
      });
    }
  }

  Future<void> onRefresh() async {
    setState(() {
      isLoading = false;
      hasMore = true;
      page = 0;
      items.clear();
    });

    await fetch();
  }

  // METHODS

  @override
  Widget build(BuildContext context) {
    final Widget content = GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color   : Theme.of(context).colorScheme.background,
            padding : EdgeInsets.fromLTRB($styles.insets.sm, $styles.insets.sm, $styles.insets.sm, 0),
            child   : SearchInputFormField(
              controller              : _searchTextController,
              onSubmit                : _handleSearchSubmitted,
              onSearchFiltersPressed  : (){},
            ),
          ),

          Container(
            color   : Theme.of(context).colorScheme.background,
            padding : EdgeInsets.all($styles.insets.xs * 1.5),
            child   : _buildStatusBar(context),
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: items.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index < items.length) {
                    final item = items[index];

                    return ListTile(title: Text(item));
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Center(
                        child: hasMore ? const AppLoadingIndicator() : const Text('No hay más datos para cargar'),
                      ),
                    );
                  }
                },
              ),
            ),
          ),

          // Expanded(
          //   child: items.isEmpty
          //       ? const Center(child: AppLoadingIndicator())
          //       : RefreshIndicator(
          //         onRefresh: onRefresh,
          //         child: ListView.builder(
          //           itemCount: items.length,
          //           itemBuilder: (BuildContext context, int index) {
          //             final item = items[index];

          //             return ListTile(title: Text(item));
          //           },
          //         ),
          //       ),
          // ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title   : Text(AppStrings.inspeccionIndexAppBarTitle, style: $styles.textStyles.h3),
        actions : <Widget>[
          PopupMenuButton<int>(
            onSelected  : (int item) => _handleSelectMenuItem(item),
            itemBuilder : (BuildContext context) => <PopupMenuEntry<int>>[
              const PopupMenuItem<int>(value: 0, child: Text('Configuración de inspecciones')),
            ],
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(child: ColoredBox(color: Theme.of(context).colorScheme.background.withOpacity(0.4), child: content)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Nueva inspección',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatusBar(BuildContext context) {
    final TextStyle statusStyle = $styles.textStyles.body.copyWith(color: Theme.of(context).colorScheme.onBackground);
    return MergeSemantics(
      child: StaticTextScale(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('0 de 0 resultados', style: statusStyle),
          ],
        ),
      ),
    );
  }
}
