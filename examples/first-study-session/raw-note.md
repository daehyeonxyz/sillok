# Raw Study Note

Topic: Operating systems - process vs thread

운영체제 강의에서 process와 thread의 차이를 공부했다.

내가 이해한 것:

- process는 자기 memory space를 가진다.
- 같은 process 안의 thread들은 memory를 공유한다.
- context switching이 비용이 크다는 말은 이해했지만, 정확히 무엇 때문에 비싼지는 아직 애매하다.

AI에게 물어본 질문:

> process 사이의 context switch가 thread 사이의 context switch보다 보통 더 비싼 이유가 뭐야?

도움이 된 설명:

process를 바꿀 때는 주소 공간과 관련된 상태까지 바뀔 수 있고, 같은 process 안의 thread들은 더 많은 context를 공유할 수 있다는 설명이 도움이 됐다.

다시 볼 것:

- context switch
- scheduler
- process memory space
