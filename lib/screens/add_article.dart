import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:miniblog/blocs/add_article_bloc/article_bloc.dart';
import 'package:miniblog/blocs/add_article_bloc/article_event.dart';
import 'package:miniblog/blocs/add_article_bloc/article_state.dart';
import 'package:miniblog/blocs/article_bloc/article_bloc.dart';
import 'package:miniblog/blocs/article_bloc/article_event.dart';

class AddArticlePage extends StatefulWidget {
  const AddArticlePage({Key? key}) : super(key: key);

  @override
  _AddArticlePageState createState() => _AddArticlePageState();
}

class _AddArticlePageState extends State<AddArticlePage> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker imagePicker = ImagePicker();
  XFile? selectedImage;
  String title = "";
  String content = "";
  String author = "";

  pickImage() async {
    XFile? selectedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = selectedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddArticleBloc, AddArticleState>(
      listener: (context, state) {
        if (state is AddArticlePop) {
          Navigator.pop(context);
          context.read<ArticleBloc>().add(FetchArticles());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Yeni blog ekle"),
          leading: InkWell(
            child: Icon(Icons.arrow_back),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  if (selectedImage != null)
                    Image.file(File(selectedImage!.path)),
                  ElevatedButton(
                      onPressed: () {
                        pickImage();
                      },
                      child: Text("Fotoğraf seç")),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Lütfen bir blog başlığı giriniz";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      title = newValue!;
                    },
                    decoration:
                        const InputDecoration(label: Text("Blog başlığı")),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Lütfen bir blog içeriği giriniz";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      content = newValue!;
                    },
                    maxLines: 5,
                    decoration:
                        const InputDecoration(label: Text("Blog İçeriği")),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Lütfen bir ad soyad giriniz";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      author = newValue!;
                    },
                    decoration: const InputDecoration(label: Text("Ad Soyad")),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // forumun valid olduğu durum
                          _formKey.currentState!.save();
                          context.read<AddArticleBloc>().add(AddArticle(
                              selectedImage, title, content, author));
                        }
                      },
                      child: const Text("Blog Ekle"))
                ],
              )),
        ),
      ),
    );
  }
}
