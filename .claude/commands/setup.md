# Resume Builder — One-Time Setup

Run this command once after installing the plugin to enable the advanced ATS/HR scoring engine.

## Input
$ARGUMENTS

## Instructions

You are helping the user set up the Resume Builder plugin's scoring engine. This is a one-time setup that installs Python dependencies needed for the MCP-based ATS and HR scorers.

### Step 1: Check Virtual Environment

> **Note:** Python 3.10+ must be installed and a virtual environment must be created before running setup. If you haven't done so, run `python -m venv <your-venv-name>` in the project folder first.

Ask the user: "What is the name of your virtual environment folder?" (common names: `.venv`, `venv`, `env`).

Store the answer as `{venv_name}`.

Check if a folder named `{venv_name}` exists in the project directory. Then verify it is a valid virtual environment by checking that the expected Python executable exists inside it:
- Windows: `{venv_name}/Scripts/python.exe`
- Mac/Linux: `{venv_name}/bin/python`

- If the folder exists and the Python executable is found, tell the user: "Virtual environment '{venv_name}' found and looks good." and proceed to Step 2.
- If the folder does not exist, tell the user:

```
No folder named '{venv_name}' was found. Please create your virtual environment first:

  python -m venv {venv_name}

Then run /setup again.
```

- If the folder exists but the Python executable is missing, tell the user:

```
The folder '{venv_name}' exists but does not appear to be a valid virtual environment.
Please recreate it:

  python -m venv {venv_name}

Then run /setup again.
```

Stop here if the virtual environment is not valid.

### Step 2: Install Dependencies

Install all required packages into the virtual environment using its pip:

- **Windows:** `{venv_name}\Scripts\pip install -r requirements.txt`
- **Mac/Linux:** `{venv_name}/bin/pip install -r requirements.txt`

Wait for it to complete. This may take 1-3 minutes (sentence-transformers downloads a ~80MB model).

If the install fails, tell the user to check that the virtual environment is active and that `requirements.txt` is present in the project folder.

### Step 3: Set Up Configuration

Check if `config.json` already exists in the project directory.

- If it exists, tell the user: "config.json found, skipping configuration." and proceed to Step 4.
- If it does not exist, create one by asking the user for the following details:
  - Full name
  - Credentials (e.g., M.D., MBA, CPA — or leave blank)
  - Email
  - Phone
  - LinkedIn URL
  - Path to their master resume file (supported formats: .docx, .pdf, .md, or .txt)

Then write `config.json` using the answers collected, including `{venv_name}` from Step 1. Set `generate_score_prompt` to `false` as a default — Step 4 will update it:

```json
{
  "venv_name": "{venv_name}",
  "master_resume_path": "<their answer>",
  "output_base_dir": "applications",
  "user_name": "<their answer>",
  "user_credentials": "<their answer or empty string>",
  "user_email": "<their answer>",
  "user_phone": "<their answer>",
  "user_linkedin": "<their answer>",
  "generate_score_prompt": false
}
```

### Step 4: (Optional) Manual Scoring Prompt

Ask the user:

```
After each resume build, would you like a scoring prompt file saved to the output folder?
You can paste it into Claude.ai to get a detailed ATS/HR score breakdown with per-dimension
evidence — no API key required.
```

If YES:
- Add `"generate_score_prompt": true` to `config.json`
- Tell the user: "A Score_Prompt.txt file will be saved in each application's output folder after every resume build."

If NO or SKIP:
- Add `"generate_score_prompt": false` to `config.json`
- They can always run `/setup` again later to enable it.

### Step 5: Verify

Run a quick test using the venv's Python to verify everything works:

- **Windows:** `{venv_name}\Scripts\python -c "import ats_scorer; import hr_scorer; print('Scoring engine ready!')"`
- **Mac/Linux:** `{venv_name}/bin/python -c "import ats_scorer; import hr_scorer; print('Scoring engine ready!')"`

If successful, tell the user:

```
Setup complete! You can now use:

  /resume [paste job description]         — Full resume + cover letter package
  /tailor-resume [paste JD]               — Resume only
  /cover-letter [paste JD]               — Cover letter only
  /writing-coach [resume file]            — Improve resume writing quality
  /find-jobs [job title] [location]       — Discover & score matching jobs

The ATS/HR scoring engine is now active and will automatically score your resumes.
```

If it fails, show the error and suggest fixes.
