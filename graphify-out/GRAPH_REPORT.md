# Graph Report - .  (2026-06-18)

## Corpus Check
- 6 files · ~109,802 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1605 nodes · 4954 edges · 55 communities (43 shown, 12 thin omitted)
- Extraction: 98% EXTRACTED · 2% INFERRED · 0% AMBIGUOUS · INFERRED: 95 edges (avg confidence: 0.73)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_ATS Scoring & Keyword Graph|ATS Scoring & Keyword Graph]]
- [[_COMMUNITY_Domain Acronyms Dictionary|Domain Acronyms Dictionary]]
- [[_COMMUNITY_ONET Technical Skills|O*NET Technical Skills]]
- [[_COMMUNITY_Finance Keywords|Finance Keywords]]
- [[_COMMUNITY_Consulting Keywords|Consulting Keywords]]
- [[_COMMUNITY_Technology Keywords|Technology Keywords]]
- [[_COMMUNITY_Healthcare Keywords|Healthcare Keywords]]
- [[_COMMUNITY_General Skills Keywords|General Skills Keywords]]
- [[_COMMUNITY_HR Scorer Core|HR Scorer Core]]
- [[_COMMUNITY_Job Discovery & Scoring Architecture|Job Discovery & Scoring Architecture]]
- [[_COMMUNITY_Job Fit Scorer|Job Fit Scorer]]
- [[_COMMUNITY_ATS Scorer Core|ATS Scorer Core]]
- [[_COMMUNITY_ATS Advanced Analysis|ATS Advanced Analysis]]
- [[_COMMUNITY_Graphify Skill Pipeline|Graphify Skill Pipeline]]
- [[_COMMUNITY_ONET Basic Skills|O*NET Basic Skills]]
- [[_COMMUNITY_ONET Problem Solving Skills|O*NET Problem Solving Skills]]
- [[_COMMUNITY_HR Scorer Data Models|HR Scorer Data Models]]
- [[_COMMUNITY_Text Extraction|Text Extraction]]
- [[_COMMUNITY_ATS Score Calculation|ATS Score Calculation]]
- [[_COMMUNITY_Company Prestige Rankings|Company Prestige Rankings]]
- [[_COMMUNITY_Application Tracker Utils|Application Tracker Utils]]
- [[_COMMUNITY_Term Matching & Pattern Utils|Term Matching & Pattern Utils]]
- [[_COMMUNITY_Core Commands & Concepts|Core Commands & Concepts]]
- [[_COMMUNITY_Tailor Resume Command Flow|Tailor Resume Command Flow]]
- [[_COMMUNITY_University Rankings|University Rankings]]
- [[_COMMUNITY_Master Resume & Project Config|Master Resume & Project Config]]
- [[_COMMUNITY_Action Verbs Library|Action Verbs Library]]
- [[_COMMUNITY_Hooks & Security Filters|Hooks & Security Filters]]
- [[_COMMUNITY_ATS Semantic & Domain Detection|ATS Semantic & Domain Detection]]
- [[_COMMUNITY_Setup Command|Setup Command]]
- [[_COMMUNITY_ATSHR Scoring Iteration|ATS/HR Scoring Iteration]]
- [[_COMMUNITY_Resume Tailoring Authenticity Rules|Resume Tailoring Authenticity Rules]]
- [[_COMMUNITY_HR Date & Education Parsing|HR Date & Education Parsing]]
- [[_COMMUNITY_Scoring Targets & Gate|Scoring Targets & Gate]]
- [[_COMMUNITY_Config Example|Config Example]]
- [[_COMMUNITY_Keyword Matching & Synonyms|Keyword Matching & Synonyms]]
- [[_COMMUNITY_ATS Anti-Gaming Detection|ATS Anti-Gaming Detection]]
- [[_COMMUNITY_General Keywords Metadata|General Keywords Metadata]]
- [[_COMMUNITY_Healthcare Keywords Metadata|Healthcare Keywords Metadata]]
- [[_COMMUNITY_Tailor Resume Setup Phase|Tailor Resume Setup Phase]]
- [[_COMMUNITY_ONET Skills Metadata|O*NET Skills Metadata]]
- [[_COMMUNITY_ATS Readability Scoring|ATS Readability Scoring]]
- [[_COMMUNITY_Find Jobs Command|Find Jobs Command]]
- [[_COMMUNITY_Graph Database Exports|Graph Database Exports]]
- [[_COMMUNITY_GitHub Multi-Repo Support|GitHub Multi-Repo Support]]
- [[_COMMUNITY_Gemini API Integration|Gemini API Integration]]
- [[_COMMUNITY_Add URL Command|Add URL Command]]
- [[_COMMUNITY_Watch Mode|Watch Mode]]
- [[_COMMUNITY_Token Reduction Benchmark|Token Reduction Benchmark]]
- [[_COMMUNITY_GraphML Export|GraphML Export]]
- [[_COMMUNITY_MCP Server|MCP Server]]
- [[_COMMUNITY_SVG Export|SVG Export]]
- [[_COMMUNITY_Whisper Transcription|Whisper Transcription]]
- [[_COMMUNITY_Cluster-Only Mode|Cluster-Only Mode]]
- [[_COMMUNITY_Environment Isolation Rule|Environment Isolation Rule]]

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
- `Exponential Skill Decay R(s,t) = W_base * e^(-λ*Δt)` --rationale_for--> `calculate_skill_freshness()`  [INFERRED]
  ats_scorer.py → hr_scorer.py
- `Python Dependencies requirements.txt` --conceptually_related_to--> `ATS and HR Scoring Pipeline`  [INFERRED]
  requirements.txt → .claude/commands/tailor-resume.md

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Graphify Full Build Pipeline (Steps 1-9)** — graphify_skill_step1_install, graphify_skill_step2_detect, graphify_skill_step3_extract, graphify_skill_step4_build, graphify_skill_step5_label, graphify_skill_step6_viz, graphify_skill_step9_cleanup [EXTRACTED 1.00]
- **Graphify Optional Export Formats** — references_exports_wiki, references_exports_neo4j, references_exports_falkordb, references_exports_svg, references_exports_graphml, references_exports_mcp [EXTRACTED 1.00]
- **Graphify Query Subcommands (query, path, explain)** — references_query_bfs_dfs, references_query_path_flow, references_query_explain_flow, references_query_vocab_expansion [EXTRACTED 1.00]

## Communities (55 total, 12 thin omitted)

### Community 0 - "ATS Scoring & Keyword Graph"
Cohesion: 0.05
Nodes (152): build_skill_graph(), Build a skill knowledge graph from the taxonomy (§2.2.2, §8.2).      Creates nod, clinical_trials, adaptive design, basket trial, bioavailability, bioequivalence, blinding (+144 more)

### Community 1 - "Domain Acronyms Dictionary"
Cohesion: 0.01
Nodes (139): aco, ae, agile, ai, anda, api, ats, aum (+131 more)

### Community 2 - "O*NET Technical Skills"
Cohesion: 0.05
Nodes (119): category, importance, technical_skills, a/b testing, access control, accounting, active directory, api design (+111 more)

### Community 3 - "Finance Keywords"
Cohesion: 0.08
Nodes (111): category, decay_lambda, synonyms, weight, financial_modeling, accretion dilution, capitalization table, contribution analysis (+103 more)

### Community 4 - "Consulting Keywords"
Cohesion: 0.08
Nodes (109): client_engagement, deliverables, board deck, C-suite presentation, case interview, current state assessment, data room, executive summary (+101 more)

### Community 5 - "Technology Keywords"
Cohesion: 0.08
Nodes (108): category, decay_lambda, synonyms, weight, _metadata, domain, last_updated, total_keywords (+100 more)

### Community 6 - "Healthcare Keywords"
Cohesion: 0.09
Nodes (105): clinical_operations, ambulatory operations, ambulatory surgery center, bed management, behavioral health, capacity planning, care coordination, care transitions (+97 more)

### Community 7 - "General Skills Keywords"
Cohesion: 0.09
Nodes (103): analytical_skills, business analysis, critical thinking, data analysis, financial analysis, problem solving, qualitative analysis, quantitative analysis (+95 more)

### Community 8 - "HR Scorer Core"
Cohesion: 0.07
Nodes (75): calculate_career_slope(), calculate_hr_score(), calculate_hr_score_from_text(), calculate_penalties(), calculate_skill_freshness(), check_page_length_penalty(), detect_edge_cases(), determine_seniority_level() (+67 more)

### Community 9 - "Job Discovery & Scoring Architecture"
Cohesion: 0.06
Nodes (48): Two-Tier Scoring: lightweight fast-path then full ATS+HR, HTMLParser, _active_attribution(), AdzunaSource, _ai_role_filter(), analyze_resume_for_search(), _build_setup_message(), _detect_text_domain() (+40 more)

### Community 10 - "Job Fit Scorer"
Cohesion: 0.09
Nodes (53): analyze_gaps(), build_candidate_profile(), calculate_job_fit(), _calculate_years_by_type(), check_knockouts(), _detect_seniority(), EnrichedProfile, _estimate_ats_range() (+45 more)

### Community 11 - "ATS Scorer Core"
Cohesion: 0.10
Nodes (31): build_synonym_maps(), calculate_weighted_score(), clean_text(), expand_acronyms(), extract_jd_keywords(), extract_keywords(), extract_phrases(), get_domain_keywords_for_text() (+23 more)

### Community 12 - "ATS Advanced Analysis"
Cohesion: 0.11
Nodes (35): apply_domain_specific_scoring(), audit_scoring_bias(), _calculate_bm25_fallback(), calculate_bm25_score(), calculate_graph_centrality_score(), calculate_recency_adjusted_score(), calculate_semantic_similarity(), calculate_skill_decay() (+27 more)

### Community 13 - "Graphify Skill Pipeline"
Cohesion: 0.07
Nodes (31): Fast Path: Existing Graph Query Shortcut, Graphify Honesty Rules, Graphify Skill — Full Pipeline Orchestrator, Graphify Query Flow (BFS/DFS Traversal), Step 1: Ensure graphify is Installed, Step 2: Detect Files, Step 3: Extract Entities and Relationships, Step 3A: Structural AST Extraction (+23 more)

### Community 14 - "O*NET Basic Skills"
Cohesion: 0.07
Nodes (27): basic_skills, active learning, active listening, communication, copywriting, critical thinking, documentation, editing (+19 more)

### Community 15 - "O*NET Problem Solving Skills"
Cohesion: 0.10
Nodes (20): complex_problem_solving, 5s, analytical thinking, continuous improvement, creativity, critical analysis, debugging, design thinking (+12 more)

### Community 16 - "HR Scorer Data Models"
Cohesion: 0.16
Nodes (20): CandidateProfile, JobEntry, JobRequirements, Represents a single job/position from resume, Parsed candidate information, Parsed job description requirements, format_report(), Gap (+12 more)

### Community 17 - "Text Extraction"
Cohesion: 0.18
Nodes (18): extract_text_from_file(), Extract text from PDF, DOCX, MD, or TXT file., _extract_pdf(), _extract_pdf_digital(), extract_text(), _is_scanned(), _ocr_via_claude(), _ocr_via_tesseract() (+10 more)

### Community 18 - "ATS Score Calculation"
Cohesion: 0.13
Nodes (17): assess_format_risk(), calculate_ats_score(), check_job_title_match(), get_likelihood_rating(), main(), Extract important multi-word phrases using domain-aware keyword sets.      Args:, Check if the JD job title appears in the resume (§10.6x callback data).      Ret, Calculate comprehensive ATS score with all enhanced features (v2.0).      Featur (+9 more)

### Community 19 - "Company Prestige Rankings"
Cohesion: 0.40
Nodes (15): fortune500, tier1_consulting, tier1_cro, companies, description, score_boost, tier1_finance, tier1_healthcare (+7 more)

### Community 20 - "Application Tracker Utils"
Cohesion: 0.19
Nodes (13): add_application(), format_excel_worksheet(), get_all_applications(), float, str, Job Application Tracker Utilities  This module provides functions to manage the, Get all applications from the tracker.      Returns:         pandas.DataFrame or, Update the status of an existing application.      Args:         company: Compan (+5 more)

### Community 21 - "Term Matching & Pattern Utils"
Cohesion: 0.18
Nodes (13): Normalize a search term using the same cleaning rules as document text., compile_term_pattern(), contains_term(), find_term_positions(), normalize_match_text(), bool, Normalize text for boundary-aware term matching., Compile a boundary-aware matcher for a term. (+5 more)

### Community 22 - "Core Commands & Concepts"
Cohesion: 0.33
Nodes (13): create-format Command — Format Definition Generator, setup Command — One-Time Initialization, tailor-resume Command — ATS+HR Resume Tailoring Pipeline, ATS Scoring — Keyword Match Engine, Authenticity Rules — Ethical Writing Constraints, HR Scoring — Cognitive Simulation Reviewer, jd_keywords.json — Extracted JD Keyword Map, Job Fit Pre-Check — Knockout Gating (+5 more)

### Community 23 - "Tailor Resume Command Flow"
Cohesion: 0.18
Nodes (13): Tailor Resume Final Report, Job Fit Pre-Check Gate, Phase 5: Finalization — Application Tracker Update, Tailor Resume Command, Application Tracker Update, tracker_utils.py — Application Tracker Utility, Resume Writing Rules 1-19, Writing Coach Integrated Mode (+5 more)

### Community 24 - "University Rankings"
Cohesion: 0.46
Nodes (12): tier1_business, tier1_global, tier1_medical, tier1_uk, description, score_boost, universities, tier1_us_elite (+4 more)

### Community 25 - "Master Resume & Project Config"
Cohesion: 0.23
Nodes (12): Master Resume Parsing Guide, Progress Tracking Protocol, Project Instructions CLAUDE.md, Master Resume Command, Master Resume Source Material Rule 12, Modification Changelog, Master Resume Formatting Guide, Role-Level Retrieval Hierarchy (+4 more)

### Community 26 - "Action Verbs Library"
Cohesion: 0.48
Nodes (11): analytical_verbs, clinical_verbs, level_1_execution, level_2_management, level_3_strategy, level_4_impact, technical_verbs, weak_verbs (+3 more)

### Community 27 - "Hooks & Security Filters"
Cohesion: 0.24
Nodes (9): run_hook.sh script, extract_path_pattern(), load_settings(), main(), matches_pattern(), Extract file path pattern from deny rule like 'Read(./path/pattern)'., Check if file path matches a deny pattern., Main function to process the hook input and check for sensitive file access. (+1 more)

### Community 28 - "ATS Semantic & Domain Detection"
Cohesion: 0.22
Nodes (10): calculate_phrase_match(), detect_domain(), _get_domain_proto_embeddings(), get_sbert_model(), Calculate important phrase matches.      Args:         resume_text: Resume conte, Calculate important phrase matches using domain-aware phrase sets.      Args:, Thread-safe lazy loading of SBERT model. Loads once on first call., Lazily compute and cache domain prototype embeddings. (+2 more)

### Community 29 - "Setup Command"
Cohesion: 0.20
Nodes (10): config.json Setup, Scoring Engine Setup Verification, Setup Command, Virtual Environment Configuration, config.json Fields Reference, Dual Engine ATS HR Scoring Feature, AI Resume Builder README, LLM Score Prompt Template (+2 more)

### Community 30 - "ATS/HR Scoring Iteration"
Cohesion: 0.31
Nodes (10): ATS and HR Scoring Pipeline, Score Check and Iteration, ISS-003 ATS Domain Misclassification, ISS-006 HR Scorer Boilerplate Ingestion, ISS-009 Hyphenated Compound Tokenization, ISS-010 ATS Boilerplate Keywords, ISS-012 Gerund Verb Stemming Mismatch, ISS-018 HR Skills Factor Instability (+2 more)

### Community 31 - "Resume Tailoring Authenticity Rules"
Cohesion: 0.33
Nodes (10): Resume Authenticity Rules, Ethical Requirements — Non-Negotiable Anti-Fabrication Rules, JD Keywords JSON Generation, llm_score_prompt.txt — Manual LLM Score Prompt Template, Phase 2: Write Tailored Resume, resume.md — Tailored Resume Output, Rule 19 ATS Keyword Bolding, Score_Prompt.txt — Filled Score Prompt for Claude.ai (+2 more)

### Community 32 - "HR Date & Education Parsing"
Cohesion: 0.20
Nodes (10): date, EducationEntry, get_title_hierarchy_level(), parse_date(), parse_resume(), int, Represents an education entry, Parse various date formats to date object (+2 more)

### Community 33 - "Scoring Targets & Gate"
Cohesion: 0.31
Nodes (9): ATS Score Target (65%+), ats_scorer.py — ATS Scoring Script, HR Score Target (70%+), hr_scorer.py — HR Scoring Script, Job Fit Decision Gate — Score Thresholds and Go/No-Go Logic, Phase 3: Score Base + Tailored Resume, Phase 4: Score Check + Iteration (max 2 rounds), Phase 6: Cleanup + Final Report (+1 more)

### Community 34 - "Config Example"
Cohesion: 0.22
Nodes (8): generate_score_prompt, output_base_dir, user_credentials, user_email, user_linkedin, user_name, user_phone, venv_name

### Community 35 - "Keyword Matching & Synonyms"
Cohesion: 0.29
Nodes (8): calculate_keyword_match(), get_canonical_term(), get_related_terms(), match_with_synonyms(), Calculate keyword match percentage with enhanced matching.      Uses:     - Lemm, Get the canonical form of a term using synonym mapping.     E.g., 'tensorflow' -, Get all related terms for a canonical term.     E.g., 'python' -> ['pandas', 'nu, Match JD terms against resume terms, considering synonyms and related terms.

### Community 36 - "ATS Anti-Gaming Detection"
Cohesion: 0.25
Nodes (8): contains_normalized_term(), detect_hidden_text(), detect_keyword_stuffing(), Detect hidden/invisible text manipulation (§2.3.2).      Checks for:     - White, Extract text from PDF file., Match a term against cleaned text without allowing substring false positives., Detect keyword stuffing and manipulation (§2.3.2).      Checks for:     - Abnorm, bool

### Community 37 - "General Keywords Metadata"
Cohesion: 0.25
Nodes (8): _metadata, decay_lambda_scale, description, domain, last_updated, total_keywords, version, weight_scale

### Community 38 - "Healthcare Keywords Metadata"
Cohesion: 0.25
Nodes (8): _metadata, decay_lambda_guide, description, domain, last_updated, total_keywords, version, weight_scale

### Community 39 - "Tailor Resume Setup Phase"
Cohesion: 0.33
Nodes (7): config.json — Project Configuration File, job_description.txt — Saved Job Description, job_fit_scorer.py — Job Fit Scoring Script, Master Resume — Canonical Reference Document, Tailor Resume Phase 0 Setup, Phase 1.5: Job Fit Pre-Check Gate, Parallel Research Phase

### Community 40 - "O*NET Skills Metadata"
Cohesion: 0.33
Nodes (6): _metadata, categories, description, importance_scale, source, version

### Community 41 - "ATS Readability Scoring"
Cohesion: 0.40
Nodes (5): _calculate_dale_chall_score(), calculate_readability(), Convert Dale-Chall readability score to 0-100 (optimal at 7.0-8.0 for technical, Calculate readability metrics (§3.1.2).      Uses Dale-Chall for technical domai, Convert grade level to 0-100 score (optimal at 10-12).

### Community 42 - "Find Jobs Command"
Cohesion: 0.50
Nodes (4): Find Jobs Command, Job Discovery Phase, Job Source Selection, Find Jobs to Tailor Resume Integration

## Knowledge Gaps
- **236 isolated node(s):** `run_hook.sh script`, `venv_name`, `output_base_dir`, `user_name`, `user_credentials` (+231 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **12 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `load_domain_keywords()` connect `ATS Scorer Core` to `ATS Scoring & Keyword Graph`, `Finance Keywords`, `Consulting Keywords`, `Technology Keywords`, `Healthcare Keywords`, `General Skills Keywords`, `ATS Advanced Analysis`, `ATS Score Calculation`?**
  _High betweenness centrality (0.401) - this node is a cross-community bridge._
- **Why does `expand_acronyms()` connect `ATS Scorer Core` to `Domain Acronyms Dictionary`?**
  _High betweenness centrality (0.169) - this node is a cross-community bridge._
- **Why does `is_valid_skill()` connect `ATS Scorer Core` to `Job Fit Scorer`, `O*NET Problem Solving Skills`?**
  _High betweenness centrality (0.121) - this node is a cross-community bridge._
- **What connects `Load Claude settings and extract deny patterns from the project-level settings.j`, `Extract file path pattern from deny rule like 'Read(./path/pattern)'.`, `Check if file path matches a deny pattern.` to the rest of the system?**
  _415 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `ATS Scoring & Keyword Graph` be split into smaller, more focused modules?**
  _Cohesion score 0.050505050505050504 - nodes in this community are weakly interconnected._
- **Should `Domain Acronyms Dictionary` be split into smaller, more focused modules?**
  _Cohesion score 0.014285714285714285 - nodes in this community are weakly interconnected._
- **Should `O*NET Technical Skills` be split into smaller, more focused modules?**
  _Cohesion score 0.04942315909414613 - nodes in this community are weakly interconnected._