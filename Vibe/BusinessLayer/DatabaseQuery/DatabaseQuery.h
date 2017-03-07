//
//  DatabaseQuery.h
//  BoxHopp
//
//   All Rights Reserved EmYa Technologies.
//

#import <Foundation/Foundation.h>
#import "Constant.h"

@interface DatabaseQuery : NSObject

#pragma mark - USER

#pragma mark - INSERT
+(BOOL)insertUser:(NSString *)_userID UserEmail:(NSString *)_userEmail UserType:(NSString *)_userType UserName:(NSString *)_userName UserFirstName:(NSString *)_userFirstName UserLastName:(NSString *)_userLastName UserPassword:(NSString *)_userPassword UserDeviceType:(NSString *)_userDeviceType UserDeviceID:(NSString *)_userDeviceID UserImageURL:(NSString *)_userImageURL UserPhoneNumber:(NSString *)_userPhoneNumber UserLoginVia:(NSString *)_userLoginVia UserAccessToken:(NSString *)_userAccessToken UserSocialID:(NSString *)_userSocialID UserStatus:(NSString *)_userStatus UserRegistrationDate:(NSString *)_userRegistrationDate;

#pragma mark - SELECT

+(User*)selectUserDetails:(NSString *)_userID;
+(NSString *)getUserID;

#pragma mark - DELETE

+(BOOL)deleteUserDetails:(NSString *)_userID;

#pragma mark - MASTER ROOM AND MASTER ITEM

#pragma mark - INSERT
+(BOOL)insertMasterRoom:(NSString *)_roomID roomName:(NSString *)_roomName roomImageURL:(NSString *)_roomImageURL roomCreatorId:(NSString *)_roomCreatorID roomCreatorName:(NSString *)_roomCreatorName roomImagePath:(NSString *)_roomImagePath;
+(BOOL)insertMasterItem:(NSString *)_itemId roomId:(NSString *)_roomId itemName:(NSString *)_itemName itemCubicFeet:(NSString *)_itemCubicFeet itemWeight:(NSString *)_itemWeight isSync:(NSString *)_isSync;

#pragma mark - SELECT
+(NSMutableArray *)getMasterRoomList;
+(NSMutableArray *)getMasterItemList:(NSString *)_roomId;
+(NSString *)getRoomName:(NSString *)_roomId;

#pragma mark - Delete
+(BOOL)deleteMasterRoom;
+(BOOL)deleteMasterItem;
+(BOOL)deleteMasterRoomWithId:(NSString *)_roomId;

#pragma mark - MOVE DETAILS

#pragma mark - INSERT
+(BOOL)insertMoveDetails:(NSString *)_moveId moveName:(NSString *)_moveName moveImageUrl:(NSString *)_moveImageUrl moveType:(NSString *)_moveType moveLocalImagePath:(NSString *)_moveLocalImagePath moveCreatedDate:(NSString *)_moveCreatedDate isSync:(NSString *)_isSync boxesAbove50LBS:(NSString *)_boxesAbove50LBS boxesBelow50LBS:(NSString *)_boxesBelow50LBS attachedNonVideoId:(NSString *)_attachedNonVideoId;

#pragma mark - SELECT
+(NSMutableArray *)getMoveDetailList;
+(NSString *)getBoxesAbove50LBS:(NSString *)_moveId;
+(NSString *)getBoxesBelow50LBS:(NSString *)_moveId;
+(NSString *)moveName:(NSString *)_nonVideoAttachmentId;
+(NSString *)getNonVideoAttachmentId:(NSString *)_moveId moveType:(NSString *)_moveType;

#pragma mark - DELETE
+(BOOL)deleteMoveDetails;
+(BOOL)deleteMoveDetails:(NSString *)_moveId;

#pragma mark - UPDATE

+(BOOL)updateMoveTableMoveName:(NSString *)_moveId moveName:(NSString *)_moveName;
+(BOOL)updateMoveBoxesAbove50LBS:(NSString *)_boxesAbove50LBS moveId:(NSString *)_moveId;
+(BOOL)updateMoveBoxesBelow50LBS:(NSString *)_boxesBelow50LBS moveId:(NSString *)_moveId;
+(BOOL)updateMoveDetails:(NSString *)_attachedNonVideoId moveId:(NSString *)_moveId moveType:(NSString *)_moveType;

#pragma mark - ITEM TABLE

#pragma mark - INSERT

+(BOOL)insertItemTable:(NSString *)_itemId roomId:(NSString *)_roomId moveId:(NSString *)_moveId itemName:(NSString *)_itemName itemCubicFeet:(NSString *)_itemCubicFeet itemWeight:(NSString *)_itemWeight itemDollarValue:(NSString *)_itemDollarValue itemImagePath:(NSString *)_itemImagePath itemQty:(NSString *)_itemQty;

#pragma mark - SELECT

+(NSMutableArray *)getItemTableList:(NSString *)_roomId moveId:(NSString *)_moveId;
+(NSMutableArray *)getItemForSendMove:(NSString *)_roomId moveId:(NSString *)_moveId;
+(NSMutableArray *)getItemListForSendMove:(NSString *)_roomId;
+(NSMutableArray *)getRoomForSendMove:(NSString *)_moveId;
#pragma mark - UPDATE

+(BOOL)updateItemTableQuantity:(NSString *)_itemId roomId:(NSString *)_roomId moveId:(NSString *)_moveId itemQty:(NSString *)_itemQty;
+(BOOL)updateItemTableDollarValue:(NSString *)_itemId roomId:(NSString *)_roomId moveId:(NSString *)_moveId itemDollarValue:(NSString *)_itemDollarValue;
+(BOOL)updateImageTableWithImageName:(NSString *)_imageName isPrimary:(NSString *)_isPrimary itemId:(NSString *)_itemId moveId:(NSString *)_moveId roomId:(NSString *)_roomId;

#pragma mark - DELETE
+(BOOL)deleteItemTable;

#pragma mark - IMAGE TABLE

#pragma mark - INSERT

+(BOOL)insertImageTable:(NSString *)_imageId imageName:(NSString *)_imageName imagePath:(NSString *)_imagePath itemId:(NSString *)_itemId moveId:(NSString *)_moveId isSync:(NSString *)_isSync isPrimary:(NSString *)_isPrimary roomId:(NSString *)_roomId;

#pragma mark - SELECT

+(NSMutableArray *)getImageList:(NSString *)_itemId roomId:(NSString *)_roomId moveId:(NSString *)_moveId;

#pragma mark - UPDATE
+(BOOL)updateImageTableWithImageId:(NSString *)_imageId isPrimary:(NSString *)_isPrimary itemId:(NSString *)_itemId moveId:(NSString *)_moveId roomId:(NSString *)_roomId;

+(BOOL)updateImageTable:(NSString *)_isPrimary itemId:(NSString *)_itemId moveId:(NSString *)_moveId roomId:(NSString *)_roomId;

+(BOOL)updateImageSyncTableWithImageName:(NSString *)_imageName isSync:(NSString *)_isSync imageId:(NSString *)_imageId itemId:(NSString *)_itemId moveId:(NSString *)_moveId roomId:(NSString *)_roomId;

#pragma mark - DELETE
+(BOOL)deleteImage:(NSString *)_imageId itemId:(NSString *)_itemId moveId:(NSString *)_moveId roomId:(NSString *)_roomId;
+(BOOL)deleteImageTable;

#pragma mark - SEND MY MOVE

#pragma mark - SELECT
+(NSMutableArray *)getSendMyMove;
+(NSMutableArray *)getVideoMyMove;


#pragma mark - ADDRESS

#pragma mark - INSERT

+(BOOL)insertMoveAddress:(NSString *)_currentAddress moveFrom:(NSString *)_moveFrom newAddress:(NSString *)_newAddress moveTo:(NSString *)_moveTo thisIsFor:(NSString *)_thisIsFor howManyStories:(NSString *)_howManyStories moveDate:(NSString *)_moveDate moveId:(NSString *)_moveId;

#pragma mark - SELECT

+(NSMutableArray *)getMoveAddress:(NSString *)_moveId;
+(NSString *)getMoveType:(NSString *)_moveId;
+(NSMutableDictionary *)MoveAddrees:(NSString *)_moveId;
+(NSString *)getCurrentZip:(NSString *)_moveId;

#pragma mark - UPDATE

+(BOOL)updateMoveAddress:(NSString *)_currentAddress moveFrom:(NSString *)_moveFrom newAddress:(NSString *)_newAddress moveTo:(NSString *)_moveTo thisIsFor:(NSString *)_thisIsFor howManyStories:(NSString *)_howManyStories moveDate:(NSString *)_moveDate moveId:(NSString *)_moveId;

#pragma mark - DELETE

+(BOOL)deleteMoveAddress:(NSString *)_moveId;
+(BOOL)deleteMoveAddress;

#pragma mark SYNC IMAGE
+(NSMutableArray *)getMoveId;
+(NSMutableArray *)getRoomID;

#pragma mark - VIDEO TABLE DETAILS

#pragma mark - INSERT

+(BOOL)insertVideoMyMove:(NSString *)_videoId moveId:(NSString *)_moveId videoName:(NSString *)_videoName videoPath:(NSString *)_videoPath videoURL:(NSString *)_videoURL videoImage:(NSString *)_videoImage videoThumbnailImagePath:(NSString *)_videoThumbnailImagePath isRequestedForVideoDownload:(NSString *)_isRequestedForVideoDownload isNameSync:(NSString *)_isNameSync isSync:(NSString *)_isSync attachedNonVideoName:(NSString *)_attachedNonVideoName attachedNonVideoId:(NSString *)_attachedNonVideoId;

#pragma mark - DELETE

+(BOOL)deleteVideoMove:(NSString *)_moveId;
+(BOOL)deleteVideoDetails:(NSString *)_moveId videoId:(NSString *)_videoId;

#pragma mark - SELECT

+(NSMutableArray *)selectVideoMyMove:(NSString *)_moveId;

#pragma mark - UPDATE

+(BOOL)updateVideoName:(NSString *)_moveId videoId:(NSString *)_videoId videoName:(NSString *)_videoName;
+(NSInteger)imageTableCount:(NSString *)_moveId;

@end
