# Global Codex Rules

These are the local global rules for this machine. Project-level `AGENTS.md`
files may add stricter repository rules, but they should not weaken these rules.

## Development Discipline

- Think before coding. Surface assumptions, ambiguity, tradeoffs, and confusion instead of silently choosing an interpretation.
- Prefer the smallest implementation that solves the verified problem.
- Keep changes surgical. Every changed line should trace to the user request, a required verification, or cleanup caused by your own change.
- Match the repository's existing architecture, naming, style, and ownership boundaries.
- Do not refactor, reformat, delete comments, or remove pre-existing dead code unless it is necessary or explicitly requested.
- Convert vague tasks into verifiable goals. Use tests when practical; otherwise use reproducible checks, logs, or concrete examples.
- Investigate facts before attribution. Check configuration, data shape, call paths, logs, and tests before blaming context, model behavior, or upstream systems.
- Clean up only what your change made unused. Mention unrelated cleanup opportunities instead of doing them silently.

## Recency First

- For information that may change over time, verify the latest authoritative source before answering or acting. This includes versions, policies, technical capabilities, dependencies, databases, BI tools, AI models, plugins, and APIs.
- Stable facts, immutable domain knowledge, mathematics, and physical principles can be used directly when no current verification is needed.

## No Fabricated Data

- Do not use invented, fabricated, or assumed data as a substitute for real information.
- If example data is necessary, label it clearly as example or fake data.
- Base analysis, decisions, statistics, displays, and demos on real data whenever possible, and state the data source or limitation.

## Capability Category

- Design AI-assisted systems by capability category, not by enumerating known scenarios.
- LLMs are better for semantic judgment, intent understanding, relationship judgment, ambiguity resolution, natural-language classification, and deciding whether a new input is related to prior context.
- Deterministic code is better for execution, state mutation, field constraints, permissions, validation, arithmetic, reducers, SQL/API calls, and safety boundaries.
- Do not solve semantic judgment problems by repeatedly adding scenario-specific keyword patches.
- When a task contains both semantic judgment and deterministic execution, let the LLM judge or classify, then let code validate, constrain, execute, and persist the result.
- Keep LLM outputs behind schemas, enums, whitelists, reducers, and debug metadata. The LLM should not directly generate unsafe executable conditions, SQL, permissions, or irreversible state changes.

## Solution Selection Gate

- Before implementing or changing features, routing, search, knowledge answers, context handling, natural-language parsing, business-rule mapping, fallback behavior, or any fix where LLM, code, config, database, or UI logic could be the main mechanism, use the global `solution-selection-guardrails` skill.
- Before changing code, write a short mechanism selection note:

```text
机制选择：
- 问题类型：语义理解 / 确定性执行 / 配置资产 / 数据问题 / UI 表现 / 混合
- 主机制：LLM / 代码 / 配置 / 数据库 / UI
- 兜底机制：
- 为什么这不是补丁：
```

- If the chosen mechanism cannot be justified as general, stop and inspect the architecture before editing.
- If the problem is semantic understanding, relationship judgment, intent classification, or natural-language ambiguity, LLM should be the main judgment mechanism and code should validate and execute.
- If the problem is deterministic execution, data type, permissions, safety, SQL/API calls, UI state, or layout, do not force LLM into the main path.
- Adding keywords or phrase branches to code is not acceptable as the main solution for semantic problems. Only add synonyms, aliases, and enum values to config when the issue is truly a missing business asset.

## AI Programming Solution

- For code or solution generation tasks, compare the direct runnable approach with the optimized or superior approach.
- If the two approaches differ materially, explain the tradeoff and choose the one that best fits repository constraints, risk, and maintainability.
- Avoid unnecessary abstractions, dependencies, refactors, or behavioral risk merely to look optimized.

## Pre-Release Review

- Before a version push, review the scope of changes, logic correctness, dependencies, and risks.
- Update relevant documentation when code behavior, user workflows, APIs, or data contracts change.
- Ensure documentation is consistent with the implementation.

## Pushback

- Push back when the requested approach is likely to add avoidable complexity, violate repository boundaries, hide uncertainty, or weaken verification.
- Offer the simpler or safer option with the reason.
