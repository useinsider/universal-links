func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
    if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
        guard let encodedURL = userActivity.webpageURL else {
            print("Unable to handle user activity: No URL provided")

            return false
        }

        let task = URLSession.shared.dataTask(with: encodedURL, completionHandler: { (data, response, error) in
            guard let resolvedURL = response?.url else {
                print("Unable to handle URL: \(encodedURL.absoluteString)")
                return
            }

            // Now you have the resolved URL that you can use to navigate somewhere in the app.
            print(resolvedURL)
        })

        task.resume()
    }

    return true
}
