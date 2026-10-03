package com.example.sheshield

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channelName = "com.example.sheshield/voice_distress_service"
    private val motionChannelName = "com.example.sheshield/motion_service"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "start" -> {
                        startService(
                            Intent(this, VoiceDistressForegroundService::class.java)
                                .setAction(VoiceDistressForegroundService.ACTION_START),
                        )
                        result.success(null)
                    }
                    "stop" -> {
                        startService(
                            Intent(this, VoiceDistressForegroundService::class.java)
                                .setAction(VoiceDistressForegroundService.ACTION_STOP),
                        )
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, motionChannelName)
            .setMethodCallHandler { call, result ->
                val action = when (call.method) {
                    "start" -> MotionForegroundService.ACTION_START
                    "stop" -> MotionForegroundService.ACTION_STOP
                    else -> null
                }
                if (action == null) {
                    result.notImplemented()
                } else {
                    startService(Intent(this, MotionForegroundService::class.java).setAction(action))
                    result.success(null)
                }
            }
    }
}
