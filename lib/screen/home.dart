import 'package:flutter/material.dart';
import 'package:youtube_app/api_youtube.dart';
import 'package:youtube_app/models/video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class HomeScreen extends StatefulWidget {
  //const HomeScreen({Key? key}) : super(key: key);

  String pesquisa;
  HomeScreen(this.pesquisa);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _listarVideo(String pesquisa) {
    Api api = Api();
    return api.pequisar(pesquisa);
  }

  @override
  void initState() {
    super.initState();
    print("chamado 1 - initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("chamado 2 - didChangeDependencies");
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("chamado 2 - didUpdateWidget");
  }

  @override
  Widget build(BuildContext context) {
    print("chamado 3 - build");
    return FutureBuilder<List<Video>>(
        future: _listarVideo(widget.pesquisa),
        builder: (context, snapshot) {
          var retorno;
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              retorno = const Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasData) {
                retorno = ListView.separated(
                  itemBuilder: (context, index) {
                    List<Video>? videos = snapshot.data;
                    Video video = videos![index];

                    return GestureDetector(
                        onTap: () {
                          print(CHAVE_YOUTUBE_API);
                          FlutterYoutube.playYoutubeVideoById(
                            apiKey: CHAVE_YOUTUBE_API,
                            videoId: video.id,
                            autoPlay: true,
                            fullScreen: true,
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(video.imagem),
                              )),
                            ),
                            ListTile(
                              title: Text(video.titulo),
                              subtitle: Text(video.canal),
                            )
                          ],
                        ));
                    // return Column(
                    //   children: [
                    //     Container(
                    //       height: 200,
                    //       decoration: BoxDecoration(
                    //           image: DecorationImage(
                    //         fit: BoxFit.cover,
                    //         image: NetworkImage(video.imagem),
                    //       )),
                    //     ),
                    //     ListTile(
                    //       title: Text(video.titulo),
                    //       subtitle: Text(video.canal),
                    //     )
                    //   ],
                    // );
                  },
                  separatorBuilder: (context, index) => const Divider(
                    height: 2,
                    color: Colors.grey,
                  ),
                  itemCount: snapshot.data!.length,
                );
              } else {
                return const Center(
                  child: Text("Nenhum dado a ser exibido"),
                );
              }
              break;

            default:
          }
          return retorno;
        });
  }

  @override
  void dispose() {
    super.dispose();
    print("chamado 4 - dispose");
  }
}
