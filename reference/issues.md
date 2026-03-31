# Issues Log

---

## OPEN

### ISS-001 — Scorer server agent blocked on Bash permissions
**Date:** 2026-03-30
**Severity:** Low (CLI fallback available)
**Context:** `/tailor-resume` skill — Phase 0 scorer server startup

**What happened:** The scorer server was launched via a background `Agent` tool call. The agent attempted to use the Bash tool but could not surface a permission approval prompt to the user while running in the background. Server never started; all scoring fell back to direct CLI calls (`ats_scorer.py`, `hr_scorer.py`).

**Impact:** Scoring ran ~30–60s slower than expected (CLI vs. server). No data loss or incorrect output.

**Fix:** Start the scorer server with a direct `Bash` tool call in the main conversation thread (where the user can approve it), not via a background agent.

**2026-03-31 update:** Fix attempted — direct `Bash` call with `start /B` + `run_in_background: true`. Still failed (exit code 1, server crash). Root cause unclear; may be a Windows `start /B` incompatibility in the bash shell environment. CLI fallback continues to work. Further investigation needed.

---

### ISS-002 — HR scorer returns 0 on SheetsResume inline date format
**Date:** 2026-03-31
**Severity:** Medium (scores are silently wrong; no error surfaced to user)
**Context:** `/tailor-resume` skill — Phase 3 tailored HR scoring

**What happened:** `hr_scorer.py` returned `overall_score: 0` / `AUTO-REJECT` with reason "Experience knockout: 0.0 years vs 5.0 required" when scoring a resume using the SheetsResume inline format:
```
**Company Name**  Mar. 2025 – Present
*Job Title*  Remote
```
The same resume content in the traditional multi-line format (company on one line, date on next) scored 71.3% on the same JD. The scorer cannot parse experience duration from the inline layout and defaults to 0 years, triggering a knockout.

**Impact:** HR score is silently wrong (shows 0 instead of ~71%). No warning or error emitted; requires manual detection.

**Workaround:** Use base HR score from a previously scored resume with the same content as a proxy. Document discrepancy in report.

**Fix needed:** Either update `hr_scorer.py` to parse inline date format, or switch the skill's resume template to use the multi-line date format the scorer expects.

---

## RESOLVED

*(none yet)*
