+++
title = "Back from SoCraTes France 2019"
description = "Reflections on SoCraTes France 2019: code reviews, pair and mob programming, TCR, fish bowl, and katas to improve software development practices."
date = 2019-11-15

[taxonomies]
tags = ["software craftsmanship", "mob programming", "TDD"]

[extra]
comment = true
first_published_site = "Just-Tech-IT"
first_published_link = "https://medium.com/just-tech-it-now/de-retour-de-socrates-france-2019-7753116b7a9"
+++

From October 17 to 20, one of the key events in the _software craftsmanship_
movement took place in France. SoCraTes-FR describes itself as an unconference
— it's more of a retreat than a traditional conference.

<!-- more -->

{{ img(src="2019-11-15-socrates-france-2019-1.jpeg", alt="Château de Massillan, where SoCraTes-FR 2019 was held") }}

The agenda isn't known in advance. Instead, it takes shape each morning from the
many workshop proposals that everyone is encouraged to submit. The October 18
agenda — so hard to choose with this many options!

{{ img(src="2019-11-15-socrates-france-2019-2.jpeg", alt="The October 18 agenda — so hard to choose with this many options!") }}

Software quality is part of AXA's DNA, so it was natural for us to sponsor the
event and send our developers. I was lucky enough to attend and discuss a wide
range of topics — from DDD to code reviews, green IT, and many katas.

Here are some highlights from the discussions I had over those four days.

## Code Reviews

I didn't expect code reviews to spark such intense discussions. To me, it's
something everyone does as part of best practices when striving to improve
software quality.

But no! Even code reviews have their detractors.

Their main argument is that reviews are usually done poorly. For example,
reviewers don't pull the code locally — they just skim through it during a
_pull request_ or when someone presents code to them. In the end, reviews only
catch naming issues, typos, formatting problems, or obvious bugs.

Meanwhile, reviewers rarely question the business logic being implemented,
partly because **the whole team** doesn't know every feature in detail. Worse,
the level of scrutiny varies based on trust in the author! We tend to trust
someone who's been on the team longer and makes fewer mistakes.

Given this reality, some companies have stopped doing code reviews altogether,
opting instead for much more _pair programming_ and _mob programming_.

### Pair Programming

_Pair programming_ is a working method where two developers work together at the
same workstation.

This technique proves useful for newcomers (whether experienced or junior) to
learn the team's working methods and established best practices. It also avoids
the potential back-and-forth of early _pull requests_.

Those back-and-forths are counterproductive: the same code gets reviewed
multiple times, development stalls, and the developer may feel frustrated or
take comments personally. Once this _pair programming_ phase ends — which can be
seen as mentoring and typically lasts several weeks — you can trust these people
and stop reviewing their code entirely (or at least not every line).

### Mob Programming

_Mob programming_ is similar to _pair programming_, except the entire team works
on the same feature! One key advantage is that the whole team shares both
business knowledge and code ownership. You'll never hear "That's not my
code/bug, it's Paul's" or "Who worked on this feature?" anymore. Since the code
is written collaboratively, it's higher quality and doesn't need review
afterward.

{{ img(src="2019-11-15-socrates-france-2019-3.png", alt="mob programming") }}
Doing _mob programming_ is like _pair programming_ to the power of n — meaning
you get sustainable code. — Someone during a discussion at SoCraTes

## Katas

During this event, I practiced several katas that helped me discover a new
language (Haskell) and new ways of coding. A code kata is a development exercise that
helps you hone your skills through practice and repetition.

If you're interested, here are the katas I practiced:

- [FizzBuzz](http://codingdojo.org/kata/FizzBuzz/)
- [RPN Calculator](http://codingdojo.org/kata/RPN/)
- [Roman Numerals](http://codingdojo.org/kata/RomanNumerals/)

### TCR Instead of TDD

I had the chance to try TCR, an acronym for test && _commit_ || _revert_. It's a
programming method proposed by
[Kent Beck](https://medium.com/@kentbeck_7670/test-commit-revert-870bbd756864)
(the inventor of TDD). The principle: when you run tests, if they fail, you
_revert_ your code!

We applied a slightly less extreme version during the kata. Before running
tests, we'd bet on whether they'd pass or not. If we won the bet, we'd _commit_;
otherwise, we'd _revert_. This approach still lets you go through the "red bar"
phase where you see failing tests.

I preferred this approach. You spend less time "running tests in your head" to
avoid seeing all your code (including the latest test) disappear. Most
importantly, you keep the benefit of seeing your tests fail before they pass —
which I consider a crucial part of the TDD I practice daily.

However, TCR does force you to go through the obvious implementation phase of
the test (bet it'll be green, commit) before refactoring (if it doesn't work,
_revert_ and return to a working state).

### Fish Bowl Mob Programming

Before SoCraTes, I'd heard of _mob programming_ but had never tried it. During
one kata, we experimented with a specific facilitation technique for _mob
programming_: the fish bowl.

The rules are fairly simple:

- A driver has the keyboard. They **only** code and don't make decisions.
- A navigator tells the driver what to do. They're the **only** one speaking.
- One chair is open for **questions**. But beware — only questions to better
  understand the code (e.g., an unfamiliar syntax) or the business logic. You
  can't ask questions like "Why are we doing it this way?" — in that case, you
  take the navigator's seat!
- Everyone else stays **silent** and can take the driver's or navigator's place
  at any moment.

I really liked this technique for _mob programming_ because it prevents the
chaos that can arise when everyone tries to code at once. In those situations,
the driver doesn't know what to do, and it's hard to make progress.

Since the event, I've tested this technique during a kata and the format was
well received. However, like other techniques, I think you need to practice it
first before using it daily on production code.
