import 'dart:io';
import 'dart:async';
import 'package:kafka/kafka.dart';

void main(List<String> arguments) async {
  var host = ContactPoint('localhost', 9092);
  var session = KafkaSession([host]);
  var group = ConsumerGroup(session, 'consumerGroupName');
  var topics = {
    'meu-topico-legal': {0, 1} // list of partitions to consume from.
  };

  var consumer = Consumer(session, group, topics, 100, 1);
  await for (MessageEnvelope envelope in consumer.consume(limit: 3)) {
    // Assuming that messages were produces by Producer from previous example.
    var value = String.fromCharCodes(envelope.message.value);
    print('Got message: ${envelope.offset}, ${value}');
    envelope.commit('metadata'); // Important.
  }
  session
      .close(); // make sure to always close the session when the work is done.
}
