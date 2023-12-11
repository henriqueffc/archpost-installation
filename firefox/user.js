// Firefox - Arch Linux
// https://github.com/henriqueffc/archpost-installation 
//
// If you make changes to this file while the application is running,
// the changes will be overwritten when the application exits.
//
// To change a preference value, you can either:
// - modify it via the UI (e.g. via about:config in the browser); or
// - set it within a user.js file in your profile.
//
user_pref("accessibility.force_disabled", 1);
user_pref("apz.overscroll.enabled", true);
user_pref("browser.cache.disk.enable", false);
user_pref("browser.cache.memory.capacity", 1048576);
user_pref("browser.display.use_system_colors", true);
user_pref("browser.download.alwaysOpenPanel", false);
user_pref("browser.gnome-search-provider.enabled", true);
user_pref("browser.preferences.defaultPerformanceSettings.enabled", false);
user_pref("browser.sessionstore.resume_from_crash", false);
user_pref("browser.startup.homepage.abouthome_cache.enabled", true);
user_pref("browser.translation.neverForLanguages", "en,pt");
user_pref("browser.urlbar.quickactions.enabled", true);
user_pref("browser.urlbar.shortcuts.quickactions", true);
user_pref("cookiebanners.service.mode.privateBrowsing", 1);
user_pref("cookiebanners.ui.desktop.enabled", true);
user_pref("dom.enable_web_task_scheduling", true);
user_pref("dom.media.webcodecs.enabled", true);
user_pref("dom.security.https_only_mode", true);
user_pref("dom.security.https_only_mode_ever_enabled", true);
user_pref("dom.webgpu.enabled", true);
user_pref("font.name-list.emoji", "emoji");
user_pref("general.autoScroll", true);
user_pref("general.smoothScroll.mouseWheel.durationMaxMS", 400);
user_pref("general.smoothScroll.mouseWheel.durationMinMS", 200);
user_pref("geo.provider.geoclue.always_high_accuracy", false);
user_pref("geo.provider.use_geoclue", false);
user_pref("gfx.canvas.remote", true);
user_pref("gfx.color_management.mode", 1);
user_pref("gfx.font_rendering.fontconfig.max_generic_substitutions", 127);
user_pref("gfx.font_rendering.opentype_svg.enabled", false);
user_pref("gfx.text.subpixel-position.force-enabled", true);
user_pref("gfx.webrender.all", true);
user_pref("gfx.webrender.compositor", true);
user_pref("gfx.webrender.enabled", true);
user_pref("gfx.webrender.precache-shaders", true);
user_pref("gfx.webrender.quality.force-subpixel-aa-where-possible", true);
user_pref("gfx.x11-egl.force-disabled", true);
user_pref("image.jxl.enabled", true);
user_pref("intl.accept_languages", "pt-br,en-us,en");
user_pref("intl.locale.requested", "pt-BR,en-US");
user_pref("layout.frame_rate", 60);
user_pref("media.av1.enabled", false);
user_pref("media.eme.enabled", true);
user_pref("media.ffmpeg.vaapi.enabled", true);
user_pref("media.ffvpx.enabled", false);
user_pref("media.gpu-process-decoder", true);
user_pref("media.hardware-video-decoding.force-enabled", true);
user_pref("media.mediasource.experimental.enabled", true);
user_pref("media.peerconnection.video.vp9_preferred", true);
user_pref("media.rdd-vpx.enabled", false);
user_pref("media.videocontrols.picture-in-picture.video-toggle.enabled", false);
user_pref("media.webrtc.hw.h264.enabled", true);
user_pref("media.webrtc.platformencoder", true);
user_pref("mousewheel.default.delta_multiplier_y", 50);
user_pref("network.dns.disablePrefetchFromHTTPS", false);
user_pref("network.dns.echconfig.enabled", true);
user_pref("network.http.max-persistent-connections-per-server", 10);
user_pref("network.predictor.enable-prefetch", true);
user_pref("network.trr.mode", 3);
user_pref("network.trr.uri", "https://mozilla.cloudflare-dns.com/dns-query");
user_pref("nglayout.initialpaint.delay", 0);
user_pref("nglayout.initialpaint.delay_in_oopif", 0);
user_pref("services.sync.prefs.sync-seen.dom.security.https_only_mode", true);
user_pref("services.sync.prefs.sync-seen.dom.security.https_only_mode_ever_enabled", true);
user_pref("webgl.disable-angle", true);
user_pref("webgl.enable-draft-extensions", true);
user_pref("webgl.force-enabled", true);
user_pref("webgl.msaa-force", true);
user_pref("widget.content.allow-gtk-dark-theme", true);
user_pref("widget.dmabuf.force-enabled", true);
user_pref("widget.gtk.rounded-bottom-corners.enabled", true);
user_pref("widget.use-xdg-desktop-portal.file-picker", 1);
