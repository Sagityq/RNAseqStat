% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/enrich_gsekegg.R
\name{enrich_gsekegg}
\alias{enrich_gsekegg}
\title{gseKEGG from DEG data}
\usage{
enrich_gsekegg(
  deg_data,
  x,
  organism = "hsa",
  keyType = "kegg",
  OrgDb = "org.Hs.eg.db",
  exponent = 1,
  minGSSize = 10,
  maxGSSize = 500,
  eps = 1e-10,
  pvalueCutoff = 0.05,
  pAdjustMethod = "BH",
  verbose = TRUE,
  use_internal_data = FALSE,
  seed = FALSE,
  by = "fgsea",
  ...
)
}
\arguments{
\item{deg_data}{a DEG data frame contains logFC and p value}

\item{x}{which column is log FC}

\item{organism}{supported organism listed in 'http://www.genome.jp/kegg/catalog/org_list.html'}

\item{keyType}{one of "kegg", 'ncbi-geneid', 'ncib-proteinid' and 'uniprot'}

\item{OrgDb}{OrgDb}

\item{exponent}{weight of each step}

\item{minGSSize}{minimal size of each geneSet for analyzing}

\item{maxGSSize}{maximal size of genes annotated for testing}

\item{eps}{This parameter sets the boundary for calculating the p value.}

\item{pvalueCutoff}{pvalue Cutoff}

\item{pAdjustMethod}{pvalue adjustment method}

\item{verbose}{print message or not}

\item{use_internal_data}{logical, use KEGG.db or latest online KEGG data}

\item{seed}{logical}

\item{by}{one of 'fgsea' or 'DOSE'}

\item{...}{other parameter}
}
\value{
a gsekegg result
}
\description{
run \code{\link[clusterProfiler]{gseKEGG}}. of DEG data
}
\examples{
\dontrun{
enrich_gsekegg(DEF_df,x = "log2FoldChange")
}
}
