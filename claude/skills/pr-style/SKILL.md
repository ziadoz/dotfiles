---
name: pr-style
description: Guidelines for writing pull request titles and descriptions that match the author's established style. Use whenever writing or editing a PR title or description.
---

# PR Style Guide

Style derived from the author's pull request history across laravel/framework, laravel/scout, spatie packages, and saloonphp/saloon. The author's GitHub username is `ziadoz`.

## Title

- Short and direct. Verb-first: "Add X", "Allow X to Y", "Skip X when Y", "Fix X".
- Use backticks for method names, class names, and config keys: `withoutAfterMaking()`, `DB::transaction()`.
- For contributions to versioned open source packages (e.g. Laravel framework), prefix with the target branch in brackets: e.g. `[12.x]`. Use whatever the current active branch is for the package.
- No full stop at the end.

**Examples:**
- `[12.x] Add withoutAfterMaking() and withoutAfterCreating() factory helpers`
- `[12.x] Add backoff functionality to DB::transaction()`
- `Allow job retries and backoff to be configured`
- `Skip CSP middleware when Vite is hot reloading`
- `[12.x] Add Event::capture() method`

## Description

Write in plain prose. No markdown headers. No bullet-point lists. No "Summary" or "Test Plan" sections.

### Structure

1. One sentence stating what the PR does.
2. One or two sentences explaining why it's useful or what problem it solves.
3. A code example if the PR introduces or changes an API (use a fenced code block).
4. One sentence on backward compatibility, limitations, or tradeoffs if relevant.

Keep it to 3–5 sentences of prose plus any code example. Do not pad it out.

### Tone

- Matter-of-fact. State what the change does without over-selling it.
- Use "This PR adds..." or "This adds..." to open.
- Mention what existing behaviour is preserved where it's non-obvious.
- If there are limitations, mention them plainly.

## Commits

Commit messages use the format `wip (a short lowercase description)`.

**Examples:**
- `wip (add event capture method)`
- `wip (fix subtitle sync on mkv conversion)`
- `wip (allow backoff to be configured on scout jobs)`

Keep the description brief and lowercase. No full stop.

### What to leave out

- No "Test Plan" section.
- No "Breaking Changes" section (mention inline if relevant).
- No checklist of changes.
- Never mention Claude Code, AI assistance, or automated tooling.
- Use emojis sparingly.
- No "Co-authored-by" lines in the description (only in commits if needed).

**Examples:**

> This PR adds two helper methods to disable any existing `afterMaking()` or `afterCreating()` callbacks bound on a factory. This is useful when you need a bare model instance in a test, but callbacks are already defined in the factory's `configure()` method.

---

> This PR adds a `backoff` parameter to `DB::transaction()` that allows a delay between deadlock retry attempts.
>
> ```php
> // Wait 1,000ms between each attempt
> DB::transaction(fn () => ..., attempts: 3, backoff: 1000);
>
> // Custom backoff per attempt
> DB::transaction(fn () => ..., attempts: 3, backoff: function ($exception, $attempt, $max) {
>     return random_int(100, 250) + ($attempt * 100);
> });
> ```
>
> For non-`sqlsrv` SQL Server connections, backoff is not supported and an exception is thrown if one is configured.

---

> When using a driver like Typesense, it can end up lagging and not being ready, causing jobs to fail. This PR adds two new config options that configure `tries`, `backoff`, and `maxExceptions` on the make and remove jobs so things can catch up. Any existing job class overrides continue to work, as the code checks properties are not already set before configuring them.

---

> This PR skips applying CSP middleware if the app is in debug mode and Vite is hot reloading, as applying CSP in this context isn't useful since all asset URLs are `http://localhost:5173`.
