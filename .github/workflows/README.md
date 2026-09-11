# Shared workflows

Reusable workflows, called by the other repos rather than copied into them.

## `claude-code-review.yml`

Posts a three-axis Claude review as anchored line comments on a PR — the first
step of the `review` → `review-triage` → `review-fix` flow, whose skills live in
[bharper77/dotfiles](https://github.com/BHarper77/dotfiles) under
`.agents/skills`.

**In the calling repo**, add `.github/workflows/claude-code-review.yml`:

```yaml
name: Claude Code Review

on:
  pull_request:
    types: [opened, synchronize, ready_for_review, reopened]

jobs:
  review:
    uses: bharper77/devops-core/.github/workflows/claude-code-review.yml@main
    secrets:
      claude_code_oauth_token: ${{ secrets.CLAUDE_CODE_OAUTH_TOKEN }}
```

Then, in that repo:

- `brady skills add review` — the job runs `/review`, which resolves to
  `.claude/skills/review`. Without it the job has nothing to enter.
- Set the `CLAUDE_CODE_OAUTH_TOKEN` secret.

Inputs, all optional: `model` (default `claude-opus-5`), `fixed_point`
(default: the PR base branch), `runs_on`, `show_full_output`.

To narrow when it runs — paths, PR author — put that on the caller's
`on:`/`if:`, not here.

### Pinning

`@main` means callers pick up changes immediately, which is the point of keeping
one copy. Pin a caller to a tag or sha if you want it to hold still.

### Two halves of one contract

The workflow's `--allowedTools` list has to cover what the skill's steps actually
call — `TaskOutput` above all, which is what makes the review post rather than
exit green having posted nothing. The skill lives in dotfiles and the workflow
lives here, so changing either half means checking the other.
