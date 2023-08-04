package com.example.gutentag

import android.app.DownloadManager
import android.net.Uri
import android.os.Environment
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(
      flutterEngine.dartExecutor.binaryMessenger,
      "com.example.gutentag/download_manager"
    ).setMethodCallHandler { call, result ->
      when (call.method) {
        "download" -> {
          val url = call.argument<String>("url") ?: throw  IllegalStateException("Must provide 'url' argument with 'download' method.")
          val name = call.argument<String>("name") ?: throw  IllegalStateException("Must provide 'name' argument with 'download' method.")
          download(url, name)
        }
        else -> throw IllegalStateException("Unsupported method ${call.method}.")
      }
    }
  }
  
  private fun download(url: String, name: String) {
    val request = DownloadManager.Request(Uri.parse(url))
      .setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED)
      .setDestinationInExternalPublicDir(Environment.DIRECTORY_DOWNLOADS, name)
      .setTitle("Downloading $name")
    (getSystemService(DOWNLOAD_SERVICE) as? DownloadManager)?.enqueue(request)
  }
}
