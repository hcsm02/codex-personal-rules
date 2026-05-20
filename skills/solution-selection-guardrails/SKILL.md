---
name: solution-selection-guardrails
description: >-
  Use before implementing or changing features, routing, search, knowledge answers,
  context handling, natural-language parsing, business-rule mapping, fallback behavior,
  or any fix where LLM, code, config, database, or UI logic could be the main mechanism.
  Forces mechanism selection so semantic problems use LLM judgement and deterministic
  problems use code/config/database execution.
---

# Solution Selection Guardrails

Use this skill before editing files when the task involves implementation choices, especially natural-language understanding, intent routing, context relation, search-condition extraction, knowledge-answer boundaries, business-rule mapping, fallback behavior, or repeated bug classes.

## Required Gate

Before changing code, write a short mechanism selection note in the working update:

```text
机制选择：
- 问题类型：语义理解 / 确定性执行 / 配置资产 / 数据问题 / UI 表现 / 混合
- 主机制：LLM / 代码 / 配置 / 数据库 / UI
- 兜底机制：
- 为什么这不是补丁：
```

If you cannot justify why the chosen mechanism is general, stop and inspect the architecture before editing.

## Selection Rules

- Use LLM as the main mechanism for semantic understanding: intent, relation to previous context, ambiguity, topic switch, natural-language classification, and whether a phrase is asking for one value or all values.
- Use code as the main mechanism for deterministic execution: reducers, state writes, field allowlists, schema validation, conflict resolution, SQL/API calls, permissions, arithmetic, sorting, and stable transformations.
- Use config as the main mechanism for business assets: field aliases, synonyms, enum values, standard tags, dimension mappings, and display names.
- Use database inspection as the main mechanism for data-shape problems: missing rows, null/empty semantics, numeric/string types, joins, and indexes.
- Use UI logic as the main mechanism for presentation and interaction state: copy feedback, modals, layout, loading, text wrapping, and client-side API base paths.

## Anti-Patch Test

Treat a change as a likely patch if any of these are true:

- It adds a keyword or phrase to code to fix one reported sentence.
- It creates a new branch for a case that is really part of an existing capability category.
- It makes a semantic decision without consulting the LLM or an existing LLM classifier/judge.
- It makes LLM output directly executable without schema, allowlist, or reducer validation.
- The test only proves one wording and does not assert the semantic contract.

When a patch is detected, replace it with one of:

- a structured LLM judge/classifier plus code validation;
- a config asset addition if the issue is only a missing business synonym or enum;
- a deterministic code mechanism if the issue is execution, not understanding.

## Implementation Workflow

1. Classify the capability category.
2. Identify the current main mechanism and whether it is the right one.
3. If semantics are involved, prefer a structured LLM decision with a small schema.
4. Keep execution in code: validate fields, merge state, build plans, and persist debug metadata.
5. Add tests for the semantic contract, not just the reported wording.
6. Run the narrowest relevant tests; expand if the touched mechanism is shared.
