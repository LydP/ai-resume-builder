# Issues Log

Technical issues prevent the tool from running correctly (crashes, path errors, environment problems).
Implementation issues degrade output quality but don't break the run (scoring inaccuracies, logic gaps).

**Reproduction policy:** When a known issue reproduces, increment the `Reproductions:` count and date list. Only add a dated update note if the reproduction yields new information (different root cause, new workaround, fix attempt, or meaningful new context). Pure "reproduced again, same behavior" observations belong in the count only.

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

**2026-05-04 update:** Reproduced on Decera Clinical Associate Data & Analytics Engineer run. JD is for a data engineering/analytics role at a life sciences education company; scorer classified as "clinical_research" at 32.8% confidence and applied clinical research penalties (missing FDA, GCP, IRB, pharmacovigilance). ATS capped at ~32%. New finding: the phrase matcher does not extract phrases from the JD text — it checks against a fixed domain phrase dictionary. Even after embedding exact JD phrases verbatim ("data pipelines," "data anomalies," "interactive dashboards and visualizations," "best practices," "analytics-ready"), phrase_score remained 0.0% for the full run because the matcher only checked "Power BI," "medical education," and "medical communications" — the three entries in its clinical_research phrase dictionary. This means phrase_score is effectively zero for any non-clinical role and the dimension contributes nothing to ATS on cross-domain analytics runs.

**2026-05-07 update:** Reproduced on Astound Data Analyst run. JD is for a broadband/telecommunications ISP; scorer classified as "consulting" at 21.2% confidence and applied Management Consulting / Strategy profile. Penalized resume for missing consulting/strategy/engagement keywords with no JD relevance. ATS total score 43.3% despite weighted keyword score of 68.2%. New JD category confirmed: telecom/ISP companies are now a documented misclassification target alongside healthcare analytics, government, legal, and B2B digital agency.

**2026-05-11 update:** Reproduced on TriWest Healthcare Alliance Data Analyst run. JD is for a military TRICARE benefits administration company; scorer detected healthcare at 26% confidence and applied "Healthcare Operations / Hospital Administration" profile. Penalized resume for missing HIPAA, EHR, patient care, JCAHO, quality improvement — none of which appear in the JD. ATS capped at 66.7%, barely clearing the 65% threshold. Eighth documented misclassification of a healthcare analytics or benefits administration role as a clinical/hospital role.

**2026-05-19 update:** Reproduced on Affirm Analyst I, Full Stack (Core Analytics) run. JD is for a fintech/BNPL analytics engineering role; scorer classified as "consulting" (28.6% confidence) and applied Management Consulting / Strategy penalties. Penalized resume for missing consulting/engagement/transformation vocabulary irrelevant to the JD. New domain documented: fintech / BNPL / lending analytics is now a confirmed misclassification target alongside healthcare analytics, government, legal, B2B digital, and telecom.

**2026-05-18 update:** Reproduced on Aquent Data Analyst 1 run. JD is for a supply chain data analyst role at a major technology company; scorer classified domain as "consulting" (23.7%) instead of "technology" (21.6%) and applied Management Consulting / Strategy penalties. New trigger identified: the JD was staffing-agency-wrapped — Aquent's own boilerplate ("Aquent Talent connects the best talent in marketing, creative, and design...") introduced consulting-adjacent language that pulled the classifier. Prior ISS-003 instances involved misclassification from the end-client's own JD language; this is the first confirmed case where the staffing agency wrapper caused the misclassification on an otherwise clearly technology-domain JD. ATS capped at 56.5% after two iterations; structural floor imposed by missing "supply chain" phrase (domain gap — not addressable) and consulting penalties in combination.

**Fix needed:** The domain classifier needs finer-grained profiles. Specifically:
- Distinguish clinical healthcare roles from healthcare analytics/data roles
- Distinguish legal/administrative services firms from finance/investment firms
- Add a government/public sector domain profile
- Add a B2B services / digital agency profile distinct from management consulting
- One approach: add a secondary classification step checking for analytics/data-science signals in the JD before applying a domain-specific vocabulary profile
- Alternatively: suppress domain-specific keyword penalties when the JD title contains "analyst," "data," or "analytics"

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
**Reproductions:** 4 (2026-05-07, 2026-05-11, 2026-05-18, 2026-05-19)
**Context:** `/tailor-resume` skill — Phase 3/4 ATS keyword matching; any JD with a benefits or EEO section

**What happened:** On the OneMagnify Data Analyst run, `ats_scorer.py` listed `dental`, `accommodation`, `vision`, `intolerance`, and `workplace` as missing keywords. All five come from the JD's benefits and EEO boilerplate sections, not the qualifications. ISS-006 documents the HR scorer doing the same thing; this issue covers the ATS scorer exhibiting identical behavior.

**2026-05-07 update:** Reproduced on Astound Data Analyst run. The Astound JD has an extensive EEO disclaimer section; scorer injected "disability", "marital", "sex", and "dedicated" into missing_keywords. Additionally, two completely spurious tokens — "doctor" and "tui" — appeared in missing_keywords with no apparent source in the JD text. These may be stemming over-truncation artifacts (e.g., a long word reduced to an unrecognizable stem) or domain vocabulary lookup side effects. Root cause unclear; flagged for investigation.

**2026-05-11 update:** Reproduced on TriWest Healthcare Alliance Data Analyst run. Missing keywords included: `gender` and `basis` (from EEO disclaimer — "on the basis of race, color... gender identity"), `retirement` (from benefits section — "401(k) Retirement Savings Plan"), and `others`, `sure`, `matt` (stemming artifacts or boilerplate prose). `matt` has no identifiable source in the JD text — consistent with the spurious token pattern first noted in the Astound run.

**Impact:** Keyword match dimension is artificially deflated. The missing keyword list is noisy, making it harder to identify genuine gaps worth addressing. Adding boilerplate words to the resume would be keyword stuffing with no interview test backing.

**Workaround:** Ignore single common words in the missing keyword list that are clearly from benefits/EEO sections. Focus iteration on missing terms that appear in the qualifications or responsibilities sections of the JD.

**Fix needed:** The ATS scorer's JD keyword extractor should scope extraction to the qualifications/requirements/responsibilities sections only, stopping before any "Benefits," "What we offer," or "Equal opportunity" heading — same fix as ISS-006 but applied to `ats_scorer.py`.

---

### ISS-011 — PowerShell Invoke-RestMethod fails to POST large text bodies to scorer server
**Date:** 2026-05-01
**Severity:** Low (recoverable — Python module call is a reliable fallback)
**Reproductions:** 1 (2026-05-18)
**Context:** `/tailor-resume` skill — Phase 0.5 job fit pre-check; any phase using server endpoints with full resume/JD text in the body

**What happened:** Attempted to call `http://localhost:8100/score/job-fit` via PowerShell `Invoke-RestMethod` with the master resume and JD text embedded as a JSON body (`@{resume_text=$resume; jd_text=$jd} | ConvertTo-Json -Depth 5`). Server returned `{"detail":"There was an error parsing the body"}`. Root cause is likely special character escaping or encoding issues when PowerShell's `ConvertTo-Json` serializes multi-line text with quotes, backslashes, or Unicode — producing malformed JSON that FastAPI's body parser rejects.

**Impact:** Cannot use the scorer server HTTP endpoints from PowerShell with large text payloads. Workaround adds one extra step per scoring call.

**Workaround:** Call the Python scorer modules directly via `venv\Scripts\python -c "from job_fit_scorer import calculate_job_fit, format_report; ..."` instead of using the HTTP endpoint. Produces identical results without the encoding issue.

**Fix needed:** Either (a) write the resume/JD to temp files and pass file paths to the endpoint instead of raw text, (b) use `curl` with a `@file` body reference to avoid PowerShell escaping entirely, or (c) add server-side error handling that logs the malformed body for diagnosis. Option (a) or (b) is the most portable fix.

---

### ISS-012 — Gerund/inflected verb forms not matched to JD stemmed keywords in ATS scorer
**Date:** 2026-05-07
**Severity:** Low (silent failure — targeted keyword addition produces no improvement with no feedback)
**Reproductions:** 1 (2026-05-19)
**Context:** `/tailor-resume` skill — Phase 4 ATS keyword iteration; any targeted keyword addition using an inflected verb form

**What happened:** On the Astound Data Analyst run, "partner" appeared in `missing_weighted` and "partn" in `missing_keywords`. Added "**partnering**" to an OBMedia bullet to address the gap. After two re-scores, "partn" remained in `missing_keywords` and "partner" remained in `missing_weighted` — zero improvement. Other bolded terms in the same resume (SQL, KPIs, actionable, cross-functional) were correctly matched, ruling out bold markup as the cause. The present participle "partnering" appears not to stem to the same token as the base form "partner" in the scorer's pipeline, even though Porter stemming should reduce both to "partner."

**Impact:** Targeted keyword additions using gerund forms ("partnering", and potentially others) silently fail — the iteration round is wasted with no score improvement and no error or warning to diagnose the mismatch.

**Workaround:** Use the base noun or verb form of the target keyword rather than a gerund (e.g., "partner with" or "in partnership with" rather than "partnering with"). Verify by checking whether the target stem appears in `matched_keywords` after re-scoring.

**2026-05-19 update:** Reproduced — confirmed that past-tense forms also fail, not just gerunds. Both "partnering" and "partnered" failed to match the weighted keyword "partner." Only the bare noun form ("analytics **partner** to...") produced a match. The issue extends beyond gerunds to simple past-tense verb forms. The stemmer appears to recognize "partner" as a noun stem but does not reduce "partnered" or "partnering" to that same stem.

**Relationship to ISS-009:** ISS-009 covers hyphenated compounds not being split before stemming. This issue covers a different tokenization failure — inflected verb forms not reducing to the same stem as their base form. Both result in a targeted keyword being present in the resume text but unrecognized by the matcher.

**Fix needed:** Investigate whether the scorer's stemmer processes "partnering" differently than "partner." If so, normalize inflected forms to their base before stemming, or add a pre-stemming lemmatization step so "partnering" → "partner" before the stem lookup runs.

---

### ISS-014 — ATS readability penalty applied to Rule-15-compliant company overview bullets
**Date:** 2026-05-11
**Severity:** Low (consistent −3 point ATS penalty on every run; narrows margin above 65% threshold)
**Reproductions:** 2 (2026-05-18, 2026-05-19)
**Context:** `/tailor-resume` skill — Phase 3/4 ATS scoring; any resume following Rule 15 format

**What happened:** On the TriWest Healthcare Alliance Data Analyst run, the ATS scorer applied a −3 point readability penalty (Flesch-Kincaid Grade 19.6, "Too Complex — Academic"). The complexity is driven primarily by the company overview lead bullets required by Rule 15 — these bullets describe revenue, headcount, exchange listings, global footprint, and market position, producing long, noun-dense sentences that register as academic to the readability scorer. Without the penalty the ATS score would have been 69.7% instead of 66.7%; in this run the score still cleared the 65% threshold but the margin was thin.

**Structural tension:** Rule 15 prioritizes human credibility ("borrow validity from the company's numbers"). The ATS readability scorer penalizes the same sentences for length and complexity. These two objectives are in direct conflict — following the mandated format costs 3 ATS points on every run with no current resolution path.

**Impact:** Every resume using the mandated format takes a consistent −3 ATS penalty. For roles where the underlying keyword match lands near the 65% floor, this can push the score below threshold and trigger unnecessary iteration rounds. The penalized content is not a quality defect; it is a required structural element.

**Workaround:** Accept the −3 penalty as a fixed cost of the format. Evaluate ATS proximity to the 65% threshold on a mentally-adjusted basis (add 3 points). Do not shorten company overview bullets to improve readability score — that degrades HR quality.

**Fix needed:** Either (a) exclude the first bullet of each role block from readability scoring, since company overview leads are descriptive rather than analytical, or (b) add a pattern exception: if a bullet matches a company overview signature (starts with company name, contains revenue/headcount/ticker/employee count indicators), exempt it from the readability grade calculation.

---

### ISS-016 — Job Fit Scorer: JD title extraction fails; better-fit titles pulled from wrong domain
**Date:** 2026-05-13
**Severity:** Low (cosmetic output errors; fit score itself appears unaffected)
**Reproductions:** 2 (2026-05-18, 2026-05-19)
**Context:** `/tailor-resume` skill — Phase 1.5 job fit pre-check

**What happened:** Two bugs surfaced in `calculate_job_fit` output on the Celigo Data Analyst run:

1. **Title extraction failure:** The FIXABLE GAPS section showed the entire JD text body as the "Target title" instead of extracting "Data Analyst." The title extractor failed to isolate the job title from the JD, falling back to the raw input string.

2. **Wrong better-fit titles:** BETTER-FIT JOB TITLES returned "Medical Monitor," "Drug Safety Physician," "Associate Medical Director," "Medical Science Liaison (MSL)," and "Clinical Scientist" — clinical medicine roles — for a Data Analyst resume against a SaaS Data Analyst JD. Domain was correctly classified as technology (27.9% confidence). The alternative title recommendation logic appears to ignore the domain classification and pull from an incorrectly mapped list — possibly defaulting to clinical_research titles when no domain clears a confidence threshold (none reached ≥30% in this run).

**Impact:** The BETTER-FIT JOB TITLES output is misleading and could cause the user to incorrectly conclude the role has disqualifying clinical requirements. The raw JD text appearing as "Target title" in the gaps section is cosmetically wrong. The fit score (70.3/100 Moderate Fit) appeared correct despite both display errors.

**Workaround:** Ignore BETTER-FIT JOB TITLES when the recommended titles are clearly from an unrelated domain. The numeric fit score is the reliable signal; the title suggestions are not.

**Fix needed:** (1) Fix title extraction — parse the `Job Title: {title}` prefix that the skill prepends to `job_description.txt`, or extract the title from the first non-boilerplate line of the JD before passing it to the scorer. (2) Fix better-fit title recommendations — gate suggestions on the detected domain, or suppress them when domain confidence is below a meaningful threshold (e.g., <40%).

---

## RESOLVED

### ISS-001 — Scorer server fails to persist across shell session
**Date:** 2026-03-30 | **Resolved:** 2026-05-19
**Severity:** Low (CLI fallback available)
**Reproductions:** 12 (2026-03-31, 2026-04-01, 2026-04-07, 2026-04-08, 2026-04-27, 2026-04-30, 2026-05-04, 2026-05-07, 2026-05-11, 2026-05-13, 2026-05-18, 2026-05-19)
**Context:** `/tailor-resume` skill — Phase 0 scorer server startup

**What happened:** The scorer server was launched via a background `Agent` tool call. The agent attempted to use the Bash tool but could not surface a permission approval prompt to the user while running in the background. Server never started; all scoring fell back to direct CLI calls (`ats_scorer.py`, `hr_scorer.py`).

**Impact:** Scoring ran ~30–60s slower than expected (CLI vs. server). No data loss or incorrect output.

**2026-03-31 update:** Fix attempted — direct `Bash` call with `start /B` + `run_in_background: true`. Still failed (exit code 1, server crash). Root cause unclear; may be a Windows `start /B` incompatibility in the bash shell environment. CLI fallback continues to work. Further investigation needed.

**2026-04-01 update:** Tried `run_in_background: true` with `&` appended to the command. Server process started but exited immediately with code 0. Root cause: bash kills background processes when the parent shell session exits. The "direct Bash call" fix does not work — the subprocess lifecycle is tied to the shell session. CLI fallback remains the only working path. Fix likely requires a persistent server started outside Claude Code (e.g., user runs it manually in a terminal before invoking the skill).

**2026-04-08 update:** See ISS-008 — the denial pattern is broader than server startup. The Phase 2/3 scoring agents (base-scorer, tailored-scorer) were also denied Bash in this run. The entire background agent model is non-functional when the user's permission system is restrictive.

**2026-04-30 update:** PowerShell `Start-Process -FilePath "venv\Scripts\python.exe" -ArgumentList "scorer_server.py --port 8100" -WindowStyle Hidden` successfully started the scorer server as a persistent Windows process detached from the Claude Code session. Server was healthy within ~10 seconds and handled all scoring for the run without issue. This is the first confirmed working server startup method across all runs. Use this PowerShell call as the standard startup path going forward instead of background agents.

**2026-05-07 update:** New finding — `run_in_background: true` in the Bash tool WITHOUT `&` appended successfully kept the server alive for the full session. The 2026-04-01 update documented that `run_in_background: true` WITH `&` caused the process to exit immediately (code 0). This run shows the opposite: omitting `&` allowed the process to persist. Background Bash may be viable as a startup path if `&` is not appended. Needs further validation before updating the recommended startup method.

**2026-05-11 update:** Server not running at session start — reproduction confirmed. New data point: started with `run_in_background: true` AND `&` appended (`venv/Scripts/python scorer_server.py --port 8100 &`). Background task reported exit code 0 (consistent with 2026-04-01), but server was alive and healthy ~30 seconds later. This contradicts the 2026-04-01 finding that `&` + `run_in_background` kills the subprocess, and suggests the behavior may be environment-dependent or intermittent. Both `with &` and `without &` have now each produced a working server in at least one run — further validation needed to determine which form is consistently reliable across sessions.

**2026-05-13 update:** Server not running at session start — reproduction confirmed. New startup path tested: `nohup venv/Scripts/python scorer_server.py --port 8100 &` as a regular foreground Bash call (no `run_in_background: true`). Server was healthy within ~20 seconds. `nohup` explicitly detaches the process from the parent shell, which may explain why this form is more reliable than the `run_in_background` variants — the server lifecycle is not tied to the Bash session at all. Candidate for the recommended startup method; needs validation across sessions.

**2026-05-19 — RESOLVED:** Scorer server removed from the tailor-resume skill entirely. All scoring now runs via direct CLI calls (`ats_scorer.py`, `hr_scorer.py`, `job_fit_scorer.py`). Phase 0 is now a simple setup step (read config, construct venv path) with no server health check or startup logic. This issue cannot reproduce in its current form.

---

### ISS-004 — Scorer server startup fails on backslash path in bash shell
**Date:** 2026-04-02 | **Resolved:** 2026-05-19
**Severity:** Low (recoverable — retry with corrected path succeeded)
**Reproductions:** 6 (2026-05-01, 2026-05-04, 2026-05-05, 2026-05-07, 2026-05-18, 2026-05-19)
**Context:** `/tailor-resume` skill — Phase 0 scorer server startup

**What happened:** The skill constructed the venv Python path using a backslash separator (`resume-writer-venv-313\Scripts\python`), which the bash shell could not resolve. First startup attempt failed immediately with "command not found." Retrying with a forward-slash path (`resume-writer-venv-313/Scripts/python`) succeeded and the server started normally.

**Impact:** One failed startup attempt and an extra retry loop. No data loss; server eventually ran correctly.

**2026-05-19 — RESOLVED:** Server startup removed from the skill. Phase 0 now specifies forward slashes explicitly ("use forward slashes always") for all venv path construction. Both the underlying cause (backslash path) and the context (server startup) are gone.

---

### ISS-008 — Background scoring agents denied Bash; entire Phase 2/3 agent model non-functional
**Date:** 2026-04-08 | **Resolved:** 2026-05-19
**Severity:** Medium (scoring falls back to blocking foreground calls; no data loss but run is slower and sequential)
**Reproductions:** 4 (2026-04-27, 2026-04-29, 2026-04-30, 2026-05-04)
**Context:** `/tailor-resume` skill — Phase 2 base-scorer agent, Phase 3 tailored-scorer agent

**What happened:** The skill launches base-scorer and tailored-scorer as background `general-purpose` agents (in addition to the scorer server startup agent documented in ISS-001). On this run, all three agent types were denied Bash permission by the user's permission system. The scoring agents returned without running any commands. All scoring fell back to sequential foreground Bash calls in the main thread.

**Impact:** The skill's intended parallel execution model (server + background agents running concurrently while resume is being written) does not function. All scoring is sequential and blocks the main thread. No scoring data is lost — CLI fallback produces the same results — but the run takes longer and the Phase 4 iteration loop cannot run asynchronously.

**Scope distinction from ISS-001:** ISS-001 documents the server startup agent specifically. ISS-008 covers the broader pattern: any background `general-purpose` agent that needs Bash will be denied when the user's permission system is restrictive. The Phase 2/3 scoring design is fundamentally incompatible with this permission model.

**2026-05-19 — RESOLVED:** Background scoring agents removed from the skill. Phases 2 and 3 are now sequential foreground CLI calls — write resume, then score base, then score tailored. The parallel agent model is eliminated. Sequential foreground execution was already the de facto behavior on every run; the skill now matches reality.

---

### ISS-013 — `localhost` not resolving to `127.0.0.1` in bash/curl; health check fails with server running
**Date:** 2026-05-07 | **Resolved:** 2026-05-19
**Severity:** Low (causes false "server not running" detection and an extra retry loop; server is usable once correct hostname is found)
**Reproductions:** 0
**Context:** `/tailor-resume` skill — Phase 0 scorer server health check

**What happened:** After the scorer server started successfully (background task output confirmed "Uvicorn running on http://127.0.0.1:8100"), `curl http://localhost:8100/health` returned exit code 7 (connection refused). Switching to `curl http://127.0.0.1:8100/health` succeeded immediately. The server binds to `127.0.0.1` by default; in this environment `localhost` does not resolve to `127.0.0.1`. Likely cause: Windows resolves `localhost` to `::1` (IPv6 loopback) first, but the server only listens on the IPv4 loopback address. The bash/curl environment inherits this resolution order.

**Impact:** The skill's health check (`curl -s http://localhost:8100/health`) produces a false negative — the server appears down when it is actually running. This triggered an unnecessary retry loop and added delay before scoring could proceed.

**2026-05-19 — RESOLVED:** Server and all curl health check calls removed from the skill. No localhost or 127.0.0.1 references remain. This issue is moot.

---

### ISS-015 — `jq` not installed; Phase 0.5 job-fit curl body construction fails
**Date:** 2026-05-13 | **Resolved:** 2026-05-19
**Severity:** Low (recoverable — Python module fallback works)
**Reproductions:** 0
**Context:** `/tailor-resume` skill — Phase 0.5 job fit pre-check

**What happened:** The Phase 0.5 skill instructions showed using `jq` to construct the JSON body for the curl POST to `/score/job-fit`. `jq` is not installed in the bash environment, causing the command to fail with "command not found" and the server to receive an empty body (422 Unprocessable Entity). Note: a later skill revision replaced jq with curl placeholder strings, but the underlying problem (embedding large text in a shell HTTP call is fragile) remained.

**Impact:** The Phase 0.5 job-fit pre-check could not run via the curl approach in this environment.

**2026-05-19 — RESOLVED:** Phase 0.5 renamed Phase 1.5 and moved to after Phase 1 (when `job_description.txt` already exists on disk). Now uses `job_fit_scorer.py --check {resume_path} {jd_path} --json` — a CLI call with file paths. No curl, no jq, no text embedding in shell arguments. Both the dependency and the design that required it are gone.

---

### ISS-017 — Scorer server caches results by file path; stale scores returned after resume edit
**Date:** 2026-05-19 | **Resolved:** 2026-05-19
**Severity:** Low (recoverable — CLI fallback produces correct results; misleading if not caught)
**Reproductions:** 0
**Context:** `/tailor-resume` skill — Phase 4 iteration re-scoring after in-place resume edits

**What happened:** After editing `resume.md` during a Phase 4 iteration round, calling `POST /score/both` via the scorer server returned scores identical to the previous call (ATS 59.4, HR 68.9) despite the file content having changed. The matched/missing keyword lists were also identical. Running `ats_scorer.py` and `hr_scorer.py` directly via Python CLI produced updated scores reflecting the edits (ATS 62.1). The server appears to cache scoring results keyed on the file path without checking the file's modification time.

**Impact:** During Phase 4 iteration, stale server scores can mask the effect of keyword additions and cause the skill to either (a) conclude an iteration had no effect when it did, or (b) trigger unnecessary additional iteration rounds.

**2026-05-19 — RESOLVED:** Server removed from the skill. All scoring — including Phase 4 iteration re-scoring — now uses direct CLI calls (`ats_scorer.py`, `hr_scorer.py`). CLI calls read files fresh on every invocation with no caching layer. Stale scores are no longer possible in normal skill operation.

---

### ISS-002 — HR scorer returns 0 on SheetsResume inline date format
**Date:** 2026-03-31 | **Resolved:** 2026-05-05 | **Reopened:** 2026-05-05 | **Re-resolved:** 2026-05-05
**Severity:** Medium | **Reproductions:** 9

Three compounding bugs caused `hr_scorer.py` to return `overall_score: 0` / `AUTO-REJECT` ("Experience knockout: 0.0 years") on every resume using the SheetsResume inline date format (`**Company**  Mar. 2025 – Present`):

1. **Template fixed** — dates now appear on their own line below the company name (`**Company**` / `[Mon. Year – Mon. Year]` / `*Job Title*  Location`), eliminating the inline parsing gap.
2. **`date_patterns` regex fixed** — updated `\w+\s+\d{4}` to `\w+\.?\s+\d{4}` so period-abbreviated months (`Mar.`) match the range pattern.
3. **Scorer peekahead guard fixed** — `startswith('*')` exclusion replaced with `re.match(r'^[•\-—]|^\*(?!\*)')` so `**Company**` bold lines are recognized as job-entry anchors; `current_job is None` constraint removed so all jobs in a resume are captured, not just the first.

Note: a secondary issue identified in this bug (scorer ignores "all levels" JD language and applies a hardcoded experience default) is tracked separately and remains open.

**2026-05-05 update — REOPENED:** HR scored 0 again on both the Comagine Health base template and the Claritev tailored resume ("Experience knockout: 0.0 years vs 1.0 required"). Root cause: both resumes used the inline date format (`**TELUS Digital**  Mar. 2025 – Present`) — the old format the template fix was supposed to eliminate. The Comagine Health resume predates the fix and was never updated, and the LLM generated the new tailored resume in the same inline style rather than the corrected spec format (`**Company**` / `[Mon. Year – Mon. Year]` / `*Job Title*  Location`). The scorer regex fix (item 2 above) is in place but insufficient on its own — the peekahead guard fix (item 3) appears to depend on the date being on a separate line to anchor correctly. Practical result: any resume generated by copying an old base template, or any run where the LLM defaults to the inline style, will still trigger this bug. The fix is not holding in practice.

**2026-05-05 update — RE-RESOLVED:** Added a dedicated `sheets_match` parsing branch in `hr_scorer.py` that handles the SheetsResume bold company line (`^\*\*(.+?)\*\*`) regardless of whether the date appears inline or on its own line. When a bold company line is detected, the branch extracts the company name, scans the same line for an inline date range, and peeks ahead up to 3 lines for an italic job title (`^\*(?!\*)`). This makes the scorer format-agnostic — both the inline format and the three-line format now parse correctly. Verified: all 7 jobs detected on the Claritev resume (11.42 years total), HR score 69.3 (up from 0). No template or skill changes required.

---

### ISS-005 — Rule 17 month periods incompatible with scorer date parsers
**Date:** 2026-04-06 | **Resolved:** 2026-05-01
**Severity:** Low | **Reproductions:** 2

Rule 17 mandates period-abbreviated months (`Mar.`, `Aug.`). The scorer's `\w+\s+\d{4}` patterns don't match the period. Fixed in `hr_scorer.py` via: (1) `date_patterns` regex updated to `\w+\.?\s+\d{4}`; (2) `parse_date()` now strips trailing periods from month tokens before matching (`re.sub(r'\b(\w{2,9})\.\s+(\d{4})', r'\1 \2', date_str)`). Rule 17 unchanged — periods in date headers are now tolerated by the scorer.
