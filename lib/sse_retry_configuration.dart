part of 'flutter_client_sse.dart';

class RetryConfiguration {
  final int? reconnectTime;
  final int? tryCount;
  final bool infinite;

  const RetryConfiguration(
      {this.reconnectTime, this.tryCount, this.infinite = true})
      : assert(!(tryCount == null && !infinite),
            'tryCount must be null if infinite is true');

  RetryConfiguration copyWith({
    int? reconnectTime,
    int? tryCount,
    bool? infinite,
  }) {
    return RetryConfiguration(
      reconnectTime: reconnectTime ?? this.reconnectTime,
      tryCount: tryCount ?? this.tryCount,
      infinite: infinite ?? this.infinite,
    );
  }

  RetryConfiguration use() {
    if (infinite) {
      return this;
    } else {
      assert(tryCount != null,
          "this should not be null because infinite is false");

      return copyWith(tryCount: tryCount! - 1);
    }
  }

  RetryConfiguration updateReconnectTime(int reconnectTime) {
    assert(reconnectTime < 1, throw "reconnect time can not be 0 or negative");

    return copyWith(reconnectTime: reconnectTime);
  }
}
