## add comment
fast_pedigree_qc <- function(ids, sires, dams) {
    .Call('_pedivieweR_fast_pedigree_qc', PACKAGE = 'pedivieweR', ids, sires, dams)
}

