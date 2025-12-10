{ ... }:
{
  services.home-assistant = {
    enable = true;
    extraComponents = [
      # Components required to complete the onboarding
      "esphome"
      "met"
      "radio_browser"

      # Additional components that seem to be necessary for basic functionality
      "mobile_app"
      "google_translate"

      "tplink"
    ];
    config = {
      # I'm disabling the default configuration, because it comes with a bunch of cruft like
      # automatic device discovery which will throw ModuleNotFound errors for any device type that
      # you have on your network that you don't have drivers for in home assistant.

      # For now automations are done via the ui
      automation = "!include automations.yaml";
    };
  };
}
