package com.lntu.lab14

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.lntu/native_code"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getNativeData") {
                // Повертаємо статичний рядок
                val nativeData = "Greetings from the native code!"
                result.success(nativeData)
            } else {
                result.notImplemented()
            }
        }
    }
}
