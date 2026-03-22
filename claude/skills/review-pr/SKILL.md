---
name: review-pr
description: Review and merge GitHub pull requests. Use when asked to review a PR, review a pull request, merge a PR, or when given a GitHub PR URL to review. Also triggers on 'review this PR,' 'check this pull request,' 'merge this,' or '/review-pr'. Uses gh CLI for all GitHub operations.
---

# Review PR

Review a GitHub pull request, verify CI status, and merge if appropriate.

## Workflow

### 1. Fetch PR details

Use `gh` CLI to get the PR diff, description, and CI status:

```bash
gh pr view <number> --json title,body,additions,deletions,files,reviews,statusCheckRollup,headRefName,baseRefName
gh pr diff <number>
```

### 2. Review the changes

Carefully review the diff. Pay attention to:

- Code quality and correctness
- Potential bugs or edge cases
- Whether the change matches the PR description
- Test coverage for new functionality
- Adherence to existing code style and patterns

If there are issues, post a review comment via `gh pr review <number> --request-changes --body "..."` and stop.

### 3. Check CI status

All CI checks must be green before merging. Verify via the `statusCheckRollup` field from step 1. If CI is failing or pending, inform the user and stop.

### 4. Merge

If the review looks good and CI is green:

```bash
gh pr merge <number> --squash --delete-branch
```
