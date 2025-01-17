% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/enrich_go.R
\name{enrich_go}
\alias{enrich_go}
\title{enrich_go}
\usage{
enrich_go(
  deg_data,
  x,
  y,
  cut_FC = 1,
  cut_P = 0.05,
  OrgDb = "org.Hs.eg.db",
  keyType = "SYMBOL",
  ont = "ALL",
  simplify = TRUE,
  pvalueCutoff = 0.05,
  pAdjustMethod = "BH",
  qvalueCutoff = 0.2,
  minGSSize = 10,
  maxGSSize = 500,
  readable = FALSE,
  pool = FALSE,
  label = c("Down", "Stable", "Up"),
  label_ns = "Stable",
  mc.cores = 1L
)
}
\arguments{
\item{deg_data}{a DEG data frame contains logFC and p value}

\item{x}{which column is log FC}

\item{y}{which column is P value}

\item{cut_FC}{a single number character or numeric vector in threshold value of log FC}

\item{cut_P}{threshold value of P value, can set for every cut_FC number in numeric vector format}

\item{OrgDb}{OrgDb}

\item{keyType}{keytype of input gene}

\item{ont}{One of "BP", "MF", and "CC" subontologies, or "ALL" for all three.}

\item{simplify}{whether simplify}

\item{pvalueCutoff}{adjusted pvalue cutoff on enrichment tests to report}

\item{pAdjustMethod}{one of "holm", "hochberg", "hommel", "bonferroni", "BH", "BY", "fdr", "none"}

\item{qvalueCutoff}{qvalue cutoff on enrichment tests to report as significant.  Tests must pass i) \code{pvalueCutoff} on unadjusted pvalues, ii) \code{pvalueCutoff} on adjusted pvalues and iii) \code{qvalueCutoff} on qvalues to be reported.}

\item{minGSSize}{minimal size of genes annotated by Ontology term for testing.}

\item{maxGSSize}{maximal size of genes annotated for testing}

\item{readable}{whether mapping gene ID to gene Name}

\item{pool}{If ont='ALL', whether pool 3 GO sub-ontologies}

\item{label}{symbol word for groups}

\item{label_ns}{which group is the stable group}

\item{mc.cores}{param for mclapply, choose cores to use in non-Windows machine}
}
\value{
enrichGO result
}
\description{
a funtion group deg data frame and make enrichment analysis in one step
}
\examples{
\dontrun{
enrich_go(deg_data = DEG_df, x = "log2FoldChange", y = "pvalue")
}
}
