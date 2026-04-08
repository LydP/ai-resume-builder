# Issues Log

Technical issues prevent the tool from running correctly (crashes, path errors, environment problems).
Implementation issues degrade output quality but don't break the run (scoring inaccuracies, logic gaps).

---

## OPEN — Technical

### ISS-001 — Scorer server fails to persist across shell session
**Date:** 2026-03-30
**Severity:** Low (CLI fallback available)
**Context:** `/tailor-resume` skill — Phase 0 scorer server startup

**What happened:** The scorer server was launched via a background `Agent` tool call. The agent attempted to use the Bash tool but could not surface a permission approval prompt to the user while running in the background. Server never started; all scoring fell back to direct CLI calls (`ats_scorer.py`, `hr_scorer.py`).

**Impact:** Scoring ran ~30–60s slower than expected (CLI vs. server). No data loss or incorrect output.

**2026-03-31 update:** Fix attempted — direct `Bash` call with `start /B` + `run_in_background: true`. Still failed (exit code 1, server crash). Root cause unclear; may be a Windows `start /B` incompatibility in the bash shell environment. CLI fallback continues to work. Further investigation needed.

**2026-04-01 update:** Tried `run_in_background: true` with `&` appended to the command. Server process started but exited immediately with code 0. Root cause: bash kills background processes when the parent shell session exits. The "direct Bash call" fix does not work — the subprocess lifecycle is tied to the shell session. CLI fallback remains the only working path. Fix likely requires a persistent server started outside Claude Code (e.g., user runs it manually in a terminal before invoking the skill).

**2026-04-07 update:** Reproduced again. Background agent (subagent_type: general-purpose) was launched to start the server; the agent's Bash tool call was denied by the user's permission system. Server never started. CLI fallback used for all scoring.

**2026-04-08 update:** See ISS-008 — the denial pattern is broader than server startup. The Phase 2/3 scoring agents (base-scorer, tailored-scorer) were also denied Bash in this run. The entire background agent model is non-functional when the user's permission system is restrictive.

---

### ISS-004 — Scorer server startup fails on backslash path in bash shell
**Date:** 2026-04-02
**Severity:** Low (recoverable — retry with corrected path succeeded)
**Context:** `/tailor-resume` skill — Phase 0 scorer server startup

**What happened:** The skill constructed the venv Python path using a backslash separator (`resume-writer-venv-313\Scripts\python`), which the bash shell could not resolve. First startup attempt failed immediately with "command not found." Retrying with a forward-slash path (`resume-writer-venv-313/Scripts/python`) succeeded and the server started normally.

**Impact:** One failed startup attempt and an extra retry loop. No data loss; server eventually ran correctly.

**Fix needed:** The skill (or the path construction logic) should normalize the venv Python path to forward slashes regardless of OS, since the shell environment is always bash. Alternatively, quote the path and use the OS-appropriate separator only when invoking via `cmd.exe`.

---

## OPEN — Implementation

### ISS-002 — HR scorer returns 0 on SheetsResume inline date format
**Date:** 2026-03-31
**Severity:** Medium (scores are silently wrong; no error surfaced to user)
**Context:** `/tailor-resume` skill — Phase 3 tailored HR scoring

**What happened:** `hr_scorer.py` returned `overall_score: 0` / `AUTO-REJECT` with reason "Experience knockout: 0.0 years vs 5.0 required" when scoring a resume using the SheetsResume inline format:
```
**Company Name**  Mar. 2025 – Present
*Job Title*  Remote
```
The same resume content in the traditional multi-line format scored 71.3% on the same JD. The scorer cannot parse experience duration from the inline layout and defaults to 0 years, triggering a knockout.

**Impact:** HR score is silently wrong (shows 0 instead of ~71%). No warning or error emitted; requires manual detection.

**Workaround:** Use base HR score from a previously scored resume with the same content as a proxy. Document discrepancy in report.

**2026-04-02 update:** Reproduced again on Verita Data Analyst run (2-year experience requirement). Confirmed the bug is not specific to high-experience-threshold roles — it fires on any role where date parsing fails.

**2026-04-06 update:** Reproduced again on Jobright.ai Data Analyst run (2-year experience requirement). Workaround applied: carried forward HR score from Paxos base template (72.8%) and documented the discrepancy in the report.

**2026-04-07 update:** Reproduced again on Buyers Edge Platform BI Analyst run (2-year requirement). ISS-005 (month periods) also fired simultaneously. Workaround applied: switched to multi-line date format without periods; HR scorer parsed dates correctly and returned 59.8%.

**2026-04-08 update:** Reproduced again on RMC Data Analyst run (2-year requirement). Inline date format + period abbreviations caused HR scorer to return "Experience knockout: 0.0 years." No workaround applied this session — HR score reported as N/A with note directing user to Score_Prompt.txt.

**Fix needed:** Either update `hr_scorer.py` to parse inline date format, or switch the skill's resume template to use the multi-line date format the scorer expects.

---

### ISS-003 — ATS scorer applies wrong domain profile to cross-domain analytics roles
**Date:** 2026-04-01
**Severity:** Medium (scores are severely deflated with no warning; misleads user on resume quality)
**Context:** `/tailor-resume` skill — Phase 3/4 ATS scoring; any JD where domain is misclassified

**What happened (first instance — 2026-04-01):** `ats_scorer.py` detected the HSAG JD as healthcare domain and applied a "Healthcare Operations / Hospital Administration" profile. This profile requires HIPAA, EHR, patient care, JCAHO, and similar clinical terms. HSAG is a healthcare data analytics organization — the Analyst I JD contains none of these clinical terms, and a data analyst resume correctly contains none of them. The scorer penalized the resume for missing clinical vocabulary that is irrelevant to the role, producing an ATS score of ~24%.

**What happened (second instance — 2026-04-02):** `ats_scorer.py` classified Verita (a legal/administrative services firm operating in corporate restructuring and settlement administration) as finance domain and applied an "Investment Banking / Private Equity / Finance" profile. This profile penalizes for missing M&A, DCF, LBO, and other finance keywords. Produced a suppressed ATS score with irrelevant warnings ("Missing critical finance keywords: m&a, ipo, lbo, dcf").

**Impact:** ATS score is misleadingly low. No warning or domain-mismatch flag is emitted to the user. The `domain_adjustments.warnings` field surfaces the issue in JSON output only.

**Workaround:** Note the issue in the report and direct the user to Score_Prompt.txt for LLM-based scoring, which handles cross-domain analytics roles more accurately.

**2026-04-08 update:** Reproduced on RMC Data Analyst run. JD is for a federal government/occupational safety & health role; scorer detected "clinical_research" at 24.9% confidence (barely above noise). Applied clinical research penalties (missing FDA, GCP, IRB, clinical trial keywords) with no relevance to the JD. ATS capped at ~42% as a result.

**Fix needed:** The domain classifier needs finer-grained profiles. Specifically:
- Distinguish clinical healthcare roles from healthcare analytics/data roles
- Distinguish legal/administrative services firms from finance/investment firms
- Add a government/public sector domain profile
- One approach: add a secondary classification step checking for analytics/data-science signals in the JD before applying a domain-specific vocabulary profile
- Alternatively: suppress domain-specific keyword penalties when the JD title contains "analyst," "data," or "analytics"

---

### ISS-008 — Background scoring agents denied Bash; entire Phase 2/3 agent model non-functional
**Date:** 2026-04-08
**Severity:** Medium (scoring falls back to blocking foreground calls; no data loss but run is slower and sequential)
**Context:** `/tailor-resume` skill — Phase 2 base-scorer agent, Phase 3 tailored-scorer agent

**What happened:** The skill launches base-scorer and tailored-scorer as background `general-purpose` agents (in addition to the scorer server startup agent documented in ISS-001). On this run, all three agent types were denied Bash permission by the user's permission system. The scoring agents returned without running any commands. All scoring fell back to sequential foreground Bash calls in the main thread.

**Impact:** The skill's intended parallel execution model (server + background agents running concurrently while resume is being written) does not function. All scoring is sequential and blocks the main thread. No scoring data is lost — CLI fallback produces the same results — but the run takes longer and the Phase 4 iteration loop cannot run asynchronously.

**Scope distinction from ISS-001:** ISS-001 documents the server startup agent specifically. ISS-008 covers the broader pattern: any background `general-purpose` agent that needs Bash will be denied when the user's permission system is restrictive. The Phase 2/3 scoring design is fundamentally incompatible with this permission model.

**Workaround:** Run all scoring via direct foreground Bash calls. Already the de facto fallback in all recent runs.

**Fix needed:** Either (a) eliminate background scoring agents entirely and run all scoring as foreground Bash calls in the main thread (simpler, matches actual behavior), or (b) design the skill to detect permission failures and auto-fall back without requiring manual intervention. Option (a) is the pragmatic fix — the background agent model has never worked reliably in this project.

---

### ISS-005 — Rule 17 month periods incompatible with scorer date parsers
**Date:** 2026-04-06
**Severity:** Low (easy workaround; same session as detection)
**Context:** `/tailor-resume` skill — any scoring run using SheetsResume date headers

**What happened:** Rule 17 mandates abbreviated month names with trailing periods (e.g., `Mar.`, `Aug.`). Both `hr_scorer.py`'s `parse_date()` and the `date_patterns` regexes use `\w+\s+\d{4}` to match month-year pairs. A period is not a word character (`\w`), so `"Mar. 2025"` fails to match — the regex captures `"Mar"` then expects whitespace but encounters `"."` and aborts. This affects parsing even in multi-line date formats (i.e., the bug is independent of ISS-002).

**Impact:** Any resume using Rule 17 month periods will produce incorrect date-derived metrics in the scorers (experience years, skill recency). In practice this session both issues (ISS-002 and ISS-005) fired simultaneously, making it hard to isolate which caused the 0-year result.

**Workaround:** Strip trailing periods from month abbreviations in date range headers (inline or standalone). Body text and bullets may keep periods per Rule 17.

**2026-04-07 update:** Reproduced again on Buyers Edge Platform BI Analyst run alongside ISS-002. Both fired simultaneously. Multi-line format + stripped periods resolved both.

**Fix needed:** Either update the skill's writing rules to omit periods from month names in date contexts, or update the scorer regexes to allow an optional period after the month token: `\w+\.?\s+\d{4}`.

---

### ISS-006 — HR scorer ingests JD benefits/boilerplate as required skills
**Date:** 2026-04-07
**Severity:** Low (deflates skills score; identifiable from the concerns list)
**Context:** `/tailor-resume` skill — Phase 3/4 HR scoring; any JD with a benefits or "What's in it for you" section

**What happened:** The Buyers Edge Platform JD included a standard benefits section ("half-day Summer Fridays", "Personal Responsibility Paid Time Off"). `hr_scorer.py` extracted "Fridays" and "Paid" as required skills and flagged them as missing in the concerns list. These are not real skill requirements — they are benefits text. The scorer's JD parsing does not distinguish the qualifications section from benefits/boilerplate.

**Impact:** Skills score is artificially deflated. The effect is bounded (weight 0.1 in HR scoring) but surfaces as a misleading concern that could confuse the user if they read the raw scorer output.

**Workaround:** Ignore skills concerns listing single common words ("Fridays", "Paid", "Amazing", etc.) — these are boilerplate leakage, not real gaps. Note in the report when this occurs.

**Fix needed:** The HR scorer's JD parser should scope skills extraction to the qualifications/requirements section only (e.g., stop parsing after a "Benefits", "What's in it for you", or "What we offer" heading).

---

### ISS-007 — No-summary rule suppresses ATS job_title_match vs. summary-bearing base templates
**Date:** 2026-04-07
**Severity:** Low (structural tension; scores are accurate, not wrong)
**Context:** `/tailor-resume` skill — Phase 4 ATS evaluation; roles where base template had a summary

**What happened:** The Forbes base template (used for comparison) contained a summary paragraph that included "business intelligence" prominently, scoring `job_title_match: 80`. The tailored resume — correctly built without a summary per Rules 9/14 — scored `job_title_match: 40`. The tailored resume's total ATS (62.3%) ended up slightly below the base template (64.3%) primarily due to this dimension, despite being more tightly aligned to the JD in its bullets and skills section.

**Impact:** The ATS comparison table in the report shows a regression that is an artifact of the rule difference between base template and tailored output, not a real quality drop. Can mislead the user into thinking the tailoring made the resume worse overall.

**Workaround:** Note in the report when the ATS regression is traceable to job_title_match and the no-summary rule, so the user understands the cause. The HR score improvement is the more meaningful signal in these cases.

**Fix needed:** No code fix needed — the no-summary rule is intentional. Consider updating the report template to flag when ATS regression is attributable to job_title_match specifically, so the user gets the right interpretation.

---

## RESOLVED

*(none yet)*
