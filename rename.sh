#!/bin/bash
find . -type f \( -name "*.md" -o -name "*.yaml" -o -name "*.yml" \) -exec sed -i '' 's/ng-sdd-execute/specgen-execute/g' {} +
find . -type f \( -name "*.md" -o -name "*.yaml" -o -name "*.yml" \) -exec sed -i '' 's/ng-sdd-research/specgen-research/g' {} +
find . -type f \( -name "*.md" -o -name "*.yaml" -o -name "*.yml" \) -exec sed -i '' 's/ng-sdd-reviewer/specgen-reviewer/g' {} +
find . -type f \( -name "*.md" -o -name "*.yaml" -o -name "*.yml" \) -exec sed -i '' 's/ng-sdd/SpecGen/g' {} +
find . -type f \( -name "*.md" -o -name "*.yaml" -o -name "*.yml" \) -exec sed -i '' 's/ngsdd/specgen/g' {} +

mv ng-sdd specgen
mv ng-sdd-execute specgen-execute
mv ng-sdd-research specgen-research
mv ng-sdd-reviewer specgen-reviewer

# Rename the skill names in SKILL.md to lowercase specgen for the agent IDs
sed -i '' 's/name: SpecGen/name: specgen/g' specgen/SKILL.md
sed -i '' 's/name: SpecGen-execute/name: specgen-execute/g' specgen-execute/SKILL.md || true
sed -i '' 's/name: SpecGen-research/name: specgen-research/g' specgen-research/SKILL.md || true
sed -i '' 's/name: SpecGen-reviewer/name: specgen-reviewer/g' specgen-reviewer/SKILL.md || true

