+++
title = "My Global Day of Code Retreat 2017"
description = "What I learned about TDD, functional programming, and communication at Code Retreat 2017."
date = 2017-11-19

[taxonomies]
tags = ["code retreat", "kata", "tdd", "pair programming", "conways game of life"]

[extra]
comment = true
+++

My takeaway from the Global Day of Code Retreat 2017.

<!-- more -->

{{ img(src="2017-11-19-my-global-day-of-code-retreat-2017-1.jpeg", alt="Picture of the Global Day of Code Retreat at AXA") }}

Last Saturday, I attended
the [Global Day of Code Retreat](http://coderetreat.org/) hosted at AXA
WebCenter (Lille, France). A code retreat is an event where you can perfect the
way you write code, design your application, learn new ways of coding... Unlike
in your everyday job, the final goal is not to finish the exercise but to
improve your skills! During this
event [Christophe Thibaut](https://twitter.com/ToF_) was our facilitator. It was
his first time as a facilitator but he was so good no one realized it!

We did six iterations
of [Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life)
kata (45 minutes of coding and 15 minutes of debriefing). During every
iteration, we had different constraints. After an iteration, you have to destroy
your code. I did every iteration in Java using IntelliJ (my everyday language
and IDE) in ping-pong programming (using TDD of course) with a different person.

## Conway's Game of Life

The rules of Conway's Game of Life are simple. In an infinite orthogonal 2-dimensional world, the following rules apply:

- When an alive cell has fewer than 2 neighbors it dies.
- When an alive cell has 2 or 3 neighbors it stays alive.
- When an alive cell has more than 3 neighbors it dies.
- When a dead cell has 3 neighbors it becomes alive.

### 1st iteration

Constraint: none. This iteration is mostly to discover the problem and the
rules.

We both already knew this kata but always had the same approach so we decided to
do it another way: we started by implementing the rules. We went quite far: we
had all the elements and were assembling them. The design of the grid emerged by
itself so we didn't have to think about which structure to use. It's the best
approach I used so far and used it during the other iterations.

### 2nd iteration

Constraint: no primitive in the public API of our methods.

We had the same approach as in the previous iteration. The hardest thing was to
define the coordinates of the cells without using `int`. We cheated and
used `Integer`, that's Java after all.

During the debriefing, we shared our difficulties and someone suggested defining
the neighbors relative to each other. Using top, right, bottom, and left. I
think it's a great idea because you can chain them and it is infinite (by
using an `int` I have a limit, a huge one, but still a limit).

### 3rd iteration

Constraint: no conditionals.

One of the most difficult constraints for me… How to remove the if in the method
that checks if a cell is dead or alive?! Finally, we
used `Map<Integer, Function>` to get the rule corresponding to the number of
neighbors. I don't usually use this pattern but it improves the readability of
the code and every Function has only one role (the S in SOLID)!

However, it was quite hard to come to this idea and we should have written the
code with conditionals then refactored it. I have no idea why we didn't use the
refactoring phase of TDD to do it.

### 4th iteration

Constraint: not only object-oriented development (Functions & Types over
classes. Purity over mutability. Composition over inheritance. Higher-order
functions over method dispatch. Options over nulls).

This was the hardest constraint. I'm not used to functional programming so I
needed to change the way I think, which is hard in 45 minutes… Even
writing the first test wasn't easy.

Finally, we wrote specific functions for every functionality (one for each rule,
one to count the number of neighbors…) then composed them.

### 5th iteration

Constraint: mute programming.

I thought it would be an easy one because we both knew the problem and already
solved it a few times. However, it wasn't so easy because it's hard to tell the
intention of a method or a variable. We had to rename them a couple of times to
know what it meant for both of us. This time writing the rules first wasn't the
best idea because once written it was hard to continue and to explain (without
speaking or writing) what we wanted to do! Communication is really important in
a team!

### 6th iteration

Constraints: TDD as if you meant it & mob programming.

The most fun! We were disciplined enough to listen to each other so it didn't
end up in a big mess. But it was hard for some people to talk and give their
point of view. When the group is working well sometimes you don't want to slow
it down. However, it could be interesting to have a higher vision of what we are
doing and it could be the opportunity for refactoring some code.

In this last iteration, we wrote the simplest code in the test to make it pass.
At first, it looked absurd because it was very far from the code we all produced
during the day. But it's a good way to experiment with things and finally design
our application in a new way.

## What did I learn?

This day was very interesting and I'm glad I spent my Saturday there. I met
passionate people, I had fun and I learned new things that I'll try to apply in my
everyday job.

- Communicating through the code is hard and sometimes a meaningful name for me
  might not make sense to someone else. Next time I do a code review I will
  challenge even more the name of the methods/variables.
- I will try to write more functional code: it's harder to write when you're not
  used to but it's really simple to test.
- I will write more code in my test to experiment: you don't have to switch to a
  different class to see what you are doing and you can easily refactor
  everything once it's working.
- Next time I will write an `if` (probably tomorrow) I'll ask myself if I can do
  without it.
