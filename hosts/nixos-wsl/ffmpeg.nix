{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = [
    (pkgs.ffmpeg-full.override {
      withAlsa = false; # Alsa in/output supporT
      withAmf = false; # AMD Media Framework video encoding
      withAom = true; # AV1 reference encoder
      withAribb24 = false; # ARIB text and caption decoding
      withAribcaption = false; # ARIB STD-B24 Caption Decoder/Renderer
      withAss = false; # (Advanced) SubStation Alpha subtitle rendering
      withAvisynth = false; # AviSynth script files reading
      withBluray = false; # BluRay reading
      withBs2b = false; # bs2b DSP library
      withBzlib = false;
      withCaca = false; # Textual display (ASCII art)
      withCdio = false; # Audio CD grabbing
      withCelt = false; # CELT decoder
      withChromaprint = false; # Audio fingerprinting
      withCodec2 = false; # codec2 en/decoding
      withCuda = false;
      withCudaLLVM = false;
      withCudaNVCC = false;
      withCuvid = false;
      withDav1d = false; # AV1 decoder (focused on speed and correctness)
      withDavs2 = false; # AVS2 decoder
      withDc1394 = false; # IIDC-1394 grabbing (ieee 1394)
      withDrm = false; # libdrm support
      withDvdnav = false; # needed for DVD demuxing
      withDvdread = false; # needed for DVD demuxing
      withFdkAac = true; # Fraunhofer FDK AAC de/encoder
      withNvcodec = false; # dynamically linked Nvidia code
      withFlite = false; # Voice Synthesis
      withFontconfig = false; # Needed for drawtext filter
      withFreetype = false; # Needed for drawtext filter
      withFrei0r = false; # frei0r video filtering
      withFribidi = false; # Needed for drawtext filter
      withGme = false; # Game Music Emulator
      withGmp = false; # rtmp(t)e support
      withGnutls = false;
      withGsm = false; # GSM de/encoder
      withHarfbuzz = false; # Needed for drawtext filter
      withIconv = false;
      withIlbc = false; # iLBC de/encoding
      withJack = false; # Jack audio
      withJxl = false; # JPEG XL de/encoding
      withKvazaar = false; # HEVC encoding
      withLadspa = false; # LADSPA audio filtering
      withLc3 = false; # LC3 de/encoding
      withLcevcdec = false; # LCEVC decoding
      withLcms2 = false; # ICC profile support via lcms2
      withLzma = false; # xz-utils
      withMetal = false; # Unfree and requires manual downloading of files
      withMfx = false; # Hardware acceleration via intel-media-sdk/libmfx
      withModplug = false; # ModPlug support
      withMp3lame = true; # LAME MP3 encoder
      withMysofa = false; # HRTF support via SOFAlizer
      withNpp = false; # Nvidia Performance Primitives-based code
      withNvdec = false;
      withNvenc = false;
      withOpenal = false; # OpenAL 1.1 capture support
      withOpenapv = false; # APV encoding support
      withOpencl = false;
      withOpencoreAmrnb = false; # AMR-NB de/encoder
      withOpencoreAmrwb = false; # AMR-WB decoder
      withOpengl = false; # OpenGL rendering
      withOpenh264 = false; # H.264/AVC encoder
      withOpenjpeg = false; # JPEG 2000 de/encoder
      withOpenmpt = false; # Tracked music files decoder
      withOpus = true; # Opus de/encoder
      withPlacebo = false; # libplacebo video processing library
      withPulse = false; # Pulseaudio input support
      withQrencode = false; # QR encode generation
      withQuirc = false; # QR decoding
      withRav1e = true; # AV1 encoder (focused on speed and safety)
      withRist = false; # Reliable Internet Stream Transport (RIST) protocol
      withRtmp = false; # RTMP[E] support via librtmp
      withRubberband = false; # Rubberband filter
      withSamba = false; # Samba protocol
      withSdl2 = false;
      withShaderc = false;
      withShine = false; # Fixed-point MP3 encoding
      withSnappy = false; # Snappy compression, needed for hap encoding
      withSoxr = false; # Resampling via soxr
      withSpeex = false; # Speex de/encoder
      withSrt = true; # Secure Reliable Transport (SRT) protocol
      withSsh = false; # SFTP protocol
      withSvg = false; # SVG protocol
      withSvtav1 = true; # AV1 encoder/decoder (focused on speed and correctness)
      withTensorflow = false; # Tensorflow dnn backend support (Increases closure size by ~390 MiB)
      withTheora = false; # Theora encoder
      withTwolame = false; # MP2 encoding
      withUavs3d = false; # AVS3 decoder
      withV4l2 = true; # Video 4 Linux support
      withVaapi = false; # Vaapi hardware acceleration
      withVdpau = false; # Vdpau hardware acceleration
      withVidStab = false; # Video stabilization
      withVmaf = true; # Netflix's VMAF (Video Multi-Method Assessment Fusion)
      withVoAmrwbenc = false; # AMR-WB encoder
      withVorbis = false; # Vorbis de/encoding, native encoder exists
      withVpl = false; # Hardware acceleration via intel libvpl
      withVpx = true; # VP8 & VP9 de/encoding
      withVulkan = false;
      withVvenc = true; # H.266/VVC encoding
      withWebp = true; # WebP encoder
      withWhisper = true; # Whisper speech recognition
      withX264 = true; # H.264/AVC encoder
      withX265 = true; # H.265/HEVC encoder
      withXavs = false; # AVS encoder
      withXavs2 = false; # AVS2 encoder
      withXcb = false; # X11 grabbing using XCB
      withXcbShape = false; # X11 grabbing shape rendering
      withXcbShm = false; # X11 grabbing shm communication
      withXcbxfixes = false; # X11 grabbing mouse rendering
      withXevd = false; # MPEG-5 EVC decoding
      withXeve = false; # MPEG-5 EVC encoding
      withXlib = false; # Xlib support
      withXml2 = false; # libxml2 support, for IMF and DASH demuxers
      withXvid = false; # Xvid encoder, native encoder exists
      withZimg = false;
      withZlib = false;
      withZmq = false; # Message passing
      withZvbi = false; # Teletext support

      withUnfree = true;

      buildFfmpeg = true;
      buildFfplay = false;
      buildFfprobe = true;

      withHtmlDoc = true;
    })
  ];
}
