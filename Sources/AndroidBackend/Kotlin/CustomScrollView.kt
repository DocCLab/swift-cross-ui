package dev.swiftcrossui.androidbackend

import android.widget.ScrollView
import android.widget.HorizontalScrollView
import android.view.View
import android.app.Activity
import android.util.Log

class CustomScrollView(val activity: Activity, val child: View): ScrollView(activity) {
    var horizontalScrollView = HorizontalScrollView(activity)

    init {
        addView(horizontalScrollView, 0)
        horizontalScrollView.addView(child, 0)
    }
}
