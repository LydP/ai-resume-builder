# Create Resume Format

Convert a resume template or example into a format definition file that `/tailor-resume` can reference.

## Input
$ARGUMENTS

## Instructions

You are converting a resume template or example into a reusable format definition file stored in the `formats/` directory.

---

### Phase 1: Load Source

Check `$ARGUMENTS`:

- **File path provided** (e.g., `reference/Resume Template.pdf`, `my-template.md`): Read the file using the Read tool. PDF files are supported.
- **No argument provided**: Ask the user:
  > "Please paste the example resume or format template you'd like to convert, or provide a file path:"
  
  Wait for their response. If they paste content, store it as the source. If they provide a file path, read that file.

---

### Phase 2: Analyze Structure

Study the source and identify:

1. **Contact header** — What fields are shown (name, email, phone, location, LinkedIn, etc.) and in what layout/order?
2. **Sections** — What sections exist and in what order? (e.g., Summary, Work Experience, Education, Skills, Certifications)
3. **Role block layout** — How is each job entry structured? (company, title, dates, location — what order, what line breaks?)
4. **Bullet style** — Bullet character used (•, -, *, number), indentation for sub-bullets, nesting depth
5. **Emphasis patterns** — What is bold, italic, all-caps, underlined? (Map these to markdown bold/italic since that's all markdown supports)
6. **Date format** — Spelled out months, abbreviated months, numeric, etc.
7. **Section dividers** — Horizontal rules, blank lines, headers only?
8. **Any explicit rules** stated in the source (e.g., "no summary section", "GPA only if 3.3+")

Note any features of the original that **cannot be replicated in markdown** (e.g., columns, custom fonts, color, tables for layout). These go in a "Markdown Limitations" section.

---

### Phase 3: Generate Format File

Produce a format definition markdown file with this structure:

```markdown
# [Format Name] Format

Source: [file path or "pasted example"]

## Template

[Fenced code block containing the markdown template with placeholder text in brackets]

## Structural Rules

- [Rule 1 — format-specific structural rule]
- [Rule 2]
- ...

## Markdown Limitations vs. Original

[Note any visual features of the source that cannot be reproduced in plain markdown]
```

**Template block guidelines:**
- Use `[PLACEHOLDER TEXT]` in brackets for variable fields
- Show every section and sub-element in its correct position
- Demonstrate bullet and sub-bullet style with example entries
- Match heading levels (H1/H2/H3) to the visual hierarchy of the original as closely as markdown allows

**Structural Rules guidelines:**
- Only include rules that are specific to this format's structure and layout
- Do NOT duplicate the writing quality rules already in `/tailor-resume` (verb strength, metrics mandate, authenticity, etc.)
- Do include: section order, presence/absence of summary, bullet counts per role age, date format, emphasis conventions, special layout notes

Show the generated format file content to the user and ask them to confirm before saving.

---

### Phase 4: Name and Save

Ask the user:
> "What should this format be named? Provide a short slug (e.g., `harvard`, `google-doc`, `chronological`). It will be saved as `formats/{slug}.md`."

Wait for their answer. Save the format file to `formats/{slug}.md`.

Confirm: "Format saved to `formats/{slug}.md`."

---

### Phase 5: Activate (Optional)

Ask the user:
> "Would you like to make this the active format for `/tailor-resume`?
> (1) Yes — update config.json now
> (2) No — I'll switch formats manually in config.json later"

If YES: Read `config.json`, update the `resume_format` field to `"formats/{slug}.md"`, and write the file back. Confirm: "Active format updated in `config.json`."

If NO: Tell the user: "To activate this format later, set `\"resume_format\": \"formats/{slug}.md\"` in `config.json`."
