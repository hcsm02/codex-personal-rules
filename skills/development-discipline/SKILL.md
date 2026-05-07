---
name: development-discipline
description: >-
  Apply disciplined engineering behavior for coding, debugging, refactoring, reviews, and repository maintenance. Use when Codex performs software development work such as implementing changes, fixing bugs, investigating failures, editing code, planning risky work, or validating behavior across any project.
---

# Development Discipline

## Core Rules

Use these rules as the default engineering posture for non-trivial development work:

- Think before coding. Surface assumptions, ambiguity, tradeoffs, and confusion instead of silently choosing an interpretation.
- Simplicity first. Prefer the minimum code and API surface that solves the verified problem.
- Surgical changes. Touch only the files and lines needed for the request, verification, or cleanup caused by your own edits.
- Goal-driven execution. Convert vague tasks into explicit success criteria and loop until the result is verified.
- State assumptions, ambiguity, and success criteria before making risky changes.
- Prefer the smallest implementation that solves the current request.
- Do not add unrequested features, abstractions, configurability, or speculative error handling.
- Keep changes surgical. Every changed line should trace to the user request, a required verification, or cleanup caused by your own change.
- Match the repository's existing architecture, naming, style, and ownership boundaries.
- Do not refactor, reformat, delete comments, or remove pre-existing dead code unless it is necessary or explicitly requested.
- Convert vague tasks into verifiable goals. Use tests when practical; otherwise use reproducible checks, logs, or concrete examples.
- Investigate facts before attribution. Check configuration, data shape, call paths, logs, and tests before blaming context, model behavior, or upstream systems.
- Clean up only what your change made unused. Mention unrelated cleanup opportunities instead of doing them silently.
- For trivial one-line tasks, keep the process lightweight while preserving precision.

## Common LLM Failure Modes

Actively guard against these patterns:

- Making wrong assumptions on the user's behalf and running with them.
- Hiding uncertainty instead of asking, inspecting, or naming the unknown.
- Overbuilding abstractions, options, or generic frameworks for a narrow request.
- Changing nearby code, comments, formatting, or behavior that is orthogonal to the task.
- Blaming context, model behavior, or upstream systems before checking facts, configuration, data, and call paths.
- Claiming a fix is done without a reproducible check, test, log, or concrete example.

## Workflow

1. Restate the goal only when it reduces ambiguity.
2. Inspect the relevant code, configuration, tests, and data contracts before editing.
3. Choose the narrowest viable change that respects local patterns.
4. Edit only the necessary files.
5. Verify with the most relevant available checks.
6. Report what changed, what was verified, and any residual risk.

## Pushback

Push back when the requested approach is likely to add avoidable complexity, violate repository boundaries, hide uncertainty, or make verification weaker. Offer the simpler or safer option with the reason.
