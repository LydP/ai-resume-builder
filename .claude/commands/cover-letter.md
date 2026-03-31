# Generate Cover Letter Only

Create a compelling one-page cover letter for a job application.

## Job Description
$ARGUMENTS

## Instructions

You are an expert career coach and professional writer. The user has provided a job description above.

**Your task:**

### Phase 1: Setup

1. **Ask the user** for the company name and job title:
   > "Please provide the company name and job title for this application:"

2. **Ask the user for company research:**
   > "Do you have company research to include in the cover letter?
   > (1) Paste research (e.g., from Gemini) — mission, recent achievements, notable facts
   > (2) I'll search the web
   > (3) Skip — focus on the role instead"

   - **Option 1:** Wait for the user to paste; store as `{company_research}`
   - **Option 2:** Ask the user for the company's website URL before searching:
     > "Please provide the company's website URL so I can search accurately:"
     Then use WebSearch, seeded with that URL, to find information a job applicant would naturally reference in a cover letter — company mission, culture signals, recent growth or wins (including funding rounds, revenue milestones, or valuations), notable products or milestones. Omit earnings reports, stock price movements, controversies, or other content that wouldn't fit naturally in a cover letter. Display a summary of what was found and ask the user to confirm before proceeding:
     > "Here's what I found about [Company]:
     > [summary]
     > Use this for the cover letter? (yes / edit / skip)"
     - **Yes:** Store summary as `{company_research}`
     - **Edit:** User provides corrections or additions; store revised version as `{company_research}`
     - **Skip:** Set `{company_research}` = none; proceed as Option 3
   - **Option 3:** Set `{company_research}` = none; the Company Connection paragraph will focus on the role and requirements instead

3. **Search for a similar existing resume** in the `applications/` folder to understand what was already tailored:
   - Use `Glob` to find all `applications/**/resume.md` files
   - From folder names (`{Company} - {JobTitle}`), identify the most semantically similar role
   - **If match found (PREFERRED)**: Read the `resume.md` directly with the Read tool
   - **If no match**: Fall back to the master resume (read `config.json` for `master_resume_path`, or glob for `*MASTER*RESUME*.md`)
   - Always also read the master resume for the full picture of the candidate's experience
   - **Format-aware reading:** Use `Read` tool directly.
   - **How to interpret the master resume structure:**
     - **Named projects (`####` headings):** Three-part format — prose paragraph (primary synthesis source; identify relevant experiences from this), `**Tools:**` line (keyword metadata; scan for JD matching), `**Details:**` sub-list (reference only; consult when the JD calls for something specific; never enumerate directly)
     - **Daily Responsibilities:** Captures routine work not tied to named projects; synthesize as-needed based on JD relevance — fills in role scope and day-to-day demands that projects don't cover
     - **Flat labeled sections (Role Context, Technical Context, etc.):** Structured lookup; scan for keywords, tools, platforms, scale

4. **Create output folder** at `applications/{CompanyName} - {JobTitle}/` (if not exists)

5. **Save the job description** as `job_description.txt` (if not exists)

### Phase 2: Cover Letter Generation

### Ethical Requirements (Non-Negotiable)

- **NEVER FABRICATE EXPERIENCES** — Every STAR example must be grounded in master resume content. Do not invent situations, actions, or results to match a JD requirement. A gap is honest; fabrication is fraud.
- **NEVER INVERT OR SOFTEN OUTCOMES** — If the master resume describes a null, negative, or deprioritized result, represent it as such. Do not reframe inconclusive findings as "optimization opportunities" or failed approaches as successes.
- **NEVER EXPAND CONTRIBUTION SCOPE** — If the master resume explicitly limits the scope of a contribution (e.g., "initial exploratory phase," "fellow analyst took over"), the cover letter must respect that boundary. Do not attribute downstream outcomes or a colleague's work to the candidate.
- **JD TERMS MUST BE GROUNDED** — Use JD language only when it accurately describes real experience in the master resume. Do not append JD terms to a sentence that has no master resume backing for them.
- **COMPANY FACTS FROM RESEARCH ONLY** — Company-specific claims (mission, achievements, facts) must come from `{company_research}` or the JD only. Do not draw on Claude's internal knowledge about the company — it may be outdated or hallucinated. If neither source has sufficient company context, default to focusing on the role.

6. **Write a cover letter** following this 3-paragraph structure:

   **Paragraph 1 — Opening:**
   - Briefly introduce the 2-3 most relevant skills for this role
   - If the master resume contains a genuine connection between the candidate's background and the company's mission or domain (e.g., a personal project, prior work in the same industry, a stated interest), surface it here — do not manufacture enthusiasm that isn't backed by the material
   - Keep this paragraph concise; it sets the stage for the project narrative

   **Paragraph 2 — Deep Narrative:**
   - Go deep on 1-2 of the most relevant experiences from the master resume — full end-to-end narrative: context, approach, tools, validation, outcome
   - Prefer depth over breadth: one well-told project is more compelling than four brief mentions
   - Personal projects (side projects, GitHub, etc.) are valid content if they appear in the master resume and are relevant to the role
   - Include quantified outcomes where available

   **Paragraph 3 — Company Connection + Close:**
   - If `{company_research}` is available: reference a specific company achievement, mission detail, or product that genuinely connects to the candidate's background or interests
   - If `{company_research}` = none: focus on what specifically attracts the candidate to this role based on the JD
   - Close with a confident, direct call to action (1-2 sentences)

7. **Format requirements:**
   - 350-400 words; should feel complete and natural, not padded to hit a word count
   - Professional but personable tone
   - NO placeholder text like [Your Address]
   - Ready to send immediately — the user may add personal context not captured in the master resume

### Phase 3: Save

8. **Save cover letter** as `cover_letter.md` in the output folder

### Phase 4: Final Output

9. **Display the full cover letter** text for review

10. **List generated files**:
    - `cover_letter.md`
    - `job_description.txt`

11. **Surface unaddressed JD requirements:**
    List any JD requirements that had no corresponding master resume content and were intentionally left out. The user can decide whether to address any of these manually.

    ```
    UNADDRESSED JD REQUIREMENTS
    ----------------------------
    - [Requirement]: [why it couldn't be addressed]
    - ...

    If none: "Full coverage achievable from existing experience."
    ```

After completion, display word count.
