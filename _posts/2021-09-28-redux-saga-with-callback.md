---
layout: post
title: How to use Redux-Saga effects within a callback
description: Use Redux-Saga channels to dispatch actions from callback-based functions in your generator sagas.
author: Xavier Balloy
first_published_site: Kumojin dev notes blog
first_published_link: https://kumojin.github.io/2021/09/28/redux-saga-with-callback.html
tags:
  - redux-saga
  - async-patterns
  - javascript
---
Because you can only add a `yield` expression in a generator body it can be
tricky to use a callback-based library in your saga (a generator function).
<!--more-->
Let's take this basic example where we want to dispatch an `ERROR` or
a `SUCCESS`
depending on the result of `callbackBasedFn` to continue our workflow.

You cannot write the following code because a `yield` expression is only allowed
in a generator body.

```js
import { put } from 'redux-saga/effects';

function* mySaga(input) {
  callbackBasedFn(input, (err, data) => {
    if (err) {
      // Not valid: A 'yield' expression is only allowed in a generator body.
      yield put({ type: 'ERROR', err });
    } else {
      // Not valid: A 'yield' expression is only allowed in a generator body.
      yield put({ type: 'SUCCESS', data });
    }
  });
}
```

A solution is to use a `channel` which acts as a watcher.

```js
import { put, take } from 'redux-saga/effects';
import { channel } from 'redux-saga';

function* mySaga(input) {
  const callbackChannel = channel();
  callbackBasedFn(input, (err, data) => {
    if (err) {
      callbackChannel.put({ type: 'ERROR', err });
    } else {
      callbackChannel.put({ type: 'SUCCESS', data });
    }
  });

  const action = yield take(callbackChannel);
  yield put(action);
}
```
