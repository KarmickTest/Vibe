

//
//  DatabaseQuery.m
//  BoxHopp
//
//   All Rights Reserved EmYa Technologies.
//

#import "DatabaseQuery.h"
#import "Constant.h"

@implementation DatabaseQuery

#pragma mark - USER

#pragma mark - INSERT
+(BOOL)insertUser:(NSString *)_userID UserEmail:(NSString *)_userEmail UserType:(NSString *)_userType UserName:(NSString *)_userName UserFirstName:(NSString *)_userFirstName UserLastName:(NSString *)_userLastName UserPassword:(NSString *)_userPassword UserDeviceType:(NSString *)_userDeviceType UserDeviceID:(NSString *)_userDeviceID UserImageURL:(NSString *)_userImageURL UserPhoneNumber:(NSString *)_userPhoneNumber UserLoginVia:(NSString *)_userLoginVia UserAccessToken:(NSString *)_userAccessToken UserSocialID:(NSString *)_userSocialID UserStatus:(NSString *)_userStatus UserRegistrationDate:(NSString *)_userRegistrationDate{
    User* _user = [[User alloc] init];
    _user = [Utility getUserInfo];
    NSString *strQry = [NSString stringWithFormat:@"Insert into User (user_Id,user_Email,user_Type,user_Name,user_Firstname,user_Lastname,user_Password,user_DeviceType,user_DeviceID,user_ImageURL,user_PhoneNumber,user_LoginVia,user_AccessToken,user_SocialID,user_Status,user_RegistrationDate) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",_userID,_userEmail,_userType,_userName,_userFirstName,_userLastName,_userPassword,_userDeviceType,_userDeviceID,_userImageURL,_userPhoneNumber,_userLoginVia,_userAccessToken,_userSocialID,_userStatus,_userRegistrationDate];
    NSLog(@"%@",strQry);
    BOOL Result = [[DbController BoxHoppdatabase] executeUpdate:strQry];
    return Result;
}

#pragma mark - SELECT

+(User*)selectUserDetails:(NSString *)_userID{
    NSString *strQuery = [NSString stringWithFormat:@"Select * from User where user_Id='%@'",_userID];
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strQuery];
    User *mUser = [[User alloc] init];
    while ([rs next]){
        mUser.user_ID = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"user_Id"]];
        mUser.userEmailID = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"user_Email"]];
        mUser.userName = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"user_Name"]];
        mUser.userDeviceID = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"user_DeviceID"]];
        mUser.userDeviceType = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"user_DeviceType"]];
        mUser.userDateOfRegistration = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"user_RegistrationDate"]];
        mUser.userType = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"user_Type"]];
        mUser.userProfilePic = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"user_ImageURL"]];
        mUser.userPhoneNo = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"user_PhoneNumber"]];
        mUser.user_LoginVia = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"user_LoginVia"]];
    }
    return mUser;
}

+(NSString *)getUserID{
    NSString *strQuery = [NSString stringWithFormat:@"Select * from User"];
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strQuery];
    NSString *strUserID;
    while ([rs next]){
        strUserID = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"user_Id"]];
    }
    return strUserID;
}

#pragma mark - UPDATE
+(BOOL)updateMoveTableMoveName:(NSString *)_moveId moveName:(NSString *)_moveName
{
    NSString *strUpdateQry = [NSString stringWithFormat:@"Update MoveTable set moveName = '%@' where moveId = '%@'",_moveName,_moveId];
    NSLog(@"%@",strUpdateQry);
    BOOL Result = [[DbController BoxHoppdatabase] executeUpdate:strUpdateQry];
    return Result;
}

#pragma mark - DELETE

+(BOOL)deleteUserDetails:(NSString *)_userID{
    NSString *query = [NSString stringWithFormat:@"DELETE FROM User where user_Id='%@'",_userID];
    
    NSLog(@"%@",query);
    BOOL result = [[DbController BoxHoppdatabase] executeUpdate:query];
    return result;
}

#pragma mark - MASTER ROOM AND MASTER ITEM

#pragma mark - INSERT
+(BOOL)insertMasterRoom:(NSString *)_roomID roomName:(NSString *)_roomName roomImageURL:(NSString *)_roomImageURL roomCreatorId:(NSString *)_roomCreatorID roomCreatorName:(NSString *)_roomCreatorName roomImagePath:(NSString *)_roomImagePath{
    
    NSString *strInsertQry = [NSString stringWithFormat:@"Insert into MasterRoom (roomId,roomName,roomImageUrl,roomCreatorId,roomCreatorName,roomImagePath) values ('%@','%@','%@','%@','%@','%@')",_roomID,_roomName,_roomImageURL,_roomCreatorID,_roomCreatorName,_roomImagePath];
    NSLog(@"%@",strInsertQry);
    BOOL Result = [[DbController BoxHoppdatabase] executeUpdate:strInsertQry];
    return Result;
}
+(BOOL)insertMasterItem:(NSString *)_itemId roomId:(NSString *)_roomId itemName:(NSString *)_itemName itemCubicFeet:(NSString *)_itemCubicFeet itemWeight:(NSString *)_itemWeight isSync:(NSString *)_isSync{
    
    NSString *strInsertQry = [NSString stringWithFormat:@"Insert into MasterItem (itemId,roomId,itemName,itemCubicFeet,itemWeight,isSync) values ('%@','%@','%@','%@','%@','%@')",_itemId,_roomId,_itemName,_itemCubicFeet,_itemWeight,_isSync];
    NSLog(@"%@",strInsertQry);
    BOOL Result = [[DbController BoxHoppdatabase] executeUpdate:strInsertQry];
    return Result;
}

#pragma mark - SELECT
+(NSMutableArray *)getMasterRoomList{
    NSString *strQuery = @"Select distinct roomId,roomName,roomImageUrl,roomCreatorId,roomCreatorName,roomImagePath from MasterRoom";
    
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strQuery];
    NSMutableArray *arrMasterRoomList=[[NSMutableArray alloc] init];
    while ([rs next]) {
        
        NSMutableDictionary *dictRoomList = [[NSMutableDictionary alloc] init];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"roomId"]] forKey:@"roomId"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"roomName"]] forKey:@"roomName"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"roomImageUrl"]] forKey:@"roomImageUrl"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"roomCreatorId"]] forKey:@"roomCreatorId"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"roomCreatorName"]] forKey:@"roomCreatorName"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"roomImagePath"]] forKey:@"roomImagePath"];
        
        [arrMasterRoomList addObject:dictRoomList];
    }
    return arrMasterRoomList;
}


+(NSMutableArray *)getMasterItemList:(NSString *)_roomId{
    //(itemId,roomId,itemName,itemCubicFeet,itemWeight,isSync)
    NSString *strQuery = [NSString stringWithFormat:@"Select distinct itemId,itemName,itemCubicFeet,itemWeight,isSync from MasterItem where roomId='%@'",_roomId];
    
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strQuery];
    NSMutableArray *arrMasterItemList=[[NSMutableArray alloc] init];
    while ([rs next]) {
        
        NSMutableDictionary *dictRoomList = [[NSMutableDictionary alloc] init];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"itemId"]] forKey:@"itemId"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"itemName"]] forKey:@"itemName"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"itemCubicFeet"]] forKey:@"itemCubicFeet"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"itemWeight"]] forKey:@"itemWeight"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"isSync"]] forKey:@"isSync"];
        
        [arrMasterItemList addObject:dictRoomList];
    }
    return arrMasterItemList;
}

+(NSString *)getRoomName:(NSString *)_roomId{
    NSString *strQuery = [NSString stringWithFormat:@"Select distinct roomName from MasterRoom where roomId='%@'",_roomId];
    
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strQuery];
    NSString *arrMasterRoomList=@"";
    while ([rs next]) {
        arrMasterRoomList = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"roomName"]];
    }
    return arrMasterRoomList;
}

#pragma Delete

+(BOOL)deleteMasterRoom{
    NSString *query = [NSString stringWithFormat:@"DELETE FROM MasterRoom"];
    NSLog(@"%@",query);
    BOOL result = [[DbController BoxHoppdatabase] executeUpdate:query];
    return result;
}

+(BOOL)deleteMasterItem{
    NSString *query = [NSString stringWithFormat:@"DELETE FROM MasterItem"];
    NSLog(@"%@",query);
    BOOL result = [[DbController BoxHoppdatabase] executeUpdate:query];
    return result;
}

+(BOOL)deleteMasterRoomWithId:(NSString *)_roomId{
    NSString *query = [NSString stringWithFormat:@"DELETE FROM MasterRoom where roomId='%@'",_roomId];
    NSLog(@"%@",query);
    BOOL result = [[DbController BoxHoppdatabase] executeUpdate:query];
    return result;
}

#pragma mark - MOVE DETAILS

#pragma mark - INSERT
+(BOOL)insertMoveDetails:(NSString *)_moveId moveName:(NSString *)_moveName moveImageUrl:(NSString *)_moveImageUrl moveType:(NSString *)_moveType moveLocalImagePath:(NSString *)_moveLocalImagePath moveCreatedDate:(NSString *)_moveCreatedDate isSync:(NSString *)_isSync boxesAbove50LBS:(NSString *)_boxesAbove50LBS boxesBelow50LBS:(NSString *)_boxesBelow50LBS attachedNonVideoId:(NSString *)_attachedNonVideoId{
    
    NSString *strSelectQry = [NSString stringWithFormat:@"Select moveId from MoveTable where moveId = '%@'",_moveId];
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strSelectQry];
    NSString *strSelect;
    while ([rs next]) {
        strSelect = [rs stringForColumn:@"moveId"];
        if([DataValidation isNullString:strSelect]==NO){
            return YES;
        }
        else{
            return NO;
        }
    }
    
    NSString *strInsertQry = [NSString stringWithFormat:@"Insert into MoveTable (moveId,moveName,moveImageUrl,moveType,moveLocalImagePath,moveCreatedDate,isSync,boxesAbove50LBS,boxesBelow50LBS,attachedNonVideoId) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",_moveId,_moveName,_moveImageUrl,_moveType,_moveLocalImagePath,_moveCreatedDate,_isSync,_boxesAbove50LBS,_boxesBelow50LBS,_attachedNonVideoId];
    NSLog(@"%@",strInsertQry);
    BOOL Result = [[DbController BoxHoppdatabase] executeUpdate:strInsertQry];
    return Result;
}

#pragma mark - SELECT

+(NSString *)getMoveType:(NSString *)_moveId{
    NSString *strQuery = [NSString stringWithFormat:@"Select distinct moveType from MoveTable where moveId='%@'",_moveId];
    
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strQuery];
    NSString *arrMasterRoomList=@"";
    while ([rs next]) {
        arrMasterRoomList = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"moveType"]];
    }
    return arrMasterRoomList;
}
+(NSMutableArray *)getMoveDetailList{
    NSString *strQuery = @"Select distinct moveId,moveName,moveImageUrl,moveType,moveLocalImagePath,moveCreatedDate,boxesAbove50LBS,boxesBelow50LBS from MoveTable";
    
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strQuery];
    NSMutableArray *arrMoveDetailList=[[NSMutableArray alloc] init];
    while ([rs next]) {
        
        NSMutableDictionary *dictMoveDetailsList = [[NSMutableDictionary alloc] init];
        [dictMoveDetailsList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"moveId"]] forKey:@"moveId"];
        [dictMoveDetailsList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"moveName"]] forKey:@"moveName"];
        [dictMoveDetailsList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"moveImageUrl"]] forKey:@"moveImageUrl"];
        [dictMoveDetailsList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"moveType"]] forKey:@"moveType"];
        [dictMoveDetailsList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"moveLocalImagePath"]] forKey:@"moveLocalImagePath"];
        [dictMoveDetailsList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"moveCreatedDate"]] forKey:@"moveCreatedDate"];
        [dictMoveDetailsList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"boxesAbove50LBS"]] forKey:@"boxesAbove50LBS"];
        [dictMoveDetailsList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"boxesBelow50LBS"]] forKey:@"boxesBelow50LBS"];
        
        [arrMoveDetailList addObject:dictMoveDetailsList];
    }
    return arrMoveDetailList;
}

+(NSString *)getBoxesAbove50LBS:(NSString *)_moveId{
    NSString *strQuery = [NSString stringWithFormat:@"SELECT boxesAbove50LBS FROM MoveTable where moveId = '%@'",_moveId];
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strQuery];
    NSString *strZip = @"";
    while ([rs next]) {
        strZip = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"boxesAbove50LBS"]];
    }
    return strZip;
}
+(NSString *)getBoxesBelow50LBS:(NSString *)_moveId{
    NSString *strQuery = [NSString stringWithFormat:@"SELECT boxesBelow50LBS FROM MoveTable where moveId = '%@'",_moveId];
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strQuery];
    NSString *strZip = @"";
    while ([rs next]) {
        strZip = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"boxesBelow50LBS"]];
    }
    return strZip;
}

+(NSString *)moveName:(NSString *)_nonVideoAttachmentId{
    NSString *strQuery = [NSString stringWithFormat:@"SELECT moveName FROM MoveTable where moveId = '%@'",_nonVideoAttachmentId];
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strQuery];
    NSString *strMoveName = @"";
    while ([rs next]) {
        strMoveName = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"moveName"]];
    }
    return strMoveName;
}

+(NSString *)getNonVideoAttachmentId:(NSString *)_moveId moveType:(NSString *)_moveType{
    NSString *strQuery = [NSString stringWithFormat:@"SELECT attachedNonVideoId FROM MoveTable where moveId = '%@' and moveType = '%@'",_moveId, _moveType];
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strQuery];
    NSString *strMoveName = @"";
    while ([rs next]) {
        strMoveName = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"attachedNonVideoId"]];
    }
    return strMoveName;
}

#pragma mark - UPDATE

+(BOOL)updateMoveBoxesAbove50LBS:(NSString *)_boxesAbove50LBS moveId:(NSString *)_moveId
{
    NSString *strUpdateQry = [NSString stringWithFormat:@"Update MoveTable set boxesAbove50LBS = '%@' where moveId = '%@' ",_boxesAbove50LBS,_moveId];
    NSLog(@"%@",strUpdateQry);
    BOOL Result = [[DbController BoxHoppdatabase] executeUpdate:strUpdateQry];
    return Result;
}

+(BOOL)updateMoveBoxesBelow50LBS:(NSString *)_boxesBelow50LBS moveId:(NSString *)_moveId
{
    NSString *strUpdateQry = [NSString stringWithFormat:@"Update MoveTable set boxesBelow50LBS = '%@' where moveId = '%@' ",_boxesBelow50LBS,_moveId];
    NSLog(@"%@",strUpdateQry);
    BOOL Result = [[DbController BoxHoppdatabase] executeUpdate:strUpdateQry];
    return Result;
}


+(BOOL)updateMoveDetails:(NSString *)_attachedNonVideoId moveId:(NSString *)_moveId moveType:(NSString *)_moveType{
    NSString *strUpdateQry = [NSString stringWithFormat:@"Update MoveTable set attachedNonVideoId = '%@' where moveId = '%@' and moveType ='%@'",_attachedNonVideoId,_moveId,_moveType];
    NSLog(@"%@",strUpdateQry);
    BOOL Result = [[DbController BoxHoppdatabase] executeUpdate:strUpdateQry];
    return Result;
}

#pragma mark - DELETE
+(BOOL)deleteMoveDetails{
    NSString *query = [NSString stringWithFormat:@"DELETE FROM MoveTable"];
    NSLog(@"%@",query);
    BOOL result = [[DbController BoxHoppdatabase] executeUpdate:query];
    return result;
}
+(BOOL)deleteMoveDetails:(NSString *)_moveId{
    NSString *query = [NSString stringWithFormat:@"DELETE FROM MoveTable where moveId=%@",_moveId];
    NSLog(@"%@",query);
    BOOL result = [[DbController BoxHoppdatabase] executeUpdate:query];
    return result;
}

#pragma mark - VIDEO MY MOVE

#pragma mark - INSERT

+(BOOL)insertVideoMyMove:(NSString *)_videoId moveId:(NSString *)_moveId videoName:(NSString *)_videoName videoPath:(NSString *)_videoPath videoURL:(NSString *)_videoURL videoImage:(NSString *)_videoImage videoThumbnailImagePath:(NSString *)_videoThumbnailImagePath isRequestedForVideoDownload:(NSString *)_isRequestedForVideoDownload isNameSync:(NSString *)_isNameSync isSync:(NSString *)_isSync attachedNonVideoName:(NSString *)_attachedNonVideoName attachedNonVideoId:(NSString *)_attachedNonVideoId
{
    
    NSString *strSelectQry = [NSString stringWithFormat:@"Select videoId from VideoMyMove where moveId = '%@' and videoId = '%@'",_moveId,_videoId];
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strSelectQry];
    NSString *strSelect;
    while ([rs next]) {
        strSelect = [rs stringForColumn:@"moveId"];
        if([DataValidation isNullString:strSelect]==NO){
            return YES;
        }
        else{
            return NO;
        }
    }
    
    NSString *strInsertQry = [NSString stringWithFormat:@"Insert into VideoMyMove (videoId,moveId,videoName,videoPath,videoUrl,isNameSync,isSync,videoImage,videoThumbnailImagePath,isRequestedForVideoDownload,attachedNonVideoName,attachedNonVideoId) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",_videoId,_moveId,_videoName,_videoPath,_videoURL,_isNameSync,_isSync,_videoImage,_videoThumbnailImagePath,_isRequestedForVideoDownload,_attachedNonVideoName,_attachedNonVideoId];
    NSLog(@"%@",strInsertQry);
    BOOL Result = [[DbController BoxHoppdatabase] executeUpdate:strInsertQry];
    return Result;
}

#pragma mark - DELETE

+(BOOL)deleteVideoMove:(NSString *)_moveId{
    NSString *query = [NSString stringWithFormat:@"DELETE FROM VideoMyMove where moveId=%@",_moveId];
    NSLog(@"%@",query);
    BOOL result = [[DbController BoxHoppdatabase] executeUpdate:query];
    return result;
}

+(BOOL)deleteVideoDetails:(NSString *)_moveId videoId:(NSString *)_videoId{
    NSString *query = [NSString stringWithFormat:@"DELETE FROM VideoMyMove where moveId=%@ and videoId=%@",_moveId,_videoId];
    NSLog(@"%@",query);
    BOOL result = [[DbController BoxHoppdatabase] executeUpdate:query];
    return result;
}

#pragma mark - SELECT

+(NSMutableArray *)selectVideoMyMove:(NSString *)_moveId{
    NSString *strQuery = [NSString stringWithFormat:@"Select distinct videoId,moveId,videoName,videoPath,videoUrl,isNameSync,isSync,videoImage,videoThumbnailImagePath,isRequestedForVideoDownload from VideoMyMove where moveId=%@",_moveId];
    
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strQuery];
    NSMutableArray *arrVideoMyMoveList=[[NSMutableArray alloc] init];
    while ([rs next]) {
        
        NSMutableDictionary *dictRoomList = [[NSMutableDictionary alloc] init];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"videoId"]] forKey:@"videoId"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"moveId"]] forKey:@"moveId"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"videoName"]] forKey:@"videoName"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"videoPath"]] forKey:@"videoPath"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"videoUrl"]] forKey:@"videoUrl"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"isNameSync"]] forKey:@"isNameSync"];
        
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"isSync"]] forKey:@"isSync"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"videoImage"]] forKey:@"videoImage"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"videoThumbnailImagePath"]] forKey:@"videoThumbnailImagePath"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"isRequestedForVideoDownload"]] forKey:@"isRequestedForVideoDownload"];
        
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"attachedNonVideoName"]] forKey:@"attachedNonVideoName"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"attachedNonVideoId"]] forKey:@"attachedNonVideoId"];
        
        [arrVideoMyMoveList addObject:dictRoomList];
        
    }
    return arrVideoMyMoveList;
}

#pragma mark - UPDATE

+(BOOL)updateVideoName:(NSString *)_moveId videoId:(NSString *)_videoId videoName:(NSString *)_videoName{
    NSString *strUpdateQry = [NSString stringWithFormat:@"Update VideoMyMove set videoName = '%@' where moveId = '%@' and videoId = '%@'",_videoName,_moveId,_videoId];
    NSLog(@"%@",strUpdateQry);
    BOOL Result = [[DbController BoxHoppdatabase] executeUpdate:strUpdateQry];
    return Result;
}



#pragma mark - ITEM TABLE

#pragma mark - INSERT

+(BOOL)insertItemTable:(NSString *)_itemId roomId:(NSString *)_roomId moveId:(NSString *)_moveId itemName:(NSString *)_itemName itemCubicFeet:(NSString *)_itemCubicFeet itemWeight:(NSString *)_itemWeight itemDollarValue:(NSString *)_itemDollarValue itemImagePath:(NSString *)_itemImagePath itemQty:(NSString *)_itemQty{
    
    NSString *strSelectQry = [NSString stringWithFormat:@"Select itemId from ItemTable where itemId=%@ and moveId=%@ and roomId=%@",_itemId,_moveId,_roomId];
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strSelectQry];
    NSString *strSelect;
    while ([rs next]) {
        strSelect = [rs stringForColumn:@"itemId"];
        if([DataValidation isNullString:strSelect]==NO){
            return YES;
        }
        else{
            return NO;
        }
    }
    NSString *strInsertQry = [NSString stringWithFormat:@"Insert into ItemTable (itemId,roomId,moveId,itemName,itemCubicFeet,itemWeight,itemDollarValue,itemImagePath,itemQty) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@') ",_itemId,_roomId,_moveId,_itemName,_itemCubicFeet,_itemWeight,_itemDollarValue,_itemImagePath,_itemQty];
    NSLog(@"%@",strInsertQry);
    BOOL Result = [[DbController BoxHoppdatabase] executeUpdate:strInsertQry];
    return Result;
}

#pragma mark - SELECT

+(NSMutableArray *)getItemTableList:(NSString *)_roomId moveId:(NSString *)_moveId{
    NSString *strQuery = [NSString stringWithFormat:@"Select distinct itemId,itemName,itemCubicFeet,itemWeight,itemDollarValue,itemImagePath,itemQty from ItemTable where roomId='%@' and moveId='%@'",_roomId,_moveId];
    
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strQuery];
    NSMutableArray *arrMasterItemList=[[NSMutableArray alloc] init];
    while ([rs next]) {
        
        NSMutableDictionary *dictRoomList = [[NSMutableDictionary alloc] init];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"itemId"]] forKey:@"itemId"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"itemName"]] forKey:@"itemName"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"itemCubicFeet"]] forKey:@"itemCubicFeet"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"itemWeight"]] forKey:@"itemWeight"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"itemDollarValue"]] forKey:@"itemDollarValue"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"itemImagePath"]] forKey:@"itemImagePath"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"itemQty"]] forKey:@"itemQuantity"];
        
        [arrMasterItemList addObject:dictRoomList];
    }
    return arrMasterItemList;
}

+(NSMutableArray *)getItemForSendMove:(NSString *)_roomId moveId:(NSString *)_moveId{
    NSString *strQuery = [NSString stringWithFormat:@"Select distinct itemId,itemName,itemCubicFeet,itemWeight,itemDollarValue,itemImagePath,itemQty from ItemTable where (roomId='%@' and itemQty!='0' and moveId='%@') || (roomId='%@' and itemDollarValue!='' and moveId='%@')",_roomId,_moveId,_roomId,_moveId];
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strQuery];
    NSMutableArray *arrMasterItemList=[[NSMutableArray alloc] init];
    while ([rs next]) {
        
        NSMutableDictionary *dictRoomList = [[NSMutableDictionary alloc] init];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"itemId"]] forKey:@"itemId"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"itemName"]] forKey:@"itemName"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"itemCubicFeet"]] forKey:@"itemCubicFeet"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"itemWeight"]] forKey:@"itemWeight"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"itemDollarValue"]] forKey:@"itemDollarValue"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"itemImagePath"]] forKey:@"itemImagePath"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"itemQty"]] forKey:@"itemQuantity"];
        
        [arrMasterItemList addObject:dictRoomList];
    }
    return arrMasterItemList;
}

+(NSMutableArray *)getItemListForSendMove:(NSString *)_roomId{
    NSString *strQuery = [NSString stringWithFormat:@"Select distinct itemId,itemName,itemCubicFeet,itemWeight,itemDollarValue,itemQty from ItemTable where roomId='%@'",_roomId];
    
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strQuery];
    NSMutableArray *arrMasterItemList=[[NSMutableArray alloc] init];
    while ([rs next]) {
        
        NSMutableDictionary *dictRoomList = [[NSMutableDictionary alloc] init];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"itemId"]] forKey:@"itemId"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"itemName"]] forKey:@"itemName"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"itemCubicFeet"]] forKey:@"itemCubicFeet"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"itemWeight"]] forKey:@"itemWeight"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"itemDollarValue"]] forKey:@"itemDollarValue"];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"itemQty"]] forKey:@"itemQuantity"];
        
        [arrMasterItemList addObject:dictRoomList];
    }
    return arrMasterItemList;
}


+(NSMutableArray *)getRoomForSendMove:(NSString *)_moveId{
    NSString *strQuery = [NSString stringWithFormat:@"Select distinct roomId from ItemTable where moveId='%@'",_moveId];
    
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strQuery];
    NSMutableArray *arrMasterItemList=[[NSMutableArray alloc] init];
    while ([rs next]) {
        
        NSMutableDictionary *dictRoomList = [[NSMutableDictionary alloc] init];
        [dictRoomList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"roomId"]] forKey:@"roomId"];
        [arrMasterItemList addObject:dictRoomList];
    }
    return arrMasterItemList;
}

#pragma mark - DELETE

+(BOOL)deleteItemTable{
    NSString *query = [NSString stringWithFormat:@"DELETE FROM ItemTable"];
    NSLog(@"%@",query);
    BOOL result = [[DbController BoxHoppdatabase] executeUpdate:query];
    return result;
}

#pragma mark - UPDATE

+(BOOL)updateItemTableQuantity:(NSString *)_itemId roomId:(NSString *)_roomId moveId:(NSString *)_moveId itemQty:(NSString *)_itemQty{
    
    NSString *strUpdateQry = [NSString stringWithFormat:@"Update ItemTable set itemQty = '%@' where moveId = '%@' and roomId = '%@' and itemId='%@'",_itemQty,_moveId,_roomId,_itemId];
    NSLog(@"%@",strUpdateQry);
    BOOL Result = [[DbController BoxHoppdatabase] executeUpdate:strUpdateQry];
    return Result;
}

+(BOOL)updateItemTableDollarValue:(NSString *)_itemId roomId:(NSString *)_roomId moveId:(NSString *)_moveId itemDollarValue:(NSString *)_itemDollarValue{
    NSString *strUpdateQry = [NSString stringWithFormat:@"Update ItemTable set itemDollarValue = '%@' where moveId = '%@' and roomId = '%@' and itemId='%@'",_itemDollarValue,_moveId,_roomId,_itemId];
    NSLog(@"%@",strUpdateQry);
    BOOL Result = [[DbController BoxHoppdatabase] executeUpdate:strUpdateQry];
    return Result;
}

#pragma mark - IMAGE TABLE

#pragma mark - INSERT

+(BOOL)insertImageTable:(NSString *)_imageId imageName:(NSString *)_imageName imagePath:(NSString *)_imagePath itemId:(NSString *)_itemId moveId:(NSString *)_moveId isSync:(NSString *)_isSync isPrimary:(NSString *)_isPrimary roomId:(NSString *)_roomId{
    
    NSString *strInsertQry = [NSString stringWithFormat:@"Insert into ImageTable (imageId,imageName,imagePath,itemId,moveId,isSync,isPrimary,roomId) values ('%@','%@','%@','%@','%@','%@','%@','%@') ",_imageId,_imageName,_imagePath,_itemId,_moveId,_isSync,_isPrimary,_roomId];
    NSLog(@"%@",strInsertQry);
    BOOL Result = [[DbController BoxHoppdatabase] executeUpdate:strInsertQry];
//    SELECT COALESCE(MAX(id)+1, 0) FROM words    
    return Result;
}

#pragma Count
+(NSInteger)imageTableCount:(NSString *)_moveId
{
    NSInteger Count=0;
   NSString *strInsertQry = [NSString stringWithFormat:@"SELECT COUNT(*) FROM ImageTable"];
   Count=[[DbController BoxHoppdatabase] getTableCount:strInsertQry];
    
    return Count;
}


#pragma mark - SELECT

+(NSMutableArray *)getImageList:(NSString *)_itemId roomId:(NSString *)_roomId moveId:(NSString *)_moveId{
    NSString *strQuery = [NSString stringWithFormat:@"Select distinct imageId,imageName,imagePath,itemId,moveId,isSync,isPrimary,roomId from ImageTable where roomId='%@' and moveId='%@' and itemId='%@'",_roomId,_moveId,_itemId];
    
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strQuery];
    NSMutableArray *arrImageList=[[NSMutableArray alloc] init];
    while ([rs next]) {
        
        NSMutableDictionary *dictImageList = [[NSMutableDictionary alloc] init];
        [dictImageList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"imageId"]] forKey:@"imageId"];
        [dictImageList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"imageName"]] forKey:@"imageName"];
        [dictImageList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"imagePath"]] forKey:@"imagePath"];
        [dictImageList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"itemId"]] forKey:@"itemId"];
        [dictImageList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"moveId"]] forKey:@"moveId"];
        [dictImageList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"isSync"]] forKey:@"isSync"];
        [dictImageList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"isPrimary"]] forKey:@"isPrimary"];
        [dictImageList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"roomId"]] forKey:@"roomId"];
        
        [arrImageList addObject:dictImageList];
    }
    return arrImageList;
}

#pragma mark - UPDATE

+(BOOL)updateImageTableWithImageId:(NSString *)_imageId isPrimary:(NSString *)_isPrimary itemId:(NSString *)_itemId moveId:(NSString *)_moveId roomId:(NSString *)_roomId
{
    NSString *strUpdateQry = [NSString stringWithFormat:@"Update ImageTable set isPrimary = '%@' where moveId = '%@' and roomId = '%@' and itemId='%@' and imageId='%@'",_isPrimary,_moveId,_roomId,_itemId,_imageId];
    NSLog(@"%@",strUpdateQry);
    BOOL Result = [[DbController BoxHoppdatabase] executeUpdate:strUpdateQry];
    return Result;
}

+(BOOL)updateImageTableWithImageName:(NSString *)_imageName isPrimary:(NSString *)_isPrimary itemId:(NSString *)_itemId moveId:(NSString *)_moveId roomId:(NSString *)_roomId
{
    NSString *strUpdateQry = [NSString stringWithFormat:@"Update ImageTable set isPrimary = '%@' where moveId = '%@' and roomId = '%@' and itemId='%@' and imageName='%@'",_isPrimary,_moveId,_roomId,_itemId,_imageName];
    NSLog(@"%@",strUpdateQry);
    BOOL Result = [[DbController BoxHoppdatabase] executeUpdate:strUpdateQry];
    return Result;
}
+(BOOL)updateImageSyncTableWithImageName:(NSString *)_imageName isSync:(NSString *)_isSync imageId:(NSString *)_imageId itemId:(NSString *)_itemId moveId:(NSString *)_moveId roomId:(NSString *)_roomId
{
    NSString *strUpdateQry = [NSString stringWithFormat:@"Update ImageTable set isSync = '%@',imageId ='%@' where moveId = '%@' and roomId = '%@' and itemId='%@' and imageName='%@'",_isSync,_imageId,_moveId,_roomId,_itemId,_imageName];
    NSLog(@"%@",strUpdateQry);
    BOOL Result = [[DbController BoxHoppdatabase] executeUpdate:strUpdateQry];
    return Result;
}

+(BOOL)updateImageTable:(NSString *)_isPrimary itemId:(NSString *)_itemId moveId:(NSString *)_moveId roomId:(NSString *)_roomId
{
    NSString *strUpdateQry = [NSString stringWithFormat:@"Update ImageTable set isPrimary = '%@' where moveId = '%@' and roomId = '%@' and itemId='%@'",_isPrimary,_moveId,_roomId,_itemId];
    NSLog(@"%@",strUpdateQry);
    BOOL Result = [[DbController BoxHoppdatabase] executeUpdate:strUpdateQry];
    return Result;
}

#pragma mark - DELETE

+(BOOL)deleteImage:(NSString *)_imageId itemId:(NSString *)_itemId moveId:(NSString *)_moveId roomId:(NSString *)_roomId{
    NSString *query = [NSString stringWithFormat:@"DELETE FROM ImageTable where moveId = '%@' and roomId = '%@' and itemId='%@' and imageId='%@'",_moveId,_roomId,_itemId,_imageId];
    NSLog(@"%@",query);
    BOOL result = [[DbController BoxHoppdatabase] executeUpdate:query];
    return result;
}

+(BOOL)deleteImageTable{
    NSString *query = [NSString stringWithFormat:@"DELETE FROM ImageTable"];
    NSLog(@"%@",query);
    BOOL result = [[DbController BoxHoppdatabase] executeUpdate:query];
    return result;
}

#pragma mark - SEND MY MOVE

#pragma mark - SELECT
+(NSMutableArray *)getSendMyMove{
    NSString *strQuery = [NSString stringWithFormat:@"SELECT moveName, moveId FROM MoveTable where moveType = 'NonVideo'"];
    
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strQuery];
    NSMutableArray *arrSendMyMoveList=[[NSMutableArray alloc] init];
    while ([rs next]) {
        
        NSMutableDictionary *dictSendMyMoveList = [[NSMutableDictionary alloc] init];
        [dictSendMyMoveList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"moveName"]] forKey:@"moveName"];
        [dictSendMyMoveList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"moveId"]] forKey:@"moveId"];
        [arrSendMyMoveList addObject:dictSendMyMoveList];
    }
    return arrSendMyMoveList;
}

+(NSMutableArray *)getVideoMyMove{
    NSString *strQuery = [NSString stringWithFormat:@"SELECT moveName, moveId FROM MoveTable where moveType = 'Video'"];
    
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strQuery];
    NSMutableArray *arrSendMyMoveList=[[NSMutableArray alloc] init];
    while ([rs next]) {
        
        NSMutableDictionary *dictSendMyMoveList = [[NSMutableDictionary alloc] init];
        [dictSendMyMoveList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"moveName"]] forKey:@"moveName"];
        [dictSendMyMoveList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"moveId"]] forKey:@"moveId"];
        [arrSendMyMoveList addObject:dictSendMyMoveList];
    }
    return arrSendMyMoveList;
}


#pragma mark - ADDRESS

#pragma mark - INSERT

+(BOOL)insertMoveAddress:(NSString *)_currentAddress moveFrom:(NSString *)_moveFrom newAddress:(NSString *)_newAddress moveTo:(NSString *)_moveTo thisIsFor:(NSString *)_thisIsFor howManyStories:(NSString *)_howManyStories moveDate:(NSString *)_moveDate moveId:(NSString *)_moveId{
    
    NSString *strSelectQry = [NSString stringWithFormat:@"Select moveId from Address where moveId = '%@'",_moveId];
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strSelectQry];
    NSString *strSelect;
    while ([rs next]) {
        strSelect = [rs stringForColumn:@"moveId"];
        if([DataValidation isNullString:strSelect]==NO){
            return YES;
        }
        else{
            return NO;
        }
    }
    
    NSString *strInsertQry = [NSString stringWithFormat:@"Insert into Address (currentAddress,moveFrom,newAddress,moveTo,thisIsFor,howManyStories,moveDate,moveId) values ('%@','%@','%@','%@','%@','%@','%@','%@') ",_currentAddress,_moveFrom,_newAddress,_moveTo,_thisIsFor,_howManyStories,_moveDate,_moveId];
    NSLog(@"%@",strInsertQry);
    BOOL Result = [[DbController BoxHoppdatabase] executeUpdate:strInsertQry];
    return Result;
}

#pragma mark - SELECT

+(NSMutableArray *)getMoveAddress:(NSString *)_moveId{
    NSString *strQuery = [NSString stringWithFormat:@"SELECT * FROM Address where moveId = '%@'",_moveId];
    
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strQuery];
    NSMutableArray *arrgetMoveAddressList=[[NSMutableArray alloc] init];
    while ([rs next]) {
        
        NSMutableDictionary *dictgetMoveAddressList = [[NSMutableDictionary alloc] init];
        [dictgetMoveAddressList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"currentAddress"]] forKey:@"currentAddress"];
        [dictgetMoveAddressList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"moveFrom"]] forKey:@"moveFrom"];
        
        [dictgetMoveAddressList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"newAddress"]] forKey:@"newAddress"];
        [dictgetMoveAddressList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"moveTo"]] forKey:@"moveTo"];
        
        [dictgetMoveAddressList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"thisIsFor"]] forKey:@"addressType"];
        [dictgetMoveAddressList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"howManyStories"]] forKey:@"howManyStories"];
        
        [dictgetMoveAddressList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"moveDate"]] forKey:@"moveDate"];
        //        [dictgetMoveAddressList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"moveId"]] forKey:@"moveId"];
        
        [arrgetMoveAddressList addObject:dictgetMoveAddressList];
    }
    return arrgetMoveAddressList;
}

+(NSMutableDictionary *)MoveAddrees:(NSString *)_moveId
{
    NSString *strQuery = [NSString stringWithFormat:@"SELECT * FROM Address where moveId = '%@'",_moveId];
    
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strQuery];
    NSMutableDictionary *dictgetMoveAddressList = [[NSMutableDictionary alloc] init];
    while ([rs next]) {
        
        [dictgetMoveAddressList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"currentAddress"]] forKey:@"currentAddress"];
        [dictgetMoveAddressList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"moveFrom"]] forKey:@"moveFromZip"];
        
        [dictgetMoveAddressList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"newAddress"]] forKey:@"newAddress"];
        [dictgetMoveAddressList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"moveTo"]] forKey:@"moveToZip"];
        
        [dictgetMoveAddressList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"thisIsFor"]] forKey:@"addressType"];
        [dictgetMoveAddressList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"howManyStories"]] forKey:@"howManyStories"];
        
        [dictgetMoveAddressList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"moveDate"]] forKey:@"moveDate"];
        //        [dictgetMoveAddressList setValue:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"moveId"]] forKey:@"moveId"];
        
    }
    return dictgetMoveAddressList;
}

+(NSString *)getCurrentZip:(NSString *)_moveId{
    NSString *strQuery = [NSString stringWithFormat:@"SELECT moveFrom FROM Address where moveId = '%@'",_moveId];
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strQuery];
    NSString *strZip = @"";
    while ([rs next]) {
        strZip = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"moveFrom"]];
    }
    return strZip;
}

#pragma mark - UPDATE

+(BOOL)updateMoveAddress:(NSString *)_currentAddress moveFrom:(NSString *)_moveFrom newAddress:(NSString *)_newAddress moveTo:(NSString *)_moveTo thisIsFor:(NSString *)_thisIsFor howManyStories:(NSString *)_howManyStories moveDate:(NSString *)_moveDate moveId:(NSString *)_moveId{
    NSString *strUpdateQry = [NSString stringWithFormat:@"Update Address set currentAddress = '%@',moveFrom ='%@',newAddress = '%@',moveTo = '%@',thisIsFor = '%@',howManyStories = '%@', moveDate = '%@' where moveId = '%@'",_currentAddress,_moveFrom,_newAddress,_moveTo,_thisIsFor,_howManyStories,_moveDate,_moveId];
    NSLog(@"%@",strUpdateQry);
    BOOL Result = [[DbController BoxHoppdatabase] executeUpdate:strUpdateQry];
    return Result;
}

#pragma mark - DELETE

+(BOOL)deleteMoveAddress:(NSString *)_moveId{
    NSString *query = [NSString stringWithFormat:@"DELETE FROM Address where moveId='%@'",_moveId];
    NSLog(@"%@",query);
    BOOL result = [[DbController BoxHoppdatabase] executeUpdate:query];
    return result;
}

+(BOOL)deleteMoveAddress{
    NSString *query = [NSString stringWithFormat:@"DELETE FROM Address"];
    NSLog(@"%@",query);
    BOOL result = [[DbController BoxHoppdatabase] executeUpdate:query];
    return result;
}

#pragma mark DatabaseQueries for Sync Image
+(NSMutableArray *)getMoveId{
    NSString *strQuery = [NSString stringWithFormat:@"SELECT moveId FROM MoveTable"];
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strQuery];
    NSMutableArray *allmoveId=[[NSMutableArray alloc] init];
    
    while ([rs next]) {
        [allmoveId addObject:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"moveId"]]];
    }
    return allmoveId;
}
+(NSMutableArray *)getRoomID{
    NSString *strQuery = [NSString stringWithFormat:@"SELECT roomId FROM MasterRoom"];
    ResultSet *rs = [[DbController BoxHoppdatabase] executeQuery:strQuery];
    NSMutableArray *allmoveId=[[NSMutableArray alloc] init];
    
    while ([rs next]) {
        [allmoveId addObject:[NSString stringWithFormat:@"%@",[rs stringForColumn:@"roomId"]]];
    }
    return allmoveId;
}

@end
