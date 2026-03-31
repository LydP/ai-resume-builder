# Find Jobs — Discover & Score

Search for jobs matching your profile and score each one against your resume.

## Search Query
$ARGUMENTS

## Instructions

You are an expert career advisor. The user wants to find jobs that match their resume and score each one for fit.

### Phase 1: Setup

1. **Read the master resume** from `config.json` -> `master_resume_path` (or glob for `*MASTER*RESUME*.md`). Use the `Read` tool directly.

2. **Parse the user's query** from `$ARGUMENTS`:
   - Extract the **job title** (e.g., "Data Scientist", "Clinical Research Associate")
   - Extract **location** if specified (e.g., "in New York", "NYC", "Remote")
   - Detect **remote preference** (keywords: "remote", "work from home", "WFH")
   - If the query is empty or unclear, ask the user what role they're looking for

3. **Select a job source** — always ask, even if only one source is available:

   Run:
   ```bash
   {venv_python} -c "
   import json
   from job_discovery import list_sources
   print(json.dumps(list_sources()))
   "
   ```
   Where `{venv_python}` is constructed from `config.json → venv_name`:
   - Windows: `{venv_name}\Scripts\python`
   - Mac/Linux: `{venv_name}/bin/python`

   Display the results as a numbered list, showing each source's display name and whether it is configured. Ask the user to pick one. Store the selected source's `name` field as `{source_name}`.

   Example display:
   ```
   Available job sources:
   1. Adzuna (configured)
   2. USAJobs (not configured)
   3. TheirStack (not configured)

   Which source would you like to use?
   ```

### Phase 2: Job Discovery

4. **Call `job_discovery.py` directly** via Bash, passing the selected source:
```bash
{venv_python} -c "
import json
from job_discovery import discover_jobs
result = discover_jobs(
    resume_text={resume_text!r},
    job_title={job_title!r},
    location={location!r},
    remote_only={remote_only},
    max_results=10,
    source_name={source_name!r},
)
print(json.dumps(result))
"
```

### Phase 3: Display Results

5. **Display a ranked results table** with the top matches:

```
## Job Discovery Results

| Rank | Title | Company | Location | ATS | HR | Salary |
|------|-------|---------|----------|-----|-----|--------|
| 1 | ... | ... | ... | 82% | 74% | $120-150K |
| 2 | ... | ... | ... | 78% | 71% | $100-130K |
```

6. **For each top-3 job**, show a brief breakdown:
   - Matched keywords (from ats_detail)
   - Missing keywords (what you'd need to add)
   - HR recommendation (INTERVIEW, MAYBE, PASS)
   - Job posting URL (use `listing_url` field)

7. **Show the attribution** line from the response (e.g., "Powered by Adzuna")

### Phase 4: Next Steps

8. **Offer actionable next steps** — present these as numbered options the user can pick:

   **Option 1 — Apply to a specific job:**
   "Type a number (e.g., '1') and I'll generate a tailored resume for that job using its description. I'll run the full `/tailor-resume` workflow automatically."

   When the user picks a job number:
   - Extract that job's `description` from the discovery results
   - Save to `applications/{Company} - {Title}/job_description.txt` with `Job Title: {job.title}\n\n` prepended before the description
   - Run the full `/tailor-resume` workflow using that job description as input
   - When complete, show the job posting URL (`listing_url`) so the user can apply

   **Option 2 — Search again:**
   "Run `/find-jobs [new query]` to search with different criteria"

   **Option 3 — View full description:**
   "Type 'details #N' to see the full job description for any result"

### Error Handling

- If `result.jobs` is empty, display the `result.message` field verbatim — it is generated dynamically by `job_discovery.py` and explains whether the issue is missing API keys, no matches, or role filtering.
- If `result.setup_required` is true, the message includes source-specific setup instructions — display it and stop.
- If results were found but then filtered out, the message will say so — suggest a broader title or different location.
