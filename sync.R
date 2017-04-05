library(DBI)
library(RMySQL)

path <- file.path(getwd(), "hd")
if(!dir.exists(path)) dir.create(path)


get_data <- function() {


m <- dbDriver("MySQL");
con <- dbConnect(m,user='dspotatotrials',password='ca7H=j~$V+p2G0715',host='176.34.248.121',dbname='datacippotato_martpot_trials');
res <- dbSendQuery(con, "SELECT `CIPNUMBER`, `CULTVRNAME`, `COLNUMBER`, `FEMALE`, `MALE`, `PopulationGroup` FROM `dspotatotrials__dpassport__main`")
dspotatotrials_dpassport <- fetch(res, n = -1)
names(dspotatotrials_dpassport) <- c("Accession_Number","Accession_Name","Accession_Code","Female_AcceNumb","Male_AcceNumb","Population")
#write.dbf(dspotatotrials_dpassport,"dspotatotrials_dpassport.dbf")

#path <- fbglobal::get_base_dir()
#path <- Sys.getenv("LOCALAPPDATA")
#print("path")
path_file <- file.path(path, "dspotatotrials_dpassport.rds")

saveRDS(dspotatotrials_dpassport, file = path_file)
#saveRDS(dspotatotrials_dpassport,file = "dspotatotrials_dpassport.rds")
dbDisconnect(con)


m <- dbDriver("MySQL");
con <- dbConnect(m,user='dssweettrials',password='c42=gFf8AfZnS0715',host='176.34.248.121',dbname='datacipsweet_martsweet_trials');
res <- dbSendQuery(con, "SELECT `CIPNUMBER`, `CULTVRNAME`, `COLNUMBER`, `FEMALE`, `MALE`, `PopulationGroup` FROM `dssweettrials__dpassport__main`")
dssweettrials_dpassport <- fetch(res, n = -1)
names(dssweettrials_dpassport) <- c("Accession_Number","Accession_Name","Accession_Code","Female_AcceNumb","Male_AcceNumb","Population")
#write.dbf(dssweettrials_dpassport,"dssweettrials_dpassport.dbf")
#path <- fbglobal::get_base_dir()
#path_file <- paste(path, "dssweettrials_dpassport.rds", sep = "\\")
path_file <- file.path(path, "dssweettrials_dpassport.rds")

saveRDS(dssweettrials_dpassport,file =  path_file)
#saveRDS(dssweettrials_dpassport,file = "dssweettrials_dpassport.rds")
dbDisconnect(con)


m <- dbDriver("MySQL");
con <- dbConnect(m,user='cippedigree',password='cF6Jr<tVW]dU60713',host='176.34.248.121',dbname='cippedigree');
res <- dbSendQuery(con, "SELECT ped_family.pedNameCipnumber, ped_family.pedFemaleCipnumber, ped_family.pedFemale, ped_family.pedMaleCipnumber, ped_family.pedMale, ped_population.PedPopName, ped_family.pedCycle FROM ped_family INNER JOIN ped_population ON ped_family.ped_population_PedPopId = ped_population.PedPopId WHERE ped_family.Crop_CropId = 'SO'")
potato_pedigree <- fetch(res, n = -1)
names(potato_pedigree) <- c("Accession_Number","Female_AcceNumb","Female_codename","Male_AcceNumb","Male_codename","Population", "Cycle")
#write.dbf(potato_pedigree,"potato_pedigree.dbf")

#path <- fbglobal::get_base_dir()
path_file <- file.path(path, "potato_pedigree.rds")

#saveRDS(potato_pedigree,file = "potato_pedigree.rds")
saveRDS(potato_pedigree, file =  path_file)


dbDisconnect(con)

m <- dbDriver("MySQL");
con <- dbConnect(m,user='cippedigree',password='cF6Jr<tVW]dU60713',host='176.34.248.121',dbname='cippedigree');
res <- dbSendQuery(con, "SELECT ped_family.pedNameCipnumber, ped_family.pedFemaleCipnumber, ped_family.pedFemale, ped_family.pedMaleCipnumber, ped_family.pedMale, ped_population.PedPopName, ped_family.pedCycle FROM ped_family INNER JOIN ped_population ON ped_family.ped_population_PedPopId = ped_population.PedPopId WHERE ped_family.Crop_CropId = 'IP'")
sweetpotato_pedigree <- fetch(res, n = -1)
names(sweetpotato_pedigree) <- c("Accession_Number","Female_AcceNumb","Female_codename","Male_AcceNumb","Male_codename","Population", "Cycle")

#path <- fbglobal::get_base_dir()
path_file <- file.path(path, "sweetpotato_pedigree.rds")
saveRDS(sweetpotato_pedigree,file = path_file)


#saveRDS(sweetpotato_pedigree,file = "sweetpotato_pedigree.rds")
dbDisconnect(con)
}

get_data()

owd <- getwd()
setwd(path)

zip(list.files(), zipfile = "../db.zip")
setwd(owd)
unlink(path, recursive = TRUE)

repo <- git2r::init(getwd())
git2r::add(repo, "db.zip")
git2r::commit(repo , paste("u", date()))

