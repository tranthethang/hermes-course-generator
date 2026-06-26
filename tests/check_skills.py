import os
import sys
import yaml

skills = [
    "hermes-course-setup",
    "hermes-course-writer",
    "hermes-course-reviewer",
    "hermes-course-validator",
    "hermes-course-evaluator"
]
errors = 0

for skill in skills:
    skill_path = os.path.abspath(os.path.join(os.path.dirname(__file__), f"../skills/{skill}/SKILL.md"))
    if not os.path.exists(skill_path):
        print(f"Error: {skill} SKILL.md is missing at {skill_path}")
        errors += 1
        continue
        
    try:
        with open(skill_path, "r", encoding="utf-8") as f:
            content = f.read()
            
        if not content.startswith("---"):
            print(f"Error: {skill} SKILL.md does not start with frontmatter block")
            errors += 1
            continue
            
        parts = content.split("---", 2)
        if len(parts) < 3:
            print(f"Error: {skill} SKILL.md has invalid frontmatter boundary")
            errors += 1
            continue
            
        yaml_text = parts[1]
        data = yaml.safe_load(yaml_text)
        
        if not data:
            print(f"Error: {skill} SKILL.md frontmatter is empty")
            errors += 1
            continue
            
        if "name" not in data or not data["name"]:
            print(f"Error: {skill} SKILL.md is missing 'name' in frontmatter")
            errors += 1
            
        if "description" not in data or not data["description"]:
            print(f"Error: {skill} SKILL.md is missing 'description' in frontmatter")
            errors += 1
            
        if "allowed-tools" not in data or not isinstance(data["allowed-tools"], list):
            print(f"Error: {skill} SKILL.md is missing 'allowed-tools' or it is not a list in frontmatter")
            errors += 1
            
        if errors == 0:
            print(f"OK: {skill} SKILL.md is valid. Name={data.get('name')}, Allowed Tools={data.get('allowed-tools')}")
        
    except Exception as e:
        print(f"Error parsing {skill} SKILL.md: {e}")
        errors += 1

if errors > 0:
    print(f"\nSkill validation failed with {errors} errors")
    sys.exit(1)
else:
    print("\nAll skill files validated successfully!")
    sys.exit(0)
