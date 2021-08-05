import 'package:kafka/kafka.dart';

void main(List<String> arguments) async {
  var host = ContactPoint('localhost', 9092);
  var session = KafkaSession([host]);

  var producer = Producer(session, 1, 1000);

  var result = await producer.produce([
    ProduceEnvelope('meu-topico-legal', 0, [
      Message([1])
    ]),
    ProduceEnvelope('meu-topico-legal', 0, [
      Message([2])
    ])
    //ProduceEnvelope('topicName', 0, [Message('msgForPartition0'.codeUnits)]),
  ]);
  print(result.hasErrors);
  print(result.offsets);
  await session
      .close(); // make sure to always close the session when the work is done.
}
