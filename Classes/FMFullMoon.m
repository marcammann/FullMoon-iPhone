//
//  FMFullMoon.m
//  FullMoon
//
//  Created by Marc Ammann on 7/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FMFullMoon.h"


@implementation FMFullMoon

@synthesize delegate;
@synthesize currentProperty;

- (id)init {
	if (self = [super init]) {
		timeZone = [[NSTimeZone systemTimeZone] name];
	}
	
	return self;
}

- (void)load {
	NSString *urlPath = [NSString stringWithFormat:@"http://isitfullmoon.com/api.php?format=xml&tz=%@", [timeZone stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSLog(urlPath);
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlPath] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	if (connection) {
        receivedData = [[NSMutableData data] retain];
    } else {
		NSError *error = [NSError errorWithDomain:@"Model" code:100001 userInfo:nil];
		[delegate fullMoon:self didFailWithError:error];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {   
	[self parseReceivedData];
	[connection release];
	
	if (parseError) {
		[delegate fullMoon:self didFailWithError:parseError];	
	} else {
		[delegate receivedDataForFullMoon:self];
	}
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[connection release];
	NSError *reterror = [NSError errorWithDomain:@"Model" code:100002 userInfo:nil];
	[delegate fullMoon:self didFailWithError:reterror];
}

- (void)parseReceivedData {
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:receivedData];
	
	parseError = nil;
	
	[parser setDelegate:self];
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    
    [parser parse];
    
	[parser release];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if (qName) {
        elementName = qName;
    }
    
	if ([elementName isEqualToString:@"status"] || [elementName isEqualToString:@"next"] || [elementName isEqualToString:@"prev"]) {
		currentProperty = [[NSMutableString alloc] init];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:@"status"]) {
		if ([currentProperty isEqualToString:@"Yes"]) {
			isItFullMoon = YES;
		} else if ([currentProperty isEqualToString:@"No"]) {
			isItFullMoon = NO;
		} else {
			parseError = [[NSError errorWithDomain:@"Parsing" code:200001 userInfo:nil] retain];
		}
	} else if ([elementName isEqualToString:@"next"]) {
		nextFullMoon = [[self dateFromString:currentProperty] retain];
		NSLog(@"%@", nextFullMoon);
	} else if ([elementName isEqualToString:@"prev"]) {
		prevFullMoon = [[self dateFromString:currentProperty] retain];
		NSLog(@"%@", prevFullMoon);
	}
	
	[currentProperty release];
	currentProperty = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (currentProperty && string && [string length] > 0) {
        [currentProperty appendString:string];
    }
}

- (NSDate *)dateFromString:(NSString *)timestamp {
	return [NSDate dateWithTimeIntervalSince1970:[timestamp floatValue]];
}

- (NSDate *)prevFullMoon {
	return prevFullMoon;
}

- (NSDate *)nextFullMoon {
	return nextFullMoon;
}

- (BOOL)isItFullMoon {
	return isItFullMoon;
}

- (void)dealloc {
	[prevFullMoon release];
	[nextFullMoon release];
	[parseError release];
	[super dealloc];
}

@end
