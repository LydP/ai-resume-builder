# Tailor Resume Only (ATS + HR Optimized) — Swarm v3.0

Optimize and tailor the resume using parallel tool calls for maximum speed. Target: 65%+ ATS + 70%+ HR with AUTHENTIC content (human-first SheetsResume format).

## Job Description
$ARGUMENTS

## Instructions

You are an expert ATS optimization specialist. The user has provided a job description above. Execute the following phases in order.

---

## PHASE 0: SETUP

Read `config.json` to get `venv_name`, then construct the venv Python path using **forward slashes always** (bash shell requires forward slashes even on Windows):
- **Windows:** `{venv_name}/Scripts/python`
- **Mac/Linux:** `{venv_name}/bin/python`

Use this path (referred to as `{venv_python}` throughout this command) for all Python invocations.

---

## PHASE 1: PARALLEL RESEARCH (launch all simultaneously)

**Before launching parallel actions**, ask the user:
> "Please provide the company name and job title for this application:"

Wait for the user's response and store the values as `{CompanyName}` and `{JobTitle}`.

Then execute these **3 actions in a single parallel tool call** (no agents — use Read, Glob, Write tools simultaneously):

**Action A — Find best matching resume:**
- Use `Glob` to find all `applications/**/resume.md` files
- From folder names (`{Company} - {JobTitle}`), identify the most semantically similar role
- **If match found (PREFERRED)**: Read the `resume.md` directly with the Read tool
- **If no match**: Fall back to the master resume (read `config.json` for `master_resume_path`, or glob for `*MASTER*RESUME*.md`)

**Action B — Read master resume:**
- Read the master resume (path from `config.json` → `master_resume_path`) for canonical job titles, dates, company names, education, certifications, publications, memberships (NEVER change these)
- **Format-aware reading:** Use `Read` tool directly.
- **How to interpret the master resume structure:**
  - **Named projects (`####` headings):** Three-part format — prose paragraph (primary synthesis source; generate bullets from this), `**Tools:**` line (keyword metadata; scan for JD matching), `**Details:**` sub-list (reference only; consult when the JD calls for something specific; never enumerate directly into output bullets)
  - **Daily Responsibilities:** Captures routine work not tied to named projects; synthesize as-needed based on JD relevance — fills in role scope and day-to-day demands that projects don't cover
  - **Flat labeled sections (Role Context, Technical Context, etc.):** Structured lookup; scan for keywords, tools, platforms, scale

**Action C — Setup output:**
- Create output folder: `applications/{CompanyName} - {JobTitle}/`
- Save JD as `job_description.txt`, prepending `Job Title: {JobTitle}\n\n` before the JD content

---

## PHASE 1.5: JOB FIT PRE-CHECK (mandatory gate)

Now that `job_description.txt` is saved, run the Job Fit Scorer:

```bash
{venv_python} job_fit_scorer.py --check "{master_resume_path}" "applications/{CompanyName} - {JobTitle}/job_description.txt" --json
```

**Decision gate:**
- **STRONG FIT (75+)**: Proceed to Phase 2.
- **MODERATE FIT (55-74)**: Proceed — show the user fixable gaps and note them for writing.
- **WEAK FIT (35-54)**: PAUSE. Show the user the report and ask: "This job is a weak fit (score: X). [Show knockouts/gaps]. Continue anyway?"
- **NO-GO (<35 or hard knockouts)**: STOP. Show the full report with knockouts and alternative job titles. Do NOT proceed. Tell the user: "This job has disqualifying requirements: [list knockouts]. Better-fit roles: [alternatives]."

Display the fit score, any knockouts, and key dimensions before proceeding.

---

## PHASE 2: WRITE TAILORED RESUME

Generate the tailored resume (see RESUME WRITING RULES below).

Save as `resume.md` in the output folder.

**After saving `resume.md`, extract and save JD keywords.**

Analyze the job description and list the keywords and phrases you intentionally targeted when writing the resume. Save as `applications/{CompanyName} - {JobTitle}/jd_keywords.json`:

```json
{
  "domain": "<clinical_research|pharma_biotech|technology|finance|consulting|general>",
  "keywords": [
    {"term": "<single word or short compound noun>", "weight": 3}
  ],
  "phrases": [
    {"term": "<multi-word phrase that should appear verbatim>", "weight": 2}
  ]
}
```

Weight scale: **3** = core requirement (repeated, role-defining, knockout if absent), **2** = important (clearly desired, prominently featured), **1** = contextual (mentioned once, nice-to-have).

Keywords vs phrases: `keywords` are terms ATS systems match individually; `phrases` are sequences that must appear verbatim. If a term fits both, put it in `phrases` only.

Rules: Max 40 keywords, max 20 phrases. Only include terms actually present in the JD. All lowercase. Omit generic filler ("experience", "strong", "ability to").

**If `generate_score_prompt: true` in `config.json`** — after saving `resume.md`, generate a manual score prompt:
1. Read the template at `reference/llm_score_prompt.txt`
2. Replace `{jd_text}` with the full job description text
3. Replace `{resume_text}` with the full contents of `resume.md`
4. Replace `{domain_context}` with a 1-2 sentence domain note based on the JD (e.g., "Domain context: This is a clinical research/pharma role. Prioritize regulatory compliance, GCP, and protocol management experience.")
5. Save the filled-in template as `applications/{folder}/Score_Prompt.txt`
6. Inform the user: "Score_Prompt.txt saved to the output folder. Paste its contents into Claude.ai to receive ATS + HR scores as JSON."

---

## PHASE 3: SCORE BASE + TAILORED RESUME

Once `resume.md` is saved, run four sequential CLI calls to score both the base template and the tailored resume:

**Base template scores:**
```bash
{venv_python} ats_scorer.py --score "{base_template_path}" "applications/{CompanyName} - {JobTitle}/job_description.txt" --json
{venv_python} hr_scorer.py --score "{base_template_path}" "applications/{CompanyName} - {JobTitle}/job_description.txt" --json
```

**Tailored resume scores:**
```bash
{venv_python} ats_scorer.py --score "applications/{CompanyName} - {JobTitle}/resume.md" "applications/{CompanyName} - {JobTitle}/job_description.txt" --jd-keywords "applications/{CompanyName} - {JobTitle}/jd_keywords.json" --json
{venv_python} hr_scorer.py --score "applications/{CompanyName} - {JobTitle}/resume.md" "applications/{CompanyName} - {JobTitle}/job_description.txt" --json
```

Store all four scores for the Phase 6 comparison table.

---

## PHASE 4: SCORE CHECK + ITERATION (max 2 rounds)

1. **Evaluate tailored scores:**

```
IF ATS < 65%:
    → Reframe 2-3 bullet points with JD language where natural
    → Add JD-relevant items to Skills bullet in the combined bottom section
    → Re-score:
       {venv_python} ats_scorer.py --score "applications/{folder}/resume.md" "applications/{folder}/job_description.txt" --jd-keywords "applications/{folder}/jd_keywords.json" --json
       {venv_python} hr_scorer.py --score "applications/{folder}/resume.md" "applications/{folder}/job_description.txt" --json

IF ATS ≥ 65% AND HR < 70%:
    → Improve bullet impact (metrics, action verbs, company overview leads)
    → Remove awkward keyword insertions
    → Re-score (same two CLI calls above)

IF ATS ≥ 65% AND HR ≥ 70%:
    → PASS — proceed to finalization
```

2. **Max 2 iteration rounds.**

---

## PHASE 5: FINALIZATION

Update the application tracker:

```bash
{venv_python} -c "
from tracker_utils import add_application
add_application(
    company='{Company}',
    job_title='{Job Title}',
    resume_file='resume.md',
    cover_letter_file='',
    jd_file='job_description.txt',
    ats_score={final_ats},
    hr_score={final_hr},
    application_date=None,
    status='Applied'
)
print('Tracker updated successfully')
"
```

---

## PHASE 6: CLEANUP + REPORT

1. **Save and display final report:** Write the report to `applications/{folder}/Report.txt`, then display it:

```
================================================================================
                    RESUME TAILOR - FINAL REPORT (v3.0)
================================================================================

COMPANY: {Company Name}
POSITION: {Job Title}
DOMAIN DETECTED: {clinical_research/pharma_biotech/technology/etc.}
BASE TEMPLATE: {source application folder or "Master Resume"}

--------------------------------------------------------------------------------
                         SCORING SUMMARY
--------------------------------------------------------------------------------

                    |  BASE RESUME  |  TAILORED RESUME  |  IMPROVEMENT
--------------------------------------------------------------------------------
ATS SCORE           |    {X}%       |      {Y}%         |    +{Z}%
HR SCORE            |    {X}%       |      {Y}%         |    +{Z}%
--------------------------------------------------------------------------------

ATS RATING: {Excellent/Good/Fair}
HR RECOMMENDATION: {STRONG INTERVIEW/INTERVIEW/MAYBE/PASS}

--------------------------------------------------------------------------------
                         AUTHENTICITY CHECK
--------------------------------------------------------------------------------

  [✓] Job titles preserved exactly from master resume
  [✓] Publications unchanged
  [✓] No keyword stuffing (each keyword 1-2x max)
  [✓] Bullets read naturally to human reviewer
  [✓] No fabricated content — all bullets grounded in master resume

--------------------------------------------------------------------------------
                         UNADDRESSED JD REQUIREMENTS
--------------------------------------------------------------------------------

{List any JD requirements that had no corresponding master resume content and
 were intentionally left unaddressed. If none, write "None — full coverage
 achievable from existing experience."}

  Examples of what to list here:
  - "Required: 2+ years Tableau experience — not present in master resume"
  - "Required: AI tool proficiency (ChatGPT/Gemini) — no supporting content"

GENERATED: resume.md
FOLDER: applications/{Company} - {JobTitle}/
ITERATIONS: {count}

================================================================================
```

2. **Offer** web reports:
```bash
{venv_python} ats_scorer.py --web --base "{base_template}" --tailored "applications/{folder}/resume.md" --jd "applications/{folder}/job_description.txt"
{venv_python} hr_scorer.py --score "applications/{folder}/resume.md" "applications/{folder}/job_description.txt" --web
```

---

## RESUME WRITING RULES (Applied during Phase 2)

### AUTHENTICITY RULES (CRITICAL)

**What You CAN Modify:**
1. **Bullet points** — Reframe achievements using JD language where natural; keywords woven in here (no dedicated keyword section)
2. **Job Titles** — Minor tweaks only: reordering words, alternate standard form, abbreviating/expanding acronyms. The fundamental role level and function must not change (e.g., cannot elevate "Associate" → "Senior", or change "Analyst" → "Manager").
3. **Skills / Interests** — Add or reorder items in the combined bottom section to reflect JD-relevant skills

**What You CANNOT Modify:**
1. **Job Titles** — Beyond minor tweaks (see above); never change role level or function
2. **Job Experience Entries** — All roles must appear with their header (company, title, dates). Zero bullets are permitted for roles with zero JD relevance, but the header must remain.
3. **Company Names** — Never change
4. **Dates** — Never change
5. **Education** — Exactly as-is
6. **Publications** — NEVER add keywords; citations stay verbatim
7. **Certifications** — Exactly as-is
8. **Professional Memberships** — Exactly as-is

**Keyword Rules:**
- No dedicated keyword section; keywords placed naturally within bullets
- Each keyword: **1-2 times MAX** across entire resume
- **Interview Test:** Every bullet must survive a 30-minute interview — no JD term included unless backed by master resume content
- 65% ATS with authentic content > 85% with stuffing

### WRITING COACH (Rules 1-10)

**Rule 1 (So What?):** Every bullet shows impact, not just activity
**Rule 2 (6-Second):** Front-load value in first 3 words
**Rule 3 (Deadwood):** Strip "Responsible for", "Successfully", "Various", "Helped"
**Rule 4 (Metrics):** 50%+ bullets contain quantified metrics (plain text, no ** bold)
**Rule 5 (Verbs L3+):** 70%+ verbs at Directive/Strategic/Transformative level
**Rule 6 (Architecture):** Impact Lead, Challenge-Action-Result, or Scope-Authority
**Rule 7 (Burstiness):** Vary bullet lengths: SHORT (6-10 words), MEDIUM (11-18 words), LONG (19-28 words). Never 3+ bullets in a row at same approximate length. Target per job block: 1-2 short, 3-4 medium, 1-2 long.
**Rule 8 (Parallel):** Consistent grammar patterns per role
**Rule 9 (No Summary):** Do NOT write a summary, profile, or objective section. The resume starts directly with WORK EXPERIENCE.
**Rule 10 (Authenticity):** Interview Test on every bullet

**Rule 11 (Anti-Cliché):** FORBIDDEN verbs: Spearheaded, Leveraged, Utilized, Facilitated, Ensured, Demonstrated, Collaborated, Streamlined, Championed, Fostered, Harnessed, Liaised. USE: Led, Directed, Built, Drove, Cut, Grew, Won, Launched, Transformed, Redesigned, Managed.

**Rule 12 (Grammatical Variety):** Min 2 bullets per job block must NOT start with an action verb. Options: noun-led ("Key architect of…"), participial ("Working across 5 teams, unified…"), result-led ("Zero protocol deviations — achieved via…").

**Rule 13 (Texture):** One real-world specific detail per job block: named tool, regulation, or real constraint. e.g. "using Medidata Rave", "per ICH E6(R2)", "despite COVID-19 closures".

**Rule 14 (No Summary):** Do NOT write a summary, profile, or objective section. There is no summary. The resume begins with WORK EXPERIENCE immediately after the contact header.

**Rule 15 (Company Overview Lead):** The first bullet of every role must be a company overview that borrows validity from the company's numbers. Anchor the reader on something impressive: revenue, market cap, Fortune 500 status, number of users, number of employees, funding raised, or other notable context. If the company is small/unknown, lead with its domain, product, or market position instead.

```
WEAK FIRST BULLET: Analyzed traffic data for ad network
STRONG FIRST BULLET: OBMedia operates a portfolio of performance marketing domains generating [X]M+ monthly sessions across [Y] verticals
```

**Rule 16 (Key Results Sub-bullets):** Nest quantifiable outcomes as indented sub-bullets under the relevant main bullet. Use sub-bullets for: revenue impact, cost savings, man-hours saved, users/partners acquired, quality metrics, and tech stack or notable client context.

```
• As Data Analyst, designed publisher quality classification system covering [N] domains
  - Reduced low-quality traffic by 30%, recovering $X in effective ad spend
  - Stack: Python, UMAP, scikit-learn, BigQuery
```

**Rule 17 (Month Abbreviation):** Always abbreviate month names: Jan., Feb., Mar., Apr., May, Jun., Jul., Aug., Sep., Oct., Nov., Dec. Never spell out full month names.

**Rule 18 (Sparse Emphasis):** Bold and italic are used sparingly. Company names bold, job titles italic. **Exception:** ATS keywords woven into bullet prose are bolded per Rule 19. No other words in bullets should be bolded.

**Rule 19 (ATS Keyword Bolding):** After writing all bullets, do one final bolding pass. Identify every JD-sourced term intentionally placed into bullet text — tools, methodologies, skills, certifications, domain terminology — and wrap each occurrence in `**...**`. Apply to every occurrence in the bullet prose. Do NOT bold within: company names, job titles, education section, certifications lines, publications, or the Technologies/Skills bullets in the bottom section (those are already keyword-visible). Purpose: gives the user a visual map of ATS coverage to protect during manual edits.

### RESUME STRUCTURE (SheetsResume Format)

**NO SUMMARY SECTION.** The resume starts directly with WORK EXPERIENCE after the contact header. Do not add a summary, profile, objective, or any introductory paragraph.

```
# [FULL NAME, CREDENTIALS]
[email] | [phone] | [City, ST] | [LinkedIn URL]

---

## WORK EXPERIENCE

**[EXACT COMPANY NAME]**
[Mon. Year – Mon. Year]
*[Job Title — may be lightly tweaked for target role; see Authenticity Rules]*  [City, ST or Remote]

• [Company overview — lead with the company's numbers/context to anchor the reader (revenue, users, Fortune 500 rank, headcount, $ raised, etc.)]
• As [job title], [core responsibilities that match the JD, including high-level numbers where impressive]
  - **Key Results:** [quantifiable outcome — revenue, cost savings, man-hours saved, users acquired, etc.]
  - [Tech stack, notable clients, or project examples if applicable]
• [Additional bullets for current/recent roles — apply Writing Coach rules]

[Repeat for each role. Bullet count: current 4-6, recent 3-4, older 2-3, very old 1-2, zero-relevance roles 0 (header + dates only)]

---

## EDUCATION

**[University Name]**  [Graduation Mon. Year]
*[Degree (e.g., B.S.), Major]*  [City, ST]
• GPA: X.X/4.0 *(only if 3.3 or above — omit otherwise)*

---

## CERTIFICATIONS, SKILLS & INTERESTS

• **Certifications:** [relevant ones; omit bullet if none]
• **Technologies:** [hard skills list]
• **Skills:** [Skill 1]; [Skill 2]; [Skill 3]...
• **Publications:** [citations if applicable; omit bullet if none]
• **Memberships:** [professional orgs if applicable; omit bullet if none]
• **Interests:** [Interest 1]; [Interest 2]; [Interest 3]...
```

### STAR BULLETS + VERB BANK

**Formula:** `[Executive Verb] [context + action] → [quantified result]`

**Verbs:** Directed, Orchestrated, Architected, Pioneered, Validated, Established, Governed, Led, Built, Drove, Launched, Transformed

**Tone:** Senior professional — authoritative and evidence-based.

**Bullet Distribution:** Current 4-6, recent 3-4, older 2-3, very old 1-2, zero-relevance 0 (header only). Every role's header (company, title, dates) must still appear.

---

## ETHICAL REQUIREMENTS (NON-NEGOTIABLE)

- **NEVER CHANGE JOB TITLES** — Match master resume exactly (copy verbatim, including all qualifiers already in the title)
- **NEVER OMIT JOB EXPERIENCES** — All roles from the master resume must be included. Older or less-relevant roles get fewer bullets (min 1), but zero roles may be dropped.
- **NEVER CHANGE PUBLICATIONS** — Titles/citations stay as-is
- **Never invent experience** — Only reframe existing content
- **NEVER FABRICATE TO FILL JD GAPS** — If a JD requirement has no corresponding content in the master resume, leave it unaddressed. Do NOT invent bullets, tools, behaviors, or skills to match. A gap is honest; fabrication is fraud. This applies even when the JD language superficially resembles something in the master resume (e.g., a role that *evaluates* AI outputs does NOT support a claim that the candidate *uses* AI tools for analysis). Surface significant unaddressable gaps in the Phase 6 report instead.
- **NEVER INVERT OR SOFTEN OUTCOMES** — If the master resume describes a null, negative, or deprioritized result (e.g., clustering did not yield separable categories; stakeholders deprioritized further work), represent it that way. Do NOT reframe inconclusive findings as "optimization opportunities" or failed approaches as successes. Honest negative results are still valid experience.
- **NEVER EXPAND CONTRIBUTION SCOPE** — If the master resume explicitly limits the scope of a contribution (e.g., "initial exploratory phase," "analysis + insight delivery only," "fellow analyst took over deeper investigation"), the bullet must respect that boundary. Do NOT attribute downstream outcomes or a colleague's findings to this candidate.
- **JD TERMS MUST BE GROUNDED** — JD language is welcome when it accurately describes real experience. But do not add JD terms — even as a closing phrase — that have no backing in the master resume. Every phrase in a bullet must describe something the candidate actually did or achieved. "Ensuring metric consistency" or "stakeholder trust" appended to an otherwise-accurate bullet are fabrication if the master resume contains nothing that supports them.
- **DO NOT IMPORT JD METRICS INTO BULLETS** — The source for specific named metrics, features, or technical terms in a bullet is the master resume, not the JD. Do not insert domain-specific JD metrics (e.g., "retention curves," "LTV," "AOV") into a bullet describing work from a different context, even if the master resume uses open-ended language like "other numerical features." Use JD language to reframe how existing content is described; do not use it to specify content that isn't there.
