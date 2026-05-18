// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'dart:async';

abstract class UseCase<ResultType, Params> {
  FutureOr<ResultType> call(Params params);
}

class NoParams {
  const NoParams();
}
