# Modification Progress

## What We're Doing
Building a modified version of the Resume Builder in this `modifications/` folder, mirroring the original folder structure. The original project is left untouched. Changes are being made incrementally, command by command, starting with `/setup`.

## Note on File Paths
This changelog was written while the project lived in a `modifications/` sub-directory of the original project. All path references (e.g. `modifications/.claude/`, `modifications/reference/`) should be read as relative to the project root of this directory.

---

## Changes Made So Far

### 1. Virtual Environment (affects all downstream commands)
- Setup no longer checks if Python is installed — that's the user's responsibility
- Setup asks the user for their venv folder name (e.g. `.venv`, `venv`, `env`)
- The venv name is stored in `config.json` as `"venv_name"`
- **All subsequent Python script calls in other commands must use the venv's Python/pip**, not the global one:
  - Windows: `{venv_name}\Scripts\python` / `{venv_name}\Scripts\pip`
  - Mac/Linux: `{venv_name}/bin/python` / `{venv_name}/bin/pip`

### 2. Dependencies (`requirements.txt`)
- Removed `stripe>=7.0.0` — Pro cloud account billing removed
- Removed `PyJWT>=2.8.0` — Pro cloud account auth removed
- All other packages retained

### 3. Config (`config.json` / `config.example.json`)
Two new fields added to `config.json`:
- `"venv_name"` — user-supplied venv folder name (set during setup Step 1)
- `"generate_score_prompt"` — boolean, set during setup Step 4 (default: false)

Any command that reads `config.json` should be aware of these new fields.

### 4. Pro Cloud Account — REMOVED
- Removed entirely from setup
- No `SCORER_CLOUD_URL` or `SCORER_CLOUD_API_KEY` in `.env`
- No references to `rb_...` API keys
- The scorer server (`fastapi`, `fastmcp`) and local scoring are still intact

### 5. LLM Scorer — REPLACED with Manual Prompt File
- The original Step 4 asked for an Anthropic API key to enable `llm_scorer.py`
- This has been replaced: if `"generate_score_prompt": true` in `config.json`, the resume building step should generate a `Score_Prompt.txt` file in the application's output folder
- The prompt template is saved at: `reference/llm_score_prompt.txt`
- Placeholders in the template: `{jd_text}`, `{resume_text}`, `{domain_context}`
- The user pastes this file's contents into Claude.ai manually — no API key needed
- `llm_scorer.py` itself has NOT been copied/modified yet — decide whether to keep, trim, or drop it when reaching the resume building step

### 6. `/tailor-resume` — Phase 0 (Scorer Server Pre-flight)
- Added venv config block at the top of Phase 0: reads `venv_name` from `config.json`, constructs `{venv_python}` (platform-aware)
- Server start command changed: `python scorer_server.py` → `{venv_python} scorer_server.py`
- CLI fallback changed: `python ats_scorer.py` → `{venv_python} ats_scorer.py`
- `{venv_python}` label introduced here for use throughout the rest of the command

### 7. Python files copied to `modifications/`
- `scorer_server.py` — copied as-is; Pro cloud references deferred (aspirational goal)
- `ats_scorer.py` — copied as-is; no changes needed
- `hr_scorer.py` — copied as-is; no changes needed
- These are the only files `scorer_server.py` needs at startup for Phase 0 to work

### 8. `/tailor-resume` — Phase 0.5 (Job Fit Pre-check)
- No changes needed to the command itself — logic is identical to original
- `job_fit_scorer.py` copied to `modifications/` as-is (depends on `ats_scorer.py` and `hr_scorer.py`, both already present)
- Pro cloud auth in `scorer_server.py` is not a concern for local use — anonymous access fallback handles it

### 9. `/tailor-resume` — Phase 1 (Parallel Research)
- Action A: Changed `python` → `{venv_python}` in the DOCX one-liner for reading prior tailored resumes
- Action B: No changes needed
- Action C: Removed Claude-inferred company/job title parsing; user is now prompted to supply both values explicitly before the parallel block launches (company/job title sometimes not explicitly stated in JD)

### 10. `/tailor-resume` — Phase 2 (Background Base Scoring + Resume Writing)
- Fallback `python` calls changed to `{venv_python}` for both `ats_scorer.py` and `hr_scorer.py`
- Implemented `Score_Prompt.txt` generation: if `generate_score_prompt: true` in `config.json`, after `resume.md` is saved, Claude reads `reference/llm_score_prompt.txt`, fills in `{jd_text}`, `{resume_text}`, and `{domain_context}` (1-2 sentence domain note inferred from JD), and saves the result as `applications/{folder}/Score_Prompt.txt`
- `llm_scorer.py` decision deferred — not needed for the command to function

### 11. `/tailor-resume` — Phase 3 (Parallel Tailored Scoring)
- Primary path uses curl only — no changes needed
- Fallback clarified: replaced vague "use CLI scorers" with a cross-reference to Phase 2 fallback pattern, specifying `resume.md` as the resume path

### 12. `/tailor-resume` — Phase 4 (Score Check + Iteration)
- Fixed stale "agents C and D" reference → "agent C" (Agent D was never defined; leftover from before ATS/HR were combined into `/score/both`)
- Fixed step 3 wording: "each round = 2 parallel scoring agents" → "each round = 1 background Bash agent calling `/score/both`" (consistent with actual re-score instructions)
- No `python` calls — all re-scoring uses curl

### 13. `/tailor-resume` — Phase 5 (Parallel Finalization)
- Replaced `python` → `{venv_python}` in Agent E (DOCX creation) and Agent F (tracker update)
- Copied `docx_generator.py` and `tracker_utils.py` to `modifications/` as-is (both were in project root)
- All third-party dependencies (`python-docx`, `pandas`, `openpyxl`) already in `requirements.txt`

### 14. `/tailor-resume` — Phase 6 (Cleanup + Report)
- Replaced bare `python` → `{venv_python}` in both `--web` report commands
- Added report save step: final report written to `applications/{folder}/Report.txt` before being displayed
- Fixed bug: `resume.md` deletion moved to last step (Step 5) so ATS web report can still reference it
- Phase 6 step order is now: collect results → collect base scores → display report → offer web reports → delete temp files

### 15. `data/` folder copied to `modifications/`
- Copied as-is from project root
- Contains 12 static reference files used by the scoring engine: `acronyms.json`, `action_verbs.json`, `company_prestige.json`, `keywords_*.json` (6 domains), `onet_skills.json`, `skill_taxonomy.json`, `university_rankings.json`
- No modifications needed

### 16. `/writing-coach` — Copied
- Copied `writing-coach.md` from original `.claude/commands/` to `modifications/.claude/commands/` as-is
- No modifications needed

### 17. `modifications/CLAUDE.md` — Created
- Created `CLAUDE.md` in the `modifications/` folder
- Instructs Claude to prompt the user to update `progress.md` after every change to the `modifications/` folder

### 18. `writing-coach.md` — Rule 11 Added
- Added Rule 11 (Plain Language) after Rule 10 in the Writing Enhancement Engine
- Rule: write for a human reader first; use the simplest phrasing that accurately conveys the meaning; retain technical terms only when they appear in or are clearly implied by the JD
- Noted two existing tensions to address later: Rule 5 (Power Verb Ladder) vs. Rule 11, and Rule 3's suggestion of "Leveraged" conflicting with the anti-cliché list in tailor-resume.md

### 19. `brainstorm.md` — Created
- Created `modifications/reference/brainstorm.md` to capture reasoning and thought processes from brainstorming sessions
- Session 1 covers: Problem 1 (plain language, resolved as Rule 11), Problem 2 (project decomposition, deferred), structural debt of Rules 11-14 in tailor-resume.md

### 20. `master_resume_formatting.md` — Created
- Created `modifications/reference/master_resume_formatting.md` as the formatting guide for the master resume
- Defines a three-part project format:
  1. Prose paragraph (context → approach → outcome) — primary synthesis source for Claude
  2. `**Tools:**` line — complete keyword inventory, treated as metadata
  3. `**Details:**` sub-list — exhaustive labeled bullets, treated as reference material (never enumerated directly into output bullets)
- Uses the real Unified Offer Mapping project as the canonical example
- Explains how Claude uses each part: paragraph drives synthesis, tools drives keyword matching, details consulted only when JD calls for something specific
- Covers writing guidelines, the three beats, consistent labeling, and what stays as plain bullets

### 21. `writing-coach.md` — Rule 12 Added
- Added Rule 12 (Master Resume Source Material) after Rule 11
- Rule defines how to read the three-part project format: paragraph = primary synthesis source; Tools line = keyword metadata; Details sub-list = reference material, never enumerated directly into output bullets
- Synthesis rule: a named project produces at most 3 output bullets regardless of how many detail items exist
- Updated Integration Protocol: Rule 12 added as first step (before reading source material); Rule 11 added to per-bullet checklist (was missing); subsequent steps renumbered

### 22. Progress tracking restructured
- `progress.md` renamed to `changelog.md` (full numbered history, append-only)
- `status.md` created as lean working summary: command status, key decisions, next steps, open tensions, aspirational goals
- `modifications/CLAUDE.md` updated to reference both files and describe their distinct purposes

### 23. `writing-coach.md` — Conflict resolutions
- **Conflict 2 (Rule 3 vs. Anti-Cliché):** Removed "Leveraged" from Rule 3's replacement options for "Utilized". New replacement: `Used / Applied / Deployed`. Reason: "Leveraged" is on the forbidden verb list in tailor-resume.md Rule 11 (Anti-Cliché); suggesting it as a replacement was contradictory.
- **Conflict 1 (Rule 5 vs. Rule 11):** Added action verb exception to Rule 11 (Plain Language). Power verbs (Rule 5) are explicitly exempt — they are industry-standard resume vocabulary that signals seniority; plain language applies to sentence structure and descriptive phrases, not action verb choice. Resolution noted as provisional; user may revise later.

### 24. Problem 2 (Project Decomposition) — documented as resolved
- Updated `brainstorm.md`: marked Problem 2 as RESOLVED; added resolution section (kept all three proposed options for context); identified Option A as the closest match
- Updated `status.md`: expanded the "Master resume format" key decision to explicitly document that Rule 12's 3-bullet cap + paragraph-first synthesis resolves the decomposition problem

### 25. `master_resume_formatting.md` — Role-Level Retrieval Hierarchy Added
- Added "Role-Level Retrieval Hierarchy" subsection under "How Claude Uses This Format"
- Explains the purpose of each section type at the role level (not just named project internals):
  - Prose paragraph → fast orientation; Claude reads this first to assess project relevance
  - Details bullets → precision layer; consulted when JD calls for something specific
  - Daily Responsibilities → role texture; captures routine day-to-day work outside named projects
  - Flat labeled sections (Role Context, Technical Context, etc.) → structured lookup; scannable facts for keyword matching

### 26. `tailor-resume.md` — Master Resume Reading Guide Added to Action B
- Added "How to interpret the master resume structure" block to Phase 1, Action B (where Claude reads the master resume)
- Covers all three section types: named projects (three-part format), Daily Responsibilities (role texture, synthesize based on JD relevance), flat labeled sections (structured lookup)

### 27. `modifications/CLAUDE.md` — Master Resume Structure Section Added
- Added "Master Resume Structure" section at the top of modifications/CLAUDE.md
- Provides the same reading guide as Action B for broad coverage — loaded in every session regardless of which command is running
- Points to `modifications/reference/master_resume_formatting.md` for the full spec

### 28. `/master-resume` command — Created
- Created `modifications/.claude/commands/master-resume.md`
- Loads four files in parallel at session start: `modifications/CLAUDE.md`, `modifications/reference/master_resume_formatting.md`, `modifications/reference/status.md`, `modifications/reference/MASTER_RESUME.md`
- Replaces the need to manually prompt Claude to read these files at the start of each editing session
- After loading, Claude confirms readiness and summarizes next steps from `status.md`

### 29. `tailor-resume.md` — Authenticity and ethics guardrails expanded
Identified fabrication patterns from a real tailor-resume run against the Curology Data Analyst JD. Six new rules added to the ETHICAL REQUIREMENTS section and one to AUTHENTICITY RULES:

- **NEVER FABRICATE TO FILL JD GAPS** — If a JD requirement has no corresponding master resume content, leave it unaddressed and surface it in the Phase 6 gap report. Explicitly covers superficial resemblance (e.g., evaluating AI outputs ≠ using AI tools).
- **NEVER INVERT OR SOFTEN OUTCOMES** — Null, negative, or deprioritized results must be represented as such. No reframing inconclusive findings as "opportunities."
- **NEVER EXPAND CONTRIBUTION SCOPE** — Explicit scope limitations in the master resume (e.g., "initial exploratory phase," "fellow analyst took over") must be preserved. Do not attribute colleagues' findings to the candidate.
- **JD TERMS MUST BE GROUNDED** — JD language is welcome when it describes real experience. Do not append JD terms to bullets that have no master resume backing for them.
- **DO NOT IMPORT JD METRICS INTO BULLETS** — Use master resume as the source for specific named metrics and features. Do not substitute JD domain metrics (e.g., "retention curves," "LTV") into bullets about work from a different context.
- **Core Competencies Interview Test** (added to Keyword Rules) — A term may only appear in Core Competencies if the candidate could answer a direct interview question about it from master resume content. Unsupported JD keywords go to the gap report instead.
- **Professional Summary grounding rule** (added to What You CAN Modify) — JD terms in the summary must describe real experience in the master resume. The summary does not have broader license to introduce unsupported claims.
- **Phase 6 report** — Added "UNADDRESSED JD REQUIREMENTS" section to surface gaps that were intentionally left out rather than fabricated.

Triggered by: fabricated "Apply AI tools (ChatGPT, Gemini) daily" bullet and competency; invented metrics ("conversion rates, retention curves"); outcome inversion on Publisher Quality Classification project; overstatement of Google Channel ID contribution scope; unsupported JD terms appended to OBMedia bullets and summary.

### 30. `text_extractor.py` — Copied to `modifications/`
- Copied as-is from project root
- Centralized text extraction utility used by `ats_scorer.py`, `hr_scorer.py`, and `scorer_server.py`
- Handles DOCX, digital PDF, scanned PDF (OCR via Claude Vision API or pytesseract), MD, and TXT

### 31. `tailor-resume.md` — Removed resume.md deletion step
- Removed Phase 6 Step 5 ("Delete temporary files — Delete applications/{folder}/resume.md")
- Motivation: resume.md is now the final output; preserving it allows the user to inspect, copy-paste, and use as a base template for future runs

### 32. `tailor-resume.md` — Removed DOCX generation
- Removed Agent E (resume-docx-creator) from Phase 5; renamed former Agent F to Agent E
- Phase 5 renamed from "PARALLEL FINALIZATION (launch both simultaneously)" to "FINALIZATION"
- Tracker update (Agent E) now references `resume.md` instead of `{Name}_Resume_{Company}.docx`
- Phase 6 "GENERATED:" line updated to `resume.md`
- Phase 6 hr_scorer.py --web command updated to use `resume.md` instead of the DOCX path
- Motivation: DOCX output format was unsatisfactory; resume.md is the final deliverable going forward; future versions may add LaTeX or other renderers

### 33. `tailor-resume.md` — Fixed stale DOCX references (group 1)
- Phase 1 Action A: glob changed from `applications/**/*Resume*.docx` to `applications/**/resume.md`; reading now uses Read tool directly instead of python-docx via Bash
- Phase 2: removed "CRITICAL .md FORMATTING RULE" (no `**` rule) — rationale was DOCX generator; with DOCX gone, bold markdown is useful in the final output
- Phase 6 Step 1: "verify DOCX + tracker" → "verify tracker"
- Resume Structure ATS FORMAT line: removed "No `**` in .md files (DOCX handles bold)"

### 34. `tailor-resume.md` — Fixed pre-existing issues (group 2)
- Phase 3 header: "2 agents in a single parallel tool call" → "1 background agent" (ATS + HR were consolidated into /score/both; only Agent C is defined)
- Verb bank: removed `Spearheaded`, `Championed`, `Streamlined` — all three were on Rule 11's FORBIDDEN list; replaced with `Led`, `Built`, `Drove`, `Launched`, `Transformed` from Rule 11's approved list

### 35. `docx_generator.py` removed; `python-docx` removed from `requirements.txt`
- Deleted `modifications/docx_generator.py` — no longer referenced anywhere in the command flow (verified by simulating tailor-resume end-to-end)
- Removed `python-docx>=1.1.0` from `modifications/requirements.txt`
- Changelog entry 13 noted docx_generator.py was copied as-is; that copy is now gone

### 36. `tailor-resume.md` + `writing-coach.md` — SheetsResume.com format adopted

Replaced the ATS/Workday resume format with the human-first SheetsResume.com template format. Changes span both command files.

**`tailor-resume.md`:**
- **Resume structure** replaced: removed PROFESSIONAL SUMMARY, CORE COMPETENCIES, and separate section blocks (CERTIFICATIONS & LICENSURE, PUBLICATIONS, PROFESSIONAL MEMBERSHIPS). New structure: WORK EXPERIENCE → EDUCATION → CERTIFICATIONS, SKILLS & INTERESTS (combined).
- **Job entry format** changed: `TITLE | COMPANY | Location` → `**Company** Mon. Year – Mon. Year` / `*Job Title* City, ST`
- **Authenticity Rules — What You CAN Modify:** removed Professional Summary and Core Competencies; added minor job title tweaks (reordering, alternate standard form, abbreviation/expansion only — role level and function must not change); added Skills/Interests as modifiable.
- **Authenticity Rules — What You CANNOT Modify:** updated zero-bullet rule (0 bullets now permitted for zero-relevance roles, but header must remain); removed minimum 1 bullet per role.
- **Keyword rules:** removed Core Competencies as primary keyword location; keywords now woven naturally into bullets only.
- **ATS target:** lowered from 75% to 65% to reflect realistic performance without a dedicated keyword-dense section. HR target unchanged at 70%+.
- **Phase 4 iteration:** removed "Add keywords to Core Competencies" step; replaced with reframing bullets and adding items to the Skills bullet in the bottom section.
- **Rules 15–18 added:**
  - Rule 15 (Company Overview Lead): first bullet of every role anchors reader with company context/numbers
  - Rule 16 (Key Results Sub-bullets): quantifiable outcomes nested as indented sub-bullets
  - Rule 17 (Month Abbreviation): always abbreviate month names
  - Rule 18 (Sparse Emphasis): bold/italic for company names and job titles only; not within bullets
- **Bullet Distribution note:** updated to include zero-relevance = 0 bullets (header only).

**`writing-coach.md`:**
- **Rule 9** replaced: "Professional Summary as a Hook" → "Opening Role as the Hook" — no summary; first role's company overview bullet is now the opening impression.
- **Section-Specific Guidelines:** removed Professional Summary and Core Competencies subsections; added Work Experience Lead Bullet (Rule 15), Key Results Sub-bullets (Rule 16), and Certifications/Skills/Interests combined section guidance.
- **Education GPA threshold:** changed from 3.5+ to 3.3+ (aligned with SheetsResume template tip).
- **Integration Protocol step 3:** "Professional Summary: Apply Rule 9" → "First role's lead bullet: Apply Rule 15 (Company Overview)."

### 37. Company Summary Field Added to Master Resume Format

**`reference/master_resume_formatting.md`:**
- Added `**Company:**` line to the Recommended Document Structure, immediately after the `##` role header.
- Format: 1–3 sentences covering product/domain, a size signal (revenue, users, headcount, funding, or Fortune rank), and market position.
- For companies with multiple roles, one `**Company:**` line on the first role entry is sufficient; Claude carries the context to subsequent roles.
- Claude uses this line as the source for the Rule 15 company overview lead bullet; fabrication is not permitted.

### 38. `cover-letter.md` — Copied from original and modified

- Copied `.claude/commands/cover-letter.md` from the original project to `modifications/.claude/commands/cover-letter.md`
- **Phase 3 rewritten:** Removed DOCX creation and `cover_letter.md` deletion steps; `cover_letter.md` is now the final deliverable (matches `tailor-resume.md` pattern)
- **Phase 4 renumbered** to steps 8–9 (was 10–11); file list updated to `cover_letter.md` + `job_description.txt` (removed DOCX filename)
- **Similar resume lookup updated:** Now globs for `applications/**/resume.md` and reads directly with Read tool (was: list subfolders and compare); fallback glob trimmed to `*MASTER*RESUME*.md` only (removed `.docx` and `.pdf` variants)
- **Format-aware reading simplified:** Collapsed to "Use `Read` tool directly" (removed DOCX/PDF handling instructions — master resume is `.md` only)

### 39. `tailor-resume.md` — Fixed stale DOCX/PDF references in Phase 1

- Action A fallback glob: removed `*MASTER*RESUME*.docx` and `*MASTER*RESUME*.pdf` variants; now `*MASTER*RESUME*.md` only
- Action B format-aware reading: collapsed to "Use `Read` tool directly" (same rationale as entry 38)

### 40. `tailor-resume.md` — Eliminated spurious summary section generation

- **Rule 9** replaced: "Summary Hook: Identity + authority → differentiator" → explicit "No Summary" rule — no summary, profile, or objective section
- **Rule 14** replaced: summary anti-cliché guidance (which presupposed a summary existed) → explicit "No Summary" rule — resume begins with WORK EXPERIENCE immediately after the contact header
- **RESUME STRUCTURE section:** added bolded "NO SUMMARY SECTION" note before the template
- Root cause: Rules 9 and 14 both implied a summary should be written, contradicting the SheetsResume template which has no summary section

### 40. `cover-letter.md` — Company/job title prompt added

- Step 1 changed from "extract from JD" to explicitly asking the user for company name and job title
- Rationale: matches `/tailor-resume` pattern; company/job title are sometimes not stated clearly in the JD

### 41. `cover-letter.md` — Master resume reading guide added to Phase 1 Step 2
- Added "How to interpret the master resume structure" block after the format-aware reading note in Step 2
- Covers all three section types: named projects (three-part format; paragraph = primary synthesis source), Daily Responsibilities (role texture), flat labeled sections (structured lookup)
- Wording adjusted from tailor-resume.md: "generate bullets from this" → "identify relevant experiences from this" (cover letter selects experiences for prose paragraphs, not resume bullets)

### 42. `cover-letter.md` — Ethical Requirements section added to Phase 2
- Added four rules at the top of Phase 2, before the writing instructions:
  - NEVER FABRICATE EXPERIENCES — STAR examples must be grounded in master resume content
  - NEVER INVERT OR SOFTEN OUTCOMES — null/negative/deprioritized results must be represented as-is
  - NEVER EXPAND CONTRIBUTION SCOPE — explicit scope limitations in master resume must be respected
  - JD TERMS MUST BE GROUNDED — JD language only where master resume backing exists
- Company facts rule intentionally omitted — will be added separately when issue 2 (Company Connection paragraph) is addressed
- Section placed before step 5 (writing instructions) so Claude encounters constraints before generating content

### 43. `cover-letter.md` — Company research step added to Phase 1

- Added step 2: asks the user how to handle company research for the Company Connection paragraph
- Three options: (1) paste research, (2) web search, (3) skip/focus on role
- Option 1: user pastes (e.g., from Gemini); stored as `{company_research}`
- Option 2: Claude first asks for company website URL (to handle small/ambiguous company names), then runs WebSearch scoped to cover-letter-relevant content (mission, culture, growth/wins, products/milestones; omits earnings reports, controversies, etc.); displays summary for user to confirm/edit/skip before using
- Option 3: `{company_research}` = none; Company Connection paragraph focuses on the role instead
- Rationale: user's existing workflow uses Gemini for company research; option 1 formalizes that; web search is a fallback; URL seed prevents wrong-company searches for small/ambiguous names

### 44. `cover-letter.md` — Ethical Requirements: COMPANY FACTS FROM RESEARCH ONLY added

- Added rule to Ethical Requirements: company facts must come from `{company_research}` or the JD only; do not draw on Claude's internal knowledge (may be outdated or hallucinated); if neither source has sufficient context, default to focusing on the role
- Completes issue 2 (Company Connection source constraint) from the original review

### 45. `cover-letter.md` — Phase 2 structure revised; gap report added

- **Structure rewritten** from 5-paragraph to 3-paragraph format based on cover letter example:
  - Para 1: Opening — 2-3 relevant skills + genuine mission/domain connection if master resume supports it; no manufactured enthusiasm
  - Para 2: Deep Narrative — 1-2 experiences (full end-to-end); personal projects valid content if in master resume; depth over breadth
  - Para 3: Company Connection + Close (merged) — specific company detail from `{company_research}` or role focus if none; confident call to action
- **Format requirements updated:** "350-400 words; feel complete and natural, not padded"; added note that user may add personal context not in master resume
- **Gap report added** as step 11 in Phase 4: lists unaddressed JD requirements the user can address manually; mirrors `tailor-resume.md` pattern
- Motivation: example cover letter (Zearn application) showed that depth on one project + merged Company Connection/Close + 3-paragraph structure produces more compelling, less formulaic output than the original 5-paragraph template

### 46. `tailor-resume.md` — Bug fix: ATS job_title_match always 0% on LinkedIn JDs

- **Root cause:** `ats_scorer.py`'s `check_job_title_match` falls back to extracting the first line of the JD as the title when no `Job Title:` / `Position:` / `Role:` label is found. LinkedIn JDs typically start with "About the job", which passes the length filter (5–80 chars) and gets used as the extracted title. That phrase never appears in the resume → score 0% (10% weight).
- **Fix:** PHASE 1 Action C now prepends `Job Title: {JobTitle}\n\n` to the JD content before saving as `job_description.txt`. The scorer's existing Pattern 1 regex (`job title: <title>`) fires before the fallback, extracting the correct title.
- No changes to `ats_scorer.py` — the fix is entirely in the command.

### 47. `/find-jobs` — Copied and partially modified

- Copied `find-jobs.md` from original `.claude/commands/` to `modifications/.claude/commands/`
- **Step 1:** Simplified master resume reading — removed `.docx` + `extract_text` MCP references; master resume is always `.md` now; use `Read` tool directly
- **Step 3:** Replaced `discover_jobs` MCP tool call with a direct Bash call to `job_discovery.py` using `{venv_python}`; MCP server dependency removed
- **Option 1 (Phase 4):** Updated `/resume` workflow reference → `/tailor-resume`; removed "After DOCX is created" wording; now shows job posting URL instead of apply URL
- **Step 5:** "Apply URL" → "Job posting URL"
- **Error handling:** Removed "If the MCP tool is not available" bullet — no longer applicable
- Status: IN PROGRESS — further edits planned

### 48. `job_discovery.py` — Copied to `modifications/`

- Copied as-is from project root
- Lazily imports `ats_scorer` and `hr_scorer` at scoring time — both already present in modifications/
- All top-level imports are standard library only (no third-party dependencies beyond what's in requirements.txt)
- `analyze_resume_for_search()` uses `ANTHROPIC_API_KEY` optionally — silently skips if not set
- Simulation confirmed: all dependencies present; modifications/ as root resolves all imports correctly

### 49. `find-jobs.md` — JD prepend fix applied to Option 1

- When the user picks a job number in Option 1, the job description is now saved with `Job Title: {job.title}\n\n` prepended before the description content
- Same fix as entry 46 — prevents `ats_scorer.py`'s title-match fallback from grabbing the first line of the JD (which is often "About the job" on LinkedIn-sourced listings)
- No changes to `job_discovery.py` or `ats_scorer.py`

### 50. `find-jobs.md` — Issues reviewed; most deferred pending `job_discovery.py` rework

Six issues identified in the current `find-jobs.md`. Status of each:
- **Issue 1 (Phase 0 config block):** Non-issue — inline note after the Bash snippet is sufficient; no Phase 0 needed
- **Issue 2 (Python boolean formatting):** Deferred — will be revisited after planned heavy edits to `job_discovery.py`
- **Issue 3 (Result structure branching):** Deferred — same reason; result schema may change
- **Issue 4 (`listing_url` vs `url`):** Deferred — `listing_url` is constructed in `_normalize_adzuna_result`, which will likely change
- **Issue 5 (JD prepend):** Fixed in entry 49
- **Issue 6 (Error handling redundancy):** Blocked by Issue 3; will be removed when Issue 3 is addressed

### 51. `job_discovery.py` — Refactored to platform-agnostic source registry

Replaced hard-coded Adzuna/Remotive coupling with a source registry pattern.

**Source protocol:** Each source is a plain class instance with `name`, `display_name`, `remote_only_source`, `setup_help`, `is_configured`, and `search(query, location, remote_only, **kwargs)`. Adding a new job board requires only writing a class and adding it to `_SOURCES`.

**`AdzunaSource`:** All of `ADZUNA_BASE`, `_adzuna_configured`, `search_adzuna`, `_normalize_adzuna_result` moved inside. `remote_only` accepted by `search()` with a TODO comment for the Adzuna API param name (deferred).

**`RemotiveSource`:** All of `REMOTIVE_URL`, `search_remotive`, `_normalize_remotive_result` moved inside. `remote_only` is a no-op (all Remotive results are remote). `listing_url` added to `_normalize()` (previously missing from Remotive output).

**Source registry:** `_SOURCES = [AdzunaSource(), RemotiveSource()]`. `_SOURCE_DISPLAY` computed from registry.

**`discover_jobs()` changes:**
- New `source_name: Optional[str] = None` parameter — resolves to exactly one source; no cross-platform fallback
- If `source_name` is None: uses first configured source (programmatic backward compatibility)
- If resolved source returns no results: returns empty with a message — no fallback to another source
- Attribution derived from `source.display_name` directly

**Deleted:** `_adzuna_configured()`, `adzuna_configured()`, `search_adzuna()`, `search_remotive()` — no callers in `modifications/`.

**New public functions:** `list_sources()` (returns registry metadata), `_build_setup_message()` (replaces hard-coded no-API-keys message; also removes Pro cloud URL), `_active_attribution()` (utility).

**Issues resolved:** Issue 2 (Python boolean formatting — `remote_only` now passed cleanly as a kwarg), Issue 3 (result structure branching — error path now always returns `message` field), Issue 4 (`listing_url` — standardized across all sources), Issue 6 (error handling — single `message` field replaces redundant branching).

### 52. `find-jobs.md` — Source selection step added; error handling updated

- **Phase 1 step 3 added:** Calls `list_sources()` via Bash, displays sources with configured status, always asks user to pick one, passes selection as `source_name` to `discover_jobs`.
- **Phase 2 (now step 4):** `discover_jobs` call updated to include `source_name={source_name!r}`.
- **Steps renumbered:** Phase 3 steps 4-6 → 5-7; Phase 4 step 7 → 8.
- **Error Handling rewritten:** Removed hard-coded Adzuna API key message; now instructs Claude to display `result.message` verbatim (generated dynamically by `job_discovery.py`).

### 53. `job_discovery.py` — Adzuna `remote_only` filter implemented

- **Finding:** Adzuna's public API has no dedicated boolean remote filter (`permanent_remote`, `is_remote`, etc.). The website's "Remote" checkbox maps to `&where=remote` in the API.
- **Fix:** Replaced the TODO comment in `AdzunaSource.search()` with the correct two-param approach: when `remote_only=True`, set `params["where"] = "remote"` and append `" remote"` to `params["what"]` (catches listings that mention remote in description but list a city as location). When `remote_only=False` and location is provided, `where` uses the location as before.
- **Remotive:** No change needed — `remote_only` is already a documented no-op since all Remotive results are remote.

### 54. `job_discovery.py` + `find-jobs.md` — Remotive removed

- **Reason:** Remotive's public API exposes only ~2,000 jobs out of the tens of thousands posted on the site, making it an unviable discovery source.
- **`job_discovery.py`:** Removed `RemotiveSource` class entirely; removed from `_SOURCES` list; removed from module docstring.
- **`find-jobs.md`:** Removed Remotive from the example source list in Phase 1 step 3.

### 55. `job_discovery.py` + `find-jobs.md` — USAJobs source added

- **`job_discovery.py`:** Added `USAJobsSource` class. Authenticates via `Authorization-Key` (API key) and `User-Agent` (registered email) headers per USAJobs API spec. Supports `remote_only` via native `RemoteIndicator=True` param and `location` via `LocationName`. Normalizes `MatchedObjectDescriptor` fields to common schema; description prefers `UserArea.Details.JobSummary`, falls back to `QualificationSummary`. Salary parsed from `PositionRemuneration[0]`. Added to `_SOURCES` and module docstring.
- **`find-jobs.md`:** Updated example source list to include USAJobs.
- **Credentials:** Requires `USAJOBS_API_KEY` + `USAJOBS_EMAIL` in `.env`. Free registration at https://developer.usajobs.gov/APIRequest/
- **No filtering preferences set yet** — pay grade, clearance requirements, and job series filters may be added later.

### 56. `job_discovery.py` + `find-jobs.md` — USAJobs API corrections and description enrichment

- **`Authorization-Key` header fix:** Corrected from `"Authorization"` to `"Authorization-Key"` per USAJobs API spec.
- **Description enrichment:** `_normalize()` now concatenates `JobSummary`, `MajorDuties`, and `QualificationSummary` (all three are distinct fields per the data dictionary) for richer scoring coverage.
- **`source_name` docstring:** Updated example from `"remotive"` to `"usajobs"`.
- **`find-jobs.md` — `listing_url` made explicit:** Both "job posting URL" references in Phase 3 and Phase 4 now specify `listing_url` field. `listing_url` is the clean listing page; `url` is the tracked apply/redirect link. The fallback in `discover_jobs()` (line 881) handles sources that only provide one URL.

### 57. `job_discovery.py` — USAJobs `HiringPath` defaulted to `public`

- Added `"HiringPath": "public"` to the default params dict in `USAJobsSource.search()`
- Filters results to "Open to the public" listings only, excluding veteran, Native American, and other restricted hiring paths
- No changes to `find-jobs.md` or other files

### 58. `job_discovery.py` + `find-jobs.md` — TheirStack source added

- Added `TheirStackSource` class following the same source protocol as Adzuna/USAJobs
- POST to `https://api.theirstack.com/v1/jobs/search` with JSON body; auth via `Authorization: Bearer {THEIRSTACK_API_KEY}`
- Default params: `job_title_or: [query]`, `job_country_code_or: ["US"]`, `posted_at_max_age_days: 30`, `limit: 25`, `page: 0`; `remote_only` maps to `"remote": true`
- Response read from `data` array (wrapper confirmed from OpenAPI spec); salary from `min/max_annual_salary_usd`
- Added to `_SOURCES` and module docstring; `find-jobs.md` example source list updated to include TheirStack
- Credential: `THEIRSTACK_API_KEY` in `.env`

### 59. `job_discovery.py` — `hiring_path` removed from TheirStack request body

- Removed `"hiring_path": "public"` — field does not exist in the TheirStack API (confirmed from full parameter list)

### 60. `job_discovery.py` — TheirStack `_normalize` refined from actual 200 response

- `location`: now prefers `short_location` ("Tulsa, OK" format) over `location`, falling back to remote indicator
- `listing_url`: now uses `final_url` (company careers page) instead of `url` (TheirStack tracked link); `url` retained as apply link

### 61. `job_discovery.py` — TheirStack credit balance check added

- Added `_get_credit_balance()` helper: GET `https://api.theirstack.com/v0/billing/credit-balance`; returns `(api_credits, used_api_credits)` or `(None, None)` on failure
- Credit balance response fields: `ui_credits`, `used_ui_credits`, `api_credits`, `used_api_credits`
- `search()` checks remaining credits (`api_credits - used_api_credits`) before making the search call: 0 remaining → print warning to stderr + return `[]`; below 25 → print low-credit warning to stderr but proceed
- Threshold constant: `_LOW_CREDIT_THRESHOLD = 25`

### 62. `.claude/hooks/` — PreToolUse file-protection hook added

Added `protect_sensitive_files.py` and `run_hook.sh` to `modifications/.claude/hooks/`, and created `modifications/.claude/settings.json` to register the hook.

**Why:** Claude Code's native `deny` permission system in `settings.json` was non-functional as of v1.0.93 (regression — anthropics/claude-code#6699, marked critical/security). Deny rules like `"Read(./.env)"` were silently ignored, giving Claude unrestricted file access. The community workaround — a `PreToolUse` hook that exits with code `2` to block tool calls — was the only reliable protection mechanism. Simão Gomes Viana's extended version (linked in the issue) dynamically reads deny patterns from `settings.json` itself, making the hook a behavioral fix for the broken native feature. The issue has since been closed as fixed by Anthropic, but the hook is retained as defense-in-depth: it provides richer blocking logic and custom error messages fed back to the model that the simple deny list cannot match.

**Exit code semantics:** `0` = allow, `1` = non-blocking error, `2` = block tool call and return stderr to Claude.

**Files added/modified:**
- `protect_sensitive_files.py` — sourced from the issue; updated shebang from nix to `#!/usr/bin/env python3`; `load_settings()` changed to read from `$CLAUDE_PROJECT_DIR/.claude/settings.json` (project-level) instead of `~/.claude/settings.json` (global)
- `run_hook.sh` — new wrapper script; reads `venv_name` from `config.json`, constructs the platform-aware venv Python path (Windows: `Scripts/python`, Mac/Linux: `bin/python`), and execs the hook; venv used even though the hook is stdlib-only, for future-proofing if third-party packages are ever added
- `settings.json` — fixed missing comma between `hooks` and `permissions` blocks; hook command changed from direct `.py` execution (fails on Windows) to `bash $CLAUDE_PROJECT_DIR/.claude/hooks/run_hook.sh`

### 63. `changelog.md` + `status.md` — Post-fork cleanup

- Removed the `## Status` section from the top of `changelog.md` — redundant with `reference/status.md`
- Added `## Note on File Paths` section to `changelog.md` explaining that all `modifications/` path references in changelog entries reflect the old sub-directory location and should be read as relative to the project root
- Fixed one stale path in `status.md`: `modifications/.claude/settings.json` → `.claude/settings.json` (in the PreToolUse hook key decision)

### 64. `hr_scorer.py` + `tailor-resume.md` — Fix ISS-002/ISS-005: HR scorer returns 0 on SheetsResume date format

Three compounding bugs caused `hr_scorer.py` to silently return `overall_score: 0` / `AUTO-REJECT` ("Experience knockout: 0.0 years") on every resume using the SheetsResume date format with period-abbreviated months.

**`tailor-resume.md`:**
- Job entry template updated: dates moved from the company name line to their own line. Before: `**[COMPANY]**  [Mon. Year – Mon. Year]` / `*[Title]*  [Location]`. After: `**[COMPANY]**` / `[Mon. Year – Mon. Year]` / `*[Title]*  [Location]`. Location remains paired with the title line.

**`hr_scorer.py`:**
- `parse_date()`: added pre-processing step to strip trailing periods from abbreviated month tokens before pattern matching and `strptime` — `re.sub(r'\b(\w{2,9})\.\s+(\d{4})', r'\1 \2', date_str)`. Resolves ISS-005: `"Mar. 2025"` now parses correctly.
- `date_patterns` regex: updated `\w+\s+\d{4}` to `\w+\.?\s+\d{4}` so period-abbreviated months match in date range patterns. Also resolves ISS-005.
- Peekahead guard (standalone job-entry detection): replaced `startswith(('•', '-', '*', '—'))` with `re.match(r'^[•\-—]|^\*(?!\*)')` — the old check incorrectly excluded `**Company**` bold lines (they start with `*`); the new check only excludes genuine bullet lines (`* item`) while allowing bold lines through. Also removed the `current_job is None` constraint so all jobs in the resume are captured, not just the first.

**`reference/issues.md`:** ISS-002 and ISS-005 moved to RESOLVED with resolution notes. The secondary issue in ISS-002 (scorer applies hardcoded experience default when JD explicitly states no minimum) is tracked separately and remains open.

### 65. `hr_scorer.py` — Fix ISS-002 regression: scorer fails on inline date format

Added a dedicated `sheets_match` parsing branch to `parse_resume()` in `hr_scorer.py` that handles the SheetsResume bold company line pattern (`^\*\*(.+?)\*\*`). The prior fix (entry 64) only worked when dates appeared on a separate line; resumes using the inline format (`**Company**  Mar. 2025 – Present`) were still silently producing 0 years of experience.

The new branch fires when a bold company line is detected in the experience section. It:
1. Extracts the company name by stripping `**` markers
2. Scans the same line for an inline date range using `date_patterns`
3. Peeks ahead up to 3 lines for an italic job title (`^\*(?!\*)(.+?)\*`)
4. Creates a `JobEntry` with the correct company and title, applying the date immediately if found inline or leaving `start_date = None` for the existing date-line handler to fill on the next pass

Both formats now parse correctly without any template or skill changes required. Verified on the Claritev tailored resume: 7 jobs detected, 11.42 total years, HR score 69.3 (was 0).

**`reference/issues.md`:** ISS-002 re-resolved with this fix noted.

## Aspirational / Long-Term Goals
- Remove all Pro cloud references from `scorer_server.py` (auth, billing, usage limits, `rb_...` API keys)

## Next Steps
- See `status.md`
