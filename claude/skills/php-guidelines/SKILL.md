---
name: php-guidelines
description: Describes PHP and Laravel guidelines provided by Spatie. These rules result in more maintainable, and readable code.
license: MIT
metadata:
   author: Spatie
   tags: php, laravel, best practices, coding standards
---

## Core Laravel Principle

**Follow Laravel conventions first.** If Laravel has a documented way to do something, use it. Only deviate when you have a clear justification.

For a reference implementation of these strictness principles applied to a real Laravel app, see [nunomaduro/essentials](https://github.com/nunomaduro/essentials).

## Strictness

### PHP

- Always add `declare(strict_types=1)` at the top of every PHP file:
  ```php
  <?php

  declare(strict_types=1);
  ```
- Every new project must have [Pint](https://laravel.com/docs/pint) (or PHP CS Fixer in non-Laravel projects) configured and enforced in CI.
- Use the [pint-strict-preset](https://github.com/nunomaduro/pint-strict-preset) as the baseline `pint.json`. Copy it into the project root as-is. For PHP CS Fixer, translate the same rules into `.php-cs-fixer.php` — the rule names are identical as Pint is built on top of PHP CS Fixer.

  ```json
  {
      "preset": "laravel",
      "rules": {
          "array_push": true,
          "backtick_to_shell_exec": true,
          "date_time_immutable": true,
          "declare_strict_types": true,
          "lowercase_keywords": true,
          "lowercase_static_reference": true,
          "final_class": true,
          "final_internal_class": true,
          "final_public_method_for_abstract_class": true,
          "fully_qualified_strict_types": true,
          "global_namespace_import": {
              "import_classes": true,
              "import_constants": true,
              "import_functions": true
          },
          "mb_str_functions": true,
          "modernize_types_casting": true,
          "new_with_parentheses": false,
          "no_superfluous_elseif": true,
          "no_useless_else": true,
          "no_multiple_statements_per_line": true,
          "ordered_class_elements": {
              "order": [
                  "use_trait",
                  "case",
                  "constant",
                  "constant_public",
                  "constant_protected",
                  "constant_private",
                  "property_public",
                  "property_protected",
                  "property_private",
                  "construct",
                  "destruct",
                  "magic",
                  "phpunit",
                  "method_abstract",
                  "method_public_static",
                  "method_public",
                  "method_protected_static",
                  "method_protected",
                  "method_private_static",
                  "method_private"
              ],
              "sort_algorithm": "none"
          },
          "ordered_interfaces": true,
          "ordered_traits": true,
          "protected_to_private": true,
          "self_accessor": true,
          "self_static_accessor": true,
          "strict_comparison": true,
          "visibility_required": true
      }
  }
  ```

  Key rules this enforces:
  - `declare_strict_types` — auto-adds `declare(strict_types=1)` to every file
  - `final_class` — all classes are `final` by default, preventing unintended inheritance
  - `global_namespace_import` — enforces `use` imports for classes, constants, and functions; no inline fully qualified names
  - `strict_comparison` — enforces `===` and `!==` over `==` and `!=`
  - `no_useless_else` / `no_superfluous_elseif` — removes redundant else branches after returns
  - `ordered_class_elements` — consistent class member ordering (traits, constants, properties, constructor, methods)
  - `protected_to_private` — tightens visibility to `private` where `protected` is unnecessary
  - `mb_str_functions` — replaces `strlen`, `strpos` etc. with their `mb_` equivalents
  - `date_time_immutable` — enforces `DateTimeImmutable` over mutable `DateTime`
- Every new project must have [PHPStan](https://phpstan.org) configured. Aim for level 8 or above. Add a `phpstan.neon` to the project root.
- Tests must be written using [Pest](https://pestphp.com) (preferred) or PHPUnit. Every new feature or bug fix should include tests.

### Laravel

Enable the following in `AppServiceProvider::boot()` for all environments unless there is a specific reason not to:

```php
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;
use Carbon\CarbonImmutable;
use Illuminate\Support\Facades\Date;

// Strict model behaviour: throws on accessing undefined attributes,
// lazy loading, and silently discarded fills on non-fillable attributes
Model::shouldBeStrict();

// Automatically eager load relationships defined in $with
Model::automaticallyEagerLoadRelationships();

// Use immutable dates throughout the app (prevents accidental mutation)
Date::use(CarbonImmutable::class);

// Prevent destructive Artisan commands (migrate:fresh, db:wipe etc.) in production
DB::prohibitDestructiveCommands(app()->isProduction());
```

In tests, also enable:

```php
// Fail the test if any HTTP request is made without an explicit fake
Http::preventStrayRequests();

// Prevent actual sleep() calls slowing down the test suite
Sleep::fake();
```

**Why each matters:**

- `Model::shouldBeStrict()` — catches typos in attribute names, prevents n+1 queries from lazy loading, and surfaces mass-assignment issues at call time rather than silently ignoring them
- `Model::automaticallyEagerLoadRelationships()` — ensures relationships declared in `$with` are always loaded, avoiding accidental n+1 queries when `$with` is defined but not respected
- `CarbonImmutable` — mutable Carbon instances can cause subtle bugs when a date is passed to a function and modified in place; immutable instances are always safe to share
- `DB::prohibitDestructiveCommands()` — prevents accidental data loss from running the wrong Artisan command on production
- `Http::preventStrayRequests()` — makes tests reliable and explicit; any HTTP call that isn't faked will throw, surfacing missing fakes immediately
- `Sleep::fake()` — keeps the test suite fast; real sleeps in tests are almost never intentional

## PHP Standards

- Follow PSR-1, PSR-2, and PSR-12
- Use camelCase for non-public-facing strings
- Use short nullable notation: `?string` not `string|null`
- Always specify `void` return types when methods return nothing

## Class Structure
- Use typed properties, not docblocks:
- Constructor property promotion when all properties can be promoted:
- One trait per line:

## Type Declarations & Docblocks
- Use typed properties over docblocks
- Specify return types including `void`
- Use short nullable syntax: `?Type` not `Type|null`
- Document iterables with generics:
  ```php
  /** @return Collection<int, User> */
  public function getUsers(): Collection
  ```

### Docblock Rules
- Don't use docblocks for fully type-hinted methods (unless description needed)
- **Always import classnames in docblocks** - never use fully qualified names:
  ```php
  use \Spatie\Url\Url;
  /** @return Url */
  ```
- Use one-line docblocks when possible: `/** @var string */`
- Most common type should be first in multi-type docblocks:
  ```php
  /** @var Collection|SomeWeirdVendor\Collection */
  ```
- If one parameter needs docblock, add docblocks for all parameters
- For iterables, always specify key and value types:
  ```php
  /**
   * @param array<int, MyObject> $myArray
   * @param int $typedArgument
   */
  function someFunction(array $myArray, int $typedArgument) {}
  ```
- Use `list<Type>` when the array is a plain sequential list and the keys are irrelevant — i.e. you only care about the values:
  ```php
  /** @return list<User> */
  public function getUsers(): array {}
  ```
- Use `array<TKey, TValue>` when the key is meaningful and you need to express both types:
  ```php
  /** @return array<string, Permission> */   // keyed by permission name
  public function getPermissions(): array {}

  /** @return array<int, User> */            // keyed by user ID
  public function getUsersById(): array {}
  ```
- The rule of thumb: if you'd iterate with `foreach ($items as $item)` and ignore the key, use `list<T>`. If you'd use `foreach ($items as $key => $value)` and the key matters, use `array<TKey, TValue>`.
- Use array shape notation for fixed keys, put each key on its own line:
  ```php
  /** @return array{
     first: SomeClass,
     second: SomeClass
  } */
  ```

## Control Flow
- **Happy path last**: Handle error conditions first, success case last
- **Avoid else**: Use early returns instead of nested conditions
- **Compound conditions**: Prefer compound `if` statements using `&&` over nested `if` statements
- **Always use curly brackets** even for single statements
- **Ternary operators**: Each part on own line unless very short

```php
// Happy path last
if (! $user) {
    return null;
}

if (! $user->isActive()) {
    return null;
}

// Process active user...

// Short ternary
$name = $isFoo ? 'foo' : 'bar';

// Multi-line ternary
$result = $object instanceof Model 
    ? $object->name 
    : 'A default value';

// Ternary instead of else
$condition
    ? $this->doSomething()
    : $this->doSomethingElse();

// Good: compound condition with &&
if ($user->isActive() && $user->hasPermission('edit')) {
    $user->edit();
}

// Bad: nested ifs
if ($user->isActive()) {
    if ($user->hasPermission('edit')) {
        $user->edit();
    }
}
```

## Laravel Conventions

### Eloquent Queries

- Always start queries with `::query()` rather than calling query methods directly on the model. This makes the intent explicit and plays better with static analysis:

  ```php
  // Bad
  User::where('active', true)->get();

  // Good
  User::query()->where('active', true)->get();
  ```

- Always include the operator argument in `where()` calls, even when it is `=`. This makes conditions easier to scan and modify:

  ```php
  // Bad
  User::query()->where('active', true)->get();

  // Good
  User::query()->where('active', '=', true)->get();
  User::query()->where('age', '>=', 18)->get();
  User::query()->where('name', 'like', 'Jamie%')->get();
  ```

### Routes
- URLs: kebab-case (`/open-source`)
- Route names: camelCase (`->name('openSource')`)
- Parameters: camelCase (`{userId}`)
- Use tuple notation: `[Controller::class, 'method']`

### Controllers
- Plural resource names (`PostsController`)
- Stick to CRUD methods (`index`, `create`, `store`, `show`, `edit`, `update`, `destroy`)
- Extract new controllers for non-CRUD actions

### Configuration
- Files: kebab-case (`pdf-generator.php`)
- Keys: snake_case (`chrome_path`)
- Add service configs to `config/services.php`, don't create new files
- Use `config()` helper, avoid `env()` outside config files

### Artisan Commands
- Names: kebab-case (`delete-old-records`)
- Always provide feedback (`$this->comment('All ok!')`)
- Show progress for loops, summary at end
- Put output BEFORE processing item (easier debugging):
  ```php
  $items->each(function(Item $item) {
      $this->info("Processing item id `{$item->id}`...");
      $this->processItem($item);
  });

  $this->comment("Processed {$items->count()} items.");
  ```

## Strings & Formatting

- Prefer string interpolation over concatenation:

```php
// Bad
$greeting = 'Hello ' . $name . ', you have ' . $count . ' messages.';

// Good
$greeting = "Hello {$name}, you have {$count} messages.";
```

- Use double quotes when the string contains a variable, single quotes otherwise:

```php
$plain = 'No variables here';
$interpolated = "Hello {$name}";
```

- Wrap complex expressions in braces:

```php
$label = "Status: {$order->status->label()}";
```

## Enums

- Use PascalCase for enum values, no prefix or suffix:

```php
// Bad
enum OrderStatus {
    case STATUS_PENDING;
    case StatusProcessing;
}

// Good
enum OrderStatus {
    case Pending;
    case Processing;
    case Shipped;
    case Delivered;
    case Cancelled;
}
```

- Backed enums should use lowercase string values:

```php
enum OrderStatus: string {
    case Pending = 'pending';
    case Processing = 'processing';
    case Shipped = 'shipped';
}
```

- Use enums instead of class constants for finite sets of values.

## Comments

Be very critical about adding comments as they often become outdated and can mislead over time. Code should be self-documenting through descriptive variable and function names.

Adding comments should never be the first tactic to make code readable.

*Instead of this:*
```php
// Get the failed checks for this site
$checks = $site->checks()->where('status', 'failed')->get();
```

*Do this:*
```php
$failedChecks = $site->checks()->where('status', 'failed')->get();
```

**Guidelines:**
- Don't add comments that describe what the code does — make the code describe itself
- Short, readable code doesn't need comments explaining it
- Use descriptive variable names instead of generic names + comments
- Only add comments when explaining *why* something non-obvious is done, not *what* is being done
- Never add comments to tests — test names should be descriptive enough

## Whitespace

- Add blank lines between statements for readability
- Exception: sequences of equivalent single-line operations
- No extra empty lines between `{}` brackets
- Let code "breathe" — avoid cramped formatting

## Validation

- Use array notation for multiple rules (easier for custom rule classes):
  ```php
  public function rules() {
      return [
          'email' => ['required', 'email'],
      ];
  }
  ```
- Custom validation rules use snake_case

## Blade Templates

- Indent with 4 spaces
- No spaces after control structures:
  ```blade
  @if($condition)
      Something
  @endif
  ```

## Authorization

- Policies use camelCase: `Gate::define('editPost', ...)`
- Use CRUD words, but `view` instead of `show`

## Translations

- Use `__()` function over `@lang`

## API Routing

- Use plural resource names: `/errors`
- Use kebab-case: `/error-occurrences`
- Limit deep nesting for simplicity

## Testing

- Use Pest (preferred) or PHPUnit
- Keep test classes in the same file when possible
- Use descriptive test method names
- Follow the arrange-act-assert pattern
- Always call `Http::preventStrayRequests()` and `Sleep::fake()` in the base test case or test setup
- Every new feature and bug fix must have test coverage

## Quick Reference

### Naming Conventions
- **Classes**: PascalCase (`UserController`, `OrderStatus`)
- **Methods/Variables**: camelCase (`getUserName`, `$firstName`)
- **Routes**: kebab-case (`/open-source`, `/user-profile`)
- **Config files**: kebab-case (`pdf-generator.php`)
- **Config keys**: snake_case (`chrome_path`)
- **Artisan commands**: kebab-case (`php artisan delete-old-records`)

### File Structure
- Controllers: plural resource name + `Controller` (`PostsController`)
- Views: camelCase (`openSource.blade.php`)
- Jobs: action-based (`CreateUser`, `SendEmailNotification`)
- Events: tense-based (`UserRegistering`, `UserRegistered`)
- Listeners: action + `Listener` suffix (`SendInvitationMailListener`)
- Commands: action + `Command` suffix (`PublishScheduledPostsCommand`)
- Mailables: purpose + `Mail` suffix (`AccountActivatedMail`)
- Resources/Transformers: plural + `Resource`/`Transformer` (`UsersResource`)
- Enums: descriptive name, no prefix (`OrderStatus`, `BookingType`)

### Migrations
- Only write `up()` methods in migrations, never `down()`

### Code Quality Reminders
- Always declare `declare(strict_types=1)` at the top of every file
- Use typed properties over docblocks
- Prefer early returns over nested if/else
- Use constructor property promotion when all properties can be promoted
- Avoid `else` statements when possible
- Prefer compound `if` conditions using `&&` over nested `if` statements
- Use string interpolation over concatenation
- Always use curly braces for control structures
- Always import namespaces with `use` statements — never use inline fully qualified class names
- Never use single-letter variable names — use descriptive names (e.g. `$exception` not `$e`)
- Enable `Model::shouldBeStrict()` and `Model::automaticallyEagerLoadRelationships()` in `AppServiceProvider`
- Use `CarbonImmutable` for dates
- Enforce Pint and PHPStan (level 8+) in CI
