.PHONY: all convert convert-circle clean

all: convert

convert:
	@mkdir -p .harness
	@harness-migrate github convert .github/workflows/continuous-integration.yaml .harness/github-pipeline.yaml || true
	@echo "✓ Converted GitHub workflow to .harness/github-pipeline.yaml"

convert-circle:
	@mkdir -p .harness
	@harness-migrate circle convert .circleci/config.yaml .harness/continuous-integration-circle-to-harness
	@echo "✓ Converted CircleCI config to .harness/continuous-integration-circle-to-harness"

clean:
	@rm -rf .harness
	@echo "✓ Cleaned .harness directory"