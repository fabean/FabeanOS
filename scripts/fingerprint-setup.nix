{ pkgs, ... }:

pkgs.writeShellScriptBin "fingerprint-setup" ''
#!/bin/bash

echo "🔐 Fingerprint Sensor Setup Script"
echo "=================================="
echo ""

# Check if fprintd is running
if systemctl is-active --quiet fprintd; then
    echo "✅ fprintd service is running"
else
    echo "❌ fprintd service is not running"
    echo "   Starting fprintd service..."
    sudo systemctl start fprintd
    sudo systemctl enable fprintd
fi

echo ""
echo "📱 Checking for fingerprint devices..."
echo ""

# List available devices
echo "Available fingerprint devices:"
fprintd-list | cat

echo ""
echo "🔍 Checking device details..."
echo ""

# Check device details
if command -v fprintd-list &> /dev/null; then
    fprintd-list | while read -r device; do
        if [[ -n "$device" ]]; then
            echo "Device: $device"
            fprintd-info "$device" 2>/dev/null || echo "  Could not get detailed info"
            echo ""
        fi
    done
else
    echo "❌ fprintd-list command not found"
fi

echo ""
echo "📋 Available commands:"
echo "  fprintd-list                    - List available devices"
echo "  fprintd-info <device>           - Get device information"
echo "  fprintd-enroll <device>         - Enroll a new fingerprint"
echo "  fprintd-delete <device> <user>  - Delete enrolled fingerprints"
echo "  fprintd-verify <device>         - Test fingerprint verification"
echo ""
echo "💡 To enroll your fingerprint, run:"
echo "   fprintd-enroll <device_name>"
echo ""
echo "💡 To test fingerprint verification, run:"
echo "   fprintd-verify <device_name>"
echo ""
echo "🔧 If you need to find your device name, run:"
echo "   lsusb | grep -i fingerprint"
echo "   or"
echo "   dmesg | grep -i fingerprint"
echo ""