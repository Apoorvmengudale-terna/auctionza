import 'dart:async';

import 'package:Auctionza/Data.dart';
import 'package:Auctionza/UploadData.dart';
import 'package:Auctionza/ui/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class HomePage extends StatefulWidget {




  @override
  _HomePageState createState() => _HomePageState();


}

class _HomePageState extends State<HomePage> {

  List<Data> dataList = [];




  @override
  void initState() {

    super.initState();
    DatabaseReference referenceData = FirebaseDatabase.instance.reference().child("Product");
    referenceData.once().then((DataSnapshot dataSnapshot){
    dataList.clear();
    var keys = dataSnapshot.value.keys;
    var values = dataSnapshot.value;

    for(var key in keys)
      {
        Data data = new Data(
          values[key]["imgUrl"],
          values[key]["title"],
          values[key]["price"],
          values[key]["description"],
          values[key]["uploadid"],
          values[key]["duration"],


        );
        dataList.add(data);
      }


    Timer(Duration(seconds: 1),(){
      setState(() {

      });
    });
    });

  }


  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> logOut() async {
    User user = auth.signOut() as User;
  }


  @override
  Widget build(BuildContext context) {

    var user = auth.currentUser;


    return Scaffold(

        backgroundColor: Colors.grey[300],//Color(0xffe1f5fe),
        appBar: AppBar(

          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "Auctionza",
            style: TextStyle(

              fontFamily: 'WorkSansBold',
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          backgroundColor: Colors.black,//(0xDD000000),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search, color: Colors.white), onPressed: (){},),

          ],
        ),

        drawer: Drawer(

          child: ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: Text("ab",style: TextStyle(
                  fontFamily: 'WorkSansBold',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                )),
                accountEmail: Text(user.email.toString(),style: TextStyle(
                  fontFamily: 'WorkSansBold',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                )),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.grey),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Color(0xff90caf9)
                ),
              ),
              InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  child: ListTile(
                    title: Text('Home Page',style: TextStyle(
                      fontFamily: 'WorkSansBold',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    )),
                    leading: Icon(Icons.home,color: Colors.purple[200],),
                  )
              ),


              InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                  child: ListTile(
                    title: Text('My Account',style: TextStyle(
                      fontFamily: 'WorkSansBold',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    )),
                    leading: Icon(Icons.person, color: Colors.red[200],),
                  )
              ),


              InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  child: ListTile(
                    title: Text('My Orders',style: TextStyle(
                      fontFamily: 'WorkSansBold',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    )),
                    leading: Icon(Icons.shopping_basket,color: Colors.pink[200],),
                  )
              ),




              Divider(),

              InkWell(
                  onTap: (){
                    logOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutPage()),
                    );
                  },
                  child: ListTile(
                    title: Text('About',style: TextStyle(
                      fontFamily: 'OpenSansBold',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    )),
                    leading: Icon(Icons.description,color: Colors.green[200],),
                  )
              ),

              InkWell(
                  onTap: (){
                    logOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: ListTile(
                    title: Text('Logout',style: TextStyle(
                      fontFamily: 'OpenSansBold',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    )),
                    leading: Icon(Icons.archive_outlined,color: Colors.brown[300],),
                  )
              ),



            ],
          ),
        ),



        body:
        dataList.length == 0
            ? Center(child: Text("No data",style: TextStyle(color: Colors.white,fontSize: 30),))
            : ListView.builder(
           itemCount: dataList.length,
            itemBuilder: (_,index){
             return CardUI(
                 dataList[index].imgUrl,
                 dataList[index].title,
                 dataList[index].description,
                 dataList[index].price,
                 dataList[index].uploadid,
                 dataList[index].duration,
                );
            }),


        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: new FloatingActionButton(

          onPressed:(){
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => UploadData()),);
          },
          child: new Icon(Icons.add),
          backgroundColor: Colors.grey[700],
        ));
  }

  Widget CardUI(String imgUrl, String title, String description, String price, String uploadid, String duration) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(imgUrl,title,price,description,duration)));},
      child: Card(
        elevation: 5,
        shadowColor: Colors.blueGrey[200],

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),

        margin: EdgeInsets.all(20),
        child: SizedBox(
          height: 187,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),gradient: LinearGradient(begin: Alignment.bottomRight,colors: [Colors.grey.withOpacity(.1),Colors.grey.withOpacity(.1),])),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children:<Widget> [
                SizedBox(height: 12,),
                Image.network(imgUrl, fit: BoxFit.cover, height: 100,),
                SizedBox(height: 5,),
                Text(title, style: TextStyle(color: Colors.black,
                    fontSize: 20,fontFamily: 'OpenSans', ),),
                SizedBox(height: 1,),
                Container(
                  child: Text("Highest Bid: $price", style: TextStyle(
                      color: Colors.black,fontSize: 15,fontFamily: 'OpenSansBold', ),
                    textAlign: TextAlign.right,),
                ),
                SizedBox(height: 1,),
                Padding(
                  padding: const EdgeInsets.only(left: 200),
                  child: Text("Time left: $duration hrs",style: TextStyle(fontSize: 14,fontFamily: 'Montserrat',),),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }





}

/*
DetailScreen(imgUrl,title,price,description,duration){

    return Scaffold(

      appBar: AppBar(backgroundColor: Colors.black, elevation: 0,),
      body: Column(

        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                image: DecorationImage(
                    image: NetworkImage(imgUrl), fit: BoxFit.fitWidth),
              ),

            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.grey[200],
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text.rich(TextSpan(text: 'Item ',
                      style: TextStyle(
                          fontFamily: 'OpenSansBold', fontSize: 25),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Name:',
                            style: TextStyle() //decoration: TextDecoration.underline)
                        ),
                        TextSpan(
                            text: ' $title', style: TextStyle()
                        ),
                      ],),),
                    SizedBox(height: 5,),
                    Text.rich(TextSpan(text: 'Highest ',
                        style: TextStyle(
                            fontFamily: 'OpenSansBold', fontSize: 18),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Bid:',
                              style: TextStyle() //decoration: TextDecoration.underline)
                          ),
                          TextSpan(
                              text: ' ₹$price', style: TextStyle()
                          ),
                        ])),
                    SizedBox(height: 5,),
                    Text.rich(TextSpan(text: 'Descri',
                        style: TextStyle(
                            fontFamily: 'OpenSansBold', fontSize: 18),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'ption:',
                              style: TextStyle() //decoration: TextDecoration.underline)
                          ),
                          TextSpan(
                              text: ' $description', style: TextStyle()
                          ),
                        ])),
                    SizedBox(height: 5,),
                    Text("Time Left : $duration hrs", style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        color: Colors.black),),
                    SizedBox(height: 5,),
                    Column(
                      children: [
                        Center(
                          child: Container(
                            width: 50,
                            child: TextFormField(

                            ),
                          ),
                        ),
                        Center(child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: TextButton(child: Text("Bid", style: TextStyle(
                              fontFamily: 'OpenSansBold', color: Colors.white),),
                            onPressed: () {



                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.black,),),
                        )),
                      ],
                    ),



                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }




*/

DetailScreen(imgUrl,title,price,description,duration) {

return Scaffold(
  appBar: AppBar(backgroundColor: Colors.black, elevation: 0,),
  body: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:<Widget> [
          Container(
           height: 250,
            decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5),spreadRadius: 5,
                blurRadius: 7,
                    offset: Offset(0, 3),)],color: Colors.blue,image: DecorationImage(image: NetworkImage(imgUrl),fit: BoxFit.fitWidth)),
          ),
          Container(
           child: Divider(color: Colors.black,height: 60,indent: 50,endIndent: 50,),
          ),
          Container(
            child: Text.rich(TextSpan(text: 'Item ',
              style: TextStyle(
                  fontFamily: 'OpenSansBold', fontSize: 25),
              children: <TextSpan>[
                TextSpan(
                    text: 'Name:',
                    style: TextStyle() //decoration: TextDecoration.underline)
                ),
                TextSpan(
                    text: ' $title', style: TextStyle()
                ),
              ],),),
          ),
          SizedBox(height: 5,),
          Container(
            child:Text.rich(TextSpan(text: 'Highest ',
                style: TextStyle(
                    fontFamily: 'OpenSansBold', fontSize: 18),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Bid:',
                      style: TextStyle() //decoration: TextDecoration.underline)
                  ),
                  TextSpan(
                      text: ' ₹$price', style: TextStyle()
                  ),
                ])),
          ),
          SizedBox(height: 5,),
          Container(
            child: Text.rich(TextSpan(text: 'Descri',
                style: TextStyle(
                    fontFamily: 'OpenSansBold', fontSize: 18),
                children: <TextSpan>[
                  TextSpan(
                      text: 'ption:',
                      style: TextStyle() //decoration: TextDecoration.underline)
                  ),
                  TextSpan(
                      text: ' $description', style: TextStyle()
                  ),
                ])),
          ),
          SizedBox(height: 5,),
          Text("Time Left : $duration hrs", style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 18,
              color: Colors.black),),
          SizedBox(height: 5,),
          Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: 150,
                    height: 40,
                    child: TextFormField(
                      decoration: InputDecoration(floatingLabelBehavior: FloatingLabelBehavior.always,labelText: 'Enter Your Bid',labelStyle: TextStyle(color: Colors.black,),focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black,width: 2),),enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black,width: 2),
                        borderRadius: BorderRadius.circular(10),

                        ),) ,

                        keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                      validator: (value){
                        if(value.isEmpty){
                          return "Please enter the price.";
                        }
                        else
                        {
                          price=value;
                        }
                      },

                    ),
                  ),
                ),
              ),
              Center(child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextButton(child: Text("Bid", style: TextStyle(
                    fontFamily: 'OpenSansBold', color: Colors.white),),
                  onPressed: () {

                  PriceChange();

                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,),),
              )),
            ],
          ),

        ],
      ),
    ),
  ),
);
}


class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = auth.currentUser;
    return new Scaffold(
        appBar: AppBar(iconTheme: IconThemeData(color: Colors.black),elevation: 0,backgroundColor: Color(0xffe3f2fd),title: Text('Profile',style: TextStyle(color: Colors.black,fontFamily: 'OpenSansBold'),)),
        body: new Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  new Container(
                    height: 250.0,
                    color: Color(0xffe3f2fd),
                    child: new Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 20.0),
                            child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                    width: 140.0,
                                    height: 140.0,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        image: new ExactAssetImage(
                                            'assets/img/as.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 90.0, right: 130.0),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    InkWell(
                                      child: new CircleAvatar(
                                        backgroundColor: Colors.black,
                                        radius: 25.0,
                                        child: new Icon(
                                          Icons.camera_alt_sharp,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onTap: () {
                                        //change user dp code
                                      },
                                    )
                                  ],
                                )),
                          ]),
                        )
                      ],
                    ),
                  ),
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Personal Information',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      _status ? _getEditIcon() : new Container(),
                                    ],
                                  )
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Name',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextFormField(
                                      decoration: const InputDecoration(
                                        hintText: "Enter Your Name",
                                      ),
                                      enabled: !_status,
                                      autofocus: !_status,

                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Email ID',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextFormField(
                                      initialValue: user.email.toString(),
                                      decoration: const InputDecoration(
                                          hintText: "Enter Email ID"),
                                      enabled: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Mobile',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      decoration: const InputDecoration(
                                          hintText: "Enter Mobile Number"),
                                      enabled: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: new Text(
                                        'Pin Code',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: new Text(
                                        'State',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: new TextField(
                                        decoration: const InputDecoration(
                                            hintText: "Enter Pin Code"),
                                        enabled: !_status,
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Flexible(
                                    child: new TextField(
                                      decoration: const InputDecoration(
                                          hintText: "Enter State"),
                                      enabled: !_status,
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          !_status ? _getActionButtons() : new Container(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: SizedBox(
              width: 130,
              height: 40,
              child: Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Container(
                    child: new TextButton(
                      child: new Text("Save",style: TextStyle(color: Colors.white),),
                      onPressed: () {
                        setState(() {
                          _status = true;
                          FocusScope.of(context).requestFocus(new FocusNode());
                        });
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage() ));
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),),

                    )),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: 130,
              height: 40,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Container(
                    child: new TextButton(
                      child: new Text("Cancel",style: TextStyle(color: Colors.white),),


                      onPressed: () {
                        setState(() {
                          _status = true;
                          FocusScope.of(context).requestFocus(new FocusNode());
                        });
                      },
                      style: TextButton.styleFrom( backgroundColor: Colors.black,shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)),),

                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.black,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}


class InfoCard extends StatelessWidget {
  // the values we need
  final String text;
  final IconData icon;
  Function onPressed;

  InfoCard(
      {@required this.text, @required this.icon, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.black54,
          ),
          title: Text(
            text,
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: "Source Sans Pro"),
          ),
        ),
      ),
    );
  }
}


const email = "apoorvmengudale@ternaengg.ac.in";
const phone = "90441539202";

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff272121), //Colors.blueGrey[500] ,
      ),
        backgroundColor: Color(0xff272121),//Colors.blueGrey[500],
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 100),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(blurRadius: 7, color: Colors.grey, spreadRadius: 2)],
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/logo.gif'),
                ),
              ),
              SizedBox(height: 10,),
              Text(
                "Auctionza",
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "OpenSans",
                ),
              ),
              SizedBox(height: 10,),
              Text(
                "Home for auctions",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.blueGrey[200],

                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"),
              ),
              SizedBox(
                height: 100,
                width: 200,
                child: Divider(
                  color: Colors.white,
                ),
              ),

              InfoCard(text: phone, icon: Icons.phone, onPressed: () async {}),
              InfoCard(text: email, icon: Icons.email, onPressed: () async {}),
            ],
          ),
        ));
  }
}





class PriceChange extends StatefulWidget {
  @override
  _PriceChangeState createState() => _PriceChangeState();
}

class _PriceChangeState extends State<PriceChange> {




  Widget build(BuildContext context) {
    return Container(    );
  }
}
