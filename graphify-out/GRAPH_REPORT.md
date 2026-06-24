# Graph Report - .  (2026-06-23)

## Corpus Check
- 1 files · ~100,218 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1547 nodes · 4879 edges · 48 communities
- Extraction: 99% EXTRACTED · 1% INFERRED · 0% AMBIGUOUS · INFERRED: 71 edges (avg confidence: 0.7)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Clinical Research Keywords|Clinical Research Keywords]]
- [[_COMMUNITY_Industry Acronyms|Industry Acronyms]]
- [[_COMMUNITY_ONET Technical Skills|O*NET Technical Skills]]
- [[_COMMUNITY_Consulting Keywords|Consulting Keywords]]
- [[_COMMUNITY_Finance Keywords|Finance Keywords]]
- [[_COMMUNITY_Technology Keywords|Technology Keywords]]
- [[_COMMUNITY_Healthcare Keywords|Healthcare Keywords]]
- [[_COMMUNITY_General Skills Keywords|General Skills Keywords]]
- [[_COMMUNITY_HR Scorer Data Models|HR Scorer Data Models]]
- [[_COMMUNITY_Job Discovery & Scoring|Job Discovery & Scoring]]
- [[_COMMUNITY_ATS Score Calculators|ATS Score Calculators]]
- [[_COMMUNITY_ATS Scorer Core|ATS Scorer Core]]
- [[_COMMUNITY_ONET Basic Skills|O*NET Basic Skills]]
- [[_COMMUNITY_ONET Complex Problem Skills|O*NET Complex Problem Skills]]
- [[_COMMUNITY_Text Extraction Engine|Text Extraction Engine]]
- [[_COMMUNITY_ATS Scoring Functions|ATS Scoring Functions]]
- [[_COMMUNITY_HR Score Calculators|HR Score Calculators]]
- [[_COMMUNITY_HR Scorer Utilities|HR Scorer Utilities]]
- [[_COMMUNITY_Company Prestige Data|Company Prestige Data]]
- [[_COMMUNITY_Application Tracker|Application Tracker]]
- [[_COMMUNITY_Tailor Pipeline Gate|Tailor Pipeline Gate]]
- [[_COMMUNITY_HR Skill Taxonomy|HR Skill Taxonomy]]
- [[_COMMUNITY_University Rankings Data|University Rankings Data]]
- [[_COMMUNITY_HR Scorer Rationale|HR Scorer Rationale]]
- [[_COMMUNITY_Resume Action Verbs|Resume Action Verbs]]
- [[_COMMUNITY_HR Scorer Reporting|HR Scorer Reporting]]
- [[_COMMUNITY_Term Matching Utilities|Term Matching Utilities]]
- [[_COMMUNITY_Git Hooks & Protection|Git Hooks & Protection]]
- [[_COMMUNITY_ATS Domain Scoring|ATS Domain Scoring]]
- [[_COMMUNITY_Master Resume & Config|Master Resume & Config]]
- [[_COMMUNITY_Setup Command|Setup Command]]
- [[_COMMUNITY_Tailor Resume Scoring|Tailor Resume Scoring]]
- [[_COMMUNITY_Config & Credentials|Config & Credentials]]
- [[_COMMUNITY_HR Resume Parsing|HR Resume Parsing]]
- [[_COMMUNITY_Known Issues Log|Known Issues Log]]
- [[_COMMUNITY_ATS Keyword Matching|ATS Keyword Matching]]
- [[_COMMUNITY_ATS Fraud Detection|ATS Fraud Detection]]
- [[_COMMUNITY_Resume Writing Rules|Resume Writing Rules]]
- [[_COMMUNITY_General Keywords Metadata|General Keywords Metadata]]
- [[_COMMUNITY_Healthcare Keywords Metadata|Healthcare Keywords Metadata]]
- [[_COMMUNITY_ONET Skills Metadata|O*NET Skills Metadata]]
- [[_COMMUNITY_Writing Coach Modes|Writing Coach Modes]]
- [[_COMMUNITY_HR Scorer Internals|HR Scorer Internals]]
- [[_COMMUNITY_Commands & Formats|Commands & Formats]]
- [[_COMMUNITY_Find Jobs Command|Find Jobs Command]]
- [[_COMMUNITY_Skill Taxonomy Domains|Skill Taxonomy Domains]]
- [[_COMMUNITY_HR Impact Scoring|HR Impact Scoring]]
- [[_COMMUNITY_Tailor Resume Finalization|Tailor Resume Finalization]]

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
- `Exponential Skill Decay R(s,t) = W_base * e^(-λ*Δt)` --rationale_for--> `calculate_skill_freshness()`  [INFERRED]
  ats_scorer.py → hr_scorer.py
- `Master Resume Source Material Rule 12` --semantically_similar_to--> `Master Resume Parsing Guide`  [INFERRED] [semantically similar]
  .claude/commands/writing-coach.md → CLAUDE.md
- `GapAnalysis` --uses--> `JobEntry`  [INFERRED]
  job_fit_scorer.py → hr_scorer.py

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Dual Scoring Pipeline (ATS + HR)** — commands_tailor_resume_ats_scorer, commands_tailor_resume_hr_scorer, commands_tailor_resume_phase_3_score_base_tailored, commands_tailor_resume_phase_4_score_check_iteration [EXTRACTED 0.95]
- **Content Authenticity Pipeline** — commands_tailor_resume_master_resume, commands_tailor_resume_authenticity_rules, commands_tailor_resume_ethical_requirements, commands_tailor_resume_phase_2_write_tailored_resume [EXTRACTED 0.90]
- **JD Keyword Extraction and Application Flow** — commands_tailor_resume_phase_1_5_extract_jd_keywords, commands_tailor_resume_jd_keywords_json, commands_tailor_resume_ats_keyword_bolding, commands_tailor_resume_resume_md [EXTRACTED 0.90]

## Communities (48 total, 0 thin omitted)

### Community 0 - "Clinical Research Keywords"
Cohesion: 0.05
Nodes (146): clinical_trials, adaptive design, basket trial, bioavailability, bioequivalence, blinding, clinical development, clinical research (+138 more)

### Community 1 - "Industry Acronyms"
Cohesion: 0.01
Nodes (139): aco, ae, agile, ai, anda, api, ats, aum (+131 more)

### Community 2 - "O*NET Technical Skills"
Cohesion: 0.05
Nodes (119): category, importance, technical_skills, a/b testing, access control, accounting, active directory, api design (+111 more)

### Community 3 - "Consulting Keywords"
Cohesion: 0.08
Nodes (111): client_engagement, deliverables, board deck, C-suite presentation, case interview, current state assessment, data room, executive summary (+103 more)

### Community 4 - "Finance Keywords"
Cohesion: 0.08
Nodes (111): category, decay_lambda, synonyms, weight, financial_modeling, accretion dilution, capitalization table, contribution analysis (+103 more)

### Community 5 - "Technology Keywords"
Cohesion: 0.08
Nodes (108): category, decay_lambda, synonyms, weight, _metadata, domain, last_updated, total_keywords (+100 more)

### Community 6 - "Healthcare Keywords"
Cohesion: 0.09
Nodes (105): clinical_operations, ambulatory operations, ambulatory surgery center, bed management, behavioral health, capacity planning, care coordination, care transitions (+97 more)

### Community 7 - "General Skills Keywords"
Cohesion: 0.09
Nodes (103): analytical_skills, business analysis, critical thinking, data analysis, financial analysis, problem solving, qualitative analysis, quantitative analysis (+95 more)

### Community 8 - "HR Scorer Data Models"
Cohesion: 0.07
Nodes (71): CandidateProfile, JobEntry, JobRequirements, Represents a single job/position from resume, Parsed candidate information, Parsed job description requirements, analyze_gaps(), build_candidate_profile() (+63 more)

### Community 9 - "Job Discovery & Scoring"
Cohesion: 0.06
Nodes (48): Two-Tier Scoring: lightweight fast-path then full ATS+HR, HTMLParser, _active_attribution(), AdzunaSource, _ai_role_filter(), analyze_resume_for_search(), _build_setup_message(), _detect_text_domain() (+40 more)

### Community 10 - "ATS Score Calculators"
Cohesion: 0.09
Nodes (39): apply_domain_specific_scoring(), assess_format_risk(), audit_scoring_bias(), _calculate_bm25_fallback(), calculate_bm25_score(), _calculate_dale_chall_score(), calculate_readability(), calculate_recency_adjusted_score() (+31 more)

### Community 11 - "ATS Scorer Core"
Cohesion: 0.09
Nodes (33): build_skill_graph(), build_synonym_maps(), calculate_weighted_score(), clean_text(), expand_acronyms(), extract_jd_keywords(), extract_keywords(), extract_phrases() (+25 more)

### Community 12 - "O*NET Basic Skills"
Cohesion: 0.07
Nodes (27): basic_skills, active learning, active listening, communication, copywriting, critical thinking, documentation, editing (+19 more)

### Community 13 - "O*NET Complex Problem Skills"
Cohesion: 0.10
Nodes (20): complex_problem_solving, 5s, analytical thinking, continuous improvement, creativity, critical analysis, debugging, design thinking (+12 more)

### Community 14 - "Text Extraction Engine"
Cohesion: 0.18
Nodes (18): extract_text_from_file(), Extract text from PDF, DOCX, MD, or TXT file., _extract_pdf(), _extract_pdf_digital(), extract_text(), _is_scanned(), _ocr_via_claude(), _ocr_via_tesseract() (+10 more)

### Community 15 - "ATS Scoring Functions"
Cohesion: 0.13
Nodes (18): calculate_ats_score(), calculate_graph_centrality_score(), check_job_title_match(), get_likelihood_rating(), infer_skills_from_graph(), main(), Infer additional skills using graph-based analysis (§8.2).      If a candidate l, Calculate skill match score using graph centrality (§8.2).      Evaluates how ce (+10 more)

### Community 16 - "HR Score Calculators"
Cohesion: 0.17
Nodes (17): calculate_career_slope(), calculate_hr_score(), calculate_penalties(), detect_edge_cases(), extract_skills_from_text(), extract_text_from_file(), str, Trapezoidal scoring for experience:     - Under 50% requirement: Knockout (0) (+9 more)

### Community 17 - "HR Scorer Utilities"
Cohesion: 0.15
Nodes (17): calculate_hr_score_from_text(), check_page_length_penalty(), generate_interview_questions(), load_json_data(), Any, Score resume for F-Pattern reading compliance (§3.1.1, §9.1).      Based on eye-, Penalize excessively long bullet points that hurt readability.      Bullets long, Apply domain-specific page length rules.      - Finance: strict 1-page rule; >~3 (+9 more)

### Community 18 - "Company Prestige Data"
Cohesion: 0.40
Nodes (15): fortune500, tier1_consulting, tier1_cro, companies, description, score_boost, tier1_finance, tier1_healthcare (+7 more)

### Community 19 - "Application Tracker"
Cohesion: 0.19
Nodes (13): add_application(), format_excel_worksheet(), get_all_applications(), float, str, Job Application Tracker Utilities  This module provides functions to manage the, Get all applications from the tracker.      Returns:         pandas.DataFrame or, Update the status of an existing application.      Args:         company: Compan (+5 more)

### Community 20 - "Tailor Pipeline Gate"
Cohesion: 0.23
Nodes (13): config.json, job_description.txt, Job Fit Decision Gate, job_fit_scorer.py, reference/llm_score_prompt.txt, Master Resume, Phase 0: Setup, Phase 1.5: Extract JD Keywords (+5 more)

### Community 21 - "HR Skill Taxonomy"
Cohesion: 0.22
Nodes (11): calculate_skill_freshness(), determine_seniority_level(), extract_years_from_text(), get_skill_decay_lambda(), parse_job_description(), HR Cognitive Simulation Engine (HR-CSE) ========================================, Parse job description into structured requirements, Extract years of experience from text like '5+ years' or 'minimum 3 years (+3 more)

### Community 22 - "University Rankings Data"
Cohesion: 0.46
Nodes (12): tier1_business, tier1_global, tier1_medical, tier1_uk, description, score_boost, universities, tier1_us_elite (+4 more)

### Community 23 - "HR Scorer Rationale"
Cohesion: 0.22
Nodes (13): float, Score therapeutic area alignment using REALISTIC HR reasoning.      Key principl, Score experience type alignment (clinical research, drug development, etc.), Score clinical trial phase experience.     HR understands: Phase I experience of, Score education alignment with REALISTIC expectations.      For director-level r, Score whether candidate's career level aligns with target role.     HR thinks: I, Main Job Fit scoring function.     Combines all fit dimensions with human-like w, score_education_fit() (+5 more)

### Community 24 - "Resume Action Verbs"
Cohesion: 0.48
Nodes (11): analytical_verbs, clinical_verbs, level_1_execution, level_2_management, level_3_strategy, level_4_impact, technical_verbs, weak_verbs (+3 more)

### Community 25 - "HR Scorer Reporting"
Cohesion: 0.23
Nodes (11): generate_html_report(), HRScoreResult, main(), print_score_report(), Convert HRScoreResult to JSON-serializable dictionary, Print formatted score report to console, Generate HTML report for web interface, Run simple web interface for HR scoring (+3 more)

### Community 26 - "Term Matching Utilities"
Cohesion: 0.20
Nodes (11): Normalize a search term using the same cleaning rules as document text., compile_term_pattern(), contains_term(), extract_job_fit_requirements(), normalize_match_text(), bool, Normalize text for boundary-aware term matching., Compile a boundary-aware matcher for a term. (+3 more)

### Community 27 - "Git Hooks & Protection"
Cohesion: 0.24
Nodes (9): run_hook.sh script, extract_path_pattern(), load_settings(), main(), matches_pattern(), Extract file path pattern from deny rule like 'Read(./path/pattern)'., Check if file path matches a deny pattern., Main function to process the hook input and check for sensitive file access. (+1 more)

### Community 28 - "ATS Domain Scoring"
Cohesion: 0.22
Nodes (10): calculate_phrase_match(), detect_domain(), _get_domain_proto_embeddings(), get_sbert_model(), Calculate important phrase matches.      Args:         resume_text: Resume conte, Calculate important phrase matches using domain-aware phrase sets.      Args:, Thread-safe lazy loading of SBERT model. Loads once on first call., Lazily compute and cache domain prototype embeddings. (+2 more)

### Community 29 - "Master Resume & Config"
Cohesion: 0.29
Nodes (10): Master Resume Parsing Guide, Progress Tracking Protocol, Project Instructions CLAUDE.md, Master Resume Command, Master Resume Source Material Rule 12, Modification Changelog, Master Resume Formatting Guide, Role-Level Retrieval Hierarchy (+2 more)

### Community 30 - "Setup Command"
Cohesion: 0.20
Nodes (10): config.json Setup, Scoring Engine Setup Verification, Setup Command, Virtual Environment Configuration, config.json Fields Reference, Dual Engine ATS HR Scoring Feature, AI Resume Builder README, LLM Score Prompt Template (+2 more)

### Community 31 - "Tailor Resume Scoring"
Cohesion: 0.31
Nodes (9): ATS Score Target (65%+), ats_scorer.py, HR Score Target (70%+), hr_scorer.py, Phase 3: Score Base + Tailored Resume, Phase 4: Score Check + Iteration, Phase 6: Cleanup + Report, Report.txt (Final Report) (+1 more)

### Community 32 - "Config & Credentials"
Cohesion: 0.22
Nodes (8): generate_score_prompt, output_base_dir, user_credentials, user_email, user_linkedin, user_name, user_phone, venv_name

### Community 33 - "HR Resume Parsing"
Cohesion: 0.22
Nodes (9): date, EducationEntry, parse_date(), parse_resume(), Score based on prestige signals using expanded databases.      Enhanced with:, Represents an education entry, Parse various date formats to date object, Parse resume text into structured CandidateProfile (+1 more)

### Community 34 - "Known Issues Log"
Cohesion: 0.31
Nodes (9): ISS-003 ATS Domain Misclassification, ISS-006 HR Scorer Boilerplate Ingestion, ISS-009 Hyphenated Compound Tokenization, ISS-010 ATS Boilerplate Keywords, ISS-012 Gerund Verb Stemming Mismatch, ISS-014 Readability Penalty vs Rule 15, ISS-018 HR Skills Factor Instability, ISS-019 Concatenated JD Token Artifacts (+1 more)

### Community 35 - "ATS Keyword Matching"
Cohesion: 0.29
Nodes (8): calculate_keyword_match(), get_canonical_term(), get_related_terms(), match_with_synonyms(), Calculate keyword match percentage with enhanced matching.      Uses:     - Lemm, Get the canonical form of a term using synonym mapping.     E.g., 'tensorflow' -, Get all related terms for a canonical term.     E.g., 'python' -> ['pandas', 'nu, Match JD terms against resume terms, considering synonyms and related terms.

### Community 36 - "ATS Fraud Detection"
Cohesion: 0.25
Nodes (8): contains_normalized_term(), detect_hidden_text(), detect_keyword_stuffing(), Detect hidden/invisible text manipulation (§2.3.2).      Checks for:     - White, Extract text from PDF file., Match a term against cleaned text without allowing substring false positives., Detect keyword stuffing and manipulation (§2.3.2).      Checks for:     - Abnorm, bool

### Community 37 - "Resume Writing Rules"
Cohesion: 0.25
Nodes (8): ATS Keyword Bolding Rule (Rule 19), Authenticity Rules, Company Overview Lead Rule (Rule 15), Ethical Requirements (Non-Negotiable), jd_keywords.json, Resume Writing Rules, STAR Bullets Formula, Writing Coach Rules (1-19)

### Community 38 - "General Keywords Metadata"
Cohesion: 0.25
Nodes (8): _metadata, decay_lambda_scale, description, domain, last_updated, total_keywords, version, weight_scale

### Community 39 - "Healthcare Keywords Metadata"
Cohesion: 0.25
Nodes (8): _metadata, decay_lambda_guide, description, domain, last_updated, total_keywords, version, weight_scale

### Community 40 - "O*NET Skills Metadata"
Cohesion: 0.33
Nodes (6): _metadata, categories, description, importance_scale, source, version

### Community 41 - "Writing Coach Modes"
Cohesion: 0.40
Nodes (5): Writing Coach Integrated Mode, Writing Coach Standalone Mode, Resume Writing Audit 8 Dimensions, Writing Coach Command, Writing Enhancement Engine

### Community 42 - "HR Scorer Internals"
Cohesion: 0.40
Nodes (5): find_term_positions(), get_title_hierarchy_level(), int, Return all boundary-aware match offsets for a term., Map job title to hierarchy level (1-9)

### Community 43 - "Commands & Formats"
Cohesion: 0.83
Nodes (4): create-format Command — Format Definition Generator, setup Command — One-Time Initialization, SheetsResume Format — Markdown Resume Template, README — AI Resume Builder Project Overview

### Community 44 - "Find Jobs Command"
Cohesion: 0.50
Nodes (4): Find Jobs Command, Job Discovery Phase, Job Source Selection, Find Jobs to Tailor Resume Integration

### Community 45 - "Skill Taxonomy Domains"
Cohesion: 0.67
Nodes (4): areas, industry_domains, e-commerce, fintech

### Community 46 - "HR Impact Scoring"
Cohesion: 0.50
Nodes (4): get_verb_power_score(), Get verb power score based on Bloom's Taxonomy classification.      Levels:, Score based on density of impact indicators using Bloom's Taxonomy.      Enhance, score_impact_density()

### Community 47 - "Tailor Resume Finalization"
Cohesion: 1.00
Nodes (3): Phase 5: Finalization, tracker_utils.add_application, tracker_utils.py

## Knowledge Gaps
- **215 isolated node(s):** `run_hook.sh script`, `venv_name`, `output_base_dir`, `user_name`, `user_credentials` (+210 more)
  These have ≤1 connection - possible missing edges or undocumented components.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `load_domain_keywords()` connect `ATS Scorer Core` to `Clinical Research Keywords`, `Consulting Keywords`, `Finance Keywords`, `Technology Keywords`, `Healthcare Keywords`, `General Skills Keywords`, `ATS Score Calculators`, `ATS Scoring Functions`?**
  _High betweenness centrality (0.435) - this node is a cross-community bridge._
- **Why does `expand_acronyms()` connect `ATS Scorer Core` to `Industry Acronyms`?**
  _High betweenness centrality (0.178) - this node is a cross-community bridge._
- **Why does `is_valid_skill()` connect `ATS Scorer Core` to `HR Scorer Data Models`, `O*NET Complex Problem Skills`?**
  _High betweenness centrality (0.132) - this node is a cross-community bridge._
- **What connects `Load Claude settings and extract deny patterns from the project-level settings.j`, `Extract file path pattern from deny rule like 'Read(./path/pattern)'.`, `Check if file path matches a deny pattern.` to the rest of the system?**
  _389 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Clinical Research Keywords` be split into smaller, more focused modules?**
  _Cohesion score 0.05376945298667412 - nodes in this community are weakly interconnected._
- **Should `Industry Acronyms` be split into smaller, more focused modules?**
  _Cohesion score 0.014285714285714285 - nodes in this community are weakly interconnected._
- **Should `O*NET Technical Skills` be split into smaller, more focused modules?**
  _Cohesion score 0.04942315909414613 - nodes in this community are weakly interconnected._