import 'dart:convert';
import 'package:adhara_socket_io/adhara_socket_io.dart';

class SocketUtil {
  // List<String> toPrint = ["trying to connect"];

  // Map<String, SocketIO> sockets = {};
  // Map<String, bool> _isProbablyConnected = {};
  static const URI = "http://10.0.2.2:3000/";
  SocketIOManager manager = SocketIOManager();
  SocketIO socket;

  initSocket() async {
    // setState(() => _isProbablyConnected[identifier] = true);
    SocketIO socket = await manager.createInstance(SocketOptions(
        //Socket IO server URI
        URI,
        enableLogging: false,
        transports: [
          Transports.WEB_SOCKET /*, Transports.POLLING*/
        ] //Enable required transport
        ));
    socket.onConnect((data) {
      pprint("connected...");
      pprint(data);
    });
    socket.onConnectError(pprint);
    socket.onConnectTimeout(pprint);
    socket.onError(pprint);
    socket.onDisconnect(pprint);
    // socket.on("type:string", (data) => pprint("type:string | $data"));
    // socket.on("type:bool", (data) => pprint("type:bool | $data"));
    // socket.on("type:number", (data) => pprint("type:number | $data"));
    // socket.on("type:object", (data) => pprint("type:object | $data"));
    // socket.on("type:list", (data) => pprint("type:list | $data"));
    // socket.on("message", (data) => pprint(data));
    socket.connect();
    this.socket = socket;
  }

  disconnect() async {
    await manager.clearInstance(socket);
    // setState(() => _isProbablyConnected[identifier] = false);
  }

  sendMessage(String messageType, List message) {
    if (socket != null) {
      pprint(message);
      // pprint("sending message from '$'...");
      this.socket.emit(messageType, message);
      // pprint("Message emitted from '$identifier'...");
    }
  }

  pprint(data) {
    if (data is Map) {
      data = json.encode(data);
    }
    print(data);
  }
}
