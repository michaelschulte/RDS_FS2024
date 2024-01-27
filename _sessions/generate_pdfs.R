# convert all html files to pdf
library(chromote)
library(xaringan)
library(pdftools)

source('https://gist.githubusercontent.com/gadenbuie/f6b8ec0335bdd45ed5a68bead60ef4fa/raw/598c5c532497a16834dbef305ce64debbd7dc1e3/xaringan-chromote-print.R')

xaringan_to_pdf("_sessions/Data/Data.html",
                output_file = '_sessions/_pdf/Data.pdf')


