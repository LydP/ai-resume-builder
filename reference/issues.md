# Issues Log

Technical issues prevent the tool from running correctly (crashes, path errors, environment problems).
Implementation issues degrade output quality but don't break the run (scoring inaccuracies, logic gaps).

**Reproduction policy:** When a known issue reproduces, increment the `Reproductions:` count and date list. Only add a dated update note if the reproduction yields new information (different root cause, new workaround, fix attempt, or meaningful new context). Pure "reproduced again, same behavior" observations belong in the count only.

---

## OPEN — Technical

### ISS-001 — Scorer server fails to persist across shell session
**Date:** 2026-03-30
**Severity:** Low (CLI fallback available)
**Reproductions:** 6 (2026-03-31, 2026-04-01, 2026-04-07, 2026-04-08, 2026-04-27, 2026-04-30)
**Context:** `/tailor-resume` skill — Phase 0 scorer server startup

**What happened:** The scorer server was launched via a background `Agent` tool call. The agent attempted to use the Bash tool but could not surface a permission approval prompt to the user while running in the background. Server never started; all scoring fell back to direct CLI calls (`ats_scorer.py`, `hr_scorer.py`).

**Impact:** Scoring ran ~30–60s slower than expected (CLI vs. server). No data loss or incorrect output.

**2026-03-31 update:** Fix attempted — direct `Bash` call with `start /B` + `run_in_background: true`. Still failed (exit code 1, server crash). Root cause unclear; may be a Windows `start /B` incompatibility in the bash shell environment. CLI fallback continues to work. Further investigation needed.

**2026-04-01 update:** Tried `run_in_background: true` with `&` appended to the command. Server process started but exited immediately with code 0. Root cause: bash kills background processes when the parent shell session exits. The "direct Bash call" fix does not work — the subprocess lifecycle is tied to the shell session. CLI fallback remains the only working path. Fix likely requires a persistent server started outside Claude Code (e.g., user runs it manually in a terminal before invoking the skill).

**2026-04-08 update:** See ISS-008 — the denial pattern is broader than server startup. The Phase 2/3 scoring agents (base-scorer, tailored-scorer) were also denied Bash in this run. The entire background agent model is non-functional when the user's permission system is restrictive.

**2026-04-30 update:** PowerShell `Start-Process -FilePath "venv\Scripts\python.exe" -ArgumentList "scorer_server.py --port 8100" -WindowStyle Hidden` successfully started the scorer server as a persistent Windows process detached from the Claude Code session. Server was healthy within ~10 seconds and handled all scoring for the run without issue. This is the first confirmed working server startup method across all runs. Use this PowerShell call as the standard startup path going forward instead of background agents.

---

### ISS-004 — Scorer server startup fails on backslash path in bash shell
**Date:** 2026-04-02
**Severity:** Low (recoverable — retry with corrected path succeeded)
**Reproductions:** 1 (2026-05-01)
**Context:** `/tailor-resume` skill — Phase 0 scorer server startup

**What happened:** The skill constructed the venv Python path using a backslash separator (`resume-writer-venv-313\Scripts\python`), which the bash shell could not resolve. First startup attempt failed immediately with "command not found." Retrying with a forward-slash path (`resume-writer-venv-313/Scripts/python`) succeeded and the server started normally.

**Impact:** One failed startup attempt and an extra retry loop. No data loss; server eventually ran correctly.

**Fix needed:** The skill (or the path construction logic) should normalize the venv Python path to forward slashes regardless of OS, since the shell environment is always bash. Alternatively, quote the path and use the OS-appropriate separator only when invoking via `cmd.exe`.

---

## OPEN — Implementation

### ISS-003 — ATS scorer applies wrong domain profile to cross-domain analytics roles
**Date:** 2026-04-01
**Severity:** Medium (scores are severely deflated with no warning; misleads user on resume quality)
**Context:** `/tailor-resume` skill — Phase 3/4 ATS scoring; any JD where domain is misclassified

**What happened (first instance — 2026-04-01):** `ats_scorer.py` detected the HSAG JD as healthcare domain and applied a "Healthcare Operations / Hospital Administration" profile. This profile requires HIPAA, EHR, patient care, JCAHO, and similar clinical terms. HSAG is a healthcare data analytics organization — the Analyst I JD contains none of these clinical terms, and a data analyst resume correctly contains none of them. The scorer penalized the resume for missing clinical vocabulary that is irrelevant to the role, producing an ATS score of ~24%.

**What happened (second instance — 2026-04-02):** `ats_scorer.py` classified Verita (a legal/administrative services firm operating in corporate restructuring and settlement administration) as finance domain and applied an "Investment Banking / Private Equity / Finance" profile. This profile penalizes for missing M&A, DCF, LBO, and other finance keywords. Produced a suppressed ATS score with irrelevant warnings ("Missing critical finance keywords: m&a, ipo, lbo, dcf").

**Impact:** ATS score is misleadingly low. No warning or domain-mismatch flag is emitted to the user. The `domain_adjustments.warnings` field surfaces the issue in JSON output only.

**Workaround:** Note the issue in the report and direct the user to Score_Prompt.txt for LLM-based scoring, which handles cross-domain analytics roles more accurately.

**2026-04-08 update:** Reproduced on RMC Data Analyst run. JD is for a federal government/occupational safety & health role; scorer detected "clinical_research" at 24.9% confidence (barely above noise). Applied clinical research penalties (missing FDA, GCP, IRB, clinical trial keywords) with no relevance to the JD. ATS capped at ~42% as a result.

**2026-04-27 update:** Reproduced on OneMagnify Data Analyst run. JD is for a B2B digital agency; scorer classified domain as "consulting" at 24% confidence and applied a "Management Consulting / Strategy" profile. Penalized resume for missing consulting/strategy/engagement/transformation vocabulary with no relevance to the JD. Base ATS suppressed to 36%; first-pass tailored ATS at 45.7%. Resolved via two keyword iteration rounds to reach 70.8%.

**2026-04-29 update:** Reproduced on Changeis, Inc. Data Analyst EOI run. JD is for a government/federal consulting firm; scorer classified as "finance" (21.3% confidence) and applied Investment Banking/Private Equity profile. Penalized resume for missing M&A, LBO, DCF, financial modeling. Government/federal consulting remains an unrecognized domain after multiple reproductions across government-adjacent roles.

**2026-05-01 update:** Reproduced on Comagine Health Healthcare Data Analyst run. JD is for a nonprofit healthcare quality consulting firm; scorer detected healthcare at 33.5% confidence and applied "Healthcare Operations / Hospital Administration" profile. Penalized resume for missing HIPAA, EHR, JCAHO, patient care, quality improvement — none of which appear in the JD. ATS capped at 36.5%. Same pattern as the first HSAG instance: healthcare analytics/consulting roles misclassified as clinical roles.

**Fix needed:** The domain classifier needs finer-grained profiles. Specifically:
- Distinguish clinical healthcare roles from healthcare analytics/data roles
- Distinguish legal/administrative services firms from finance/investment firms
- Add a government/public sector domain profile
- Add a B2B services / digital agency profile distinct from management consulting
- One approach: add a secondary classification step checking for analytics/data-science signals in the JD before applying a domain-specific vocabulary profile
- Alternatively: suppress domain-specific keyword penalties when the JD title contains "analyst," "data," or "analytics"

---

### ISS-008 — Background scoring agents denied Bash; entire Phase 2/3 agent model non-functional
**Date:** 2026-04-08
**Severity:** Medium (scoring falls back to blocking foreground calls; no data loss but run is slower and sequential)
**Reproductions:** 3 (2026-04-27, 2026-04-29, 2026-04-30)
**Context:** `/tailor-resume` skill — Phase 2 base-scorer agent, Phase 3 tailored-scorer agent

**What happened:** The skill launches base-scorer and tailored-scorer as background `general-purpose` agents (in addition to the scorer server startup agent documented in ISS-001). On this run, all three agent types were denied Bash permission by the user's permission system. The scoring agents returned without running any commands. All scoring fell back to sequential foreground Bash calls in the main thread.

**Impact:** The skill's intended parallel execution model (server + background agents running concurrently while resume is being written) does not function. All scoring is sequential and blocks the main thread. No scoring data is lost — CLI fallback produces the same results — but the run takes longer and the Phase 4 iteration loop cannot run asynchronously.

**Scope distinction from ISS-001:** ISS-001 documents the server startup agent specifically. ISS-008 covers the broader pattern: any background `general-purpose` agent that needs Bash will be denied when the user's permission system is restrictive. The Phase 2/3 scoring design is fundamentally incompatible with this permission model.

**Workaround:** Run all scoring via direct foreground Bash calls. Already the de facto fallback in all recent runs.

**Fix needed:** Either (a) eliminate background scoring agents entirely and run all scoring as foreground Bash calls in the main thread (simpler, matches actual behavior), or (b) design the skill to detect permission failures and auto-fall back without requiring manual intervention. Option (a) is the pragmatic fix — the background agent model has never worked reliably in this project.

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

### ISS-009 — Hyphenated compound words not tokenized to component keywords in ATS scorer
**Date:** 2026-04-08
**Severity:** Low (marginal keyword match impact; easy workaround)
**Context:** `/tailor-resume` skill — Phase 4 ATS keyword matching; any bullet containing hyphenated compounds

**What happened:** During the TRG Data Analyst 1 run, "vendor" was identified as a missing keyword. Added "vendor-side publisher contacts" to an OBMedia bullet to try to pick up the match. Re-score showed "vendor" still listed as missing — zero improvement in keyword_match despite the word being present in the resume as a hyphen-joined token. The ATS scorer tokenizes/stems words individually and does not split hyphenated compounds, so "vendor-side" is treated as a single unknown token rather than "vendor" + "side."

**Impact:** Targeted keyword additions using hyphenated forms (e.g., "vendor-side", "data-driven", "results-oriented") will not register as keyword matches. The edit wastes a bullet slot without achieving its intended ATS improvement.

**Workaround:** Use the target keyword standalone or in a non-hyphenated phrase (e.g., "vendor contacts" instead of "vendor-side contacts").

**Fix needed:** Update the ATS scorer tokenizer to split hyphenated tokens into component words before stemming and matching, so "vendor-side" contributes a match for "vendor."

---

### ISS-010 — ATS scorer flags JD benefits/boilerplate words as missing keywords
**Date:** 2026-04-27
**Severity:** Low (marginal keyword match deflation; easy to identify and ignore)
**Reproductions:** 0
**Context:** `/tailor-resume` skill — Phase 3/4 ATS keyword matching; any JD with a benefits or EEO section

**What happened:** On the OneMagnify Data Analyst run, `ats_scorer.py` listed `dental`, `accommodation`, `vision`, `intolerance`, and `workplace` as missing keywords. All five come from the JD's benefits and EEO boilerplate sections, not the qualifications. ISS-006 documents the HR scorer doing the same thing; this issue covers the ATS scorer exhibiting identical behavior.

**Impact:** Keyword match dimension is artificially deflated. The missing keyword list is noisy, making it harder to identify genuine gaps worth addressing. Adding boilerplate words to the resume would be keyword stuffing with no interview test backing.

**Workaround:** Ignore single common words in the missing keyword list that are clearly from benefits/EEO sections. Focus iteration on missing terms that appear in the qualifications or responsibilities sections of the JD.

**Fix needed:** The ATS scorer's JD keyword extractor should scope extraction to the qualifications/requirements/responsibilities sections only, stopping before any "Benefits," "What we offer," or "Equal opportunity" heading — same fix as ISS-006 but applied to `ats_scorer.py`.

---

### ISS-011 — PowerShell Invoke-RestMethod fails to POST large text bodies to scorer server
**Date:** 2026-05-01
**Severity:** Low (recoverable — Python module call is a reliable fallback)
**Reproductions:** 0
**Context:** `/tailor-resume` skill — Phase 0.5 job fit pre-check; any phase using server endpoints with full resume/JD text in the body

**What happened:** Attempted to call `http://localhost:8100/score/job-fit` via PowerShell `Invoke-RestMethod` with the master resume and JD text embedded as a JSON body (`@{resume_text=$resume; jd_text=$jd} | ConvertTo-Json -Depth 5`). Server returned `{"detail":"There was an error parsing the body"}`. Root cause is likely special character escaping or encoding issues when PowerShell's `ConvertTo-Json` serializes multi-line text with quotes, backslashes, or Unicode — producing malformed JSON that FastAPI's body parser rejects.

**Impact:** Cannot use the scorer server HTTP endpoints from PowerShell with large text payloads. Workaround adds one extra step per scoring call.

**Workaround:** Call the Python scorer modules directly via `venv\Scripts\python -c "from job_fit_scorer import calculate_job_fit, format_report; ..."` instead of using the HTTP endpoint. Produces identical results without the encoding issue.

**Fix needed:** Either (a) write the resume/JD to temp files and pass file paths to the endpoint instead of raw text, (b) use `curl` with a `@file` body reference to avoid PowerShell escaping entirely, or (c) add server-side error handling that logs the malformed body for diagnosis. Option (a) or (b) is the most portable fix.

---

## RESOLVED

### ISS-002 — HR scorer returns 0 on SheetsResume inline date format
**Date:** 2026-03-31 | **Resolved:** 2026-05-01
**Severity:** Medium | **Reproductions:** 8

Three compounding bugs caused `hr_scorer.py` to return `overall_score: 0` / `AUTO-REJECT` ("Experience knockout: 0.0 years") on every resume using the SheetsResume inline date format (`**Company**  Mar. 2025 – Present`):

1. **Template fixed** — dates now appear on their own line below the company name (`**Company**` / `[Mon. Year – Mon. Year]` / `*Job Title*  Location`), eliminating the inline parsing gap.
2. **`date_patterns` regex fixed** — updated `\w+\s+\d{4}` to `\w+\.?\s+\d{4}` so period-abbreviated months (`Mar.`) match the range pattern.
3. **Scorer peekahead guard fixed** — `startswith('*')` exclusion replaced with `re.match(r'^[•\-—]|^\*(?!\*)')` so `**Company**` bold lines are recognized as job-entry anchors; `current_job is None` constraint removed so all jobs in a resume are captured, not just the first.

Note: a secondary issue identified in this bug (scorer ignores "all levels" JD language and applies a hardcoded experience default) is tracked separately and remains open.

---

### ISS-005 — Rule 17 month periods incompatible with scorer date parsers
**Date:** 2026-04-06 | **Resolved:** 2026-05-01
**Severity:** Low | **Reproductions:** 2

Rule 17 mandates period-abbreviated months (`Mar.`, `Aug.`). The scorer's `\w+\s+\d{4}` patterns don't match the period. Fixed in `hr_scorer.py` via: (1) `date_patterns` regex updated to `\w+\.?\s+\d{4}`; (2) `parse_date()` now strips trailing periods from month tokens before matching (`re.sub(r'\b(\w{2,9})\.\s+(\d{4})', r'\1 \2', date_str)`). Rule 17 unchanged — periods in date headers are now tolerated by the scorer.
