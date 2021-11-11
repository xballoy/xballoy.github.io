---
layout: post
title: "How to avoid conditional in your code"
author: "Xavier Balloy"
tags:
  - code retreat
  - java
  - kata
---
A couple of weeks ago I’ve been asked to share how I avoided `if` in my code at
the Global Day of Code Retreat 2017.
<!--more-->

**DISCLAIMER**: this solution was produced during a kata where we forced
ourselves to code under certain conditions (no `if` in this case). It is not the
only solution (you can use polymorphism for example) and is probably not a good
pattern to solve this specific case in a real project.

In my implementation of Conway’s Game of Life, I have the following method to
know if a cell will be `DEAD` or `ALIVE` in the next iteration.

```java
public Status newStatusFor(int neighboursCount) {
  if (neighboursCount< 2||neighboursCount>3) {
    return Status.DEAD;
  }
  return Status.ALIVE;
}
```

Because we have a small finite number of possibilities (a cell has up to 8
neighbours) I did as follow:

```java
private static ImmutableMap<Integer, Status> neighboursRules=ImmutableMap.<Integer, Status>builder()
  .put(0,Status.DEAD)
  .put(1,Status.DEAD)
  .put(2,Status.ALIVE)
  .put(3,Status.ALIVE)
  .put(4,Status.DEAD)
  .put(5,Status.DEAD)
  .put(6,Status.DEAD)
  .put(7,Status.DEAD)
  .put(8,Status.DEAD)
  .build();

public VitalStatus newStatusFor(int neighboursCount) {
  return neighboursRules.get(neighboursCount);
}
```

In this case, I just return the value of the enum but I could have returned
a `Function` and done something more complicated.

## Conclusion

- **When to use**: you have a small finite number of possibilities
- **Benefit**: if you put a `Function` in the value it’s easy to modify it
  without changing the existing code (open/closed principle)
