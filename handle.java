@Override
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);
    onNewIntent(getIntent());
}

protected void onNewIntent(Intent intent) {
    String action = intent.getAction();
    final String encodedURL = intent.getDataString();
    if (Intent.ACTION_VIEW.equals(action) && encodedURL != null) {
        Log.d("App Link", encodedURL);
        new Thread(new Runnable() {
            public void run() {
                try {
                    URL originalURL = new URL(encodedURL);
                    HttpURLConnection ucon = (HttpURLConnection) originalURL.openConnection();
                    ucon.setInstanceFollowRedirects(false);
                    URL resolvedURL = new URL(ucon.getHeaderField("Location"));
                    Log.d("App Link", resolvedURL.toString());
                }
                catch (MalformedURLException ex) {
                    Log.e("App Link",Log.getStackTraceString(ex));
                }
                catch (IOException ex) {
                    Log.e("App Link",Log.getStackTraceString(ex));
                }
            }
        }).start();
    }
}