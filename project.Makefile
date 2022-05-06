## Add your own custom Makefile targets here

# --------------------------------------------
# MARKDOWN DOCS
# Generate documentation ready for mkdocs
# --------------------------------------------
gen-docs: target/docs/index.md
.PHONY: gen-docs

target/docs/index.md:
	$(RUN) gen-markdown $(GEN_OPTS) --img --mergeimports --notypesdir --warnonexist --dir target/docs $(SCHEMA_SRC)
