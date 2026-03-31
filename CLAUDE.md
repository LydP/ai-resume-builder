# Project Instructions

## Master Resume Structure

The master resume is structured for Claude's parsing — it is reference material, not a submittable document. Full formatting spec: `reference/master_resume_formatting.md`.

When reading the master resume, interpret each section type as follows:
- **Named projects (`####` headings):** Three-part format — prose paragraph (primary synthesis source; generate bullets from this), `**Tools:**` line (keyword metadata; scan for JD matching), `**Details:**` sub-list (reference only; consult when the JD calls for something specific; never enumerate directly into output bullets)
- **Daily Responsibilities:** Captures routine work not tied to named projects; synthesize as-needed based on JD relevance — fills in role scope and day-to-day demands that projects don't cover
- **Flat labeled sections (Role Context, Technical Context, etc.):** Structured lookup; scan for keywords, tools, platforms, scale

## Progress Tracking

After every change, ask the user if they want to update the progress tracking files before moving on:
- `reference/changelog.md` — full numbered history of every change (append new entry)
- `reference/status.md` — lean working summary; update Next Steps and Key Decisions as needed