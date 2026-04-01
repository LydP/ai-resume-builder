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

**2026-04-01 update:** Tried `run_in_background: true` with `&` appended to the command. Server process started but exited immediately with code 0. Root cause: bash kills background processes when the parent shell session exits. The "direct Bash call" fix does not work — the subprocess lifecycle is tied to the shell session. CLI fallback remains the only working path. Fix likely requires a persistent server started outside Claude Code (e.g., user runs it manually in a terminal before invoking the skill).

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

### ISS-003 — ATS scorer applies clinical healthcare profile to data analytics roles at healthcare companies
**Date:** 2026-04-01
**Severity:** Medium (scores are severely deflated with no warning; misleads user on resume quality)
**Context:** `/tailor-resume` skill — Phase 3/4 ATS scoring; any JD where healthcare domain is detected

**What happened:** `ats_scorer.py` detected the HSAG JD as healthcare domain and applied a "Healthcare Operations / Hospital Administration" profile. This profile requires HIPAA, EHR, patient care, JCAHO, and similar clinical terms. HSAG is a healthcare data analytics organization — the Analyst I JD contains none of these clinical terms, and a data analyst resume correctly contains none of them. The scorer penalized the resume for missing clinical vocabulary that is irrelevant to the role, producing an ATS score of ~24% on a resume that is a reasonable authentic fit.

**Impact:** ATS score is misleadingly low. No warning or domain-mismatch flag is emitted. The `domain_adjustments.warnings` field shows "Missing critical healthcare keywords: patient care, quality improvement, jcaho, hipaa, ehr" — surfaced in JSON output only, not reported to the user by the skill.

**Workaround:** Note the issue in the report and direct the user to Score_Prompt.txt for LLM-based scoring, which handles cross-domain analytics roles more accurately.

**Fix needed:** `ats_scorer.py` should distinguish between clinical healthcare roles (hospital, nursing, patient care, clinical research) and healthcare analytics/data science roles. One approach: add a secondary domain classification step that checks for analytics/data-science signals before applying the clinical profile. Alternatively, suppress clinical keyword requirements when the JD title contains "analyst," "data," or "analytics."

---

## RESOLVED

*(none yet)*
