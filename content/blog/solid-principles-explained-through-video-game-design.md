+++
title = "SOLID principles explained through video game design"
description = "Learn how to identify and fix SOLID principle violations during code reviews, with practical TypeScript examples based on video game design."
date = 2023-01-31

[taxonomies]
tags = ["solid", "clean-code", "typescript"]

[extra]
comment = true
mermaid = true
first_published_site = "Kumojin"
first_published_link = "https://kumojin.com/5-principes-solid-expliques-developpeurs/"
+++

**Code reviews are one of the tools developers use to find problems as early as possible. However, it can be difficult to identify issues related to SOLID principles if you don't know what to look for. So rather than offering yet another article that just defines the principles, I'll show you how to recognize and fix violations, with code examples based on video game design.**

<!-- more -->

## Why apply SOLID principles

The SOLID principles tell us **how to organize our functions and data structures** into classes and how those classes should interconnect.

Note that although we use the word "class," this does not mean these principles only apply to object-oriented development. SOLID principles apply to any grouping of functions and data structures, even if those groupings aren't technically classes in the object-oriented sense.

The goal of these principles is to create modules that:

- **tolerate change**;
- are **easy to understand**;
- are the **foundation of components** that can be used in any type of system.

The theory behind SOLID principles was introduced in their current form, but in a different order, in 2002 by Robert C. Martin (also known as [Uncle Bob](https://en.wikipedia.org/wiki/Robert_C._Martin)). However, it was only a few years later that Michael Feathers suggested reordering them to create the **SOLID** acronym.

The SOLID concepts are:

- **S**ingle Responsibility Principle (SRP)
- **O**pen-Closed Principle (OCP)
- **L**iskov Substitution Principle (LSP)
- **I**nterface Segregation Principle (ISP)
- **D**ependency Inversion Principle (DIP)

## Single Responsibility Principle

The Single Responsibility Principle states that a class should have only one reason to change. Separating responsibilities into different classes is important because if a class has multiple responsibilities and one of them changes, it could impact the other and cause unintended side effects.

> Note: all the following examples are inspired by [Leek Wars](https://leekwars.com/), a programming game in which you must create the most powerful leek and destroy your enemies.

Consider the following class diagram:

{% mermaid() %}
classDiagram
  class LeekAI {
    +play()
    -move(reason: Reason, cell: Cell)
    -attack(leek: Leek)
    -heal(leek: Leek)
  }
{% end %}

In this example, the `LeekAI` class has multiple responsibilities:

- moving on the map;
- attacking a leek;
- healing a leek;
- playing its turn by orchestrating the three actions above.

One reason to modify the `LeekAI` class would be to change how the leek attacks. Another would be to change how it moves on the map. Since we have two reasons to modify this class, we have violated the Single Responsibility Principle and introduced **excessive coupling**.

To fix this, we should extract these methods into their own classes:

{% mermaid() %}
classDiagram
  LeekAI <-- MoveAI
  LeekAI <-- AttackAI
  LeekAI <-- HealAI
  class LeekAI {
    +play()
  }
  class MoveAI {
    +move(leek: Leek, reason: Reason, cell: Cell)
  }
  class AttackAI {
    +attack(leek: Leek, target: Leek)
  }
  class HealAI {
    +heal(leek: Leek, target: Leek)
  }
{% end %}

With this new structure, we have removed the excessive coupling. The `LeekAI` class now has **only one reason to change**: if we change the order of our gameplay phases during a turn.

Even though the Single Responsibility Principle talks about classes, it can also apply at the function level.

Take this possible implementation of `MoveAI`:

```ts
class MoveAI {
  move(leek: Leek, reason: Reason, cell: number) {
    if (reason === Reason.Attack) {
      // Calculate the best position to attack the cell
      // Move to the best position to attack
    } else if (reason === Reason.Retreat) {
      // Move away from the cell
    }
  }
}
```

The `move` function performs multiple tasks, so it violates the Single Responsibility Principle. It executes a different movement depending on the reason, and in the case of an attack, it also calculates the best position.

Fixing this is straightforward — just create dedicated functions.

```ts
class MoveAI {
  move(leek: Leek, reason: Reason, cell: number) {
    if (reason === Reason.Attack) {
      this.moveToAttack(leek, cell);
    } else if (reason === Reason.Retreat) {
      this.moveAway(leek, cell);
    }
  }

  private moveToAttack(leek: Leek, cell: number) {
    const bestCellToAttack = this.getBestCellToAttack(leek, cell);
    this.moveToward(leek, bestCellToAttack);
  }

  private getBestCellToAttack(leek: Leek, cell: number) {
    // Calculate the best position to attack the cell
  }

  private moveToward(leek: Leek, cell: number) {
    // Move toward the cell
  }

  private moveAway(leek: Leek, cell: number) {
    // Move away from the cell
  }
}
```

## Open-Closed Principle

The Open-Closed Principle states that a software entity should be open for extension but closed for modification.

A software entity that is open for extension means the behavior of a module can change — for example, when requirements change. However, it must be closed for modification to prevent a module from changing when its behavior changes. This may seem counterintuitive, but the key to applying this principle is abstraction! Indeed, **if a module only references abstractions, it is possible to add an implementation without modifying it**.

For example, the following code does not respect the Open-Closed Principle:

```ts
class LeekAI {
  private readonly moveModule = new SimpleMoveAI();
  private readonly attackModule = new SimpleAttackAI();

  public play() {
    // ...
    moveModule.move(me, Reason.Attack, enemy);
  }
}
```

In the code above, `LeekAI` depends on the concrete classes `SimpleMoveAI` and `SimpleAttackAI`.
If we want to change how our AI moves but these two classes cannot be modified (e.g. they come from a third-party library), we would have to modify `LeekAI` directly, which means our class is open for modification — exactly what we want to avoid!

To fix this, we should create abstractions for `SimpleMoveAI` and `SimpleAttackAI` and use those abstractions in `LeekAI`, so we can change movement or attack behavior without modifying our module.

{% mermaid() %}
classDiagram
  MoveAI <|.. SimpleMoveAI
  MoveAI <|.. AdvancedMoveAI
  class MoveAI {
    <<Interface>>
    +move(leek: Leek, reason: Reason, cell: Cell)
  }
  class SimpleMoveAI {
    +move(leek: Leek, reason: Reason, cell: number)
  }
  class AdvancedMoveAI {
    +move(leek: Leek, reason: Reason, cell: number)
  }
  AttackAI <|.. SimpleAttackAI
  AttackAI <|.. AdvancedAttackAI
  class AttackAI {
    <<Interface>>
    +attack(leek: Leek, target: number)
  }
  class SimpleAttackAI {
    +attack(leek: Leek, target: number)
  }
  class AdvancedAttackAI {
    +attack(leek: Leek, target: number)
  }
{% end %}

We can then modify our class as follows:

```ts
class LeekAI {
  constructor(
    private readonly moveModule: MoveAI,
    private readonly attackModule: AttackAI
  ) {}

  public play() {
    // ...
    moveModule.move(me, Reason.Attack, enemy);
  }
}
```

The `LeekAI` class no longer knows about the concrete implementations for movement and attack. If we want to change their behavior, we no longer need to modify `LeekAI` — so it is closed for modification. If, for example, we want to implement a new way of attacking, we just need to create a new implementation of `AttackAI` — so it is open for extension.

We will see how to instantiate the correct implementations of `MoveAI` and `AttackAI` in the section on the Dependency Inversion Principle, as the two principles are closely related.

## Liskov Substitution Principle

The Liskov Substitution Principle can be paraphrased as follows: subtypes must be substitutable for their base types. It is named after [Barbara Liskov](https://en.wikipedia.org/wiki/Barbara_Liskov) and describes how subtypes must be usable in place of their supertypes without breaking program functionality.

We are talking about **subtypes, not subclasses**. A subtype has a stricter definition and is used to indicate that the type was designed to replace its supertype. A subclass relationship **does NOT imply** a subtype relationship.

There are a few heuristics that can give you clues about Liskov Substitution Principle violations. They all relate to derived classes that, in one way or another, remove functionality from their base classes. A derived class that does less than its base is generally not substitutable for that base, and therefore violates the Liskov Substitution Principle.

For example, if `SmartLeek` derives from `Leek`:

```ts
class Leek {
  useWeapon(weapon: Weapon): boolean {
    // ...
  }
}

class SmartLeek extends Leek {
  useWeapon(weapon: Weapon): boolean {
    // ...
  }
}
```

As a derived class, `SmartLeek` must respect the following rules:

- The **preconditions** (assertions about state before executing the function) of `SmartLeek`'s `useWeapon` **must not be stronger** than those of `Leek`.
- The **postconditions** (assertions about state after executing the function) **must not be weaker** than those of `Leek`.
- It must not throw exceptions where `Leek` does not.
- Its behavior must not differ from that of `Leek`.

## Interface Segregation Principle

This principle states that several specific interfaces are preferable to a single general-purpose interface.

Look at the following code snippet:

```ts
interface CanUseChipAndWeapon {
  setWeapon(weapon: number): void;
  useWeapon(entity: number): number;
  useChip(chip: number, entity: number): number;
}

class Leek implements CanUseChipAndWeapon {
  setWeapon(weapon: number) {
    // [...]
  }

  useWeapon(entity: number): number {
    // [...]
  }
  useChip(chip: number, entity: number): number {
    // [...]
  }
}

class Bulb implements CanUseChipAndWeapon {
  setWeapon(weapon: number) {
    // Do nothing
  }

  useWeapon(entity: number): number {
    // Do nothing
  }

  useChip(chip: number, entity: number): number {
    // [...]
  }
}
```

In the example above, we have two classes `Leek` and `Bulb` that implement `CanUseChipAndWeapon`. However, `Bulb` cannot use weapons but is forced to implement both `setWeapon` and `useWeapon`.

To fix this, we should split the interface into two smaller ones.

```ts
interface CanUseChip {
  useChip(chip: number, entity: number): number;
}

interface CanUseWeapon {
  setWeapon(weapon: number): void;
  useWeapon(entity: number): number;
}

class Leek implements CanUseChip, CanUseWeapon {
  setWeapon(weapon: number) {
    // [...]
  }

  useWeapon(entity: number): number {
    // [...]
  }
  useChip(chip: number, entity: number): number {
    // [...]
  }
}

class Bulb implements CanUseChip {
  useChip(chip: number, entity: number): number {
    // [...]
  }
}
```

This separation allows modules to be independent of each other and makes the code easier to read and refactor.

## Dependency Inversion Principle

As mentioned earlier, the Dependency Inversion Principle is closely related to the Open-Closed Principle. In fact, it is this principle that makes the Open-Closed Principle possible.

The Dependency Inversion Principle states:

- High-level modules should not depend on low-level modules. Both should depend on abstractions.
- Abstractions should not depend on details. Details should depend on abstractions.

To clarify, let's revisit the Open-Closed Principle code:

```ts
class LeekAI {
  private readonly moveModule = new SimpleMoveAI();
  private readonly attackModule = new SimpleAttackAI();

  public play() {
    // ...
    moveModule.move(me, Reason.Attack, enemy);
  }
}
```

Here, `LeekAI` depends on two low-level modules, so we are not respecting the Dependency Inversion Principle. To fix this, we will use the [Inversion of Control](https://en.wikipedia.org/wiki/Inversion_of_control) (IoC) principle. Let's revisit how we fixed this for the Open-Closed Principle.

```ts
class LeekAI {
  constructor(
    private readonly moveModule: MoveAI,
    private readonly attackModule: AttackAI
  ) {}

  public play() {
    // ...
    moveModule.move(me, Reason.Attack, enemy);
  }
}
```

This time, our module depends on abstractions and our implementations depend on an interface, as shown in the class diagram.

{% mermaid() %}
classDiagram
  MoveAI <|.. SimpleMoveAI
  MoveAI <|.. AdvancedMoveAI
  class MoveAI {
    <<Interface>>
    +move(leek: Leek, reason: Reason, cell: number)
  }
  class SimpleMoveAI {
    +move(leek: Leek, reason: Reason, cell: number)
  }
  class AdvancedMoveAI {
    +move(leek: Leek, reason: Reason, cell: number)
  }

  AttackAI <|.. SimpleAttackAI
  AttackAI <|.. AdvancedAttackAI
  class AttackAI {
    <<Interface>>
    +attack(leek: Leek, target: number)
  }
  class SimpleAttackAI {
    +attack(leek: Leek, target: number)
  }
  class AdvancedAttackAI {
    +attack(leek: Leek, target: number)
  }
{% end %}

Finally, to link the concrete implementations to the abstractions, we use [dependency injection](https://en.wikipedia.org/wiki/Dependency_injection) (DI).

```ts
class LeekAI {
  constructor(
    private readonly moveModule: MoveAI,
    private readonly attackModule: AttackAI
  ) {}

  public play() {
    // ...
    moveModule.move(me, Reason.Attack, enemy);
  }
}

// Elsewhere in your code
const ai = new LeekAI(new SimpleMoveAI(), new SimpleAttackAI());
ai.play();
```

## Conclusion

In this article, we explored the SOLID principles — specifically how to identify where they are not being followed and how to fix those violations. By following these guiding principles for your modules, you will have a solid foundation for assembling them into the components that make up your application.

## Bibliography

- Robert C. Martin. Agile Software Development, Principles, Patterns, and Practices. Pearson, 2002.
- Robert C. Martin. Clean Architecture: A Craftsman's Guide to Software Structure and Design. Prentice Hall, 2017.
