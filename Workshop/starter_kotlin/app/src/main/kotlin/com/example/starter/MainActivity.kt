package com.example.starter

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.example.starter.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.messageText.text = "Hello from Kotlin"
        binding.actionButton.setOnClickListener {
            binding.messageText.text = "Button clicked!"
        }
    }
}