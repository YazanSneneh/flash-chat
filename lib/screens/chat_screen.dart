import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

final _firebaseStore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
class ChatScreen extends StatefulWidget {
  static String chatScreenId = 'chat';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

    final controller = TextEditingController();
    String messageText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser()async {
     try{
       final currentUser = await _auth.currentUser;
       if(currentUser !=null){
         print('logged email : '+currentUser.email);
       }
     }catch(e){
       print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
                // getMessagesFromStream();

              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
           Expanded(child: StreamProvider( )),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      controller.clear();
                       _firebaseStore.collection('messages').add({
                         'text': messageText,
                         'sender': _auth.currentUser.email
                       });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StreamProvider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firebaseStore.collection('messages').snapshots(),
        builder:(context, snapshot){

            if(!snapshot.hasData){
              return Text('Currently empty chat');
            }
              final messages = snapshot.data.docs.reversed;
              final List<BubbleMessage> messageList = [];
              for( var message in messages){
                  final text = message['text'];
                  final sender = message['sender'];

                  final currentLoggedUserEmail = _auth.currentUser.email;

                  final messageWidget = BubbleMessage(text: text, sender: sender, isMe: currentLoggedUserEmail == sender ? true: false);
                  messageList.add(messageWidget);
              }

              return ListView(
                reverse: true,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                children: messageList,
              );
            }

    );
  }
}

class BubbleMessage extends StatelessWidget {
  const BubbleMessage({
    @required this.text,
    @required this.sender,
    @required this.isMe
  });

  final String text;
  final String sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: isMe == false? CrossAxisAlignment.start: CrossAxisAlignment.end,
        children: [
          Text(sender, style: TextStyle(color: Colors.black54),),
          Material(
            elevation: 6,
            borderRadius: BorderRadius.only(
                topLeft: isMe == true? Radius.circular(30): Radius.circular(0),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
                topRight: isMe == false? Radius.circular(30): Radius.circular(0)
            ),
            color: isMe == true? Colors.blueAccent: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
              child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isMe == true? Colors.white : Colors.black,
              ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
