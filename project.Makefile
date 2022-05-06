## Add your own custom Makefile targets here

# ---------------------------------------
# MARKDOWN DOCS
#      Generate documentation ready for mkdocs
# ---------------------------------------
gen-docs: site/index.md
.PHONY: gen-docs

target/docs/index.md:
	$(RUN) gen-markdown $(GEN_OPTS) --img --mergeimports --notypesdir --warnonexist --dir target/docs $(SCHEMA_SRC)

site/index.md: target/docs/index.md
	# mkdocs.yml moves from the target/docs to the site directory
	$(RUN) mkdocs build
