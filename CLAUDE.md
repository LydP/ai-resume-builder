# Project Instructions

## Master Resume Structure

The master resume is structured for Claude's parsing — it is reference material, not a submittable document. Full formatting spec: `reference/master_resume_formatting.md`.

When reading the master resume, interpret each section type as follows:
- **Named projects (`####` headings):** Three-part format — prose paragraph (primary synthesis source; generate bullets from this), `**Tools:**` line (keyword metadata; scan for JD matching), `**Details:**` sub-list (reference only; consult when the JD calls for something specific; never enumerate directly into output bullets)
- **Daily Responsibilities:** Captures routine work not tied to named projects; synthesize as-needed based on JD relevance — fills in role scope and day-to-day demands that projects don't cover
- **Flat labeled sections (Role Context, Technical Context, etc.):** Structured lookup; scan for keywords, tools, platforms, scale

## Progress Tracking

After every change, ask the user if they want to update the progress tracking files before moving on:
- `reference/changelog.md` — full numbered history of every change (append new entry)
- `reference/status.md` — lean working summary; update Next Steps and Key Decisions as needed

After every `/tailor-resume` session, also ask the user if they want to update:
- `reference/skill_gaps.md` — tally of skills/experience absent or weak in the master resume; increment counts for any gaps surfaced in the Unaddressed JD Requirements section of the report. If the file does not exist, create it using this exact format:

```markdown
# Skill Gaps Reference

Tracks skills and experience absent or weak in the master resume, tallied across job applications.

---

## Hard Skills (Tools & Technologies)

| Skill | Appearances |
|-------|-------------|

---

## Domain & Soft Skills

| Gap | Appearances |
|-----|-------------|
```

## graphify

This project has a knowledge graph at graphify-out/ with god nodes, community structure, and cross-file relationships.

Rules:
- For codebase questions, first run `graphify query "<question>"` when graphify-out/graph.json exists. Use `graphify path "<A>" "<B>"` for relationships and `graphify explain "<concept>"` for focused concepts. These return a scoped subgraph, usually much smaller than GRAPH_REPORT.md or raw grep output.
- If graphify-out/wiki/index.md exists, use it for broad navigation instead of raw source browsing.
- Read graphify-out/GRAPH_REPORT.md only for broad architecture review or when query/path/explain do not surface enough context.
- After modifying code, run `graphify update .` to keep the graph current (AST-only, no API cost).
