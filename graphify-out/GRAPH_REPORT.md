# Graph Report - .  (2026-06-05)

## Corpus Check
- 3 files · ~114,054 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1587 nodes · 4934 edges · 44 communities (41 shown, 3 thin omitted)
- Extraction: 98% EXTRACTED · 2% INFERRED · 0% AMBIGUOUS · INFERRED: 82 edges (avg confidence: 0.72)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Clinical & ATS Keyword Scoring|Clinical & ATS Keyword Scoring]]
- [[_COMMUNITY_Industry Acronym Lookup|Industry Acronym Lookup]]
- [[_COMMUNITY_Technical Skill Taxonomy|Technical Skill Taxonomy]]
- [[_COMMUNITY_Finance Domain Keywords|Finance Domain Keywords]]
- [[_COMMUNITY_Consulting Domain Keywords|Consulting Domain Keywords]]
- [[_COMMUNITY_Technology Domain Keywords|Technology Domain Keywords]]
- [[_COMMUNITY_Healthcare Domain Keywords|Healthcare Domain Keywords]]
- [[_COMMUNITY_General Skill Keywords|General Skill Keywords]]
- [[_COMMUNITY_HR Scoring Data Models|HR Scoring Data Models]]
- [[_COMMUNITY_HR Scoring Engine|HR Scoring Engine]]
- [[_COMMUNITY_Job Discovery Pipeline|Job Discovery Pipeline]]
- [[_COMMUNITY_ATS Core Scoring|ATS Core Scoring]]
- [[_COMMUNITY_ATS Advanced Scoring|ATS Advanced Scoring]]
- [[_COMMUNITY_ONET Basic Skills|O*NET Basic Skills]]
- [[_COMMUNITY_Text Extraction Utilities|Text Extraction Utilities]]
- [[_COMMUNITY_Complex Problem Solving Skills|Complex Problem Solving Skills]]
- [[_COMMUNITY_Graphify Knowledge Graph Skill|Graphify Knowledge Graph Skill]]
- [[_COMMUNITY_ATS Score Assessment|ATS Score Assessment]]
- [[_COMMUNITY_Resume & Job Commands|Resume & Job Commands]]
- [[_COMMUNITY_HR Term Pattern Matching|HR Term Pattern Matching]]
- [[_COMMUNITY_Claude Hooks & Permissions|Claude Hooks & Permissions]]
- [[_COMMUNITY_Company Prestige Tiers|Company Prestige Tiers]]
- [[_COMMUNITY_ATS Semantic Embedding|ATS Semantic Embedding]]
- [[_COMMUNITY_Application Tracker Utils|Application Tracker Utils]]
- [[_COMMUNITY_Master Resume Rules|Master Resume Rules]]
- [[_COMMUNITY_University Rankings Data|University Rankings Data]]
- [[_COMMUNITY_Resume Action Verbs|Resume Action Verbs]]
- [[_COMMUNITY_Configuration & Credentials|Configuration & Credentials]]
- [[_COMMUNITY_Setup & Configuration|Setup & Configuration]]
- [[_COMMUNITY_Score Iteration & Issues|Score Iteration & Issues]]
- [[_COMMUNITY_Authenticity & Writing Rules|Authenticity & Writing Rules]]
- [[_COMMUNITY_Scoring Targets & Gates|Scoring Targets & Gates]]
- [[_COMMUNITY_Config Example Templates|Config Example Templates]]
- [[_COMMUNITY_ATS Integrity Checks|ATS Integrity Checks]]
- [[_COMMUNITY_General Keywords Metadata|General Keywords Metadata]]
- [[_COMMUNITY_Healthcare Keywords Metadata|Healthcare Keywords Metadata]]
- [[_COMMUNITY_Resume Tailoring Setup|Resume Tailoring Setup]]
- [[_COMMUNITY_HR Resume Parsing|HR Resume Parsing]]
- [[_COMMUNITY_ATS Synonym Matching|ATS Synonym Matching]]
- [[_COMMUNITY_ONET Skills Metadata|O*NET Skills Metadata]]
- [[_COMMUNITY_ATS Readability Scoring|ATS Readability Scoring]]
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
- **Scoring Pipeline: ATS Scorer + HR Scorer + JD + Resume** — commands_tailor_resume_ats_scorer, commands_tailor_resume_hr_scorer, commands_tailor_resume_resume_md, commands_tailor_resume_job_description_txt, commands_tailor_resume_jd_keywords_json [EXTRACTED 0.95]
- **Resume Writing Rule System: Authenticity + Writing Coach + Ethical Requirements + SheetsResume Format** — commands_tailor_resume_authenticity_rules, commands_tailor_resume_writing_coach_rules, commands_tailor_resume_ethical_requirements, commands_tailor_resume_sheetsresume_format, commands_tailor_resume_ats_keyword_bolding [EXTRACTED 0.95]
- **Tailor Resume Swarm v3.0 — All Ordered Phases** — commands_tailor_resume_phase0_setup, commands_tailor_resume_phase1_parallel_research, commands_tailor_resume_phase1_5_job_fit_precheck, commands_tailor_resume_phase2_write_tailored_resume, commands_tailor_resume_phase3_score_base_tailored, commands_tailor_resume_phase4_score_check_iteration, commands_tailor_resume_phase5_finalization, commands_tailor_resume_phase6_cleanup_report [EXTRACTED 1.00]

## Communities (44 total, 3 thin omitted)

### Community 0 - "Clinical & ATS Keyword Scoring"
Cohesion: 0.05
Nodes (152): build_skill_graph(), Build a skill knowledge graph from the taxonomy (§2.2.2, §8.2).      Creates nod, clinical_trials, adaptive design, basket trial, bioavailability, bioequivalence, blinding (+144 more)

### Community 1 - "Industry Acronym Lookup"
Cohesion: 0.01
Nodes (139): aco, ae, agile, ai, anda, api, ats, aum (+131 more)

### Community 2 - "Technical Skill Taxonomy"
Cohesion: 0.05
Nodes (119): category, importance, technical_skills, a/b testing, access control, accounting, active directory, api design (+111 more)

### Community 3 - "Finance Domain Keywords"
Cohesion: 0.08
Nodes (111): category, decay_lambda, synonyms, weight, financial_modeling, accretion dilution, capitalization table, contribution analysis (+103 more)

### Community 4 - "Consulting Domain Keywords"
Cohesion: 0.08
Nodes (109): client_engagement, deliverables, board deck, C-suite presentation, case interview, current state assessment, data room, executive summary (+101 more)

### Community 5 - "Technology Domain Keywords"
Cohesion: 0.08
Nodes (108): category, decay_lambda, synonyms, weight, _metadata, domain, last_updated, total_keywords (+100 more)

### Community 6 - "Healthcare Domain Keywords"
Cohesion: 0.09
Nodes (105): clinical_operations, ambulatory operations, ambulatory surgery center, bed management, behavioral health, capacity planning, care coordination, care transitions (+97 more)

### Community 7 - "General Skill Keywords"
Cohesion: 0.09
Nodes (103): analytical_skills, business analysis, critical thinking, data analysis, financial analysis, problem solving, qualitative analysis, quantitative analysis (+95 more)

### Community 8 - "HR Scoring Data Models"
Cohesion: 0.07
Nodes (73): CandidateProfile, JobEntry, JobRequirements, Represents a single job/position from resume, Parsed candidate information, Parsed job description requirements, analyze_gaps(), build_candidate_profile() (+65 more)

### Community 9 - "HR Scoring Engine"
Cohesion: 0.07
Nodes (73): calculate_career_slope(), calculate_hr_score(), calculate_hr_score_from_text(), calculate_penalties(), calculate_skill_freshness(), check_page_length_penalty(), detect_edge_cases(), determine_seniority_level() (+65 more)

### Community 10 - "Job Discovery Pipeline"
Cohesion: 0.06
Nodes (48): Two-Tier Scoring: lightweight fast-path then full ATS+HR, HTMLParser, _active_attribution(), AdzunaSource, _ai_role_filter(), analyze_resume_for_search(), _build_setup_message(), _detect_text_domain() (+40 more)

### Community 11 - "ATS Core Scoring"
Cohesion: 0.09
Nodes (33): build_synonym_maps(), calculate_keyword_match(), calculate_weighted_score(), clean_text(), expand_acronyms(), extract_jd_keywords(), extract_keywords(), extract_phrases() (+25 more)

### Community 12 - "ATS Advanced Scoring"
Cohesion: 0.12
Nodes (31): apply_domain_specific_scoring(), audit_scoring_bias(), _calculate_bm25_fallback(), calculate_bm25_score(), calculate_graph_centrality_score(), calculate_recency_adjusted_score(), calculate_semantic_similarity(), calculate_skill_decay() (+23 more)

### Community 13 - "O*NET Basic Skills"
Cohesion: 0.07
Nodes (27): basic_skills, active learning, active listening, communication, copywriting, critical thinking, documentation, editing (+19 more)

### Community 14 - "Text Extraction Utilities"
Cohesion: 0.16
Nodes (20): extract_text_from_file(), Extract text from PDF, DOCX, MD, or TXT file., extract_text_from_file(), Extract text from PDF, DOCX, MD, or TXT file., _extract_pdf(), _extract_pdf_digital(), extract_text(), _is_scanned() (+12 more)

### Community 15 - "Complex Problem Solving Skills"
Cohesion: 0.10
Nodes (20): complex_problem_solving, 5s, analytical thinking, continuous improvement, creativity, critical analysis, debugging, design thinking (+12 more)

### Community 16 - "Graphify Knowledge Graph Skill"
Cohesion: 0.11
Nodes (20): AST Structural Extraction, Community Detection and Labeling, Graphify Fast Path Query, Graphify Outputs HTML JSON Report, Graphify Build Pipeline, Graphify Skill, Semantic Extraction via Subagents, Graphify Add URL Ingest (+12 more)

### Community 17 - "ATS Score Assessment"
Cohesion: 0.13
Nodes (17): assess_format_risk(), calculate_ats_score(), check_job_title_match(), get_likelihood_rating(), main(), Extract important multi-word phrases using domain-aware keyword sets.      Args:, Check if the JD job title appears in the resume (§10.6x callback data).      Ret, Calculate comprehensive ATS score with all enhanced features (v2.0).      Featur (+9 more)

### Community 18 - "Resume & Job Commands"
Cohesion: 0.13
Nodes (17): Find Jobs Command, Job Discovery Phase, Job Source Selection, Find Jobs to Tailor Resume Integration, Tailor Resume Final Report, Job Fit Pre-Check Gate, Phase 5: Finalization — Application Tracker Update, Tailor Resume Command (+9 more)

### Community 19 - "HR Term Pattern Matching"
Cohesion: 0.14
Nodes (16): Normalize a search term using the same cleaning rules as document text., compile_term_pattern(), contains_term(), find_term_positions(), get_title_hierarchy_level(), normalize_match_text(), bool, int (+8 more)

### Community 20 - "Claude Hooks & Permissions"
Cohesion: 0.16
Nodes (13): run_hook.sh script, hooks, PreToolUse, permissions, deny, extract_path_pattern(), load_settings(), main() (+5 more)

### Community 21 - "Company Prestige Tiers"
Cohesion: 0.40
Nodes (15): fortune500, tier1_consulting, tier1_cro, companies, description, score_boost, tier1_finance, tier1_healthcare (+7 more)

### Community 22 - "ATS Semantic Embedding"
Cohesion: 0.16
Nodes (14): calculate_phrase_match(), detect_domain(), embed_with_cache(), _get_domain_proto_embeddings(), get_sbert_model(), Calculate important phrase matches.      Args:         resume_text: Resume conte, Calculate important phrase matches using domain-aware phrase sets.      Args:, Thread-safe lazy loading of SBERT model. Loads once on first call. (+6 more)

### Community 23 - "Application Tracker Utils"
Cohesion: 0.19
Nodes (13): add_application(), format_excel_worksheet(), get_all_applications(), float, str, Job Application Tracker Utilities  This module provides functions to manage the, Get all applications from the tracker.      Returns:         pandas.DataFrame or, Update the status of an existing application.      Args:         company: Compan (+5 more)

### Community 24 - "Master Resume Rules"
Cohesion: 0.21
Nodes (13): Master Resume Parsing Guide, Progress Tracking Protocol, Project Instructions CLAUDE.md, Master Resume Command, Master Resume Source Material Rule 12, Modification Changelog, Master Resume Formatting Guide, Role-Level Retrieval Hierarchy (+5 more)

### Community 25 - "University Rankings Data"
Cohesion: 0.46
Nodes (12): tier1_business, tier1_global, tier1_medical, tier1_uk, description, score_boost, universities, tier1_us_elite (+4 more)

### Community 26 - "Resume Action Verbs"
Cohesion: 0.48
Nodes (11): analytical_verbs, clinical_verbs, level_1_execution, level_2_management, level_3_strategy, level_4_impact, technical_verbs, weak_verbs (+3 more)

### Community 27 - "Configuration & Credentials"
Cohesion: 0.18
Nodes (10): generate_score_prompt, master_resume_path, output_base_dir, user_credentials, user_email, user_linkedin, user_name, user_phone (+2 more)

### Community 28 - "Setup & Configuration"
Cohesion: 0.20
Nodes (10): config.json Setup, Scoring Engine Setup Verification, Setup Command, Virtual Environment Configuration, config.json Fields Reference, Dual Engine ATS HR Scoring Feature, AI Resume Builder README, LLM Score Prompt Template (+2 more)

### Community 29 - "Score Iteration & Issues"
Cohesion: 0.31
Nodes (10): ATS and HR Scoring Pipeline, Score Check and Iteration, ISS-003 ATS Domain Misclassification, ISS-006 HR Scorer Boilerplate Ingestion, ISS-009 Hyphenated Compound Tokenization, ISS-010 ATS Boilerplate Keywords, ISS-012 Gerund Verb Stemming Mismatch, ISS-018 HR Skills Factor Instability (+2 more)

### Community 30 - "Authenticity & Writing Rules"
Cohesion: 0.33
Nodes (10): Resume Authenticity Rules, Ethical Requirements — Non-Negotiable Anti-Fabrication Rules, JD Keywords JSON Generation, llm_score_prompt.txt — Manual LLM Score Prompt Template, Phase 2: Write Tailored Resume, resume.md — Tailored Resume Output, Rule 19 ATS Keyword Bolding, Score_Prompt.txt — Filled Score Prompt for Claude.ai (+2 more)

### Community 31 - "Scoring Targets & Gates"
Cohesion: 0.31
Nodes (9): ATS Score Target (65%+), ats_scorer.py — ATS Scoring Script, HR Score Target (70%+), hr_scorer.py — HR Scoring Script, Job Fit Decision Gate — Score Thresholds and Go/No-Go Logic, Phase 3: Score Base + Tailored Resume, Phase 4: Score Check + Iteration (max 2 rounds), Phase 6: Cleanup + Final Report (+1 more)

### Community 32 - "Config Example Templates"
Cohesion: 0.22
Nodes (8): generate_score_prompt, output_base_dir, user_credentials, user_email, user_linkedin, user_name, user_phone, venv_name

### Community 33 - "ATS Integrity Checks"
Cohesion: 0.25
Nodes (8): contains_normalized_term(), detect_hidden_text(), detect_keyword_stuffing(), Detect hidden/invisible text manipulation (§2.3.2).      Checks for:     - White, Extract text from PDF file., Match a term against cleaned text without allowing substring false positives., Detect keyword stuffing and manipulation (§2.3.2).      Checks for:     - Abnorm, bool

### Community 34 - "General Keywords Metadata"
Cohesion: 0.25
Nodes (8): _metadata, decay_lambda_scale, description, domain, last_updated, total_keywords, version, weight_scale

### Community 35 - "Healthcare Keywords Metadata"
Cohesion: 0.25
Nodes (8): _metadata, decay_lambda_guide, description, domain, last_updated, total_keywords, version, weight_scale

### Community 36 - "Resume Tailoring Setup"
Cohesion: 0.33
Nodes (7): config.json — Project Configuration File, job_description.txt — Saved Job Description, job_fit_scorer.py — Job Fit Scoring Script, Master Resume — Canonical Reference Document, Tailor Resume Phase 0 Setup, Phase 1.5: Job Fit Pre-Check Gate, Parallel Research Phase

### Community 37 - "HR Resume Parsing"
Cohesion: 0.29
Nodes (7): date, EducationEntry, parse_date(), parse_resume(), Represents an education entry, Parse various date formats to date object, Parse resume text into structured CandidateProfile

### Community 38 - "ATS Synonym Matching"
Cohesion: 0.40
Nodes (6): get_canonical_term(), get_related_terms(), match_with_synonyms(), Get the canonical form of a term using synonym mapping.     E.g., 'tensorflow' -, Get all related terms for a canonical term.     E.g., 'python' -> ['pandas', 'nu, Match JD terms against resume terms, considering synonyms and related terms.

### Community 39 - "O*NET Skills Metadata"
Cohesion: 0.33
Nodes (6): _metadata, categories, description, importance_scale, source, version

### Community 40 - "ATS Readability Scoring"
Cohesion: 0.40
Nodes (5): _calculate_dale_chall_score(), calculate_readability(), Convert Dale-Chall readability score to 0-100 (optimal at 7.0-8.0 for technical, Calculate readability metrics (§3.1.2).      Uses Dale-Chall for technical domai, Convert grade level to 0-100 score (optimal at 10-12).

## Knowledge Gaps
- **237 isolated node(s):** `run_hook.sh script`, `PreToolUse`, `deny`, `venv_name`, `output_base_dir` (+232 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **3 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `load_domain_keywords()` connect `ATS Core Scoring` to `Clinical & ATS Keyword Scoring`, `Finance Domain Keywords`, `Consulting Domain Keywords`, `Technology Domain Keywords`, `Healthcare Domain Keywords`, `General Skill Keywords`, `ATS Advanced Scoring`, `ATS Score Assessment`?**
  _High betweenness centrality (0.394) - this node is a cross-community bridge._
- **Why does `expand_acronyms()` connect `ATS Core Scoring` to `Industry Acronym Lookup`?**
  _High betweenness centrality (0.161) - this node is a cross-community bridge._
- **Why does `is_valid_skill()` connect `ATS Core Scoring` to `HR Scoring Data Models`, `Complex Problem Solving Skills`?**
  _High betweenness centrality (0.135) - this node is a cross-community bridge._
- **What connects `Load Claude settings and extract deny patterns from the project-level settings.j`, `Extract file path pattern from deny rule like 'Read(./path/pattern)'.`, `Check if file path matches a deny pattern.` to the rest of the system?**
  _413 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Clinical & ATS Keyword Scoring` be split into smaller, more focused modules?**
  _Cohesion score 0.050505050505050504 - nodes in this community are weakly interconnected._
- **Should `Industry Acronym Lookup` be split into smaller, more focused modules?**
  _Cohesion score 0.014285714285714285 - nodes in this community are weakly interconnected._
- **Should `Technical Skill Taxonomy` be split into smaller, more focused modules?**
  _Cohesion score 0.04942315909414613 - nodes in this community are weakly interconnected._