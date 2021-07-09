import 'dart:ui';

import 'package:blog/blog_detayi.dart';
import 'package:blog/model/blog.dart';
import 'package:blog/veri/bloglari_getir.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogListesi extends StatelessWidget {

  @override

  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.indigo,
           actions: [
             Container(
               height: 50,
               width: 50,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(20),
                 image: DecorationImage(image: AssetImage("assets/images/modelgrid2.jpeg"),fit: BoxFit.contain,),
               ), ),
           ],
         /*  [IconButton(
             icon: Icon(Icons.arrow_forward_ios),
            // tooltip: 'Open shopping cart',//
        onPressed: (){}
                    /*async =>
                         Navigator.of(context) .push(
                        MaterialPageRoute(builder: (context) {
                           var blogDetayi = BlogDetayi();
                          return blogDetayi;
                                      }))),  // *  /  */  )  ],*/

          title: Text("Blog Sayfam"),
        ),



        body: FutureBuilder<List<Blog>>(

          future: bloglariGetir(),
          builder: (context, blogListesiFuture) {

            if (blogListesiFuture.connectionState != ConnectionState.done)
              return Center(child: CircularProgressIndicator());

            if (blogListesiFuture.hasData == null)
              return Center(child: Text("Veri Yok"));

            List<Blog> blogListesi = blogListesiFuture.data;
             if (blogListesi.length==0)
               return Center(child: Text("Veri Yok"));
            return Column(
              children: [
                Container(

                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: Material(
                                  child: Container(
                                    height: 250,
                                    width: double.infinity,
                                    child: imageSlider(context,blogListesi), ) )) ]
                    )),

                Expanded(
                  child: ListView.builder(
                    itemCount: 100,
                    itemBuilder: (context, i) {
                      Blog blog = blogListesi[i];
                      return Card(
                        elevation: 3,
                        color: Colors.grey.shade200,
                        child: ListTile(
                          title: Text(
                            blog.title,
                            style: TextStyle(fontSize: 12),

                          ),
                          subtitle: Text(blog.url),
                          trailing: IconButton(
                              icon: Icon(Icons.open_in_new),
                              onPressed: () async =>
                                  Navigator.of(context)
                                      .push(
                                      MaterialPageRoute(builder: (context) {
                                        var blogDetayi = BlogDetayi(
                                            blogId: blog.id);
                                        return blogDetayi;
                                      }))),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },)
    );
  }

  Widget imageSlider(context,List<Blog>blogListesi)  {

    return ListView(

       scrollDirection:Axis.horizontal,
      children: List.generate(3, (i){

        return  Container(
          height: double.maxFinite,
          width:MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(image:AssetImage("assets/images/resim${i+2}.jpg"),fit: BoxFit.cover,),),


          /*Container(

          child:Center(
              height: MediaQuery.of(context).size.height / 2,
            child:Image(image:AssetImage("assets/images/resim${i+2}.jpg"),),
          ),*/

        );
      })
    );
  }

}
