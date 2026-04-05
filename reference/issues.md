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

**Fix needed:** The domain classifier needs finer-grained profiles. Specifically:
- Distinguish clinical healthcare roles from healthcare analytics/data roles
- Distinguish legal/administrative services firms from finance/investment firms
- One approach: add a secondary classification step checking for analytics/data-science signals in the JD before applying a domain-specific vocabulary profile
- Alternatively: suppress domain-specific keyword penalties when the JD title contains "analyst," "data," or "analytics"

---

## RESOLVED

*(none yet)*
