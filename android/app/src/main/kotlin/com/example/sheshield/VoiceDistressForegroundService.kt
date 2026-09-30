package com.example.sheshield

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.pm.ServiceInfo
import android.os.Build
import android.os.IBinder
import android.os.PowerManager

/**
 * Exists for one reason: Android freezes/kills a normal app process soon
 * after the screen turns off or the activity backgrounds. A microphone-type
 * foreground service (mandatory persistent notification, by OS design --
 * you cannot hide a background mic listener from the user) plus a partial
 * wake lock keep this process alive instead, so the [VoiceDistressService]
 * already listening in the main Dart isolate just keeps running -- there is
 * deliberately no separate headless isolate here, this service's only job
 * is to stop the OS from suspending the one that already exists.
 */
class VoiceDistressForegroundService : Service() {
    private var wakeLock: PowerManager.WakeLock? = null

    companion object {
        const val ACTION_START = "com.example.sheshield.VOICE_DISTRESS_START"
        const val ACTION_STOP = "com.example.sheshield.VOICE_DISTRESS_STOP"
        private const val CHANNEL_ID = "voice_distress_channel"
        private const val NOTIFICATION_ID = 4201
    }

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        if (intent?.action == ACTION_STOP) {
            stopSelf()
            return START_NOT_STICKY
        }

        startForegroundWithNotification()
        acquireWakeLock()
        return START_STICKY
    }

    override fun onDestroy() {
        wakeLock?.let { if (it.isHeld) it.release() }
        wakeLock = null
        super.onDestroy()
    }

    private fun acquireWakeLock() {
        if (wakeLock?.isHeld == true) return
        val powerManager = getSystemService(Context.POWER_SERVICE) as PowerManager
        wakeLock = powerManager.newWakeLock(
            PowerManager.PARTIAL_WAKE_LOCK,
            "sheshield:voiceDistressListening",
        ).apply {
            // No timeout: this is released explicitly in onDestroy when the
            // person turns the feature off. setReferenceCounted(false) so a
            // stray double-acquire can never leak it.
            setReferenceCounted(false)
            acquire()
        }
    }

    private fun startForegroundWithNotification() {
        val manager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                "Voice distress listening",
                NotificationManager.IMPORTANCE_LOW,
            ).apply {
                description = "Shown while SheShield listens for spoken distress phrases."
                setShowBadge(false)
            }
            manager.createNotificationChannel(channel)
        }

        val openApp = packageManager.getLaunchIntentForPackage(packageName)
        val contentIntent = PendingIntent.getActivity(
            this, 0, openApp,
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT,
        )

        val notification: Notification = Notification.Builder(this, CHANNEL_ID)
            .setContentTitle("SheShield is listening")
            .setContentText("Voice distress detection is active in the background.")
            .setSmallIcon(applicationInfo.icon)
            .setOngoing(true)
            .setContentIntent(contentIntent)
            .build()

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            startForeground(
                NOTIFICATION_ID,
                notification,
                ServiceInfo.FOREGROUND_SERVICE_TYPE_MICROPHONE,
            )
        } else {
            startForeground(NOTIFICATION_ID, notification)
        }
    }
}
