# All artifacts of the build should be preserved
.SECONDARY:

# ----------------------------------------
# Model documentation and schema directory
# ----------------------------------------
SRC_DIR = .
PKG_DIR = ga4gh-va-spec
SCHEMA_DIR = $(SRC_DIR)/schema
MODEL_DOCS_DIR = $(SRC_DIR)/docs
SOURCE_FILES := $(shell find $(SCHEMA_DIR) -name '*.yaml')
SCHEMA_NAMES = $(patsubst $(SCHEMA_DIR)/%.yaml, %, $(SOURCE_FILES))

SCHEMA_NAME = ga4gh
SCHEMA_SRC = $(SCHEMA_DIR)/$(SCHEMA_NAME).yaml
PKG_TGTS = graphql json_schema shex owl csv
TGTS = docs python $(PKG_TGTS)
# add csv to match established ccdhmodel repo
# MAM 20210806 does docs and python by default
# note json_schema vs jsonschema

# Targets by PKG_TGT
PKG_T_GRAPHQL = $(PKG_DIR)/graphql
PKG_T_JSON = $(PKG_DIR)/json
PKG_T_JSONLD_CONTEXT = $(PKG_DIR)/jsonld
PKG_T_JSON_SCHEMA = $(PKG_DIR)/json_schema
PKG_T_OWL = $(PKG_DIR)/owl
PKG_T_RDF = $(PKG_DIR)/rdf
PKG_T_SHEX = $(PKG_DIR)/shex
PKG_T_SQLDDL = $(PKG_DIR)/sqlddl
PKG_T_DOCS = $(MODEL_DOCS_DIR)
PKG_T_PYTHON = $(PKG_DIR)
PKG_T_MODEL = $(PKG_DIR)/model
PKG_T_SCHEMA = $(PKG_T_MODEL)/schema
# MAM 20210806
PKG_T_CSV = $(PKG_DIR)/csv

RUN = poetry run
GEN_OPTS = --log_level WARNING

# ---------------------------------------
# ECHO: List all targets
# ---------------------------------------
echo:
	echo $(patsubst %,gen-%,$(TGTS))

tdir-%:
	rm -rf target/$*
	mkdir -p target/$*

# ----------------------------------------
# TOP LEVEL TARGETS
# ----------------------------------------
all: install gen

# ---------------------------------------
# We don't want to pollute the python environment with linkml tool specific packages.
# For this reason, use Pipfile (which generates a Pipfile.lock file).
# ---------------------------------------
install:
	poetry install

# ---------------------------------------
# CLEAN: clear out all of the targets
# ---------------------------------------
clean:
	rm -rf target/
	rm -rf docs/
	poetry install --remove-untracked
.PHONY: clean

# ---------------------------------------
# MARKDOWN DOCS
#      Generate documentation ready for mkdocs
# ---------------------------------------
gen-docs: site/index.md
.PHONY: gen-docs

target/docs/index.md: $(SCHEMA_DIR)/$(SCHEMA_NAME).yaml tdir-docs install
	$(RUN) gen-markdown $(GEN_OPTS) --img --mergeimports --notypesdir --warnonexist --dir target/docs $<

site/index.md: target/docs/index.md install
	mkdir -p $(PKG_T_DOCS)
	cp -R $(MODEL_DOCS_DIR)/*.md target/docs
	# mkdocs.yml moves from the target/docs to the site directory
	$(RUN) mkdocs build

#################
# DOCUMENTATION #
#################

# test docs locally.
.PHONY: docserve
docserve: gen-docs
	$(RUN) mkdocs serve
