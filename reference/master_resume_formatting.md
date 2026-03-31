# Master Resume — Project Formatting Guide

## Recommended Document Structure

A consistent Markdown heading hierarchy gives Claude the clearest signal for parsing your resume. The following structure is recommended:

```
# Experience

## Job Title | Company, Location

**Company:** [1–3 sentences: product/domain, size signal (revenue/users/headcount/funding/Fortune rank), market position]

### Major Projects

#### Project Name
[paragraph + Tools + Details]

#### Project Name
[paragraph + Tools + Details]

### Daily Responsibilities
[plain bullets]

### [Other subsections as needed]
```

`##` identifies a role, `###` identifies a subsection type, and `####` identifies a named project. This removes ambiguity about where one project ends and another begins, and signals to Claude that `####` items are named projects rather than arbitrary sections. Claude can work with other structures, but this one requires the least inference.

The `**Company:**` line sits immediately after the `##` role header. For companies where you held multiple roles, one `**Company:**` line on the first role entry is sufficient — Claude will carry that context to subsequent roles at the same company. Claude uses this line as the source for the Rule 15 company overview lead bullet; do not fabricate facts not present here.

---

## Target Format for Named Projects

Each named project uses a three-part structure:

1. **A prose paragraph** — concise narrative covering problem, approach, and outcome
2. **A tools line** — complete list of tools and technologies used, labeled consistently
3. **A details sub-list** — exhaustive labeled bullets capturing all project specifics

---

### Example

#### Unified Offer Mapping
Unified two separate categorization systems — one for ~30,000 Google domains, one for ~5,000 Bing categories — into a single standardized taxonomy. Built an NLP pipeline using text vectorization and cosine similarity to automatically assign each Google domain to its best-matching Bing category; stored results in Snowflake via a data pipeline with S3 backup. Validated accuracy using human graders across several hundred samples, achieving an 80% accuracy rate accepted by all stakeholders. Shadowed stakeholders and conducted screenshare sessions to understand how they used the categorized data, then built a Redash SQL dashboard that automated the downstream insights they had previously been generating manually — eliminating several hours of weekly work.

**Tools:** Python, Pandas, PyTorch, Snowflake, SQL, Redash, Google Sheets, S3

**Details:**
- Business Context: two separate categorization systems (Google domains aka "offers," Bing categories) → unified into one using Bing's ~5,000 categories as foundation for ~30,000 Google domains
- Requirements: stakeholder shadowing to understand workflow/needs + screenshare walk-throughs of manual categorization process → scoped what to build.
- Tech Approach: aggregated all available DB text describing each offer/category into composite documents → vectorized → cosine similarity scoring against all category vectors → assigned best-match category per offer
- DB Design: designed relational tables in Snowflake for algorithm outputs; pipeline to write results post-processing; S3 backup/archival
- Validation: distributed random samples across multiple Google Sheets (100 per sheet) → stakeholder volunteers who had previously done this manually graded results; several hundred graded; 80% accuracy accepted by all stakeholders
- Dashboard: Redash SQL dashboard showing category-level aggregate insights — the business-critical output stakeholders had been manually categorizing to obtain; automated categorization + insights delivery
- Impact: eliminated several hours/week of manual categorization by automating a fully manual process; consistent, scalable approach with automated delivery
- Skills Applied: user research, requirements gathering, NLP, text vectorization, cosine similarity algorithms, relational DB design, pipeline dev, SQL dashboards, stakeholder collaboration, validation methodology design


---

## How Claude Uses This Format

### Named Project Internals
- **Paragraph** — primary synthesis source. Claude reads this to understand what the project is and generates tailored resume bullets from it.
- **Tools line** — metadata. Claude scans this for keyword matching against the JD; tools mentioned here are available to surface in bullets even if not in the paragraph.
- **Details sub-list** — reference material. Claude consults this when a JD emphasizes something specific (e.g., a particular method, stakeholder process, or validation approach) that warrants surfacing. It is never enumerated directly into output bullets.

### Role-Level Retrieval Hierarchy

Each subsection type serves a different retrieval depth:

- **Prose paragraph (project)** — fast orientation layer. Claude reads this first to assess whether a project is relevant to the JD. If only one thing gets read, it's this.
- **Details bullets** — precision layer. Claude consults these when the JD calls for something specific enough that the prose summary alone wouldn't surface it (a particular method, tool, or outcome).
- **Daily Responsibilities** — role texture layer. Captures what the job looked like day-to-day outside of named projects. Fills in the scope and routine demands of the role.
- **Flat labeled sections (Role Context, Technical Context, etc.)** — structured lookup layer. Tech stacks, tools, platforms, scale. Designed to be scanned and matched against JD requirements without parsing prose.

---

## The Three Beats (Paragraph)

Write the paragraph in this order:

1. **Context/problem** — what situation or need prompted the work
2. **What you did** — scope, approach, key methods (include technical terms where real)
3. **Outcome** — what changed as a result, ideally quantified

## Writing Guidelines

- **Paragraph length:** 3-5 sentences. Small or straightforward projects can be 2 sentences.
- **Metrics:** Put the outcome/metric at or near the end of the paragraph where it's easy to pull into a resume bullet.
- **Tools:** The paragraph should mention the most contextually relevant tools; the tools line captures the complete inventory.
- **Project name:** Use a `####` heading (see Recommended Document Structure). This unambiguously marks the start of a new project and groups all three parts as a single unit.
- **Consistent labels:** Use `**Tools:**` and `**Details:**` across all projects so Claude can reliably identify each part.
- **Details depth:** The details sub-list can be as exhaustive as needed — it's reference material, not prose, so readability is not a concern.
- **Details format:** Write Details bullets as terse phrases or fragments, not full sentences. Fragments read as reference material; full sentences read as content to synthesize, which works against the paragraph-first intent.

## What Stays as Bullets

Routine responsibilities not tied to a specific named project can remain as plain bullets under the role. These are already atomic and don't have the decomposition problem:

- "Maintained weekly reporting for X stakeholders"
- "Responded to ad hoc data requests from the revenue team"
- "Onboarded and mentored 2 junior analysts"
