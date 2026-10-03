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
 * Keeps the app process alive while movement detection is on, so the
 * accelerometer/gyroscope streams read by the Dart MotionService keep
 * flowing with the screen off (Android throttles/stops sensors for
 * backgrounded apps otherwise). Like VoiceDistressForegroundService it runs
 * no logic of its own: a mandatory persistent notification plus a partial
 * wake lock, nothing else. Sensor data never leaves the Dart isolate.
 */
class MotionForegroundService : Service() {
    private var wakeLock: PowerManager.WakeLock? = null

    companion object {
        const val ACTION_START = "com.example.sheshield.MOTION_START"
        const val ACTION_STOP = "com.example.sheshield.MOTION_STOP"
        private const val CHANNEL_ID = "motion_guard_channel"
        private const val NOTIFICATION_ID = 4202
    }

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        if (intent?.action == ACTION_STOP) {
            stopForeground(STOP_FOREGROUND_REMOVE)
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
        val pm = getSystemService(Context.POWER_SERVICE) as PowerManager
        wakeLock = pm.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, "sheshield:motionGuard").apply {
            setReferenceCounted(false)
            acquire()
        }
    }

    private fun startForegroundWithNotification() {
        val manager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                "Movement detection",
                NotificationManager.IMPORTANCE_LOW,
            ).apply {
                description = "Shown while SheShield watches for falls, sprints and struggles."
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
            .setContentTitle("SheShield movement protection is on")
            .setContentText("Motion is analysed on this phone only. Turn off in Settings.")
            .setSmallIcon(applicationInfo.icon)
            .setOngoing(true)
            .setContentIntent(contentIntent)
            .build()

        if (Build.VERSION.SDK_INT >= 34) {
            startForeground(NOTIFICATION_ID, notification, ServiceInfo.FOREGROUND_SERVICE_TYPE_SPECIAL_USE)
        } else {
            startForeground(NOTIFICATION_ID, notification)
        }
    }
}
