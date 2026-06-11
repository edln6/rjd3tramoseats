#' @include utils.R
NULL

#' @importFrom rjd3jars check_java_version

#' @importFrom stats is.ts start
#' @importFrom RProtoBuf read readProtoFiles2
#' @importFrom rJava .jpackage .jcall .jnull is.jnull .jfield
#'
.onLoad <- function(libname, pkgname) {
    result <- rJava::.jpackage(pkgname, lib.loc = libname)
    if (!result)
        stop("Loading java packages failed", call. = FALSE)

    if (rjd3jars::check_java_version(FALSE)) {
        rjd3jars::reload_dictionaries()
    }

    assign("providers", list(), rjd3toolkit::.jd3_env)
	
    proto.dir <- system.file("proto", package = pkgname)
    RProtoBuf::readProtoFiles2(protoPath = proto.dir)

    assign("tramoseats", list(), rjd3toolkit::.jd3_env)

    if (is.null(getOption("summary_info"))) {
        options(summary_info = TRUE)
    }
}

#' Set an option for tramoseats
#'
#' @param name Name of the option
#' @param obj Option
#'
#' @export
#'
#' @examples
#' tramoseats_option("test", "DUMMY")
tramoseats_option<-function(name, obj){
    options<-rjd3toolkit::.jd3_env$tramoseats
    options[[name]]<-obj
    assign("tramoseats", options, rjd3toolkit::.jd3_env)
    invisible()
}

#' Set an option for tramoseats
#'
#' @param name Name of the option
#'
#' @returns The requested option or NULL if it doesn't exist
#' @export
#'
#' @examples
#' tramoseats_option("test", "DUMMY")
#' get_tramoseats_option("test")
get_tramoseats_option<-function(name){
    options<-rjd3toolkit::.jd3_env$tramoseats
    return (options[[name]])
}


