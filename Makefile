.PHONY: all convert clean

all: convert

convert:
	@mkdir -p .harness
	@harness-migrate github convert .github/workflows/continuous-integration.yaml .harness/continuous-integration-github-to-harness.yaml
	@echo "✓ Converted to .harness/continuous-integration-github-to-harness.yaml"

clean:
	@rm -rf .harness
	@echo "✓ Cleaned .harness directory"