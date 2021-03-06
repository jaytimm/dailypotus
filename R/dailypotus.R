#' Get presidential timelines from wikipedia 
#' @name dailypotus
#' 
#'
generic_timeline <- function(qs, url, pres) {
  
  timeline <- lapply(1:length(qs), function(x) {
    
    url1 <- paste0(url, '_(', qs[x], ')')
    ## httr::HEAD(url1)$status_code == '404'
    tq_list <- xml2::read_html(url1)
    tq_list1 <- rvest::html_nodes(tq_list, "table")
    tq_list2 <- rvest::html_table(tq_list1, fill = TRUE)
    
    new <- lapply(1:length(tq_list2), function(z) {
      
      if ( all(c('Date', 'Events') %in% colnames(tq_list2[[z]])) |
           all(c('Date', 'Events') %in% tq_list2[[z]][2,]) ) {
        
        n0 <- tq_list2[[z]][, c(1:2)]
        colnames(n0) <- c('Date', 'Events')
        n0
        
      } else{ data.frame(Date = '', Events = '')
      }
    })
    
    out <- data.table::rbindlist(Filter(function(i) nrow(i) >= 3, new))
    
    out$quarter <- qs[x]
    out <- subset(out, !grepl('\\[edit', Date))
    out$Events <- gsub('\\[[0-9]+\\]', '', out$Events) ## Citations
    out$Events <- gsub('\\[citation needed\\]', '', out$Events)
    
    out$Date <- gsub('\n', ' ', out$Date)
    out$Date <- gsub(',', '', out$Date)
    out$dow <- gsub(' .*$', '', out$Date)
    
    ## --
    out$date <-  as.Date(paste0(gsub('_.*$', '', out$quarter),
                                gsub('^.*day ', '', out$Date)),
                         "%Y %B %d")
    
    out[, c('quarter', 'date', 'dow', 'Events')]
  })
  
  y <- data.table::rbindlist(timeline)
  y <- subset(y, !is.na(date))
  y$cc <-  ifelse((grepl('January_2021', y$quarter) &
                     lubridate::month(y$date) == 1), 'y', 'n')
  y[y$cc == 'y']$date <- y[y$cc == 'y']$date + 366
  y <- y[order(y$date),]
  y[, cc:=NULL]
  
  y$weekof <- lubridate::floor_date(as.Date(y$date, "%Y-%m-%d"),
                                    unit = 'week')
  y$daypres <- 1:nrow(y)
  
  ## by bullet point -- 
  y1 <- tidyr::separate_rows(y, Events, sep = '\n')
  y1$bullet <- sequence(rle(as.character(y1$date))$lengths)
  y1$pres <- pres
  y2 <- y1[, c('pres', 
               'quarter', 'weekof', 
               'daypres', 'date',
               'dow', 'bullet', 
               'Events')]
  return(data.table::setDT(y2))
}


#' @rdname dailypotus
#' @export
daily_wiki_trump <- function(){
  
  pres <- 'Trump'
  url45 <- 'https://en.wikipedia.org/wiki/Timeline_of_the_Donald_Trump_presidency'
  qs <- c('_Q1', '_Q2', '_Q3', '_Q4')
  ys <- c(2017:2020)
  allqs <- do.call(paste0, expand.grid(ys, qs))
  allqs45 <- gsub('2020_Q4', '2020_Q4–January_2021', allqs)
  
  generic_timeline(qs = allqs45, 
                   url = url45, 
                   pres = 'Trump')
}



#' @rdname dailypotus
#' @export
daily_wiki_biden <- function(){
  
  url46 <- 'https://en.wikipedia.org/wiki/Timeline_of_the_Joe_Biden_presidency'
  qs <- c('_Q1', '_Q2', '_Q3', '_Q4')
  ys <- c(2021:2024)
  allqs46 <- sort(do.call(paste0, expand.grid(ys, qs)))
  qq <- paste0(as.numeric(format(Sys.Date(),'%Y')), '_', quarters(Sys.Date()))
  
  generic_timeline(qs = allqs46[1:which(allqs46 == qq)], 
                   url = url46,
                   pres = 'Biden')
}

## jj <- timeline_biden()
## jj0 <- timeline_trump()
