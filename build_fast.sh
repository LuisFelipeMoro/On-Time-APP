#!/bin/bash

# Fast Flutter Build Script
echo "🚀 Starting optimized Flutter build..."

# Set UTF-8 encoding for CocoaPods
export LANG=en_US.UTF-8

# Use debug mode for faster builds
echo "📱 Running in debug mode for speed..."
flutter run --debug

# Alternative: Use simulator for even faster builds
# flutter run -d "iPhone Simulator" --debug