{ config, ... }:

{
  home.file.".config/swaync/config.json".text = ''
    {
      "$schema": "/etc/xdg/swaync/configSchema.json",
      "positionX": "right",
      "positionY": "top",
      "control-center-margin-top": 10,
      "control-center-margin-bottom": 10,
      "control-center-margin-right": 10,
      "control-center-margin-left": 10,
      "notification-icon-size": 64,
      "notification-body-image-height": 100,
      "notification-body-image-width": 200,
      "timeout": 10,
      "timeout-low": 5,
      "timeout-critical": 0,
      "fit-to-screen": false,
      "control-center-width": 500,
      "control-center-height": 1025,
      "notification-window-width": 500,
      "keyboard-shortcuts": true,
      "image-visibility": "when-available",
      "transition-time": 200,
      "hide-on-clear": false,
      "hide-on-action": true,
      "script-fail-notify": true,
      "widgets": [
        "title",
        "mpris",
        "volume",
        "backlight",
        "dnd",
        "notifications"
      ],
      "widget-config": {
        "title": {
          "text": "Notification Center",
          "clear-all-button": true,
          "button-text": "󰆴 Clear All"
        },
        "dnd": {
          "text": "Do Not Disturb"
        },
        "label": {
          "max-lines": 1,
          "text": "Notification Center"
        },
        "mpris": {
          "image-size": 96,
          "image-radius": 7
        },
        "volume": {
          "label": "󰕾"
        },
        "backlight": {
          "label": "󰃟"
        },
      }
    }
  '';
  home.file.".config/swaync/style.css".text = ''
    * {
      font-family: JetBrainsMono Nerd Font Mono, Font Awesome, sans-serif;
      font-weight: normal;
      font-size: 12px;
    }

    .control-center .notification-row:focus,
    .control-center .notification-row:hover {
      opacity: 0.9;
      background: #1a1b26;
    }

    .notification-row {
      outline: none;
      margin: 8px;
      padding: 0;
    }

    .notification {
      background: transparent;
      padding: 0;
      margin: 0px;
    }

    .notification-content {
      background: #1a1b26;
      padding: 12px;
      border-radius: 8px;
      border: none;
      margin: 0;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
    }

    .notification-default-action {
      margin: 0;
      padding: 0;
      border-radius: 8px;
    }

    .close-button {
      background: #f7768e;
      color: #1a1b26;
      text-shadow: none;
      padding: 4px 8px;
      border-radius: 4px;
      margin-top: 8px;
      margin-right: 8px;
      font-size: 10px;
    }

    .close-button:hover {
      box-shadow: none;
      background: #bb9af7;
      transition: all 0.2s ease-in-out;
      border: none;
    }

    .notification-action {
      border: none;
      border-top: 1px solid #414868;
      border-radius: 0;
      background: #1a1b26;
    }

    .notification-default-action:hover,
    .notification-action:hover {
      color: #7aa2f7;
      background: #414868;
    }

    .notification-default-action {
      border-radius: 8px;
      margin: 0px;
    }

    .notification-default-action:not(:only-child) {
      border-bottom-left-radius: 0;
      border-bottom-right-radius: 0;
    }

    .notification-action:first-child {
      border-bottom-left-radius: 8px;
      background: #1a1b26;
    }

    .notification-action:last-child {
      border-bottom-right-radius: 8px;
      background: #1a1b26;
    }

    .inline-reply {
      margin-top: 8px;
    }

    .inline-reply-entry {
      background: #414868;
      color: #cdd6f4;
      caret-color: #cdd6f4;
      border: 1px solid #565a6e;
      border-radius: 4px;
      padding: 8px;
    }

    .inline-reply-button {
      margin-left: 4px;
      background: #7aa2f7;
      border: none;
      border-radius: 4px;
      color: #1a1b26;
      padding: 4px 8px;
    }

    .inline-reply-button:disabled {
      background: #565a6e;
      color: #414868;
      border: none;
    }

    .inline-reply-button:hover {
      background: #bb9af7;
    }

    .body-image {
      margin-top: 8px;
      background-color: #414868;
      border-radius: 4px;
    }

    .summary {
      font-size: 14px;
      font-weight: 600;
      background: transparent;
      color: #cdd6f4;
      text-shadow: none;
    }

    .time {
      font-size: 11px;
      font-weight: normal;
      background: transparent;
      color: #565a6e;
      text-shadow: none;
      margin-right: 8px;
    }

    .body {
      font-size: 12px;
      font-weight: normal;
      background: transparent;
      color: #a9b1d6;
      text-shadow: none;
      margin-top: 4px;
    }

    .control-center {
      background: #1a1b26;
      border: none;
      border-radius: 12px;
      box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4);
    }

    .control-center-list {
      background: transparent;
    }

    .control-center-list-placeholder {
      opacity: 0.5;
      color: #565a6e;
    }

    .floating-notifications {
      background: transparent;
    }

    .blank-window {
      background: alpha(black, 0);
    }

    .widget-title {
      color: #cdd6f4;
      background: transparent;
      padding: 12px 16px 8px 16px;
      margin: 0;
      font-size: 16px;
      font-weight: 600;
      border-radius: 0;
    }

    .widget-title>button {
      font-size: 12px;
      color: #7aa2f7;
      text-shadow: none;
      background: transparent;
      box-shadow: none;
      border-radius: 4px;
      padding: 4px 8px;
    }

    .widget-title>button:hover {
      background: #414868;
      color: #cdd6f4;
    }

    .widget-dnd {
      background: transparent;
      padding: 8px 16px;
      margin: 0;
      border-radius: 0;
      font-size: 14px;
      color: #cdd6f4;
    }

    .widget-dnd>switch {
      border-radius: 12px;
      background: #565a6e;
    }

    .widget-dnd>switch:checked {
      background: #7aa2f7;
      border: none;
    }

    .widget-dnd>switch slider {
      background: #cdd6f4;
      border-radius: 10px;
    }

    .widget-dnd>switch:checked slider {
      background: #cdd6f4;
      border-radius: 10px;
    }

    .widget-label {
      margin: 8px 16px 4px 16px;
    }

    .widget-label>label {
      font-size: 12px;
      color: #565a6e;
    }

    .widget-mpris {
      color: #cdd6f4;
      padding: 8px 16px;
      margin: 0;
      border-radius: 0;
      background: transparent;
    }

    .widget-mpris > box > button {
      border-radius: 4px;
      background: #414868;
      color: #cdd6f4;
    }

    .widget-mpris > box > button:hover {
      background: #565a6e;
    }

    .widget-mpris-player {
      padding: 8px 16px;
      margin: 0;
      background: transparent;
    }

    .widget-mpris-title {
      font-weight: 600;
      font-size: 14px;
      color: #cdd6f4;
    }

    .widget-mpris-subtitle {
      font-size: 12px;
      color: #a9b1d6;
    }

    .widget-menubar>box>.menu-button-bar>button {
      border: none;
      background: transparent;
    }

    .topbar-buttons>button {
      border: none;
      background: transparent;
    }

    .widget-volume {
      background: transparent;
      padding: 8px 16px;
      margin: 0;
      border-radius: 0;
      font-size: 14px;
      color: #cdd6f4;
    }

    .widget-volume>box>button {
      background: #7aa2f7;
      border: none;
      border-radius: 4px;
    }

    .widget-volume>box>button:hover {
      background: #bb9af7;
    }

    .per-app-volume {
      background-color: #414868;
      padding: 8px 12px;
      margin: 4px 16px;
      border-radius: 4px;
    }

    .widget-backlight {
      background: transparent;
      padding: 8px 16px;
      margin: 0;
      border-radius: 0;
      font-size: 14px;
      color: #cdd6f4;
    }

    .widget-backlight>box>button {
      background: #7aa2f7;
      border: none;
      border-radius: 4px;
    }

    .widget-backlight>box>button:hover {
      background: #bb9af7;
    }
  '';
}
