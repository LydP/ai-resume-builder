# SheetsResume Format

Source: `reference/Resume Template - SheetsResume.com - 2025.pdf`

## Template

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

## Structural Rules

- **No summary section.** The resume starts directly with WORK EXPERIENCE after the contact header. Never add a summary, profile, objective, or any introductory paragraph.
- **Section order:** WORK EXPERIENCE → EDUCATION → CERTIFICATIONS, SKILLS & INTERESTS
- **Header format:** Full name (+ credentials if any) as H1; contact line (email | phone | City, ST | LinkedIn) immediately below; horizontal rule (`---`) before the first section.
- **Role block layout:** Company name (bold) on one line, date range on the next, then job title (italic) and location on the same line separated by two spaces.
- **Bullet distribution:** Current role 4–6 bullets, recent roles 3–4, older roles 2–3, very old roles 1–2, zero-relevance roles 0 bullets (header + dates only — the header must still appear for every role).
- **Sub-bullets:** Nest quantifiable outcomes and tech stack context as indented sub-bullets (`  - ...`) under the relevant main bullet.
- **Emphasis:** Company names bold (`**...**`), job titles italic (`*...*`). No other bolding in bullets except ATS keywords (applied as a final pass by `/tailor-resume`).
- **Month abbreviation:** Jan., Feb., Mar., Apr., May, Jun., Jul., Aug., Sep., Oct., Nov., Dec. Never spell out full month names.

## Markdown Limitations vs. Original

The PDF source uses two-column layout, custom fonts, and colored section dividers. The markdown equivalent uses horizontal rules (`---`) as section dividers and relies on heading hierarchy and bold/italic for structure. Column layout is not reproducible in markdown.
