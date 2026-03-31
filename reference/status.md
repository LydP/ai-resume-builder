# Modification Status

## Command Status
| Command | Status |
|---------|--------|
| `/setup` | COMPLETE |
| `/tailor-resume` | COMPLETE |
| `/writing-coach` | COMPLETE |
| `/resume` | SKIPPED (not implementing) |
| `/cover-letter` | COMPLETE |
| `/find-jobs` | IN PROGRESS |

---

## Key Decisions (affect all downstream work)

**Venv-aware Python calls**
All Python/pip calls use `{venv_python}` constructed from `config.json → venv_name`. Pattern established in `/tailor-resume` Phase 0; must be applied to all future commands.
- Windows: `{venv_name}\Scripts\python`
- Mac/Linux: `{venv_name}/bin/python`

**Pro cloud account removed**
No `SCORER_CLOUD_URL`, `SCORER_CLOUD_API_KEY`, or `rb_...` API keys anywhere. Local scoring and scorer server remain intact.

**LLM Scorer replaced with Score_Prompt.txt**
If `config.json → generate_score_prompt: true`, generate `applications/{folder}/Score_Prompt.txt` after writing the resume. Template lives at `reference/llm_score_prompt.txt`. Placeholders: `{jd_text}`, `{resume_text}`, `{domain_context}`. User pastes into Claude.ai manually — no API key needed.

**New `config.json` fields**
- `venv_name` — set during setup
- `generate_score_prompt` — boolean, default false

**Master resume format + project decomposition (Problem 2)**
Projects now use a three-part format: prose paragraph + `**Tools:**` line + `**Details:**` sub-list. Defined in `reference/master_resume_formatting.md`. Writing Coach Rule 12 governs how Claude reads this format (paragraph = synthesize; Tools = keyword metadata; Details = reference only, never enumerate) and caps output at 3 bullets per named project. This resolves the decomposition problem where Claude previously generated one bullet per Details sub-item.

**PreToolUse hook replaces broken native `deny` permissions (entry 62)**
`.claude/settings.json` registers a `PreToolUse` hook that enforces the `permissions.deny` list. Motivation: Claude Code's native deny system was non-functional as of v1.0.93 (anthropics/claude-code#6699). The hook reads deny patterns from the project-level `settings.json` via `$CLAUDE_PROJECT_DIR` and exits with code `2` to block matching file access. Hook is invoked via `run_hook.sh`, which resolves the venv Python from `config.json` — consistent with the venv-first pattern and future-proof if the hook ever needs third-party packages.

**DOCX generation removed; resume.md is the final output; docx_generator.py deleted**
`tailor-resume.md` no longer generates a DOCX file. `resume.md` is saved in the application folder and is the deliverable. Future versions may add LaTeX or other renderers. Prior tailored resumes are now found by globbing `applications/**/resume.md` rather than `*Resume*.docx`.

**SheetsResume.com format adopted (entry 36)**
Human-first format replaces ATS/Workday format. No Professional Summary or Core Competencies. Work Experience leads; job entries use `**Company**` bold + date inline, `*Job Title*` italic. Combined CERTIFICATIONS, SKILLS & INTERESTS footer. Keywords woven into bullets only. ATS target lowered to 65%; HR target unchanged at 70%+. Minor job title tweaks now permitted (reordering/abbreviation/alternate standard form only — role level and function must not change). Zero bullets allowed for zero-relevance roles (header must still appear). New rules 15–18: Company Overview Lead, Key Results Sub-bullets, Month Abbreviation, Sparse Emphasis.

---

## Next Steps
- User to reformat master resume using `reference/master_resume_formatting.md` (now includes `**Company:**` line per role)
- Address structural debt: Rules 11-14 in `tailor-resume.md` belong in `writing-coach.md` (renumber as 12-15 given new Rule 11) — note rules 15-18 added in entry 36; renumbering now more pressing
- `/find-jobs`: All known issues resolved (entries 51-55). Adzuna `remote_only` implemented via `where=remote` + keyword append (entry 53). Remotive removed — public API too limited (entry 54). USAJobs added (entry 55). USAJobs `HiringPath` defaults to `public` (entry 57). TheirStack added with credit balance check (entries 58-61). Pending: live test run before marking COMPLETE.

## Open Tensions
- Rule 5 (Power Verb Ladder) vs. Rule 11 (Plain Language) — resolved provisionally: added action verb exception to Rule 11 exempting power verbs from the plain language test. User may revise.

## Aspirational / Long-Term Goals
- Remove all Pro cloud references from `scorer_server.py` (auth, billing, usage limits, `rb_...` API keys)
- Remove Pro cloud reference from `job_discovery.py` lines 676-681: no-API-keys message still recommends the hosted scorer at `https://resume-scorer-web.streamlit.app`; replace with local-only guidance
