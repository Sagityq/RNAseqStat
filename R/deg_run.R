#' run DEG
#'
#' run DEG module in limma, DESeq2 and edgeR
#'
#' @param counts_data a counts data frame of rows in genes and columns in samples
#' @param group_list a list ordered by samples in counts_data
#' @param dir a directory to store results
#' @param test_group the name of the numerator level for the fold change (Test group)
#' @param control_group the name of the denominator level for the fold change (Control group)
#' @param parallel if FALSE, no parallelization. if TRUE, parallel execution using BiocParallel
#'
#' @importFrom fs dir_exists dir_create
#' @importFrom glue glue
#' @importFrom utils write.csv
#'
#' @return a csv file and a DEG_container ob
#' @export
#'
#' @examples
#' \dontrun{
#' deg_run(counts_input,group_list,test_group = "T", control_group = "C",dir = tempdir())
#' }
deg_run <- function(counts_data,group_list,test_group = "T", control_group = "C",dir,parallel = FALSE) {

  if (!fs::dir_exists(dir)) {
    fs::dir_create(dir)
  }

  counts_data_filtered =counts_data

  deg_df_DESeq2 <- deg_DESeq2(counts_data_filtered,group_list,parallel = parallel,
            test_group = test_group, control_group = control_group, qc = TRUE,
             x = "log2FoldChange", y = "pvalue",
             dir = dir, prefix = "2-DEG_DEseq2")

  deg_df_edgeR <- deg_edgeR(counts_data_filtered, group_list,
            control_group = control_group,
             x = "logFC", y = "PValue",
             dir = dir, prefix = "2-DEG_edgeR")

  deg_df_limma <- deg_limma(counts_data_filtered,group_list,
            test_group = test_group, control_group = control_group,
             x = "logFC", y = "P.Value",
             dir = dir, prefix = "2-DEG_limma")

  allg <- Reduce(intersect, list(rownames(deg_df_DESeq2),
                         rownames(deg_df_edgeR),
                         rownames(deg_df_limma)))

  deg_df_intersect=cbind(deg_df_limma[allg,c(1,4)],
              deg_df_edgeR[allg,c(1,5)],
              deg_df_DESeq2[allg,c(2,6)])

  colnames(deg_df_intersect) <- paste0(colnames(deg_df_intersect),"_",rep(c("limma","edgeR","DESeq2"),each=2))

  write.csv(deg_df_intersect,file =  glue('{dir}/2-DEG_intersect_results.csv'))

  deg_results <- create_DEG_container(
    deg_df_limma = deg_df_limma,
    deg_df_edgeR = deg_df_edgeR,
    deg_df_DESeq2 = deg_df_DESeq2,
    deg_df_intersect = deg_df_intersect,
    counts_data_filtered = counts_data_filtered,
    group_list = group_list
  )

  save(deg_results,file = glue('{dir}/2-DEG_results.Rdata'))

  return(deg_results)

}

#' a S4 class
#'
#' contains results of DEG module
#'
#' @importFrom methods setClass
#'
#' @rdname DEG_container
#'
#' @export
setClass(Class="DEG_container",
         slots = representation(
           deg_df_limma = "data.frame",
           deg_df_edgeR = "data.frame",
           deg_df_DESeq2 = "data.frame",
           deg_df_intersect = "data.frame",
           counts_data_filtered = "data.frame",
           group_list = "character"
         )
)


#' DEG_container create function
#'
#' a function to create DEG_container ob
#'
#' @param deg_df_limma a deg data frame was produced by limma
#' @param deg_df_edgeR a deg data frame was produced by edgeR
#' @param deg_df_DESeq2 a deg data frame was produced by DESeq2
#' @param deg_df_intersect a deg data frame was combined by results of limma edgeR DESeq2
#' @param counts_data_filtered a filtered counts data frame used to produce deg data frame
#' @param group_list a list ordered by samples in counts_data
#'
#' @importFrom methods new
#'
#' @return a DEG_container ob
#' @noRd
create_DEG_container <- function(
  deg_df_limma = NA,
  deg_df_edgeR = NA,
  deg_df_DESeq2 = NA,
  deg_df_intersect = NA,
  counts_data_filtered = NA,
  group_list = NA
) {

  new("DEG_container",
      deg_df_limma = as.data.frame(deg_df_limma),
      deg_df_edgeR = as.data.frame(deg_df_edgeR),
      deg_df_DESeq2 = as.data.frame(deg_df_DESeq2),
      deg_df_intersect = as.data.frame(deg_df_intersect),
      counts_data_filtered = as.data.frame(counts_data_filtered),
      group_list = as.character(group_list)
  )
}
