# Graph Report - .  (2026-06-17)

## Corpus Check
- 7 files · ~115,382 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1604 nodes · 4971 edges · 51 communities (48 shown, 3 thin omitted)
- Extraction: 98% EXTRACTED · 2% INFERRED · 0% AMBIGUOUS · INFERRED: 90 edges (avg confidence: 0.72)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Clinical Keywords Library|Clinical Keywords Library]]
- [[_COMMUNITY_Acronym Dictionary|Acronym Dictionary]]
- [[_COMMUNITY_Skill Taxonomy Categories|Skill Taxonomy Categories]]
- [[_COMMUNITY_Consulting Keywords Library|Consulting Keywords Library]]
- [[_COMMUNITY_Finance Keywords Library|Finance Keywords Library]]
- [[_COMMUNITY_Technology Keywords Library|Technology Keywords Library]]
- [[_COMMUNITY_Healthcare Keywords Library|Healthcare Keywords Library]]
- [[_COMMUNITY_General Skills Keywords|General Skills Keywords]]
- [[_COMMUNITY_Semantic Embedding Engine|Semantic Embedding Engine]]
- [[_COMMUNITY_Job Discovery & Scoring Core|Job Discovery & Scoring Core]]
- [[_COMMUNITY_ATS Score Calculation|ATS Score Calculation]]
- [[_COMMUNITY_ATS Scorer Module|ATS Scorer Module]]
- [[_COMMUNITY_Soft Skills Library|Soft Skills Library]]
- [[_COMMUNITY_ONET Skills Taxonomy|O*NET Skills Taxonomy]]
- [[_COMMUNITY_Graphify Knowledge Graph|Graphify Knowledge Graph]]
- [[_COMMUNITY_Keyword Matching Utilities|Keyword Matching Utilities]]
- [[_COMMUNITY_File Text Extraction|File Text Extraction]]
- [[_COMMUNITY_HR Scorer Module|HR Scorer Module]]
- [[_COMMUNITY_Resume Pipeline Commands|Resume Pipeline Commands]]
- [[_COMMUNITY_Job Discovery Command|Job Discovery Command]]
- [[_COMMUNITY_HR Score Calculation|HR Score Calculation]]
- [[_COMMUNITY_HR Education & Prestige Scoring|HR Education & Prestige Scoring]]
- [[_COMMUNITY_Claude Code Hooks & Settings|Claude Code Hooks & Settings]]
- [[_COMMUNITY_Company Prestige Database|Company Prestige Database]]
- [[_COMMUNITY_Application Tracker|Application Tracker]]
- [[_COMMUNITY_Job Fit Scoring Utils|Job Fit Scoring Utils]]
- [[_COMMUNITY_Project Config & Instructions|Project Config & Instructions]]
- [[_COMMUNITY_University Rankings Database|University Rankings Database]]
- [[_COMMUNITY_HR Text Analysis|HR Text Analysis]]
- [[_COMMUNITY_Action Verbs Library|Action Verbs Library]]
- [[_COMMUNITY_Runtime Configuration|Runtime Configuration]]
- [[_COMMUNITY_Setup Command Flow|Setup Command Flow]]
- [[_COMMUNITY_Scoring Pipeline & Issues|Scoring Pipeline & Issues]]
- [[_COMMUNITY_Resume Authenticity & Ethics|Resume Authenticity & Ethics]]
- [[_COMMUNITY_Skill Knowledge Graph|Skill Knowledge Graph]]
- [[_COMMUNITY_Job Fit Scorer|Job Fit Scorer]]
- [[_COMMUNITY_Score Targets & Scripts|Score Targets & Scripts]]
- [[_COMMUNITY_Example Configuration|Example Configuration]]
- [[_COMMUNITY_Keyword Domain Metadata|Keyword Domain Metadata]]
- [[_COMMUNITY_Keyword Decay Metadata|Keyword Decay Metadata]]
- [[_COMMUNITY_Resume Parser|Resume Parser]]
- [[_COMMUNITY_Core Input Files|Core Input Files]]
- [[_COMMUNITY_Domain Phrase Matching|Domain Phrase Matching]]
- [[_COMMUNITY_PDF Security & Extraction|PDF Security & Extraction]]
- [[_COMMUNITY_Keyword Category Schema|Keyword Category Schema]]
- [[_COMMUNITY_Job Description Parser|Job Description Parser]]
- [[_COMMUNITY_Readability Metrics|Readability Metrics]]
- [[_COMMUNITY_Verb Power Scoring|Verb Power Scoring]]
- [[_COMMUNITY_Graphify Watch Mode|Graphify Watch Mode]]
- [[_COMMUNITY_Graphify MCP Server|Graphify MCP Server]]
- [[_COMMUNITY_Graphify Neo4j Export|Graphify Neo4j Export]]

## God Nodes (most connected - your core abstractions)
1. `category` - 163 edges
2. `importance` - 162 edges
3. `decay_lambda` - 129 edges
4. `technical_skills` - 119 edges
5. `weight` - 98 edges
6. `category` - 98 edges
7. `synonyms` - 98 edges
8. `decay_lambda` - 98 edges
9. `weight` - 98 edges
10. `category` - 98 edges

## Surprising Connections (you probably didn't know these)
- `detect_keyword_stuffing()` --semantically_similar_to--> `score_burstiness()`  [INFERRED] [semantically similar]
  ats_scorer.py → hr_scorer.py
- `calculate_skill_decay()` --semantically_similar_to--> `calculate_skill_freshness()`  [INFERRED] [semantically similar]
  ats_scorer.py → hr_scorer.py
- `Dual Engine ATS HR Scoring Feature` --semantically_similar_to--> `ATS and HR Scoring Pipeline`  [INFERRED] [semantically similar]
  README.md → .claude/commands/tailor-resume.md
- `Master Resume Command` --references--> `master_resume_path`  [EXTRACTED]
  .claude/commands/master-resume.md → config.json
- `Parallel Research Phase` --references--> `master_resume_path`  [EXTRACTED]
  .claude/commands/tailor-resume.md → config.json

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **tailor-resume Full Pipeline — All Phases** — commands_tailor_resume, concept_job_fit_scoring, concept_ats_scoring, concept_hr_scoring, concept_jd_keywords, concept_tracker [EXTRACTED 1.00]
- **Setup Initialization — Config, Format, and Dependencies** — commands_setup, config_json, formats_sheets_resume, concept_resume_format [EXTRACTED 1.00]
- **Resume Writing Quality System — Authenticity + Style Rules** — concept_authenticity_rules, concept_writing_coach_rules, formats_sheets_resume, concept_jd_keywords [INFERRED 0.85]

## Communities (51 total, 3 thin omitted)

### Community 0 - "Clinical Keywords Library"
Cohesion: 0.05
Nodes (150): clinical_trials, adaptive design, basket trial, bioavailability, bioequivalence, blinding, clinical development, clinical research (+142 more)

### Community 1 - "Acronym Dictionary"
Cohesion: 0.01
Nodes (139): aco, ae, agile, ai, anda, api, ats, aum (+131 more)

### Community 2 - "Skill Taxonomy Categories"
Cohesion: 0.05
Nodes (119): category, importance, technical_skills, a/b testing, access control, accounting, active directory, api design (+111 more)

### Community 3 - "Consulting Keywords Library"
Cohesion: 0.08
Nodes (111): client_engagement, deliverables, board deck, C-suite presentation, case interview, current state assessment, data room, executive summary (+103 more)

### Community 4 - "Finance Keywords Library"
Cohesion: 0.08
Nodes (111): category, decay_lambda, synonyms, weight, financial_modeling, accretion dilution, capitalization table, contribution analysis (+103 more)

### Community 5 - "Technology Keywords Library"
Cohesion: 0.08
Nodes (108): category, decay_lambda, synonyms, weight, _metadata, domain, last_updated, total_keywords (+100 more)

### Community 6 - "Healthcare Keywords Library"
Cohesion: 0.09
Nodes (105): clinical_operations, ambulatory operations, ambulatory surgery center, bed management, behavioral health, capacity planning, care coordination, care transitions (+97 more)

### Community 7 - "General Skills Keywords"
Cohesion: 0.09
Nodes (103): analytical_skills, business analysis, critical thinking, data analysis, financial analysis, problem solving, qualitative analysis, quantitative analysis (+95 more)

### Community 8 - "Semantic Embedding Engine"
Cohesion: 0.07
Nodes (77): embed_with_cache(), _get_domain_proto_embeddings(), get_sbert_model(), Thread-safe lazy loading of SBERT model. Loads once on first call., Encode text with SBERT, using disk + memory cache., Lazily compute and cache domain prototype embeddings., CandidateProfile, JobEntry (+69 more)

### Community 9 - "Job Discovery & Scoring Core"
Cohesion: 0.06
Nodes (48): Two-Tier Scoring: lightweight fast-path then full ATS+HR, HTMLParser, _active_attribution(), AdzunaSource, _ai_role_filter(), analyze_resume_for_search(), _build_setup_message(), _detect_text_domain() (+40 more)

### Community 10 - "ATS Score Calculation"
Cohesion: 0.11
Nodes (38): apply_domain_specific_scoring(), assess_format_risk(), audit_scoring_bias(), calculate_ats_score(), _calculate_bm25_fallback(), calculate_bm25_score(), calculate_graph_centrality_score(), calculate_recency_adjusted_score() (+30 more)

### Community 11 - "ATS Scorer Module"
Cohesion: 0.11
Nodes (23): check_job_title_match(), clean_text(), extract_jd_keywords(), extract_phrases(), get_domain_keywords_for_text(), is_recognized_skill(), is_valid_skill(), load_domain_keywords() (+15 more)

### Community 12 - "Soft Skills Library"
Cohesion: 0.07
Nodes (27): basic_skills, active learning, active listening, communication, copywriting, critical thinking, documentation, editing (+19 more)

### Community 13 - "O*NET Skills Taxonomy"
Cohesion: 0.10
Nodes (20): complex_problem_solving, 5s, analytical thinking, continuous improvement, creativity, critical analysis, debugging, design thinking (+12 more)

### Community 14 - "Graphify Knowledge Graph"
Cohesion: 0.11
Nodes (20): AST Structural Extraction, Community Detection and Labeling, Graphify Fast Path Query, Graphify Outputs HTML JSON Report, Graphify Build Pipeline, Graphify Skill, Semantic Extraction via Subagents, Graphify Add URL Ingest (+12 more)

### Community 15 - "Keyword Matching Utilities"
Cohesion: 0.12
Nodes (19): calculate_keyword_match(), calculate_weighted_score(), expand_acronyms(), extract_keywords(), get_canonical_term(), get_related_terms(), lemmatize_text(), lemmatize_word() (+11 more)

### Community 16 - "File Text Extraction"
Cohesion: 0.18
Nodes (18): extract_text_from_file(), Extract text from PDF, DOCX, MD, or TXT file., _extract_pdf(), _extract_pdf_digital(), extract_text(), _is_scanned(), _ocr_via_claude(), _ocr_via_tesseract() (+10 more)

### Community 17 - "HR Scorer Module"
Cohesion: 0.18
Nodes (16): generate_html_report(), generate_interview_questions(), HRScoreResult, main(), print_score_report(), HR Cognitive Simulation Engine (HR-CSE) ========================================, Generate relevant interview questions based on scoring gaps, Convert HRScoreResult to JSON-serializable dictionary (+8 more)

### Community 18 - "Resume Pipeline Commands"
Cohesion: 0.27
Nodes (17): create-format Command — Format Definition Generator, setup Command — One-Time Initialization, tailor-resume Command — ATS+HR Resume Tailoring Pipeline, ATS Scoring — Keyword Match Engine, Authenticity Rules — Ethical Writing Constraints, HR Scoring — Cognitive Simulation Reviewer, jd_keywords.json — Extracted JD Keyword Map, Job Fit Pre-Check — Knockout Gating (+9 more)

### Community 19 - "Job Discovery Command"
Cohesion: 0.13
Nodes (17): Find Jobs Command, Job Discovery Phase, Job Source Selection, Find Jobs to Tailor Resume Integration, Tailor Resume Final Report, Job Fit Pre-Check Gate, Phase 5: Finalization — Application Tracker Update, Tailor Resume Command (+9 more)

### Community 20 - "HR Score Calculation"
Cohesion: 0.17
Nodes (17): calculate_career_slope(), calculate_hr_score(), calculate_penalties(), detect_edge_cases(), extract_skills_from_text(), extract_text_from_file(), str, Trapezoidal scoring for experience:     - Under 50% requirement: Knockout (0) (+9 more)

### Community 21 - "HR Education & Prestige Scoring"
Cohesion: 0.16
Nodes (17): EducationEntry, float, Score based on prestige signals using expanded databases.      Enhanced with:, Score therapeutic area alignment using REALISTIC HR reasoning.      Key principl, Score experience type alignment (clinical research, drug development, etc.), Score clinical trial phase experience.     HR understands: Phase I experience of, Score education alignment with REALISTIC expectations.      For director-level r, Score whether candidate's career level aligns with target role.     HR thinks: I (+9 more)

### Community 22 - "Claude Code Hooks & Settings"
Cohesion: 0.16
Nodes (13): run_hook.sh script, hooks, PreToolUse, permissions, deny, extract_path_pattern(), load_settings(), main() (+5 more)

### Community 23 - "Company Prestige Database"
Cohesion: 0.40
Nodes (15): fortune500, tier1_consulting, tier1_cro, companies, description, score_boost, tier1_finance, tier1_healthcare (+7 more)

### Community 24 - "Application Tracker"
Cohesion: 0.19
Nodes (13): add_application(), format_excel_worksheet(), get_all_applications(), float, str, Job Application Tracker Utilities  This module provides functions to manage the, Get all applications from the tracker.      Returns:         pandas.DataFrame or, Update the status of an existing application.      Args:         company: Compan (+5 more)

### Community 25 - "Job Fit Scoring Utils"
Cohesion: 0.17
Nodes (13): Normalize a search term using the same cleaning rules as document text., compile_term_pattern(), contains_term(), extract_job_fit_requirements(), find_term_positions(), normalize_match_text(), bool, Normalize text for boundary-aware term matching. (+5 more)

### Community 26 - "Project Config & Instructions"
Cohesion: 0.21
Nodes (13): Master Resume Parsing Guide, Progress Tracking Protocol, Project Instructions CLAUDE.md, Master Resume Command, Master Resume Source Material Rule 12, Modification Changelog, Master Resume Formatting Guide, Role-Level Retrieval Hierarchy (+5 more)

### Community 27 - "University Rankings Database"
Cohesion: 0.46
Nodes (12): tier1_business, tier1_global, tier1_medical, tier1_uk, description, score_boost, universities, tier1_us_elite (+4 more)

### Community 28 - "HR Text Analysis"
Cohesion: 0.19
Nodes (13): calculate_hr_score_from_text(), check_page_length_penalty(), load_json_data(), Any, Score resume for F-Pattern reading compliance (§3.1.1, §9.1).      Based on eye-, Penalize excessively long bullet points that hurt readability.      Bullets long, Apply domain-specific page length rules.      - Finance: strict 1-page rule; >~3, Score sentence-length variability (burstiness).     Coefficient of variation (st (+5 more)

### Community 29 - "Action Verbs Library"
Cohesion: 0.48
Nodes (11): analytical_verbs, clinical_verbs, level_1_execution, level_2_management, level_3_strategy, level_4_impact, technical_verbs, weak_verbs (+3 more)

### Community 30 - "Runtime Configuration"
Cohesion: 0.18
Nodes (10): generate_score_prompt, master_resume_path, output_base_dir, user_credentials, user_email, user_linkedin, user_name, user_phone (+2 more)

### Community 31 - "Setup Command Flow"
Cohesion: 0.20
Nodes (10): config.json Setup, Scoring Engine Setup Verification, Setup Command, Virtual Environment Configuration, config.json Fields Reference, Dual Engine ATS HR Scoring Feature, AI Resume Builder README, LLM Score Prompt Template (+2 more)

### Community 32 - "Scoring Pipeline & Issues"
Cohesion: 0.31
Nodes (10): ATS and HR Scoring Pipeline, Score Check and Iteration, ISS-003 ATS Domain Misclassification, ISS-006 HR Scorer Boilerplate Ingestion, ISS-009 Hyphenated Compound Tokenization, ISS-010 ATS Boilerplate Keywords, ISS-012 Gerund Verb Stemming Mismatch, ISS-018 HR Skills Factor Instability (+2 more)

### Community 33 - "Resume Authenticity & Ethics"
Cohesion: 0.33
Nodes (10): Resume Authenticity Rules, Ethical Requirements — Non-Negotiable Anti-Fabrication Rules, JD Keywords JSON Generation, llm_score_prompt.txt — Manual LLM Score Prompt Template, Phase 2: Write Tailored Resume, resume.md — Tailored Resume Output, Rule 19 ATS Keyword Bolding, Score_Prompt.txt — Filled Score Prompt for Claude.ai (+2 more)

### Community 34 - "Skill Knowledge Graph"
Cohesion: 0.22
Nodes (8): build_skill_graph(), build_synonym_maps(), Build a skill knowledge graph from the taxonomy (§2.2.2, §8.2).      Creates nod, Build synonym lookup maps from skill taxonomy., calculate_skill_freshness(), get_skill_decay_lambda(), Get the decay constant (λ) for a skill.     Higher λ = faster decay (tech skills, Calculate skill freshness using exponential decay.      Formula: R(s,t) = W_base

### Community 35 - "Job Fit Scorer"
Cohesion: 0.22
Nodes (9): get_likelihood_rating(), main(), Convert score to likelihood rating., Score a resume against a job description and return results., Score resume text directly against job description text., Run the Flask web server to display comparison., run_web_server(), score_resume() (+1 more)

### Community 36 - "Score Targets & Scripts"
Cohesion: 0.31
Nodes (9): ATS Score Target (65%+), ats_scorer.py — ATS Scoring Script, HR Score Target (70%+), hr_scorer.py — HR Scoring Script, Job Fit Decision Gate — Score Thresholds and Go/No-Go Logic, Phase 3: Score Base + Tailored Resume, Phase 4: Score Check + Iteration (max 2 rounds), Phase 6: Cleanup + Final Report (+1 more)

### Community 37 - "Example Configuration"
Cohesion: 0.22
Nodes (8): generate_score_prompt, output_base_dir, user_credentials, user_email, user_linkedin, user_name, user_phone, venv_name

### Community 38 - "Keyword Domain Metadata"
Cohesion: 0.25
Nodes (8): _metadata, decay_lambda_scale, description, domain, last_updated, total_keywords, version, weight_scale

### Community 39 - "Keyword Decay Metadata"
Cohesion: 0.25
Nodes (8): _metadata, decay_lambda_guide, description, domain, last_updated, total_keywords, version, weight_scale

### Community 40 - "Resume Parser"
Cohesion: 0.25
Nodes (8): date, get_title_hierarchy_level(), parse_date(), parse_resume(), int, Parse various date formats to date object, Map job title to hierarchy level (1-9), Parse resume text into structured CandidateProfile

### Community 41 - "Core Input Files"
Cohesion: 0.33
Nodes (7): config.json — Project Configuration File, job_description.txt — Saved Job Description, job_fit_scorer.py — Job Fit Scoring Script, Master Resume — Canonical Reference Document, Tailor Resume Phase 0 Setup, Phase 1.5: Job Fit Pre-Check Gate, Parallel Research Phase

### Community 42 - "Domain Phrase Matching"
Cohesion: 0.33
Nodes (6): calculate_phrase_match(), detect_domain(), Calculate important phrase matches.      Args:         resume_text: Resume conte, Calculate important phrase matches using domain-aware phrase sets.      Args:, Auto-detect the industry domain from text (§4).      Uses embedding-based protot, Domain Auto-Detection (SBERT prototype + keyword fallback)

### Community 43 - "PDF Security & Extraction"
Cohesion: 0.33
Nodes (6): contains_normalized_term(), detect_hidden_text(), Detect hidden/invisible text manipulation (§2.3.2).      Checks for:     - White, Extract text from PDF file., Match a term against cleaned text without allowing substring false positives., bool

### Community 44 - "Keyword Category Schema"
Cohesion: 0.33
Nodes (6): _metadata, categories, description, importance_scale, source, version

### Community 45 - "Job Description Parser"
Cohesion: 0.40
Nodes (6): determine_seniority_level(), extract_years_from_text(), parse_job_description(), Parse job description into structured requirements, Extract years of experience from text like '5+ years' or 'minimum 3 years, Determine job seniority level from job description text

### Community 46 - "Readability Metrics"
Cohesion: 0.40
Nodes (5): _calculate_dale_chall_score(), calculate_readability(), Convert Dale-Chall readability score to 0-100 (optimal at 7.0-8.0 for technical, Calculate readability metrics (§3.1.2).      Uses Dale-Chall for technical domai, Convert grade level to 0-100 score (optimal at 10-12).

### Community 47 - "Verb Power Scoring"
Cohesion: 0.50
Nodes (4): get_verb_power_score(), Get verb power score based on Bloom's Taxonomy classification.      Levels:, Score based on density of impact indicators using Bloom's Taxonomy.      Enhance, score_impact_density()

## Knowledge Gaps
- **238 isolated node(s):** `run_hook.sh script`, `PreToolUse`, `deny`, `venv_name`, `output_base_dir` (+233 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **3 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `load_domain_keywords()` connect `ATS Scorer Module` to `Clinical Keywords Library`, `Consulting Keywords Library`, `Finance Keywords Library`, `Technology Keywords Library`, `Healthcare Keywords Library`, `General Skills Keywords`, `ATS Score Calculation`, `Keyword Matching Utilities`?**
  _High betweenness centrality (0.390) - this node is a cross-community bridge._
- **Why does `expand_acronyms()` connect `Keyword Matching Utilities` to `Acronym Dictionary`, `ATS Scorer Module`?**
  _High betweenness centrality (0.160) - this node is a cross-community bridge._
- **Why does `is_valid_skill()` connect `ATS Scorer Module` to `Semantic Embedding Engine`, `O*NET Skills Taxonomy`, `Keyword Matching Utilities`?**
  _High betweenness centrality (0.133) - this node is a cross-community bridge._
- **What connects `Load Claude settings and extract deny patterns from the project-level settings.j`, `Extract file path pattern from deny rule like 'Read(./path/pattern)'.`, `Check if file path matches a deny pattern.` to the rest of the system?**
  _414 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Clinical Keywords Library` be split into smaller, more focused modules?**
  _Cohesion score 0.051479028697571746 - nodes in this community are weakly interconnected._
- **Should `Acronym Dictionary` be split into smaller, more focused modules?**
  _Cohesion score 0.014285714285714285 - nodes in this community are weakly interconnected._
- **Should `Skill Taxonomy Categories` be split into smaller, more focused modules?**
  _Cohesion score 0.04942315909414613 - nodes in this community are weakly interconnected._