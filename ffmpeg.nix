{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = [
    (pkgs.ffmpeg.override {
      withAom = true;
      withFdkAac = true;
      withOpencl = true;
      withOpus = true;
      withRav1e = true;
      withSrt = true;
      withSvg = true;
      withSvtav1 = true;
      withV4l2 = true;
      withVmaf = true;
      withVpx = true;
      withVvenc = true;
      withWebp = true;
      withWhisper = true;
      withX264 = true;
      withX265 = true;

      withUnfree = true;

      buildFfmpeg = true;
      buildFfplay = false;
      buildFfprobe = true;

      withHtmlDoc = true;
    })
  ];
}
