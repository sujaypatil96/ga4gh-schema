# GA4GH Schema
## GA4GH

The [Global Alliance for Genomics and Health](https://www.ga4gh.org/) is an international coalition, formed to enable the sharing of genomic and clinical data.

## Schema
### Toolchain

The tools used to build a data model for GA4GH variant annotation are:

1. [LinkML](https://linkml.io/linkml/): Linked data modeling language that allows you to specify and author schemas or data models as YAML files
2. [schemasheets](https://linkml.io/schemasheets/): A tool built on top of LinkML that allows data modelers to specify schemas in a spreadsheet format, which can be compiled down to LinkML

###

Run the following command to auto generate a LinkML model from the schemasheets specification of the GA4GH model:

```bash
poetry run sheets2linkml --output src/linkml/ga4gh_va_schema.yaml src/data/spreadsheets/ga4gh_schemasheets.tsv
```

### Results
1. [ga4gh_schemasheets.tsv](src/data/spreadsheets/ga4gh_schemasheets.tsv): schemasheets specific tsv which contains the GA4GH source data model as a spreadsheet
2. [ga4gh_va_schema.yaml](src/linkml/ga4gh_va_schema.yaml): LinkML model generated from the above spreadsheet specification file