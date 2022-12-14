import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    getData();
  }

  Map<String,dynamic>? data;

  int total = 0;
  
  getData() async{
    try{

      var body = json.encode({"month": 11});
      
      final response = await http.post(Uri.parse("http://canteen.benzyinfotech.com/api/v3/customer/report"),
      headers: {
        "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMjI2Zjc5NTNkOWU4Mjk1YTJiMmE3MjIyNTM2ZTlmYjgxM2YwNGJmNGEzNWUwNDNmNDMwMjBhOWFmNjU1MWQzNjU3Y2YwNzliZTcyMGQwNWUiLCJpYXQiOjE2NzA5MTY2NzkuNTg4NDE4MDA2ODk2OTcyNjU2MjUsIm5iZiI6MTY3MDkxNjY3OS41ODg0MjM5NjczNjE0NTAxOTUzMTI1LCJleHAiOjE3MDI0NTI2NzkuNTI1NTYyMDQ3OTU4Mzc0MDIzNDM3NSwic3ViIjoiMTEwIiwic2NvcGVzIjpbXX0.rs5Tk61lQN_YEt3E2XxlbdKQqpuG3RAN7LcFH5WCgaEJKXOOGZ70NP7y01mDZNsrFbksz708xMeBKZXK9rkPnuOJPztc85y3mrEbWM4yBw25JzGeuOeFK-0rT2NCFXaS1XHkT8iYfnpNS6eDQjfPuRLgeTntnSwzGnVj0U0r1abHKHPhSxd1j9sQ_H3yvmj3leLsEtiOV1AK_wv1JN7mQFABrZZqmf8X2HjQz7ZwUs8V0jDhFhlsOE5W7NLmiliX-crm1NPM47dt2pik1i8HWs1i70Vf34wP0fEsaD0A2RBpF8qfgMjLxODMW0AOQ1QkZB5N3evaSJKBK2MzWGDnOLZgqwQlr0DQEeUik0eqASLcLG3XQjtqwg2IApCuQiQjLYl12iPoNfYeaFpucsof2AYoeZwG_iUDGaxm960xDTxTil6pht4gi1wGzensQ9xYGfiqTo8oCD2Lh_IijbYf5XlTum7wmUA65CQhWYc7LG9QEhDas2s0QIuPnTKSnLATlNF87lJyal_K-39VS6fbadvoqCEq9PEjMzinwMgF7yQJijl05E6HsUuwOO21jGnOqg5Xlfzdk-mRga1hi7QJo_TgO22jWL9jRJVIjaLxrCQPgJm3n3u7CiWZ9OWh3Eb1d6RGIWsQ7FAj8yECujiiP2jg_5bP3vEIHf2JsP7tIS8",
        "Content-Type": "application/json",
      },
      body: body);

      setState(() {
        data = jsonDecode(response.body);
      });

      totalFine();
      
    }catch (e){
      print("Error: $e");
    }
  }

  totalFine(){
    for(int i = 0; i < data!["reports"].length; i++){
      if(data!["reports"][i]['opt_ins'].length != 0){
        Map<String,dynamic>? fine = data!["reports"][i]['opt_ins'] ?? {};
        if(fine!["breakfast"] == "Pending"){
          total = total + 100;
        }
        if(fine["lunch"] == "Pending"){
          total = total + 100;
        }
        if(fine["dinner"] == "Pending"){
          total = total + 100;
        }
      }

    }
    setState(() {
    });
  }
  
  oneFine(Map<String, dynamic> fine){
    int t = 0;
    if(fine["breakfast"] == "Pending"){
      t = t + 100;
    }
    if(fine["lunch"] == "Pending"){
      t = t + 100;
    }
    if(fine["dinner"] == "Pending"){
      t = t + 100;
    }
    return t.toString();
  }

  @override
  Widget build(BuildContext context) {
    double mediaQH = MediaQuery.of(context).size.height;
    double mediaQW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Benzy"),
      ),
      body: Container(
        height: mediaQH,
        width: mediaQW,
        child: data != null ?
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                height: 70,
                width: mediaQW,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(32.5),
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        alignment: Alignment.center,
                        child: data!["user"]["image"] != null ?
                        Image.network(data!["user"]["image"]) :
                        Icon(Icons.person,color: Colors.white,size: 30,),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(data!["user"]["f_name"] ?? "User",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                            ),),
                            Text(data!["user"]["l_name"] ?? "User",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),),
                          ],
                        ),

                        Text(data!["user"]["phone"] ?? "xx xxxx xxxxx xx",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),),

                        Text(data!["user"]["email"] ?? "",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),),

                      ],
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 30,
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 45,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(22.5),
                    ),
                    alignment: Alignment.center,
                    child: Text("Total Fine: $total",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                    ),),)
                ],
              ),

              ListView.builder(
                itemCount: data!["reports"].length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  return data!["reports"][index]["opt_ins"].length != 0 ?
                    Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 10),
                    child: Container(
                      height: 120,
                      width: mediaQW*0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Text(data!["reports"][index]["date"],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.5,
                          ),),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 80,
                                      child: Text("Breakfast",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.5,
                                        ),),
                                    ),
                                    Text(data!["reports"][index]["opt_ins"]["breakfast"],
                                      style: TextStyle(
                                        color: data!["reports"][index]["opt_ins"]["breakfast"] == "Canceled" ? Colors.red :
                                        data!["reports"][index]["opt_ins"]["breakfast"] == "Pending" ? Colors.yellow :
                                        data!["reports"][index]["opt_ins"]["breakfast"] == "Delivered" ? Colors.green : Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.5,
                                      ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 80,
                                      child: Text("Lunch",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.5,
                                        ),),
                                    ),
                                    Text(data!["reports"][index]["opt_ins"]["lunch"],
                                      style: TextStyle(
                                        color: data!["reports"][index]["opt_ins"]["lunch"] == "Canceled" ? Colors.red :
                                        data!["reports"][index]["opt_ins"]["lunch"] == "Pending" ? Colors.yellow :
                                        data!["reports"][index]["opt_ins"]["lunch"] == "Delivered" ? Colors.green : Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.5,
                                      ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 80,
                                      child: Text("Dinner",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.5,
                                        ),),
                                    ),
                                    Text(data!["reports"][index]["opt_ins"]["dinner"],
                                      style: TextStyle(
                                        color: data!["reports"][index]["opt_ins"]["dinner"] == "Canceled" ? Colors.red :
                                        data!["reports"][index]["opt_ins"]["dinner"] == "Pending" ? Colors.yellow :
                                        data!["reports"][index]["opt_ins"]["dinner"] == "Delivered" ? Colors.green : Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.5,
                                      ),),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          Text("Fine: " + oneFine(data!["reports"][index]["opt_ins"]),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),)

                        ],
                      ),
                    ),
                  ) : Container();
                },
              )

            ],
          ),
        ) : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
