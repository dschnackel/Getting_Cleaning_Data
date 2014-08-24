prep<-function(){
        #Loads all libraries
        library(data.table)

}

getTidyData<-function(){
        
        prep()
        DT<-getAllData()
        print("Run Get Average Data")
        avg<-getAvgData(DT)
        print("Write Average Data To File")
        write.table(avg,file="data/UCI_HAR_Dataset/tidyData.txt",row.name=F,sep=",")
            
}

getAllData<-function(){
        print("Run Get All Data")
        #Read in auxillary tables
        features<-read.table("data/UCI_HAR_Dataset/features.txt",header=F)
        activity<-read.table("data/UCI_HAR_Dataset/activity_labels.txt",header=F)
        
        #Retrieve Data
        testData<-getTest(features,activity)
        trainData<-getTrain(features,activity)
        allData<-rbind(testData,trainData
                       )
        #Subset data to show only required variables
        t1<-subset(allData,,colnames(allData)[1:2])
        t2<-subset(allData,,colnames(allData) %like% "std")
        t3<-subset(allData,,colnames(allData) %like% "mean")
        allData<-data.table(t1,t2,t3)
        return(allData)
}

getAvgData<-function(allData){
        cnames<-names(allData)
        cnames<-cnames[-2:-1]
        DD<-subset(allData,,colnames(allData) %in% cnames)
        avg<-aggregate(DD,by=list(allData[[1]],allData[[2]]) , FUN=mean, na.rm=TRUE)
        names(avg)[1]<- "activity"
        names(avg)[2]<- "subject"
        return(avg)
}

getTest<-function(features,activity){
        print("Run Get Test Data")
        ##Load library
        #library(data.table)
        ##Read file from local 
        testids<-read.table("data/UCI_HAR_Dataset/test/y_test.txt",header=F)
        names(testids)[1]<-"testid"
        DT<-read.table("data/UCI_HAR_Dataset/test/X_test.txt",header=F,col.names=features[,2])
        subjects<-read.table("data/UCI_HAR_Dataset/test/subject_test.txt",header=F)
        names(subjects)[1]<-"subject"
        DT<-data.table(subjects,DT)
        #tIds<-DT[[1]]
        tIds<-testids[[1]]
        #for(i in 1:length(DT[[2]])){tIds[i]<-as.character(activity[activity[,1]==DT[[1]][i],2])}
        for(i in 1:length(testids[[1]])){tIds[i]<-as.character(activity[activity[,1]==testids[[1]][i],2])}
        DT<-data.table(activity=tIds,DT)
        return(DT)
        
}

getTrain<-function(features,activity){
        print("Run Get Training Data")
        ##Load library
        #library(data.table)
        ##Read file from local 
        testids<-read.table("data/UCI_HAR_Dataset/train/y_train.txt",header=F)
        names(testids)[1]<-"testid"
        DT<-read.table("data/UCI_HAR_Dataset/train/X_train.txt",header=F,col.names=features[,2])
        subjects<-read.table("data/UCI_HAR_Dataset/train/subject_train.txt",header=F)
        names(subjects)[1]<-"subject"
        DT<-data.table(subjects,DT)
        tIds<-testids[[1]]
        for(i in 1:length(testids[[1]])){tIds[i]<-as.character(activity[activity[,1]==testids[[1]][i],2])}
        DT<-data.table(activity=tIds,DT)
        return(DT)
        
}