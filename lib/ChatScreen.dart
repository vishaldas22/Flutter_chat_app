import 'package:flutter/material.dart';
import 'package:bishal_chat_app/ChatMessage.dart';
import 'package:flutter/cupertino.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

final ThemeData kIOSTheme = new ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = new ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _textController = new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  bool _isComposing = false;

  Widget _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    ChatMessage message = new ChatMessage(
      text: text,
      animationController: new AnimationController(
          duration: new Duration(milliseconds: 500), vsync: this),
    );

    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  Widget _buildTextComposer() {
    return new IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  controller: _textController,
                  onSubmitted: _handleSubmitted,
                  onChanged: (String text) {
                    setState(() {
                      _isComposing = text.length > 0;
                    });
                  },
                  decoration:
                      new InputDecoration.collapsed(hintText: "Type a message"),
                ),
              ),
              new Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Theme.of(context).platform == TargetPlatform.iOS
                      ? new CupertinoButton(
                          child: new Text("Send"),
                          onPressed: _isComposing
                              ? () => _handleSubmitted(_textController.text)
                              : null)
                      : new IconButton(
                          icon: new Icon(Icons.send),
                          onPressed: _isComposing
                              ? () => _handleSubmitted(_textController.text)
                              : null))
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Bishal's Chat"),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Flexible(
                child: new ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            )),
            new Container(
              decoration: new BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            )
          ],
        ),
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? new BoxDecoration(
                border:
                    new Border(top: new BorderSide(color: Colors.grey[200])))
            : null,
      ),
    );
  }
}
