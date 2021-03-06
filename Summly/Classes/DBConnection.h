//
//  DBConnection.h
//  SyjRedess
//
//  Created by rex on 12-10-31.
//
//


#import <sqlite3.h>
#import "Statement.h"

@interface DBConnection : NSObject
{
    
}

+ (void)migrate:(NSString*)dbname to:(NSString*)newdbname queries:(NSString*)query_file;
+ (void)createEditableCopyOfDatabaseIfNeeded:(BOOL)force;
+ (void)deletePinsCache;

+ (sqlite3 *)getSharedDatabase;
+ (void)closeDatabase;

+ (void)beginTransaction;
+ (void)commitTransaction;

+ (Statement *) statementWithQuery:(const char *)sql;






@end
