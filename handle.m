- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler {
    if (userActivity.activityType == NSUserActivityTypeBrowsingWeb) {
        NSURL *encodedURL = userActivity.webpageURL;

        if (encodedURL == nil) {
            NSLog(@"Unable to handle user activity: No URL provided");

            return false;
        }
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithURL:encodedURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (response == nil || [response URL] == nil) {
                NSLog(@"Unable to handle URL: %@", encodedURL.absoluteString);

                return;
            }

            // Now you have the resolved URL that you can use to navigate somewhere in the app.
            NSURL *resolvedURL = [response URL];
            NSLog(@"Original URL: %@", resolvedURL.absoluteString);
        }];

        [task resume];
    }

    return YES;
}