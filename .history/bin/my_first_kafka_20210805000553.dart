import 'package:kafka/kafka.dart';
import 'dart:io';

void main(List<String> arguments) async {
  var host = ContactPoint('localhost', 29092);
  var session = KafkaSession([host]);

  var producer = Producer(session, 1, 1000);
  var result = await producer.produce([
    ProduceEnvelope('topicName', 0, [Message('msgForPartition0'.codeUnits)]),
    ProduceEnvelope('topicName', 1, [Message('msgForPartition1'.codeUnits)])
  ]);
  print(result.hasErrors);
  print(result.offsets);
  await session
      .close(); // make sure to always close the session when the work is done.
}
