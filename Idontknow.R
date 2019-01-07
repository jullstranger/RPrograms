
# I will collect Information for CEDAR probes/genes and individuals hier for trans-eQTLs

input.dir<-"~/Research/GEN/UAG/CROHN/GE_Data_Log2_RSN_SBC_v2/"

f2r<-"~/Research/GEN/UAG/CROHN/Julia/MatrixEQTL_Ana_UK_1000_4PEER_Factors_Reanalysis/Trans_eQTLsVsPCs_eProbes_1e-10__X_Y_Incl_PEER_CORR.txt"
ge.info<-read.table(f2r, header = TRUE, stringsAsFactors =  FALSE)

super.good<-read.table ("~/Data/ReAnnotate/Probes_good_reanno_31137_TSS.txt" , header = TRUE, stringsAsFactors =  FALSE)

per.tis.info<-data.frame()
for ( tis in ge.info$Tissue ) {
  f2r<-paste (input.dir, tis, "/PEER_Factors_" , tis, "_Corr_X_Y_Incl.txt" , sep="")
  peers<-read.table(f2r, header = TRUE, stringsAsFactors =  FALSE)
  n.indis<-nrow(peers)
  
  f2r<-paste( input.dir , tis, "/GeneLoc_all_X_Y_Incl.txt" , sep="")
  probes<-read.table (f2r, header = TRUE, stringsAsFactors =  FALSE)
  probes<-merge (probes, super.good , by.x = "geneid" , by.y = "ProbeID")
  n.probes<- length(unique( probes$geneid))
  n.genes<-length( unique( probes$Gene))
  per.tis.info<-rbind ( per.tis.info , data.frame (N_Indis = n.indis , N_Probes = n.probes , N_Genes = n.genes) )
  print( paste("Ready with " , tis, sep=" " ))
}

f2w<-paste ( input.dir , "Genes_Indis_Info.txt" , sep="")
write.table ( file = f2w, per.tis.info , row.names = FALSE , quote = FALSE)

min(per.tis.info$N_Indis)
# [1] 198
max(per.tis.info$N_Indis)
# [1] 298
length(unique(super.good$ProbeID))
# [1] 31137
length(unique(super.good$Gene))
# [1] 20602

# collect information about regions pre tissue
